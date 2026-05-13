# Remaining Verification Work

Full numerical verification is not complete.

## Phase 4 Completion Status (2026-05-12)

All exported package examples are classified. All UNVERIF rows have been resolved:
30 confirmed absent from the 2nd edition PDF (UNVERIF_CONFIRMED_ABSENT) and 7 reclassified
as confirmed MISMATCH with root-cause documentation.

Final master table: 531 total rows, 475 EXACT, 8 APPROX, 18 MISMATCH,
30 UNVERIF_CONFIRMED_ABSENT. Pass rate 96.4% (483/501 verifiable quantities).

## Current Verified Scope

| Chapter | Status | Quantities | Notes |
|---|---|---:|---|
| Chapter 1 | Verified | 12 | Printed Table 1.1 linear and logistic model quantities. |
| Chapters 2-5 | Verified/documented | 14 | Chapter 2 syntax-only rows (7 UNVERIF_CA); Chapter 3 numerical rows verified; Chapter 4-5 theory-only (4 UNVERIF_CA). |
| Chapters 8-10 | Verified/documented | 384 | Chapters 8-10: 373 EXACT/APPROX, 11 MISMATCH, 1 UNVERIF_CA (Exam8.6 figure-only). |
| Chapter 11 | Partially verified | 29 | Count-data examples with 7 documented mismatches and 4 UNVERIF_CA rows. |
| Chapters 12-21 | Classified | 30 | All rows are UNVERIF_CONFIRMED_ABSENT (legacy content absent from 2nd ed), except Ch21 (12 EXACT + 1 UNVERIF_CA). |

## Remaining MISMATCHes (18 total)

All 18 mismatch rows are confirmed irreducible and documented in
`inst/verification/mismatch-report.md` with cause categories and repair attempts:

- **Exam11.3** (7): dataset reconstruction unavailable; original RCBD_counts file absent
- **Exam8.7 a F/p** (2): estimable-function construction differs between SAS GLIMMIX EFFECT and R lm B-spline; spline component F statistics are EXACT but marginal a test is not
- **Exam9.4 Bounded** (3): Kenward-Roger denominator df approximation differs at boundary VC
- **Exam9.4 NOBOUND** (4): SAS NOBOUND allows negative VCs; lme4 constrains VCs ≥ 0
- **Exam10.2 BLUP SE** (1): SAS ESTIMATE KR broad SE formula not reproducible in lme4
- **Exam10.4 BLUP SE** (1): SAS ESTIMATE TYPE=EBP SUBJECT gives subject-specific SEs; lme4 ranef(condVar=TRUE) gives equal conditional SEs per effect

No further repairs are possible given the available R tooling and data.

## R CMD check

R CMD check: 0 ERRORs, 0 WARNINGs, 0 NOTEs.
spelling::spell_check_package(): No spelling errors found.
urlchecker::url_check(): All URLs are correct.

## Ready for Phase 5

Phase 4 complete. Pass rate 96.4% (483/501). Next: Phase 5 — pkgdown::build_site() and devtools::release().
