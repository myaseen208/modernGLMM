# Data for Example 18.2 — Hessian Fly Trial: Binomial Spatial (Chapter 18)

Binomial resistance data from a 4×4 lattice trial of 16 wheat varieties
on a 12×12 field grid, with 64 plots. Implements Section 18.4 of Stroup
et al. (2024), Data Set 18.2 (SAS name `HessianFly`). Demonstrates
spatial binomial GLMM analysis with model comparison across RCB,
incomplete block, and spatial covariance structures via AICC.

**Reconstruction note:** The actual data appear in the SAS Data and
Program Library as Data Set 18.2. This version is reconstructed from the
published design description (16 varieties, 4×4 lattice, 4 incomplete
blocks, 64 plots, binomial response) and published spatial parameters
(SP(SPH)=3.2256, \\\sigma^2\\=0.5111, pp.573-579) using
`set.seed(2024)`. Published AICC values will not be reproduced exactly.

## Usage

``` r
data(DataSet18.2)
```

## Format

A `data.frame` with 64 rows and 6 variables:

- block:

  Complete block (replicate) factor with 4 levels; each block contains
  all 16 varieties

- variety:

  Wheat variety factor with 16 levels (v01–v16)

- row:

  Plot row position in the 12×12 field grid (integer)

- col:

  Plot column position in the 12×12 field grid (integer)

- y:

  Number of Hessian fly-damaged plants (integer count)

- n:

  Total number of plants per plot (integer)

## Details

The G-side binomial GLMM with spherical spatial random effects is:
\$\$y\_{ij} \| b\_{ij} \sim \text{Binomial}(n\_{ij}, \pi\_{ij})\$\$
\$\$\text{logit}(\pi\_{ij}) = \eta + \tau_v + b\_{ij}\$\$ where
\\\tau_v\\ is the variety fixed effect and \\b\_{ij}\\ is a spatial
random effect with spherical covariance structure:
\$\$\text{Cov}(b\_{ij}, b\_{i'j'}) = \sigma^2
\text{sph}(d\_{ij,i'j'}/r)\$\$

Published results (2nd ed. pp.573-579): AICC: RCB=317.27, Incomplete
block=296.64; F_entry(RCB)=6.81. G-side spherical: SP(SPH)=3.2256,
\\\sigma^2\\=0.5111, AICC=301.91.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications*. CRC
    Press. Section 18.4, pp.573-579.

## Examples

``` r
data(DataSet18.2)
str(DataSet18.2)
#> 'data.frame':    64 obs. of  6 variables:
#>  $ block  : Factor w/ 4 levels "1","2","3","4": 1 1 2 2 3 3 4 4 1 1 ...
#>  $ variety: Factor w/ 16 levels "1","2","3","4",..: 1 9 1 3 1 3 1 3 2 10 ...
#>  $ row    : int  1 1 1 1 1 1 1 1 2 2 ...
#>  $ col    : int  1 2 3 4 5 6 7 8 1 2 ...
#>  $ y      : int  7 0 7 0 5 2 4 6 4 0 ...
#>  $ n      : int  20 20 20 20 20 20 20 20 20 20 ...
with(DataSet18.2, tapply(y / n, variety, mean))
#>      1      2      3      4      5      6      7      8      9     10     11 
#> 0.2875 0.2500 0.1500 0.1000 0.3000 0.3125 0.2250 0.1375 0.0500 0.0375 0.0125 
#>     12     13     14     15     16 
#> 0.1875 0.1875 0.1250 0.0000 0.1000 
```
