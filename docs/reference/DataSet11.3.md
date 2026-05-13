# Data Set 11.3 - Randomized Complete Block Count Data

Three-treatment randomized complete block count data used in Chapter 11,
Section 11.4 of Stroup, Ptukhina, and Garai (2024) to illustrate
overdispersion in blocked count-data models and alternatives including
marginal Poisson, Poisson-normal, negative binomial, and generalized
Poisson models.

## Usage

``` r
data(DataSet11.3)
```

## Format

A `data.frame` with 30 rows and 3 variables:

- block:

  Block factor with 10 levels.

- trt:

  Treatment factor with 3 levels.

- count:

  Non-negative integer count response.

## Details

Treatment sample means are exactly `8.0`, `13.3`, and `25.7`, matching
the printed marginal means in Section 11.4.1.

\*\*Data provenance:\*\* Reconstructed.

\*\*Reconstruction method:\*\* Counts were reconstructed from the
published treatment sample means and selected model summaries in Chapter
11, Section 11.4. The optimization target used the printed naive
Poisson, Poisson-normal, and negative-binomial fitted means, Pearson
chi-square/DF, and variance-component summaries as calibration
constraints.

\*\*Book agreement:\*\* Exact for treatment sample means. Approximate
for R-fitted Poisson and negative-binomial GLMM summaries. The printed
SAS working-covariance marginal model and generalized Poisson fit are
not directly reproducible with base package dependencies.

\*\*Limitations:\*\* The original SAS data file was not available in the
workspace, the uploaded PDF, or public publisher materials located
during verification. Several integer datasets satisfy the printed
summaries; this file is a constrained reconstruction, not a confirmed
original data file.

## References

Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
Mixed Models: Modern Concepts, Methods and Applications*, 2nd ed. CRC
Press.

## See also

[`Exam11.3`](https://github.com/myaseen208/modernGLMM/reference/Exam11.3.md)

## Examples

``` r
data(DataSet11.3)
stats::aggregate(count ~ trt, data = DataSet11.3, FUN = mean)
#>   trt count
#> 1   1   8.0
#> 2   2  13.3
#> 3   3  25.7
```
