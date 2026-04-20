---
description: "Codzienny triage skrzynki — co wymaga uwagi, co mozna zignorowac"
argument-hint: "opcjonalnie: zakres np. '48h', 'tydzien', lub bez argumentu = ostatnie 24h"
allowed-tools: ["mcp__claude_ai_Gmail__*"]
model: "haiku"
---

# Email Triage

Przeanalizuj nieprzeczytane maile i podziel je na 3 kategorie: co wymaga akcji, co warto przejrzec, co to szum.

## Instrukcje

Parametry: $ARGUMENTS

### Krok 1: Ustal zakres czasowy
- Bez argumentu lub "24h" -> `is:unread newer_than:1d`
- "48h" -> `is:unread newer_than:2d`
- "tydzien" -> `is:unread newer_than:7d`
- Inny argument -> potraktuj jako filtr dodatkowy

### Krok 2: Szybka pre-klasyfikacja po senderze (alias-aware routing)

Zanim czytasz tresc — skategoryzuj po domenie sendera:
- **Auto-szum** (nie czytaj tresci): `pepper.pl`, `instagram.com`, `linkedin.com`, `allegro.pl` (marketing), `zalando.pl`, `glovo.com`, `bolt.eu` (promo), `medium.com` (digest)
- **Auto-przejrzyj** (nie czytaj tresci): znane newslettery techniczne, powiadomienia z serwisow dev (sentry, clickup, github)
- **Czytaj tresc** (`gmail_read_message`): wszystko inne — osobiste, banki, faktury, nieznani senderzy

To oszczedza ~80% wywolan API.

### Krok 3: Klasyfikacja

Sklasyfikuj kazdy mail:
- **Wymaga akcji** — odpowiedz do wyslania, platnosc, deadline, cos pilnego, MFA/kody
- **Warto przejrzec** — newsletter ktory czytasz, interesujaca tresc, nie pilne
- **Szum** — promo, kupony, notyfikacje social, newsletter ktorego nie czytasz

### Krok 4: Raport

```
## Triage skrzynki — [data]

### Wymaga akcji ([liczba])
- **[Sender]** — [Temat] -> [co konkretnie trzeba zrobic, 1 zdanie]

### Warto przejrzec ([liczba])
- **[Sender]** — [Temat] -> [o czym jest, 1 zdanie]

### Szum ([liczba])
- [Sender] — [Temat]
- ...

### Top senderzy szumu
1. [sender] — [X] maili
2. ...
```

## Wazne zasady
- Raport po polsku, krotko, bez lania wody
- Nie proponuj usuwania — tylko archiwizacje
- Jesli mail to kod MFA/OTP -> zawsze "Wymaga akcji" nawet jesli juz uzyty
- Faktury i potwierdzenia platnosci -> "Warto przejrzec" (nie szum)
- Maile od mBank, Autopay, ERGO Hestia -> zawsze czytaj tresc (moga byc wazne)
