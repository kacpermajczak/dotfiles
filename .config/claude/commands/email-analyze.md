---
description: "Gleboka analiza skrzynki — top senderzy, gotowy XML filtrow do importu w Gmail"
argument-hint: "opcjonalnie: fokus np. 'newslettery', 'promo', 'social', lub bez argumentu = pelna analiza"
allowed-tools: ["mcp__claude_ai_Gmail__*"]
---

# Email Analyze

Przeprowadz gleboka analize skrzynki, zidentyfikuj wzorce i wygeneruj gotowy plik XML z filtrami do importu w Gmail.

## Instrukcje

Parametry: $ARGUMENTS

### Krok 1: Zbierz dane

Wykonaj rownolegle nastepujace wyszukiwania (`gmail_search_messages`, maxResults: 50 kazde):
- `category:promotions`
- `category:social`
- `category:updates`
- `unsubscribe`
- `is:unread`

Pobierz tez liste etykiet (`gmail_list_labels`).

### Krok 2: Zgrupuj po senderach

Dla kazdego wyniku pogrupuj maile po domenie sendera (np. `pepper.pl`, `instagram.com`).
Policz wolumen kazdego sendera.
Zidentyfikuj top 20 senderow lacznie.

### Krok 3: Wygeneruj raport

```
## Analiza skrzynki — kacpermajczak1@gmail.com

### Istniejace etykiety uzytkownika
[lista etykiet pogrupowana: systemowe / uzytkownika / kategorie]

### Top senderzy (wolumen)
| # | Sender | Liczba maili | Kategoria | Rekomendacja |
|---|--------|-------------|-----------|--------------|
| 1 | pepper.pl | ~XXX | Promo/Kupony | Skip Inbox + etykieta Kupony |
| 2 | instagram.com | ~XXX | Social | Skip Inbox + Archiwizuj |
...

### Proponowana struktura etykiet
[bazujac na istniejacych etykietach + brakujace]

### Gotowe filtry Gmail do importu

Zapisz ponizej jako `gmail-filters.xml` i zaimportuj w:
**Gmail -> Ustawienia (kolo zebate) -> Filtry i adresy zablokowane -> Importuj filtry**

Przy imporcie zaznacz "Zastosuj tez filtr do pasujacych rozmow" zeby oczyscic istniejace maile.
```

### Krok 4: Generuj XML filtrow

Wygeneruj XML na podstawie **rzeczywistych senderow** znalezionych w analizie, nie przykladowych.

Reguly generowania XML:
- Grupuj senderow tej samej kategorii w jeden filtr (operator OR)
- Uzyj istniejacych etykiet uzytkownika tam gdzie pasuja
- Kazdy `<entry>` MUSI miec `<title>Mail Filter</title>`
- Max ~45 adresow email per filtr (limit ~1488 znakow) — podzieel jesli wiecej
- Operator OR musi byc WIELKIMI LITERAMI
- Znaki specjalne escapeuj: `&` -> `&amp;`, `"` -> `&quot;`
- Dla etykiet zagniezdzonych uzyj `/`: np. `Kupony/Pepper`
- Zawsze `shouldArchive` zamiast `shouldTrash`

Przyklad poprawnego XML:

```xml
<?xml version='1.0' encoding='UTF-8'?>
<feed xmlns='http://www.w3.org/2005/Atom' xmlns:apps='http://schemas.google.com/apps/2006'>

  <entry>
    <title>Mail Filter</title>
    <apps:property name='from' value='pepper.pl OR allegro.pl OR zalando.pl'/>
    <apps:property name='label' value='Kupony'/>
    <apps:property name='shouldArchive' value='true'/>
  </entry>

  <entry>
    <title>Mail Filter</title>
    <apps:property name='from' value='instagram.com OR linkedin.com'/>
    <apps:property name='label' value='Social'/>
    <apps:property name='shouldArchive' value='true'/>
    <apps:property name='shouldMarkAsRead' value='true'/>
  </entry>

</feed>
```

Dostepne wlasciwosci XML:
- Kryteria: `from`, `to`, `subject`, `hasTheWord`, `doesNotHaveTheWord`, `hasAttachment`
- Akcje: `label`, `shouldArchive`, `shouldMarkAsRead`, `shouldStar`, `shouldNeverSpam`, `shouldAlwaysMarkAsImportant`, `shouldNeverMarkAsImportant`, `forwardTo`
- NIGDY nie uzywaj `shouldTrash`

### Krok 5: Instrukcje archiwizacji

Na koncu raportu dodaj sekcje:

```
### Jak zarchiwizowac istniejace maile (recznie w Gmail)

Dla kazdej kategorii:
1. Wpisz w wyszukiwarke Gmail: `from:pepper.pl` (lub odpowiednia fraza)
2. Kliknij checkbox -> "Zaznacz wszystkie [X] rozmow"
3. Kliknij "Archiwizuj"
4. Powtorz dla kolejnej kategorii
```

## Wazne zasady
- Nigdy nie sugeruj usuwania — zawsze archiwizuj
- XML musi byc poprawny skladniowo (gotowy do importu bez edycji)
- Raport po polsku, tabele czytelne
- Jesli fokus podany w $ARGUMENTS -> skup sie tylko na tej kategorii
