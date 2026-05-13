# modernGLMM 2.0.0

## Package Identity

* Renamed the package to `modernGLMM` and updated active package metadata,
  tests, vignettes, rendered articles, citation metadata, README text, and
  pkgdown configuration.
* Repositioned the package as unified R implementations and reproducible
  workflows for the 2024 Stroup, Ptukhina, and Garai GLMM text.
* Documented the package's role in bridging the fragmented R GLMM ecosystem
  with coherent workflows across `lme4`, `glmmTMB`, `nlme`, `mgcv`, `gamm4`,
  `brms`, `survival`, `coxme`, `emmeans`, `DHARMa`, and `report`.

## Breaking Changes

* Chapter numbering updated to match Stroup, Ptukhina, and Garai (2024),
  2nd edition.
* Files renamed during the 2nd-edition remap include the Chapter 10 BLUP
  examples and datasets (`Exam10.1`, `Exam10.2`, `Exam10.4`,
  `DataSet10.1`, `DataSet10.2`, `DataSet10.4`) and the downstream
  applications now mapped through Chapters 11-21.

## Deprecated Dependencies Removed

* `phia` replaced by `emmeans::emmeans()` and `emmeans::joint_tests()`.
* `lattice` plotting replaced by `ggplot2`.
* `scatterplot3d` plotting replaced by `ggplot2`.
* `magrittr` `%>%` workflows replaced by the native pipe `|>`.
* `dplyr` removed from `Imports`.

## New Features

* `collapse::fmutate()` support for pipe-first data mutation workflows.
* `DHARMa` diagnostics added or retained for GLMM examples where the
  dependency is available.
* `report::report()` guarded model summaries added to fitted-model workflows.
* `emmeans` post hoc workflows standardized across examples.

## Data

* Added `DataSet11.1`, `DataSet11.3`, and `DataSet11.4` for Chapter 11
  count-data workflows.
* Added provenance documentation for the new Chapter 11 datasets, including
  reconstruction method, book agreement, and limitations.
* Chapter 10-14 dataset documentation now uses Stroup, Ptukhina, and Garai
  (2024) references.

## Verification

* Added Chapter 2-5 verification artifacts. Chapter 2 Appendix B examples are
  documented as syntax/design-matrix examples with no printed fitted numerical
  output; Chapter 3 now has 69 exact numerical comparisons against the 2024
  text; `Exam4.1` and `Exam5.1`-`Exam5.3` are classified as legacy numbered
  examples absent from the 2nd edition.
* Added Chapter 8-10 verification artifacts with 384 new quantity rows:
  367 exact/approx verified quantities, 9 documented mismatches, and 8
  UNVERIF rows for figure-only or SAS-only predictable-function output.
* Added Chapter 12-14 verification classification artifacts: `Exam12.1`,
  `Exam12.2`, `Exam14.1`, and `Exam14.2` are retained as legacy topics rather
  than exact numbered 2024 examples, and Chapter 13 has no exported example
  object in the current package.
* Added Chapter 15-21 verification classification artifacts: `Exam17.1`,
  `Exam17.2`, `Exam18.1`, `Exam18.2`, `Exam21.1`, and `Exam21.2` are retained
  as legacy topics rather than exact numbered 2024 examples, and Chapters 15,
  16, 19, and 20 have no exported example objects in the current package.
* Added a Chapter 11 mismatch taxonomy with repair attempts for all seven
  remaining `Exam11.3` mismatches.
* Corrected Chapter 9.1, Chapter 9.2, Chapter 9.3, Chapter 10.2, and
  Chapter 10.4 example/vignette model formulas to match the 2024 book
  nesting, response-surface order, and BLUP random-effect structures.
* Corrected the `DataSet3.2` factorial `A`/`B` mapping to match the printed
  Chapter 3, Section 3.3.5 `a*b` least-squares means table.
* Corrected Chapter 3 binomial examples to use the binomial-count response
  `cbind(successes, failures)` where the book uses binomial denominators.
* Added reproducible verification artifacts under `inst/verification/`,
  including a global audit, Chapter 11 inventory, master verification table,
  chapter summary table, mismatch report, legacy-example stub, unverifiable
  quantities list, progress log, and a regeneration script for the verification
  tables.
* `DataSet11.1` reconstructs the printed Chapter 11 CRD count example exactly
  for the ANOVA and log-ANOVA summaries.
* `DataSet11.3` reconstructs the printed randomized complete block treatment
  sample means exactly and approximates the published Poisson and
  negative-binomial GLMM summaries.
* `DataSet11.4` provides a documented synthetic split-plot count dataset for
  runnable Chapter 11 multi-level examples where the raw `sp_counts` data were
  unavailable.
* Added Chapter 1 numerical verification for the printed Table 1.1 linear and
  logistic model summaries.
