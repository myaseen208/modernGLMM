# Chapter 11 Count-Data Inventory

Ground truth: Stroup, Ptukhina, and Garai (2024), Chapter 11.

## Data Set 11.1 / Exam11.1

Book section: 11.1.2, "Poisson Example Pre-GLM ANOVA-Based Analysis and
Poisson GLMM".

Design: two-treatment completely randomized design with five observations per
treatment (`n = 10`). Response is a non-negative integer count.

Treatment structure: `trt` has two levels, 1 and 2.

Random effects: none for the ANOVA and Poisson GLM; observation-within-
treatment unit effect for the Poisson-normal GLMM.

Book models:

| Model | Fixed Effects | Random Effects | Family |
|---|---|---|---|
| ANOVA | `trt` | none | Gaussian |
| Log ANOVA | `trt` on `log(count)` | none | Gaussian |
| Poisson GLM | `trt` | none | Poisson, log link |
| Poisson-normal GLMM | `trt` | unit within treatment | Poisson, log link |

Published quantities extracted: ANOVA F and p, treatment least-squares means
and SEs, log-scale LS-means and back-transformed means, Poisson GLM Pearson
chi-square/DF, Poisson-normal fixed effects and unit variance.

Package status: `DataSet11.1` and `Exam11.1` exist. The dataset is a
reconstruction from printed numerical constraints.

Verification result: exact for the ANOVA/log-ANOVA and Poisson GLM Pearson
diagnostic rows; approximate for selected Poisson-normal GLMM rows because the
book uses SAS PROC GLIMMIX and the package uses `lme4`.

## Data Set 11.3 / Exam11.3

Book section: 11.4, "Blocked Design Example".

Design: three treatments observed in ten complete blocks (`n = 30`). Response
is a non-negative integer count.

Treatment structure: `trt` has three levels; `block` has ten levels.

Random effects: block for the naive Poisson and negative-binomial GLMMs;
block plus block-by-treatment unit effect for the Poisson-normal GLMM.

Book models:

| Model | Fixed Effects | Random Effects | Family |
|---|---|---|---|
| Naive Poisson GLMM | `trt` | block | Poisson, log link |
| Quasi-marginal model | `trt` | block plus residual scale | quasi-Poisson |
| Marginal CS model | `trt` | working compound symmetry by block | quasi-Poisson |
| Poisson-normal GLMM | `trt` | block and block-by-treatment | Poisson, log link |
| Negative-binomial GLMM | `trt` | block | negative binomial |
| Generalized Poisson GLMM | `trt` | block | generalized Poisson |

Published quantities extracted: treatment sample means, naive Poisson
Pearson chi-square/DF and LS-means, Poisson-normal variance components,
negative-binomial variance/scale, and generalized Poisson fit/test statistics.

Package status: `DataSet11.3` and `Exam11.3` exist. The dataset is a
constrained reconstruction because the raw `RCBD_counts` data file was not
available in the workspace, PDF, or publisher materials located during prior
verification.

Verification result: exact for treatment sample means; approximate for the
Poisson-normal block variance; unresolved mismatches remain for the naive
Poisson fitted means, Poisson-normal unit variance, and negative-binomial
variance/scale rows. The generalized Poisson model is documented as
unreproduced because the package does not import a matching generalized
Poisson GLMM likelihood engine.

## Data Set 11.4 / Exam11.4

Book section: 11.5, "Count Data with Multi-Level Experiment".

Design: split-plot count-data experiment with four blocks, seven levels of
whole-plot factor `a`, and four levels of subplot factor `b` (`n = 112`).
Response is a non-negative integer count.

Treatment structure: 7 by 4 factorial.

Random effects: block and block-by-`a` whole-plot effects for the conditional
negative-binomial GLMM; a marginal model with block and compound-symmetry
working covariance is also printed in the book.

Book models:

| Model | Fixed Effects | Random Effects | Family |
|---|---|---|---|
| Marginal model | `a * b` | block plus CS working covariance | quasi-Poisson |
| Negative-binomial GLMM | `a * b` | block and block-by-`a` | negative binomial |

Published quantities extracted: marginal covariance parameters, fixed-effect
tests, selected `a*b` LS-means for `a = 1` and `a = 7`, negative-binomial
covariance parameters, fixed-effect tests, and selected `a*b` LS-means.

Package status: `DataSet11.4` and `Exam11.4` exist. The dataset is synthetic
because the raw `sp_counts` data file was not available.

Verification result: selected displayed means were compared only as a pattern
check and are marked UNVERIF in the master table. The synthetic dataset is an
executable workflow analogue, not a numerical reproduction of all book
outputs.
