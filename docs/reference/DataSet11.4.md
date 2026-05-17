# Data Set 11.4 - Split-Plot Count Data

Split-plot count data for the multi-level Chapter 11 example in Section
11.5 of Stroup, Ptukhina, and Garai (2024). The treatment structure is a
7 by 4 factorial with four blocks.

## Usage

``` r
data(DataSet11.4)
```

## Format

A `data.frame` with 112 rows and 4 variables:

- block:

  Block factor with 4 levels.

- a:

  Whole-plot treatment factor with 7 levels.

- b:

  Subplot treatment factor with 4 levels.

- count:

  Non-negative integer count response.

## Details

The data provide a complete 4-block, 7-level `a`, 4-level `b` split-plot
layout for fitting the marginal Poisson and negative-binomial GLMMs
described in Chapter 11, Section 11.5.

\*\*Data provenance:\*\* Synthetic.

\*\*Reconstruction method:\*\* The original raw SAS data were not
available. Counts were generated from the printed model-scale and
data-scale means for the displayed `a = 1` and `a = 7` cells, with
intermediate `a` levels interpolated to preserve the 7 by 4 factorial
structure.

\*\*Book agreement:\*\* Approximate for the displayed `a = 1` and
`a = 7` fitted mean pattern. Not verified for all 28 cells because the
book prints only selected least-squares means.

\*\*Limitations:\*\* This dataset is suitable for runnable examples and
demonstrations of the Chapter 11 workflow, but it is not a verified copy
of the book's original `sp_counts` data.

## References

Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
Mixed Models: Modern Concepts, Methods and Applications*, 2nd ed. CRC
Press.

## Examples

``` r
data(DataSet11.4)
stats::aggregate(count ~ a + b, data = DataSet11.4, FUN = mean)
#>    a b count
#> 1  1 1 10.75
#> 2  2 1 16.25
#> 3  3 1 21.75
#> 4  4 1 27.00
#> 5  5 1 32.50
#> 6  6 1 38.00
#> 7  7 1 43.75
#> 8  1 2  8.75
#> 9  2 2 14.25
#> 10 3 2 19.50
#> 11 4 2 24.75
#> 12 5 2 30.25
#> 13 6 2 35.25
#> 14 7 2 40.50
#> 15 1 3 19.75
#> 16 2 3 20.50
#> 17 3 3 21.25
#> 18 4 3 22.00
#> 19 5 3 22.50
#> 20 6 3 23.25
#> 21 7 3 24.00
#> 22 1 4  6.50
#> 23 2 4  8.75
#> 24 3 4 10.50
#> 25 4 4 12.25
#> 26 5 4 14.25
#> 27 6 4 16.25
#> 28 7 4 18.50
```
