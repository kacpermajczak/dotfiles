## Gmail i zarządzanie skrzynką

**Zasady:**
- NIGDY nie usuwaj maili — zawsze archiwizuj
- Gmail MCP jest read-only: możesz szukać, czytać, listować — nie możesz archiwizować ani aplikować etykiet
- Akcje na skrzynce (archiwizacja, filtry, etykiety) wykonuje user ręcznie lub przez skrypty

**Skille do użytku:**
- `/email-analyze` — jednorazowa głęboka analiza skrzynki → generuje strukturę etykiet + plik XML z filtrami do importu
- `/email-triage` — codzienny triage: co wymaga uwagi dziś
- `/email-cleanup` — ad-hoc: znajdź kandydatów do archiwizacji + gotowe filter strings

**Kiedy używać:**
- User pyta "co mam w skrzynce" / "co ważnego" → `/email-triage`
- User chce ogarnąć bałagan, skonfigurować filtry → `/email-analyze`
- User chce wyczyścić konkretną kategorię (promo, social) → `/email-cleanup`

**Styl raportów:** po polsku, bullet-pointy, bez lania wody

- try to avoid using setTimeout
- uzywaj chrome-devtools mcp do testowania strony
- use Animate UI (https://animate-ui.com/) instead of regular shadcn for UI components

## Universal Programming Principles

### 🛡️ Guard Clauses & Early Returns
- Always use guard clauses instead of nested if statements
- Early return on error conditions and invalid states
- Keep happy path at the end with minimal nesting
- Maximum 1-2 indentation levels for better readability

### 💎 Value Objects & Immutability
- Prefer immutable data structures wherever possible
- Use value objects for domain concepts (IDs, states, etc.)
- Avoid mutable shared state that can cause bugs
- Prefer functional programming patterns (map, filter, reduce)

### 📝 Declarative Code
- Code should express intent clearly (what, not how)
- Use functional methods over imperative loops when possible
- Write self-documenting code with meaningful names
- Prefer composition over inheritance

### 🧩 Single Responsibility Principle
- Each function/class should have one reason to change
- Functions should do one thing well
- Keep functions small (ideally under 20 lines)
- Separate concerns into different modules

### 🔌 Dependency Injection
- Pass dependencies explicitly rather than using globals
- Use interfaces/abstractions for loose coupling
- Make dependencies clear in constructors
- Avoid hidden dependencies and global state

### ⚡ Pure Functions Preferred
- Same input should always produce same output
- Minimize side effects where possible
- Makes code easier to test and reason about
- Isolate side effects to specific layers

### 🧹 Resource Management
- Always clean up resources (files, connections, timers)
- Use proper cleanup patterns (defer in Go, cleanup in useEffect)
- Prevent memory leaks and resource exhaustion
- Handle cancellation and timeouts appropriately
