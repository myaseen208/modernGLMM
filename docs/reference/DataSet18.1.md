# Data for Example 18.1 — Alliance Wheat Trial: Gaussian Spatial (Chapter 18)

Wheat yield data from a 12×12 field grid (144 plots) with 48 treatments
and 3 complete blocks (columns 1–4, 5–8, 9–12). Implements Section 18.3
of Stroup et al. (2024), Data Set 18.1 (SAS names `ch15_ex1` /
`asademo`). Demonstrates spatial covariance model selection (spherical,
exponential, Gaussian) via AICC for a Gaussian response.

**Reconstruction note:** The actual data appear in the SAS Data and
Program Library as Data Set 18.1 (Alliance wheat trial). This version is
reconstructed from the published design description (48 treatments,
12×12 grid, 3 column blocks) and published spatial parameters
(range=4.1214, \\\sigma^2\\=14.0107, pp.569-571) using `set.seed(2024)`.
Published AICC values and range estimates will not be reproduced
exactly.

## Usage

``` r
data(DataSet18.1)
```

## Format

A `data.frame` with 144 rows and 5 variables:

- row:

  Field row position (integer, 1–12)

- col:

  Field column position (integer, 1–12)

- block:

  Complete block factor: columns 1-4 = block 1, columns 5-8 = block 2,
  columns 9-12 = block 3

- trt:

  Treatment factor with 48 levels (t01–t48); each treatment appears once
  per block

- y:

  Continuous wheat yield response

## Details

Spatial models replace the iid residual assumption with a covariance
function of Euclidean distance \\d\_{ij}\\ between plots. The spherical
covariance (SP(SPH)), which is the best model in the book, is:
\$\$C(d\_{ij}) = \begin{cases} \sigma^2 \left\[1 - \frac{3d\_{ij}}{2r} +
\frac{d\_{ij}^3}{2r^3}\right\] & d\_{ij} \< r \\ 0 & d\_{ij} \ge r
\end{cases}\$\$ where \\r\\ is the range parameter and \\\sigma^2\\ is
the sill.

Published results (2nd ed. pp.569-571): SP(SPH): range=4.1214, residual
\\\sigma^2\\=14.0107. AICC: Spherical=512.9, Exponential=521.9,
Gaussian=530.9, Incomplete block=588.8, Complete block=597.9.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications*. CRC
    Press. Section 18.3, pp.563-573.

2.  Pinheiro, J., & Bates, D. (2000). *Mixed-Effects Models in S and
    S-PLUS*. Springer.

## Examples

``` r
data(DataSet18.1)
str(DataSet18.1)
#> 'data.frame':    144 obs. of  5 variables:
#>  $ row  : int  1 1 1 1 1 1 1 1 1 1 ...
#>  $ col  : int  1 2 3 4 5 6 7 8 9 10 ...
#>  $ block: Factor w/ 3 levels "1","2","3": 1 1 1 1 2 2 2 2 3 3 ...
#>  $ trt  : Factor w/ 48 levels "1","2","3","4",..: 2 42 24 38 6 33 40 18 4 34 ...
#>  $ y    : num  60.1 86.2 49.6 75.2 69.2 ...
with(DataSet18.1, table(block))
#> block
#>  1  2  3 
#> 48 48 48 
```
