
# modernGLMM

[![R \>=
4.1.0](https://img.shields.io/badge/R-%3E%3D%204.1.0-276DC3.svg)](https://www.r-project.org/)
[![License:
GPL-3](https://img.shields.io/badge/License-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![Lifecycle:
active](https://img.shields.io/badge/lifecycle-active-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#active)

`modernGLMM` provides unified, reproducible R implementations of examples
from Stroup, Ptukhina, and Garai (2024), bridging the fragmented
mixed-model ecosystem in R through consistent workflows, numerical
verification, and modern statistical tooling.

> Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
> Mixed Models: Modern Concepts, Methods and Applications* (2nd ed.).
> CRC Press.

The book supplies SAS code for its worked examples and documents why no
single R implementation was provided at the time of publication: the R
GLMM ecosystem is broad and capable but spread across many specialized
packages. `modernGLMM` closes that gap with coherent companion workflows,
systematic numerical verification against the printed text, and a unified
interface to `lme4`, `glmmTMB`, `nlme`, `emmeans`, `DHARMa`, `report`,
and related packages.

The package is intended for reproducible teaching, applied GLMM analysis,
and verification of model-fitting workflows.

## Scope

`modernGLMM` includes datasets, example scripts, vignettes, and
verification artifacts for workflows spanning:

- Gaussian linear and mixed models
- Generalized linear models and generalized linear mixed models
- BLUPs and predictable functions
- Treatment structures and multi-level designs
- Counts, rates, proportions, multinomial responses, and zero-inflated
  models
- Time-to-event data, smoothing splines, repeated measures, correlated
  errors, Bayesian GLMMs, and power analysis

The R implementation layer uses `lme4`, `glmmTMB`, `nlme`, `mgcv`,
`gamm4`, `brms`, `survival`, `coxme`, `emmeans`, `DHARMa`, `report`, and
related packages where each tool is appropriate.

## Installation

Install the development version from GitHub:

``` r
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("myaseen208/modernGLMM")
```

After CRAN release, install with:

``` r
install.packages("modernGLMM")
```

## Example

``` r
library(modernGLMM)

data(DataSet11.1)

fit <- stats::glm(
  y ~ trt,
  family = stats::poisson(link = "log"),
  data = DataSet11.1
)

summary(fit)

if (requireNamespace("emmeans", quietly = TRUE)) {
  emmeans::emmeans(fit, specs = ~ trt, type = "response")
}

if (requireNamespace("report", quietly = TRUE)) {
  report::report(fit)
}
```

## Verification Status

Verification artifacts are stored in `inst/verification/`. Current
verification covers Chapter 1, Chapters 2-5, Chapters 8-10, Chapter 11,
and Chapter 12-21 legacy/no-export classifications. Full numerical
reproduction is claimed only for rows marked `EXACT` or `APPROX`.

## Citation

``` r
citation("modernGLMM")
```
