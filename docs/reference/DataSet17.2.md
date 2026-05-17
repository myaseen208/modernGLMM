# Data for Example 17.2 — Sparse Longitudinal Data with SP(POW) (Chapter 17)

Sparse longitudinal data from 41 subjects (17 on treatment 1, 24 on
treatment 2) observed at up to 9 unequally-spaced time points (0, 1, 2,
4, 8, 16, 32, 64, 128), with only 101 of 369 possible observations
present. Implements Example 17.3.2 of Stroup et al. (2024), Data Set
17.2 (SAS name `all`). Demonstrates the SP(POW) spatial-power covariance
as a generalisation of AR(1) to irregular time grids.

**Reconstruction note:** The actual data appear in the SAS Data and
Program Library as Data Set 17.2. This version is reconstructed from the
published design description (41 subjects, 9 unequal times, sparse
101/369 observations) and published random coefficient model parameters
(pp.516-518) using `set.seed(2024)`. Published AICC and parameter
estimates will not be reproduced exactly.

## Usage

``` r
data(DataSet17.2)
```

## Format

A `data.frame` with 101 rows and 4 variables:

- subject:

  Subject identifier (factor with 41 levels)

- trt:

  Treatment factor with 2 levels (1, 2); 17 subjects on trt=1, 24
  subjects on trt=2

- time:

  Actual time of measurement: one of 0, 1, 2, 4, 8, 16, 32, 64, 128
  (continuous; unequally spaced)

- y:

  Continuous Gaussian response

## Details

For unequally-spaced observations, the SP(POW) covariance between
observations at times \\X_j\\ and \\X\_{j'}\\ on the same subject is:
\$\$\text{Cov}(e_j, e\_{j'}) = \sigma^2 \rho^{\|X_j - X\_{j'\|}}\$\$
Unlike AR(1), SP(POW) accommodates unequal spacing and missing
observations. The random coefficient model is: \$\$y\_{ik} =
\beta\_{0i} + b\_{0k} + (\beta\_{1i} + b\_{1k}) X_j + e\_{ijk}\$\$ where
\\b\_{0k}\\ and \\b\_{1k}\\ are random intercept and slope.

Published results (2nd ed. pp.517-518): Best = heterogeneous SP(POW) by
treatment, AICC=575.96; Homogeneity test: \\\chi^2\\=8.65, p=0.0132.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications*. CRC
    Press. Section 17.3.2, pp.516-518.

2.  Littell, R.C., Milliken, G.A., Stroup, W.W., Wolfinger, R.D., &
    Schabenberger, O. (2006). *SAS for Mixed Models*, 2nd ed. SAS
    Institute.

## Examples

``` r
data(DataSet17.2)
str(DataSet17.2)
#> 'data.frame':    101 obs. of  4 variables:
#>  $ subject: Factor w/ 41 levels "1","2","3","4",..: 1 1 2 2 2 3 3 3 3 4 ...
#>  $ trt    : Factor w/ 2 levels "1","2": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ time   : num  32 128 2 4 128 0 4 8 16 0 ...
#>  $ y      : num  -0.123 -19.122 6.697 8.426 -36.56 ...
cat("Observations per treatment:\n")
#> Observations per treatment:
print(table(DataSet17.2$trt))
#> 
#>  1  2 
#> 48 53 
cat("Sparsity:", nrow(DataSet17.2), "of",
    length(unique(DataSet17.2$subject)) * 9, "possible\n")
#> Sparsity: 101 of 369 possible
```
