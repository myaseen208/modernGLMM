# Data for Example 14.1 — Ordinal Proportional Odds GLMM (Chapter 14)

Ordinal frequency count data from a randomised complete block design
with 6 treatments and 10 blocks. The response is a three-category
ordered rating (slight, moderate, severe). Implements Section 14.3 of
Stroup et al. (2024), Data Set 14.1 (SAS name `univar_multinom`).
Suitable for proportional-odds (cumulative logit) GLMM analysis.

**Reconstruction note:** The first 9 rows (block 1, treatments 0–2) are
transcribed exactly from the published table (p.435 of the 2nd ed.). The
remaining 171 rows are reconstructed from the published cumulative-logit
parameters (\\\hat\eta_0=0.3492\\, \\\hat\eta_1=1.9956\\, treatment
effects pp.436-437) using `set.seed(2024)`. The actual data appear in
the SAS Data and Program Library as Data Set 14.1.

## Usage

``` r
data(DataSet14.1)
```

## Format

A `data.frame` with 180 rows and 4 variables:

- blk:

  Block factor with 10 levels (1–10)

- trt:

  Treatment factor with 6 levels (0–5)

- rating:

  Ordered factor with levels `slight` \< `modrat` \< `severe`

- y:

  Frequency count of observations in this blk × trt × rating cell
  (non-negative integer)

## Details

The proportional-odds GLMM for treatment \\i\\ in block \\k\\ with
ordinal category \\j\\ is: \$\$\text{logit}\[P(Y\_{ik} \le j)\] =
\eta_j - \tau_i - b_k\$\$ where \\\eta_j\\ are the cumulative intercept
thresholds, \\\tau_i\\ is the treatment fixed effect, and \\b_k \sim
\mathcal{N}(0, \sigma^2_b)\\ is the block random effect.

Published results (2nd ed. pp.436-437): \\\hat\eta_0=0.3492\\,
\\\hat\eta_1=1.9956\\; Treatment F(5,768)=17.67, p\<0.0001.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications*. CRC
    Press. Section 14.3, pp.434-438.

2.  Agresti, A. (2010). *Analysis of Ordinal Categorical Data*, 2nd ed.
    Wiley.

## Examples

``` r
data(DataSet14.1)
str(DataSet14.1)
#> 'data.frame':    180 obs. of  4 variables:
#>  $ blk   : Factor w/ 10 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ trt   : Factor w/ 6 levels "0","1","2","3",..: 1 1 1 2 2 2 3 3 3 4 ...
#>  $ rating: Ord.factor w/ 3 levels "slight"<"modrat"<..: 1 2 3 1 2 3 1 2 3 1 ...
#>  $ y     : int  1 4 23 2 7 23 4 7 18 8 ...
with(DataSet14.1, tapply(y, list(trt, rating), sum))
#>   slight modrat severe
#> 0     19     58    203
#> 1     20     70    194
#> 2     67    106    108
#> 3     80    110     90
#> 4    120    100     60
#> 5    170     80     30
```