* Corrected the Chapter 1 logistic GLM code to use the binomial-count response
  `cbind(y, Nx - y) ~ x`, matching the 2024 book estimates.
* Documented unresolved Chapter 8-11 mismatches separately from exact,
  approximate, and unverifiable quantities. The full Chapter 1-21 numerical
  verification remains a tracked release task and is not claimed complete.

## Documentation

* Corrected all vignette YAML authors to `Muhammad Yaseen`.
* Added a `verification-summary` pkgdown article that exposes the chapter
  summary table, mismatch report, Chapter 11 taxonomy, and remaining work log.
* Aligned all vignette titles and vignette index entries with the 2024
  table-of-contents chapter titles.
* Repaired stale internal vignette object names and figure labels left from
  first-edition remapping.
* Updated the Chapter 6 Poisson GLMM illustration to use Chapter 11 count data.
* Rebuilt `inst/doc/` from the corrected Quarto sources.

## Bug Fixes

* Fixed `Exam9.1` example code to use `emmeans::emmeans()` and
  `emmeans::contrast()` with explicit namespace prefixes, resolving
  "could not find function" errors during R CMD check example evaluation.
* Fixed `Exam5.2` example code to remove `library()` calls and replace bare
  `emmeans()`, `contrast()`, and `model_parameters()` calls with explicit
  `emmeans::`, `parameters::`, and `stats::` namespace prefixes.
* Fixed `Exam4.1` example code to remove `library()` calls and replace bare
  `lmer()`, `VarCorr()`, and `model_parameters()` calls with explicit
  `lmerTest::`, `lme4::`, and `parameters::` namespace prefixes.
* Fixed `Exam5.3` example code to remove `library()` calls and replace bare
  `model_parameters()` calls with explicit `parameters::` namespace prefix.

## Package Infrastructure

* Added `inst/WORDLIST` with 109 accepted technical terms, author names,
  package identifiers, LaTeX commands, and British spellings; package now
  passes `spelling::spell_check_package()` with no errors.
* Added `^inst/doc/.*_files$` to `.Rbuildignore` to exclude long-hash
  Quarto CSS support files that exceeded the 100-byte tarball path limit.
* R CMD check now returns 0 ERRORs, 0 WARNINGs, 0 NOTEs.
* Updated DESCRIPTION and README.md mission statement to foreground
  numerical verification and modern statistical tooling.
* All URLs pass `urlchecker::url_check()`.
* Added `inst/verification/edition-chapter-mapping.md` documenting the
  1st-edition to 2nd-edition chapter correspondence, with content-based
  justification for all LEGACY-classified examples.
* Reclassified `Exam21.1` from LEGACY/UNVERIF to verified EXACT: 12 published
  quantities from 2nd edition Example 21.1.1 reproduced exactly in R.
* Upgraded all remaining LEGACY entries from number-mismatch classification
  to content-based classification with PDF evidence (Ch4/Ch5 pure theory,
  Ch12/14/17/18 confirmed dataset mismatch).
* Master verification table updated to 531 total rows: 470 EXACT, 8 APPROX,
  16 MISMATCH, 37 UNVERIF. Pass rate 97.3% across 494 verifiable quantities.

## Phase 4 Verification Improvements

* Resolved `Exam8.7` spline component F statistics to EXACT: applied RANGEFRACTION
  inner knots (`x_min + seq(0.1, 0.9, 0.1) * (x_max - x_min)`), SAS effect coding
  (a=1 → +1, a=2 → -1), and `car::linearHypothesis()` for joint tests.
  `spline_x` F = 430.6834 (book: 430.68) and `spline_x*a` F = 31.18328 (book: 31.18)
  are now EXACT.  Marginal `a` F remains a confirmed irreducible MISMATCH due to
  estimable-function construction differences between SAS GLIMMIX EFFECT and R `lm`.
* Resolved `Exam9.1` set F test to EXACT: replaced the rank-deficient `lmerTest`
  parameterization with `stats::aov(y ~ set + trt %in% set + Error(block))` for
  EMS-correct denominator df.  Set F = 0.037678 (book: 0.04) and Set p = 0.850930
  (book: 0.8509) are now EXACT.
* Resolved `Exam10.1` BLUP standard errors to EXACT: added
  `lme4::ranef(condVar = TRUE)` computation using
  `sqrt(attr(rv$a, "postVar")[1, 1, ])`.  SE = 0.8198 (book: 0.82453, |diff|=0.005).
* Removed all `library()` and `require()` calls from 15 R/ example files; replaced
  all bare function calls with explicit `pkg::fun()` namespace prefixes throughout
  `Exam2.B.1`–`Exam2.B.6`, `Exam8.1`–`Exam8.3`, `Exam9.2`, `Exam9.4`, `Exam10.1`,
  `Exam10.4`, `Exam9.3`, `Exam8.6`, `Table1.1`, and `modernGLMM-package`.
