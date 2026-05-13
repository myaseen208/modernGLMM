# Example 3.2 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam3.2 used binomial data, two treatment samples

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

## See also

[`DataSet3.1`](https://github.com/myaseen208/modernGLMM/reference/DataSet3.1.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r
#-------------------------------------------------------------
## Linear Model and results discussed in Article 1.2.1 after Table1.1
#-------------------------------------------------------------
data(DataSet3.1)
DataSet3.1$trt <- factor(x = DataSet3.1$trt)
Exam3.2.glm <- stats::glm(
  formula = cbind(F, N - F) ~ trt,
  family  = stats::binomial(link = "logit"),
  data    = DataSet3.1
)
summary(Exam3.2.glm)
#> 
#> Call:
#> stats::glm(formula = cbind(F, N - F) ~ trt, family = stats::binomial(link = "logit"), 
#>     data = DataSet3.1)
#> 
#> Coefficients:
#>             Estimate Std. Error z value Pr(>|z|)    
#> (Intercept)  -2.1542     0.1962 -10.981  < 2e-16 ***
#> trt1          1.2682     0.2339   5.422  5.9e-08 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 56.195  on 19  degrees of freedom
#> Residual deviance: 23.169  on 18  degrees of freedom
#> AIC: 86.498
#> 
#> Number of Fisher Scoring iterations: 4
#> 
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.2.glm)
}
#> Parameter   | Log-Odds |   SE |         95% CI |      z |      p
#> ----------------------------------------------------------------
#> (Intercept) |    -2.15 | 0.20 | [-2.56, -1.79] | -10.98 | < .001
#> trt [1]     |     1.27 | 0.23 | [ 0.82,  1.74] |   5.42 | < .001
#> 
#> Uncertainty intervals (profile-likelihood) and p-values (two-tailed)
#>   computed using a Wald z-distribution approximation.

#-------------------------------------------------------------
## Individual least squares treatment means
#-------------------------------------------------------------
emmeans::emmeans(object = Exam3.2.glm, specs = "trt")
#>  trt emmean    SE  df asymp.LCL asymp.UCL
#>  0   -2.154 0.196 Inf     -2.54    -1.770
#>  1   -0.886 0.127 Inf     -1.14    -0.636
#> 
#> Results are given on the logit (not the response) scale. 
#> Confidence level used: 0.95 
emmeans::emmeans(object = Exam3.2.glm, specs = "trt", type = "response")
#>  trt  prob     SE  df asymp.LCL asymp.UCL
#>  0   0.104 0.0183 Inf    0.0732     0.146
#>  1   0.292 0.0263 Inf    0.2431     0.346
#> 
#> Confidence level used: 0.95 
#> Intervals are back-transformed from the logit scale 

#---------------------------------------------------
## Overall mean (equal-weight average of treatment means)
#---------------------------------------------------
emmeans::emmeans(object = Exam3.2.glm, specs = ~1)
#>  1       emmean    SE  df asymp.LCL asymp.UCL
#>  overall  -1.52 0.117 Inf     -1.75     -1.29
#> 
#> Results are averaged over the levels of: trt 
#> Results are given on the logit (not the response) scale. 
#> Confidence level used: 0.95 
emmeans::emmeans(object = Exam3.2.glm, specs = ~1, type = "response")
#>  1        prob     SE  df asymp.LCL asymp.UCL
#>  overall 0.179 0.0172 Inf     0.148     0.216
#> 
#> Results are averaged over the levels of: trt 
#> Confidence level used: 0.95 
#> Intervals are back-transformed from the logit scale 

#---------------------------------------------------
## Pairwise treatment means estimate
#---------------------------------------------------
emmeans::contrast(
  emmeans::emmeans(object = Exam3.2.glm, specs = "trt"),
  method = "pairwise"
)
#>  contrast    estimate    SE  df z.ratio p.value
#>  trt0 - trt1    -1.27 0.234 Inf  -5.422 <0.0001
#> 
#> Results are given on the log odds ratio (not the response) scale. 
emmeans::contrast(
  emmeans::emmeans(object = Exam3.2.glm, specs = "trt", type = "response"),
  method = "pairwise"
)
#>  contrast    odds.ratio     SE  df null z.ratio p.value
#>  trt0 / trt1      0.281 0.0658 Inf    1  -5.422 <0.0001
#> 
#> Tests are performed on the log odds ratio scale 
```
