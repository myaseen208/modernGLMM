# Rename Audit

## Scope

The package identity was renamed globally to `modernGLMM` across active package
metadata, source files, examples, tests, vignettes, rendered articles, citation
metadata, pkgdown configuration, README files, and helper scripts.

## Actions

| Area | Action |
|---|---|
| Package directory | Renamed the nested package source directory to `modernGLMM`. |
| DESCRIPTION | Updated `Package`, `Title`, `Description`, `URL`, and `BugReports`. |
| R package docs | Renamed package-level roxygen source to `R/modernGLMM-package.R`. |
| Tests | Updated package loading and package-scoped data calls. |
| Vignettes | Updated `library()` calls and package-scoped data loads. |
| README | Rewritten for the new package identity and positioning. |
| pkgdown | Updated site URL, navbar links, and reference index. |
| Generated artifacts | Stale check, archive, and unzipped generated artifacts with the legacy identifier were removed before rebuilding. |
| Source build | Added `README.html` to `.Rbuildignore` to keep generated HTML out of CRAN source builds. |

## Validation Checklist

- DESCRIPTION `Package` field updated: yes
- Active `library()` references updated: yes
- Package-qualified data/example references updated: yes
- README badges updated: yes
- pkgdown references updated: yes
- NAMESPACE regenerated: yes
- Tests passing: yes
- Rendered HTML rebuilt: yes
- URL check passed: yes
- Remaining exact legacy package-name references in active package scans: 0

## Validation Commands

| Command | Result |
|---|---|
| `devtools::document()` | OK |
| `devtools::test()` | 134 passed, 0 failed, 0 warnings, 0 skips |
| `devtools::check(manual = FALSE, vignettes = FALSE)` | 0 ERRORs, 0 WARNINGs, 0 NOTEs |
| `devtools::check_man()` | OK, no issues detected |
| `spelling::spell_check_package()` | Completed; domain vocabulary reported only |
| `urlchecker::url_check()` | OK, all URLs correct |
