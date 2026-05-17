# Data Set 11.1 - Completely Randomized Count Data

Two-treatment completely randomized count data used in Chapter 11,
Section 11.1.2 of Stroup, Ptukhina, and Garai (2024) to compare pre-GLM
ANOVA analyses, a Poisson GLM, and a Poisson-normal GLMM with an
observation-level random effect.

## Usage

``` r
data(DataSet11.1)
```

## Format

A `data.frame` with 10 rows and 3 variables:

- trt:

  Treatment factor with levels `1` and `2`.

- unit:

  Replication unit within treatment.

- count:

  Non-negative integer count response.

## Details

The reconstructed counts are `2, 2, 3, 5, 12` for treatment 1 and
`6, 11, 12, 12, 34` for treatment 2.

\*\*Data provenance:\*\* Reconstructed.

\*\*Reconstruction method:\*\* The integer counts were solved from the
published treatment means, log-count means, ANOVA residual mean square,
and log-count ANOVA residual mean square in Chapter 11, Section 11.1.2.

\*\*Book agreement:\*\* Exact for the published untransformed ANOVA
treatment means, F statistic, p-value, log-count treatment means,
log-count standard error, and log-count treatment comparison.
Approximate for the Poisson-normal GLMM when fitted in R because lme4
uses likelihood-based estimation, whereas the book reports SAS PROC
GLIMMIX output.

\*\*Limitations:\*\* The book references the SAS file `Data_Set_11_1`,
but the raw SAS file is not included in this package or in the uploaded
PDF. The reconstruction is therefore based on printed numerical
constraints.

## References

Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
Mixed Models: Modern Concepts, Methods and Applications*, 2nd ed. CRC
Press.

## See also

[`Exam11.1`](https://github.com/myaseen208/modernGLMM/reference/Exam11.1.md)

## Examples

``` r
data(DataSet11.1)
stats::aggregate(count ~ trt, data = DataSet11.1, FUN = mean)
#>   trt count
#> 1   1   4.8
#> 2   2  15.0
```
