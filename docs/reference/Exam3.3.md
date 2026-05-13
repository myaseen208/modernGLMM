# Example 3.3 — RCBD with Estimable Functions

Example 3.3 (Stroup et al., 2024) demonstrates the use of estimable
functions for an RCBD with fixed location effects. Uses `DataSet3.2` and
illustrates treatment contrast estimation via emmeans.

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
DataSet3.2$trt <- factor(x = DataSet3.2$trt, levels = c(3, 0, 1, 2))
DataSet3.2$loc <- factor(x = DataSet3.2$loc, levels = c(8, 1, 2, 3, 4, 5, 6, 7))

## Linear model
Exam3.3.lm1 <- stats::lm(formula = Y ~ trt + loc, data = DataSet3.2)
summary(Exam3.3.lm1)
#> 
#> Call:
#> stats::lm(formula = Y ~ trt + loc, data = DataSet3.2)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -2.7750 -0.7875  0.3625  1.0813  2.3000 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  28.2500     0.9945  28.407  < 2e-16 ***
#> trt0         -2.1375     0.8481  -2.520  0.01988 *  
#> trt1         -2.9500     0.8481  -3.478  0.00224 ** 
#> trt2          0.2875     0.8481   0.339  0.73798    
#> loc1         -0.9750     1.1994  -0.813  0.42538    
#> loc2         -3.2500     1.1994  -2.710  0.01312 *  
#> loc3         -1.6750     1.1994  -1.397  0.17713    
#> loc4         -0.3500     1.1994  -0.292  0.77329    
#> loc5          0.8250     1.1994   0.688  0.49907    
#> loc6         -0.3000     1.1994  -0.250  0.80492    
#> loc7         -3.5750     1.1994  -2.981  0.00713 ** 
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 1.696 on 21 degrees of freedom
#> Multiple R-squared:  0.6818, Adjusted R-squared:  0.5303 
#> F-statistic:   4.5 on 10 and 21 DF,  p-value: 0.001795
#> 

if (requireNamespace("emmeans", quietly = TRUE)) {
  ## Estimated marginal means for treatment
  Lsm3.3 <- emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt)
  print(Lsm3.3)

  ## Pairwise contrasts
  emmeans::contrast(object = Lsm3.3, method = "pairwise")

  ## Reverse pairwise contrasts
  emmeans::contrast(object = Lsm3.3, method = "revpairwise")

  ## LSM Trt0 (Table 3.4, p. 77)
  emmeans::contrast(
    object = emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(0, 1, 0, 0))
  )

  ## Trt0 vs Trt1
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(0, 1, -1, 0))
  )

  ## Average Trt0 + Trt1
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(0, 1/2, 1/2, 0))
  )

  ## Average Trt0+2+3
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(1/3, 1/3, 0, 1/3))
  )

  ## Trt2 vs Trt3
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(-1, 0, 0, 1))
  )

  ## Trt1 vs Trt2
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(0, 0, 1, -1))
  )

  ## Trt1 vs Trt3
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(-1, 0, 1, 0))
  )

  ## Average (Trt0+1) vs Average (Trt2+3)
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(-1/2, 1/2, 1/2, -1/2))
  )

  ## Trt1 vs Average (Trt0+1+2)
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(1/3, 1/3, -1, 1/3))
  )
}
#>  trt emmean  SE df lower.CL upper.CL
#>  3     27.1 0.6 21     25.8     28.3
#>  0     24.9 0.6 21     23.7     26.2
#>  1     24.1 0.6 21     22.9     25.4
#>  2     27.4 0.6 21     26.1     28.6
#> 
#> Results are averaged over the levels of: loc 
#> Confidence level used: 0.95 
#>  contrast estimate    SE df t.ratio p.value
#>  trt          2.33 0.692 21   3.370  0.0029
#> 
#> Results are averaged over the levels of: loc 
```
