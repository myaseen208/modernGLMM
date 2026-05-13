# Data for Example 21.1 — Power Curve for One-Way ANOVA (Chapter 21)

Pre-computed power values for a balanced one-way ANOVA (3 treatments)
across a grid of sample sizes and standardised effect sizes. Suitable
for plotting power curves and selecting sample sizes.

## Usage

``` r
data(DataSet21.1)
```

## Format

A `data.frame` with 30 rows and 3 variables:

- n_per_group:

  Sample size per treatment group (5–50, step 5)

- effect_size:

  Cohen's \\f\\ effect size (0.2, 0.5, or 0.8)

- power:

  Estimated power (0–1)

## Details

Power for a one-way ANOVA F-test is computed using the non-central F
distribution with non-centrality parameter \$\$\lambda = n \cdot k \cdot
f^2\$\$ where \\n\\ is the per-group sample size, \\k\\ is the number of
groups, and \\f\\ is Cohen's f effect size.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications*. CRC
    Press.

2.  Cohen, J. (1988). *Statistical Power Analysis for the Behavioral
    Sciences*, 2nd ed. Lawrence Erlbaum Associates.

## See also

[`Exam21.1`](https://github.com/myaseen208/modernGLMM/reference/Exam21.1.md)

## Examples

``` r
data(DataSet21.1)
str(DataSet21.1)
#> 'data.frame':    30 obs. of  3 variables:
#>  $ n_per_group: int  5 10 15 20 25 30 35 40 45 50 ...
#>  $ effect_size: num  0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 ...
#>  $ power      : num  0.0872 0.1394 0.1949 0.2521 0.3098 ...
```
