# Data for Example 12.1 — Continuous Proportion Dose-Response (Chapter 12)

Continuous proportion data from a dose-response study with two
treatments each applied to 12 runs, observed at six dose levels (0–5).
Implements Section 12.6.2 of Stroup et al. (2024), Data Set 12.7 (SAS
name `rates`). The response is a continuous proportion suitable for beta
regression with a run-level GLMM random effect.

**Reconstruction note:** The actual data appear in the SAS Data and
Program Library as Data Set 12.7. This version is reconstructed from the
published regression parameters (\\\beta\_{0,0}=0.6965\\,
\\\beta\_{1,0}=0.2846\\; \\\beta\_{0,1}=0.8054\\,
\\\beta\_{1,1}=0.5541\\; p.406) with run random effects drawn from
\\N(0, 0.45^2)\\ and Beta precision \\\phi=10\\, using `set.seed(2024)`.
Numerical output will approximate published values.

## Usage

``` r
data(DataSet12.1)
```

## Format

A `data.frame` with 144 rows and 4 variables:

- trt:

  Treatment factor with levels 0 and 1

- run:

  Run factor with 24 levels (t0r1-t0r12, t1r1-t1r12); 12 runs per
  treatment, nested within treatment

- dose:

  Integer dose level: 0, 1, 2, 3, 4, or 5

- proportion:

  Continuous proportion response in \\(0, 1)\\

## Details

The beta GLMM for the linear dose-response within each treatment is:
\$\$\text{logit}(\mu\_{ijk}) = \beta\_{0i} + \beta\_{1i} D_j +
r(\tau)\_{ik}\$\$ where \\r(\tau)\_{ik} \sim \mathcal{N}(0,\sigma^2_r)\\
is the run random effect nested within treatment, and \\D_j\\ is the
dose level.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications*. CRC
    Press. Section 12.6.2, pp.404-407.

2.  Ferrari, S., & Cribari-Neto, F. (2004). Beta regression for
    modelling rates and proportions. *Journal of Applied Statistics*,
    31(7), 799-815.

## Examples

``` r
data(DataSet12.1)
str(DataSet12.1)
#> 'data.frame':    144 obs. of  4 variables:
#>  $ trt       : Factor w/ 2 levels "0","1": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ run       : Factor w/ 24 levels "t0r1","t0r10",..: 1 1 1 1 1 1 2 2 2 2 ...
#>  $ dose      : int  0 1 2 3 4 5 0 1 2 3 ...
#>  $ proportion: num  0.688 0.957 0.863 0.74 0.89 ...
with(DataSet12.1, tapply(proportion, list(trt, dose), mean))
#>           0         1         2         3         4         5
#> 0 0.6939107 0.7212031 0.7210461 0.8140771 0.8964916 0.8705738
#> 1 0.6766403 0.7444827 0.8466202 0.9294818 0.9419682 0.9697002
```
