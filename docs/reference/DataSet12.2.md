# Data for Example 12.2 — Binomial Nested Factorial (Chapter 12)

Binomial count data from a nested factorial design with factor A (2
levels, representing two sets) and factor B (3 levels nested within A),
replicated across 10 blocks (5 blocks per set). Implements Section
12.3.2 of Stroup et al. (2024), Data Set 12.2 (SAS name `ch11_ex_12C2`).
The response is the number of successes out of a fixed total, suitable
for binomial GLMM analysis.

**Reconstruction note:** The actual data appear in the SAS Data and
Program Library as Data Set 12.2. This version is reconstructed from the
published design description (5 blocks × setA + 5 blocks × setB, 3
treatments B0/B1/B2 per block, N=20 per cell, 30 obs total) and the
published logit B(A) LSMeans (p.382) using `set.seed(123)`. Numerical
output will approximate published values.

## Usage

``` r
data(DataSet12.2)
```

## Format

A `data.frame` with 30 rows and 5 variables:

- block:

  Block factor with 10 levels (1–10); blocks 1–5 are assigned to `setA`,
  blocks 6–10 to `setB`

- a:

  Set factor with 2 levels (`setA`, `setB`); each set assigned to 5
  blocks (whole-plot factor)

- b:

  Treatment factor nested within A, with 3 levels (`B0`, `B1`, `B2`)
  within each set

- f:

  Number of successes (integer count)

- n:

  Total number of trials per cell (integer, N=20)

## Details

The binomial GLMM for the nested factorial structure is:
\$\$\text{logit}(\pi\_{ijk}) = \eta + \alpha_i + \beta\_{j(i)} +
r\_{k(i)}\$\$ where \\\alpha_i\\ is the set (A) effect,
\\\beta\_{j(i)}\\ is the treatment B nested within A, and \\r\_{k(i)}
\sim \mathcal{N}(0, \sigma^2_A)\\ is the block-within-A random effect
(whole-plot error).

Published results (2nd ed. p.382): \\\hat\sigma^2_A = 0.4784\\
(SE=0.2664); A: F(1,8)=0.46, p=0.5187; B(A): F(4,16)=2.43, p=0.0907.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications*. CRC
    Press. Section 12.3.2, pp.388-392.

## Examples

``` r
data(DataSet12.2)
str(DataSet12.2)
#> 'data.frame':    30 obs. of  5 variables:
#>  $ block: Factor w/ 10 levels "1","2","3","4",..: 1 1 1 2 2 2 3 3 3 4 ...
#>  $ a    : Factor w/ 2 levels "setA","setB": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ b    : Factor w/ 3 levels "B0","B1","B2": 1 2 3 1 2 3 1 2 3 1 ...
#>  $ f    : int  9 9 8 13 10 10 14 14 15 6 ...
#>  $ n    : int  20 20 20 20 20 20 20 20 20 20 ...
with(DataSet12.2, tapply(f / n, list(a, b), mean))
#>        B0   B1   B2
#> setA 0.52 0.59 0.50
#> setB 0.28 0.33 0.48
```
