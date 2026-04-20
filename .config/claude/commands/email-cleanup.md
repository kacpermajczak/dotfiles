---
description: "Znajdz maile do archiwizacji w danej kategorii + gotowe filter strings dla Gmail"
argument-hint: "kategoria np. 'promo', 'social', 'newslettery', 'allegro', lub bez argumentu = wszystko"
allowed-tools: ["mcp__claude_ai_Gmail__*"]
model: "haiku"
---

# Email Cleanup

Znajdz maile ktore zasmiecaja skrzynke i wygeneruj gotowe filter strings do skopiowania do Gmail.

## Instrukcje

Parametry: $ARGUMENTS

### Krok 1: Dobierz query do kategorii

Na podstawie $ARGUMENTS wybierz query:
- "promo" / "promocje" / bez argumentu -> `category:promotions`
- "social" -> `category:social`
- "newslettery" / "newsletter" -> `unsubscribe`
- "aktualizacje" / "updates" -> `category:updates`
- Konkretna nazwa (np. "allegro", "pepper") -> `from:allegro.pl` lub `from:pepper.pl`
- Bez argumentu -> wykonaj wszystkie powyzsze

### Krok 2: Zbierz i pogrupuj dane

Dla kazdego query (`gmail_search_messages`, maxResults: 50):
1. Zbierz wyniki
2. Pogrupuj po domenie sendera
3. Policz wolumen
4. Dla top 5 senderow przejrzyj 1 przykladowy mail (`gmail_read_message`) — sprawdz czy jest link unsubscribe

### Krok 3: Wygeneruj raport

```
## Cleanup — [kategoria]

### Kandydaci do archiwizacji (posortowani po wolumenie)

| Sender | Maili | Ostatni | Unsubscribe? |
|--------|-------|---------|--------------|
| pepper.pl | ~85 | 2026-03-22 | Tak (link w mailu) |
| instagram.com | ~62 | 2026-03-23 | Nie (odsubskrybuj w apce) |
...

### Gotowe filter strings (skopiuj do Gmail)

**Jak dodac filtr recznie:**
Gmail -> Ustawienia -> Filtry -> Utworz nowy filtr -> wklej kryterium -> wybierz akcje

# Promo/Kupony -> Skip Inbox + Etykieta
from:(pepper.pl OR allegro.pl OR zalando.pl)
Akcje: Pomin skrzynke odbiorcza, Zastosuj etykiete: Kupony

# Social -> Skip Inbox + Oznacz jako przeczytane
from:(instagram.com OR linkedin.com)
Akcje: Pomin skrzynke odbiorcza, Oznacz jako przeczytane

### Jak zarchiwizowac istniejace maile

Dla kazdego sendera (w Gmail):
1. Wyszukaj: `from:pepper.pl`
2. Zaznacz checkbox -> "Zaznacz wszystkie X rozmow pasujacych do wyszukiwania"
3. Kliknij "Archiwizuj"

Albo zbiorczo:
- `from:(pepper.pl OR allegro.pl OR zalando.pl)` -> zaznacz wszystkie -> Archiwizuj

### Linki unsubscribe (gdzie znalezione)

- **pepper.pl** -> [link z mailu jesli znaleziony]
- **instagram.com** -> Odsubskrybuj w Ustawienia -> Powiadomienia -> Email
```

## Wazne zasady
- Nigdy nie sugeruj usuwania — zawsze archiwizuj
- Filter strings musza byc gotowe do skopiowania (dzialajaca skladnia Gmail)
- Raport po polsku, krotko
- Jesli znaleziono link unsubscribe -> zawsze go podaj
- OR w filter strings musi byc WIELKIMI LITERAMI
