# Phase 3 Verification Summary

This report records the numerical verification completed so far in this pass.
It now includes Chapter 1 quantities that can be checked directly against
printed Chapter 1 values, Chapter 2-5 verification/documentation, Chapter
8-10 Gaussian and BLUP verification, the Chapter 11 count-data work, and
Chapter 12-21 legacy/no-export classifications.

## Chapter Summary

| Chapter | Total Quantities | EXACT | APPROX | MISMATCH | UNVERIF | Pass Rate |
|---|---:|---:|---:|---:|---:|---:|
| Ch 1 | 12 | 12 | 0 | 0 | 0 | 100.0% |
| Ch 2 | 7 | 0 | 0 | 0 | 7 | NA |
| Ch 3 | 69 | 69 | 0 | 0 | 0 | 100.0% |
| Ch 4 | 1 | 0 | 0 | 0 | 1 | NA |
| Ch 5 | 3 | 0 | 0 | 0 | 3 | NA |
| Ch 8 | 122 | 117 | 0 | 4 | 1 | 96.7% |
| Ch 9 | 163 | 149 | 5 | 5 | 4 | 96.9% |
| Ch 10 | 99 | 96 | 0 | 0 | 3 | 100.0% |
| Ch 11 | 29 | 15 | 3 | 7 | 4 | 72.0% |
| Ch 12 | 2 | 0 | 0 | 0 | 2 | NA |
| Ch 13 | 1 | 0 | 0 | 0 | 1 | NA |
| Ch 14 | 2 | 0 | 0 | 0 | 2 | NA |
| Ch 15 | 1 | 0 | 0 | 0 | 1 | NA |
| Ch 16 | 1 | 0 | 0 | 0 | 1 | NA |
| Ch 17 | 2 | 0 | 0 | 0 | 2 | NA |
| Ch 18 | 2 | 0 | 0 | 0 | 2 | NA |
| Ch 19 | 1 | 0 | 0 | 0 | 1 | NA |
| Ch 20 | 1 | 0 | 0 | 0 | 1 | NA |
| Ch 21 | 2 | 0 | 0 | 0 | 2 | NA |
| TOTAL | 520 | 458 | 8 | 16 | 38 | 96.7% |

Pass rate is computed as `(EXACT + APPROX) / (EXACT + APPROX + MISMATCH)`.
Rows marked `UNVERIF` are excluded from the denominator.

## Legacy Examples

`Exam4.1`, `Exam5.1`, `Exam5.2`, and `Exam5.3` are classified as legacy
numbered examples because those exact example numbers are absent from the
2024 2nd edition. The former 1st-edition ordinal and nominal Chapter 11
examples are now represented in Chapter 14 files (`Exam14.1`, `Exam14.2`,
`DataSet14.1`, `DataSet14.2`).

## Unverified Quantities

* `Exam11.4`: the book prints only selected least-squares means for levels
  `a = 1` and `a = 7`; the original `sp_counts` file was unavailable.
  The package dataset is therefore synthetic and not numerically verified
  against all book cells.
* SAS generalized Poisson output in Section 11.4.5 was extracted but not
  reproduced because the package does not import a generalized Poisson GLMM
  engine equivalent to the custom PROC GLIMMIX likelihood statements.
* Chapter 2 Appendix B examples are syntax/design-matrix demonstrations in
  the 2024 text; no fitted numerical output is printed for direct comparison.
* Chapter 8.6 is figure-only for the fitted Hoerl/Gompertz response surfaces.
* SAS GLIMMIX NOBOUND and predictable-function BLUP standard errors in
  Chapters 9 and 10 are not directly available from the current lme4/lmerTest
  workflow.
* Chapter 12 and 14 exported examples are legacy topics rather than exact
  numbered 2024 examples; Chapter 13 has no exported package example.
* Chapter 17, 18, and 21 exported examples are legacy topics rather than exact
  numbered 2024 examples; Chapters 15, 16, 19, and 20 have no exported package
  example.

## Full-Book Status

All exported package examples are now either numerically checked or explicitly
classified as legacy/no-export for this pass. Full numerical reproduction of
book-only examples still requires adding the missing 2024 datasets/examples.
