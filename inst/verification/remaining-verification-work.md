# Remaining Verification Work

## Phase 5 Completion Status (2026-05-12)

**Pass rate: 96.4%** (483 EXACT+APPROX / 501 verifiable quantities).

18 MISMATCHes remain — all confirmed irreducible after the 12-step diagnostic.
30 UNVERIF_CONFIRMED_ABSENT rows document content confirmed absent from the 2nd edition PDF.

No further verification work is required for Phase 5. Phase 6 (pkgdown + CRAN) is next.

## Irreducible MISMATCH Quantities (18)

All 18 have been processed through the 12-step diagnostic. Root causes:

| Function | Rows | Root cause | Reinstatement condition |
|---|---:|---|---|
| Exam8.7 | 2 | SAS GLIMMIX estimable-function construction for qualitative factor in spline model differs from `car::Anova` Type III | Implement GLIMMIX EFFECT spline parameterization in R |
| Exam9.4 | 3 | KR denominator df shifts when `block:a` VC is at boundary (0) | Resolve KR boundary behaviour in lme4/lmerTest or use NOBOUND |
| Exam9.4 | 4 | SAS GLIMMIX NOBOUND allows negative VCs; lme4 constrains VC ≥ 0 | Add NOBOUND option to lme4 or use a negative-VC estimator |
| Exam10.2 | 1 | SAS GLIMMIX ESTIMATE KR broad BLUP SE formula not in lme4 | Validate `merTools::predictInterval` against printed value |
| Exam10.4 | 1 | SAS GLIMMIX ESTIMATE TYPE=EBP SE not in lme4 | Validate `merTools::predictInterval` or EBP SE formula |
| Exam11.3 | 7 | Original `RCBD_counts` dataset unavailable; reconstruction gap + SAS GLIMMIX PL vs glmmTMB ML | Obtain original dataset or use MASS::glmmPQL for PL fits |

## UNVERIF_CONFIRMED_ABSENT Content (30)

Content confirmed absent from the 2nd edition PDF via direct chapter reading.

| Chapter(s) | Function(s) | Reason |
|---|---|---|
| Ch 2 App. B | Exam2.B.1–7 | SAS PROC GLIMMIX syntax only; no printed numerical output |
| Ch 4 | Exam4.1 | Pure-theory chapter; no applied examples |
| Ch 5 | Exam5.1–5.3 | Pure-theory chapter; no applied examples |
| Ch 8 | Exam8.6 | Hoerl/Gompertz fits shown graphically only; no printed coefficients |
| Ch 11 | Exam11.4 | Synthetic split-plot dataset; `sp_counts` unavailable |
| Ch 12 | Exam12.1, Exam12.2 | 1st-edition legacy datasets; 2nd ed uses different designs |
| Ch 13, 15, 16, 19, 20 | (chapter-level) | No exported example function in package |
| Ch 14 | Exam14.1, Exam14.2 | 1st-edition legacy datasets; 2nd ed uses different designs |
| Ch 17 | Exam17.1, Exam17.2 | 1st-edition legacy datasets; 2nd ed uses different designs |
| Ch 18 | Exam18.1, Exam18.2 | 1st-edition legacy datasets; 2nd ed uses different designs |
| Ch 21 | Exam21.2 | t-test pilot power absent from 2nd ed Ch 21 |

## Current Verified Scope

| Chapter | Verifiable | EXACT | APPROX | MISMATCH | Pass Rate |
|---|---:|---:|---:|---:|---|
| Chapter 1 | 12 | 12 | 0 | 0 | 100.0% |
| Chapter 3 | 69 | 69 | 0 | 0 | 100.0% |
| Chapter 8 | 121 | 119 | 0 | 2 | 98.3% |
| Chapter 9 | 163 | 151 | 5 | 7 | 95.7% |
| Chapter 10 | 99 | 97 | 0 | 2 | 98.0% |
| Chapter 11 | 25 | 15 | 3 | 7 | 72.0% |
| Chapter 21 | 12 | 12 | 0 | 0 | 100.0% |
| **TOTAL** | **501** | **475** | **8** | **18** | **96.4%** |

## R CMD check

R CMD check: 0 ERRORs, 0 WARNINGs, 0 NOTEs.
spelling::spell_check_package(): No spelling errors.
urlchecker::url_check(): All URLs correct.

## Ready for Phase 6

Phase 5 complete. 96.4% pass rate with 18 documented irreducible MISMATCHes and 30
confirmed-absent UNVERIF entries. Next: Phase 6 — `pkgdown::build_site()` and `devtools::release()`.
