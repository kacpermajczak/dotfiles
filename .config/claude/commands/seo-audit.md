---
description: "Comprehensive SEO and usability audit with Polish report"
argument-hint: "website URL to audit (e.g., www.example.com)"
allowed-tools: ["*"]
---

## SEO & Usability Audit

Perform a comprehensive SEO and usability audit for: $ARGUMENTS

### Workflow:

1. **Initialize Audit**
   - Use TodoWrite to track all audit tasks
   - Extract and validate URL from arguments
   - Normalize URL (add https:// if missing, handle www)
   - Validate domain format
   - Create timestamp for audit identification
   - Use Bash to create directory: `mkdir -p audyty-seo/[domain]-[timestamp]`

2. **Launch Orchestrator Agent**

   Use Task tool to launch tech-lead-orchestrator to coordinate all testing agents

3. **Launch Parallel Testing Agents**

   **Agent 1: playwright-tester (Technical SEO & Security)**
   - Test using Playwright MCP on the provided URL
   - Extract and analyze meta tags (title, description, OG tags, Twitter Cards)
   - Check heading hierarchy (H1-H6)
   - Verify single H1 presence
   - Find images without alt text
   - Test robots.txt and sitemap.xml
   - Verify SSL certificate and HTTPS implementation
   - Check security headers (CSP, X-Frame-Options, HSTS)
   - Measure Core Web Vitals (LCP, FID, CLS, FCP, TTI, TBT)
   - Check canonical URLs and hreflang tags
   - Test 404 error handling and redirect chains
   - Check for mixed content warnings
   - Verify mobile-first indexing signals
   - Test cookie consent and GDPR compliance
   - Return findings as: critical issues, warnings, passed tests, metrics

   **Agent 2: playwright-tester (Accessibility)**
   - Test WCAG 2.1 AA compliance using axe-core
   - Check keyboard navigation (tab order, focus indicators)
   - Verify ARIA labels and roles
   - Test color contrast ratios (minimum 4.5:1)
   - Check form labels and error messages
   - Test responsive viewports (mobile: 375x667, tablet: 768x1024, desktop: 1920x1080)
   - Capture screenshots for each viewport
   - Return accessibility violations by severity

   **Agent 3: performance-optimizer**
   - Analyze page load performance
   - Check resource optimization (images, CSS, JS)
   - Analyze caching headers and CDN usage
   - Measure TTFB and network timings
   - Identify third-party script impact
   - Calculate total page weight
   - Return performance bottlenecks and optimization opportunities

   **Agent 4: frontend-developer (Content & Links)**
   - Analyze content structure and quality
   - Check internal/external linking (find broken links)
   - Test all links for 404 errors
   - Check for duplicate content
   - Analyze content readability (Flesch-Kincaid score)
   - Check word count and content depth
   - Detect keyword cannibalization
   - Evaluate semantic HTML usage
   - Check for structured data (Schema.org, JSON-LD)
   - Analyze UX elements (navigation, CTAs, forms)
   - Verify mobile touch targets (min 44x44px)
   - Check content freshness dates
   - Return content and UX findings

   **Agent 5: sentry-debugger (Error Monitoring)**
   - Check for JavaScript errors in console
   - Monitor network request failures
   - Identify performance bottlenecks in code
   - Check for unhandled promise rejections

4. **Additional Analysis**

   Use WebFetch tool to:
   - Check external resources availability
   - Verify social media meta tags rendering
   - Test Open Graph preview

   Use WebSearch tool to:
   - Research competitor SEO strategies
   - Check domain authority indicators
   - Find keyword opportunities

5. **Generate Polish Report**

   Use documentation-specialist agent to compile findings into Polish report:

   **Report Structure:**
   - 📊 Ogólne Wyniki (Overall Scores)
     * SEO: X/100
     * Wydajność: X/100
     * Dostępność: X/100
     * Użyteczność: X/100
     * Bezpieczeństwo: X/100

   - 🚨 Krytyczne Problemy (Critical Issues)
   - ⚠️ Ostrzeżenia (Warnings)
   - ✅ Testy Zakończone Pomyślnie (Passed Tests)

   - 📈 Szczegółowe Wyniki (Detailed Findings)
     * Analiza SEO Technicznego
     * Analiza Treści i Słów Kluczowych
     * Metryki Wydajności (Core Web Vitals)
     * Raport Dostępności (WCAG 2.1)
     * Wyniki Użyteczności i UX
     * Analiza Bezpieczeństwa
     * Analiza Linków (wewnętrzne/zewnętrzne/uszkodzone)
     * Dane Strukturalne i Schema.org

   - 🎯 Rekomendacje (Recommendations)
     * Wysoki Priorytet (Krytyczne dla SEO)
     * Średni Priorytet (Ważne ulepszenia)
     * Niski Priorytet (Nice to have)

   - 💡 Plan Działania (Action Plan)
   - 📊 Analiza Konkurencji (jeśli dostępna)

6. **Save Results**
   - Use Write tool to save Polish report: `audyty-seo/[domain]-[timestamp]/raport.md`
   - Use Write tool to save raw data: `audyty-seo/[domain]-[timestamp]/dane.json`
   - Save screenshots in: `audyty-seo/[domain]-[timestamp]/zrzuty/`
   - Save error logs if any: `audyty-seo/[domain]-[timestamp]/bledy.log`

7. **Complete and Report**
   - Mark all todos as completed
   - Display summary to user in Polish:
     ```
     Audyt SEO zakończony! ✅

     📊 Wyniki:
     - SEO: X/100 (Ocena)
     - Wydajność: X/100 (Ocena)
     - Dostępność: X/100 (Ocena)
     - Użyteczność: X/100 (Ocena)
     - Bezpieczeństwo: X/100 (Ocena)

     🚨 Znaleziono X krytycznych problemów
     ⚠️ Znaleziono X ostrzeżeń
     ✅ X testów zakończonych pomyślnie

     📁 Raport zapisany: audyty-seo/[domain]-[timestamp]/raport.md
     ```

### Important Notes:
- All user-facing output must be in Polish
- Use Playwright MCP for all browser interactions
- Run agents in parallel for efficiency (use single Task call with multiple agents)
- Generate comprehensive, actionable recommendations
- Include specific examples and metrics in the report
- Handle errors gracefully and continue with other tests
- Validate URL format before starting audit
- Create audit directory structure before saving files
- Use tech-lead-orchestrator for complex coordination
- Check for both www and non-www versions of the site
- Test mobile and desktop versions separately