# Data for Example 17.1 — Crossover with ARH(1) Covariance (Chapter 17)

Longitudinal data from a two-treatment crossover study with 41 subjects
measured at 6 equally-spaced time points per period (2 periods), plus a
baseline covariate. Implements Example 17.3.1 of Stroup et al. (2024),
Data Set 17.1 (SAS name `x_over_ante1`). Demonstrates covariance model
selection (CS, AR(1), ARH(1)) for repeated measures within a crossover
design.

**Reconstruction note:** The actual data appear in the SAS Data and
Program Library as Data Set 17.1. This version is reconstructed from the
published design description (41 subjects: 17 in sequence 0→1, 24 in
sequence 1→0; 2 periods × 6 times; baseline covariate) and published
regression contrasts (pp.513-516) using `set.seed(2024)`. Published AICC
and F-statistics will not be reproduced exactly.

## Usage

``` r
data(DataSet17.1)
```

## Format

A `data.frame` with 492 rows and 7 variables:

- id:

  Subject identifier (factor with 41 levels)

- sequence:

  Crossover sequence: `"01"` (trt 0 then 1) or `"10"` (trt 1 then 0); 17
  and 24 subjects respectively

- period:

  Period factor with 2 levels (1, 2)

- trt:

  Treatment factor with 2 levels (0, 1)

- t:

  Time index within period: 0, 1, 2, 3, 4, 5 (equally spaced)

- baseline:

  Subject-level baseline covariate (continuous)

- y:

  Continuous Gaussian response

## Details

The random coefficient model with ARH(1) within-subject covariance is:
\$\$y\_{ijkl} = \beta\_{0i} + b\_{0ik} + (\beta\_{1i} + b\_{1ik}) T_j +
\rho_p + \beta_b X_k + e\_{ijkl}\$\$ where \\b\_{0ik}\\ and \\b\_{1ik}\\
are subject-specific random intercept and slope, \\\rho_p\\ is the
period effect, \\X_k\\ is the baseline covariate, and \\e\_{ijkl}\\
follows an ARH(1) structure (heterogeneous variances per time point with
AR(1) lag-1 correlation).

Published results (2nd ed. p.516): Best covariance = ARH(1),
AICC=3035.25. Equal intercepts: F(1,526)=1.16, p=0.2818; Equal slopes:
F(1,104)=4.18, p=0.0434.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications*. CRC
    Press. Section 17.3.1, pp.513-516.

2.  Verbeke, G., & Molenberghs, G. (2000). *Linear Mixed Models for
    Longitudinal Data*. Springer.

## Examples

``` r
data(DataSet17.1)
str(DataSet17.1)
#> 'data.frame':    492 obs. of  7 variables:
#>  $ id      : Factor w/ 41 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ sequence: Factor w/ 2 levels "01","10": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ period  : Factor w/ 2 levels "1","2": 1 1 1 1 1 1 2 2 2 2 ...
#>  $ trt     : Factor w/ 2 levels "0","1": 1 1 1 1 1 1 2 2 2 2 ...
#>  $ t       : int  0 1 2 3 4 5 0 1 2 3 ...
#>  $ baseline: num  2.5 2.5 2.5 2.5 2.5 ...
#>  $ y       : num  6.83 4.74 6.1 7.01 7.26 ...
cat("Subjects per sequence:\n")
#> Subjects per sequence:
print(table(unique(DataSet17.1[, c("id", "sequence")])$sequence))
#> 
#> 01 10 
#> 17 24 
```
