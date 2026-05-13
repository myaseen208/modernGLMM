# Example 3.5 — Factorial Fixed Effects, Estimable Functions

Example 3.5 (Stroup et al., 2024) analyses a factorial treatment
structure with fixed location effects using `DataSet3.2`. Simple effects
and marginal means are estimated via emmeans.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

## See also

[`DataSet3.2`](https://github.com/myaseen208/modernGLMM/reference/DataSet3.2.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r
data(DataSet3.2)
DataSet3.2$A   <- factor(x = DataSet3.2$A)
DataSet3.2$B   <- factor(x = DataSet3.2$B)
DataSet3.2$loc <- factor(x = DataSet3.2$loc, levels = c(8, 1, 2, 3, 4, 5, 6, 7))

Exam3.5.lm <- stats::lm(formula = Y ~ A + B + loc, data = DataSet3.2)
Exam3.5.lm
#> 
#> Call:
#> stats::lm(formula = Y ~ A + B + loc, data = DataSet3.2)
#> 
#> Coefficients:
#> (Intercept)           A1           B1         loc1         loc2         loc3  
#>      25.981        2.688       -0.550       -0.975       -3.250       -1.675  
#>        loc4         loc5         loc6         loc7  
#>      -0.350        0.825       -0.300       -3.575  
#> 

if (requireNamespace("emmeans", quietly = TRUE)) {
  ## A=0 marginal mean
  emmeans::contrast(
    object = emmeans::emmeans(object = Exam3.5.lm, specs = ~ B),
    list(trt = c(1, 0))
  )

  ## B=0 marginal mean
  emmeans::contrast(
    object = emmeans::emmeans(object = Exam3.5.lm, specs = ~ B),
    list(B0 = c(1, 0))
  )

  ## Simple effect of A at B0 (B = "0")
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.5.lm, specs = ~ A | B),
    method = "pairwise",
    by     = "B"
  )

  ## Simple effect of B at A0 (A = "0")
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.5.lm, specs = ~ B | A),
    method = "pairwise",
    by     = "A"
  )

  ## All A*B marginal means
  emmeans::emmeans(object = Exam3.5.lm, specs = ~ A * B)
}
#>  A B emmean   SE df lower.CL upper.CL
#>  0 0   24.8 0.51 22     23.8     25.9
#>  1 0   27.5 0.51 22     26.4     28.6
#>  0 1   24.3 0.51 22     23.2     25.3
#>  1 1   27.0 0.51 22     25.9     28.0
#> 
#> Results are averaged over the levels of: loc 
#> Confidence level used: 0.95 
```
