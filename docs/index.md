# modernGLMM

[![R \>=
4.1.0](https://img.shields.io/badge/R-%3E%3D%204.1.0-276DC3.svg)](https://www.r-project.org/)
[![License:
GPL-3](https://img.shields.io/badge/License-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

`modernGLMM` provides reproducible R implementations of all worked
examples from:

> Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
> Mixed Models: Modern Concepts, Methods and Applications* (2nd ed.).
> CRC Press.

The book supplies SAS code for its worked examples. `modernGLMM`
provides equivalent R implementations using `lme4`, `glmmTMB`, `nlme`,
`emmeans`, and `car`, with numerical results independently verified
against the printed text.

## Installation

``` r
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("myaseen208/modernGLMM")
```

## Implemented Examples

| Chapter | Topic                                      | Functions                                  |
|---------|--------------------------------------------|--------------------------------------------|
| 1       | Linear and logistic regression review      | `Exam1.1`, `Exam1.2`                       |
| 3       | Treatment structures and factorial designs | `Exam3.2`, `Exam3.3`, `Exam3.5`, `Exam3.9` |
| 8       | Mixed model foundations and splines        | `Exam8.1`, `Exam8.2`, `Exam8.3`, `Exam8.7` |
| 9       | Variance component estimation              | `Exam9.1`, `Exam9.2`, `Exam9.3`, `Exam9.4` |
| 10      | BLUPs and predictable functions            | `Exam10.1`, `Exam10.2`, `Exam10.4`         |
| 11      | Count data GLMMs                           | `Exam11.1`, `Exam11.3`                     |
| 21      | Power analysis for GLMMs                   | `Exam21.1`                                 |

Chapters 12–18 depend on the SAS Data and Program Library that
accompanies the book. These chapters are included as documented
functions and datasets; full numerical verification awaits access to
those data (see `inst/verification/datasets-not-yet-available.md`).

## Verification

Numerical results have been independently verified against the 2nd
edition.

| Status                   |     Count | Description                                                       |
|--------------------------|----------:|-------------------------------------------------------------------|
| EXACT                    |       477 | Matches book value within tolerance (                             |
| APPROX                   |        10 | Matches within wider tolerance (                                  |
| MISMATCH_IRREDUCIBLE     |        14 | Documented irreducible discrepancy (SAS/R estimation differences) |
| UNVERIF_CONFIRMED_ABSENT |        30 | No printed target in 2nd edition or dataset not yet available     |
| **Pass rate**            | **97.2%** | 487 / 501 verifiable quantities                                   |

Full results: `inst/verification/verification-results.csv`

Documented irreducible mismatches arise from:

- SAS GLIMMIX estimable-function construction (Exam8.7, Exam10.4)
- Kenward–Roger denominator df at variance-component boundary (Exam9.4)
- SAS NOBOUND allowing negative variance components; R enforces VC ≥ 0
  (Exam9.4)
- Exam11.3 dataset reconstructed from published sample means; SAS uses
  PL, R uses ML

## Quick Start

``` r
library(modernGLMM)

# Chapter 11: Poisson GLMM for count data
Exam11.1()

# Chapter 9: Variance component estimation (REML)
Exam9.1()

# Chapter 21: Power analysis for a GLMM
Exam21.1()
```

## Requesting the SAS Data and Program Library

Chapters 12–18 use datasets from the SAS Data and Program Library
accompanying the book. To request access, contact:

- **Author:** Walter W. Stroup — <wstroup1@unl.edu>
- **Publisher:** <mpkbookspermissions@tandf.co.uk>

## Citation

``` r
citation("modernGLMM")
```

Yaseen, M., Munawar, A., Stroup, W. W., Ptukhina, M., and Garai, S.
(2026). *modernGLMM: R Implementation of Examples from Stroup, Ptukhina
and Garai (2024) Generalized Linear Mixed Models* (Version 0.1.0).
GitHub. <https://github.com/myaseen208/modernGLMM>
