---
description: "Generate changelog summary from latest git tag"
argument-hint: "optional: --client for non-technical version"
allowed-tools: ["*"]
---

# Changelog Generator

Automatically generate a comprehensive changelog summary of all changes since the latest git tag.

## Instructions:

1. Fetch latest tags from remote: `git fetch --tags`
2. Find the most recent tag
3. Get all commits since that tag
4. Categorize commits by type (feat, fix, refactor, chore, style, docs, test)
5. Generate formatted changelog summary in Polish
6. If `--client` flag is provided, generate a non-technical, business-friendly version

## Process:

Parse arguments: $ARGUMENTS

1. **Fetch and identify latest tag:**
   - Run: `git fetch --tags`
   - Run: `git tag --sort=-creatordate | head -1`
   - Count commits: `git log [TAG]..HEAD --oneline --no-decorate | wc -l`

2. **Get all commit messages:**
   - Run: `git log [TAG]..HEAD --pretty=format:"%s" --no-decorate`

3. **Categorize commits:**
   - ✨ **Nowe funkcjonalności** (feat:)
   - 🐛 **Poprawki błędów** (fix:)
   - 🔧 **Refaktoryzacje** (refactor:)
   - 📦 **Aktualizacje zależności** (chore(deps):, fix(deps):)
   - 🎨 **Stylowanie** (style:)
   - 📝 **Dokumentacja** (docs:)
   - 🧪 **Testy** (test:)
   - 🛠️ **Konfiguracja i narzędzia** (chore:, build:, ci:)
   - 🔀 **Merge'e** (Merge pull request)

4. **Generate summary:**
   - Group by category
   - Use bullet points
   - Show commit count summary
   - Highlight major features/changes
   - All output in Polish

5. **For --client flag:**
   - Remove technical jargon
   - Focus on business value and user benefits
   - Use simple language
   - Group by functional areas (not commit types)
   - Explain "what" and "why" instead of "how"

## Output Format:

### Technical Version (default):
```
## Podsumowanie zmian od wersji [TAG] ([N] commitów)

### ✨ Nowe funkcjonalności
- [grouped and summarized features]

### 🐛 Poprawki błędów
- [bug fixes]

### 🔧 Refaktoryzacje
- [refactoring changes]

### 📦 Aktualizacje zależności
- [dependency updates]

### 🎨 Stylowanie
- [styling changes]

### 🛠️ Konfiguracja i narzędzia
- [config and tooling changes]

[... other categories as needed ...]
```

### Client Version (--client):
```
## Co nowego w systemie? (od wersji [TAG])

### ✨ Nowe możliwości dla użytkowników
- [business-focused feature descriptions]

### 🎨 Ulepszenia wygody użytkowania
- [UX improvements in simple terms]

### 🚀 Aktualizacja fundamentów systemu
- [technical upgrades explained in business terms]

### 🔧 Usprawnienia techniczne
- [technical improvements in simple terms]

---
**Podsumowanie:** [Brief summary of major changes]
```

## Important Notes:

- Always fetch tags first to ensure latest tag is available
- Group similar commits together for readability
- Ignore merge commits unless they contain important info in description
- For client version, translate technical terms to business benefits
- Be concise but comprehensive
- Focus on the "why" and impact, not just the "what"
- ALL output must be in Polish language