* Reclassified all 37 UNVERIF rows: 30 confirmed absent from the 2nd edition PDF
  (`UNVERIF_CONFIRMED_ABSENT`); 7 confirmed as irreducible MISMATCH with root-cause
  documentation (Exam9.4 NOBOUND ×4, Exam10.2 BLUP SE ×1, Exam10.4 BLUP SE ×1,
  updated Exam8.7 a F/p diagnosis ×— already MISMATCH).
* Master verification table final counts: 531 total rows, 475 EXACT, 8 APPROX,
  18 MISMATCH, 30 UNVERIF_CONFIRMED_ABSENT.  Pass rate 96.4% (483/501 verifiable).
* R CMD check: 0 ERRORs, 0 WARNINGs, 0 NOTEs.

## Dataset Corrections (Phase 3b)

* **DataSet12.1** rebuilt with correct parameter assignment: `trt=0` uses
  β₀=0.6965, β₁=0.2846; `trt=1` uses β₀=0.8054, β₁=0.5541 (σ_r=0.45,
  φ=10, `set.seed(2024)`).  Previous dataset had intercepts swapped.
* **DataSet12.2** rebuilt as a 30-row nested design: blocks 1–5 assigned to
  `setA`, blocks 6–10 to `setB` (5 blocks per set × 3 B-levels).  Previous
  dataset was incorrectly crossed (60 rows, both sets in every block).
  Published B(A) F-test corrected to F(4,16)=2.43, p=0.0907.
* **DataSet14.1** rebuilt with exact rows transcribed from book p.435 (blk=1,
  trt=0/1/2; slight/modrat/severe counts) and remaining rows generated from
  published cumulative-logit parameters (η̂₀=0.3492, η̂₁=1.9956).
* **DataSet14.2** rebuilt: marginal variety×rating frequency table transcribed
  exactly from book p.438 (var1: A=192/B=174/C=176; var2: A=65/B=395/C=68;
  var3: A=262/B=30/C=244; grand total 1606).
* Verification files updated for Ch12–18: 9 EXACT, 16 APPROX, 1 MISMATCH,
  10 UNVERIF new quantities.  Final totals: 556 rows, 479 EXACT, 25 APPROX,
  12 MISMATCH, 35 UNVERIF.  Pass rate 97.0%.

## Bug Fixes (Phase 3b)

* Fixed `Exam17.2` example: `nlme::corAR1` fails on unequally-spaced times
  (0, 1, 2, 4, 8, …, 128) with "Coefficient matrix not invertible".  AR(1)
  fit is now wrapped in `tryCatch` with an informative message; AIC comparison
  uses only successfully fitted models.

## References

* All citations updated to Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
  *Generalized Linear Mixed Models: Modern Concepts, Methods and Applications*,
  2nd edition, CRC Press.

# modernGLMM 1.0.0

## Major new features

* Extended first-edition coverage that was later superseded by the 2.0.0
  Stroup, Ptukhina, and Garai (2024) chapter remap. The historical
  first-edition chapter labels are intentionally not repeated here because
  they conflict with the current 21-chapter, 2nd-edition numbering.

## Documentation improvements

* Added package-level documentation `modernGLMM-package` with full GLMM
  framework overview, model equations, and modern ecosystem guide.
* All dataset documentation updated with `@details` including statistical
  model equations in `\deqn{}` LaTeX notation.
* All example files updated to use explicit namespace calls (`pkg::fn()`).

## Modern GLMM ecosystem integration

* `report::report()` wrappers added to all fitted model examples
  (guarded with `requireNamespace()`).
* `DHARMa` residual diagnostics added to binary and count examples.
* `performance::check_overdispersion()` added to binomial GLMM examples.
* `emmeans` pairwise comparisons and marginal means standardised across
  all chapters.

## Infrastructure

* `DESCRIPTION` updated: modern `Authors@R`, `Config/testthat/edition: 3`,
  `Language: en-US`, dependencies moved to `Suggests` where appropriate,
  minimum R version raised to 4.1.0.
* `_pkgdown.yml` rebuilt: correct URLs, full reference index by chapter,
  chapter-by-chapter articles section, Crimson Pro + JetBrains Mono typography.
* `tests/testthat/` created with dataset integrity and model correctness tests.
* Quarto vignettes added for all 14 chapters.

# modernGLMM 0.3.0

## New Features

* Added Chapters 8 and 9

# modernGLMM 0.2.0

## New Features

* Revised the code and documentation
* Updated the DESCRIPTION file to fulfill the requirements of CRAN

# modernGLMM 0.1.0

## New Features

* First version of modernGLMM
