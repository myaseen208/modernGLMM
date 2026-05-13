# Example 10.1 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam10.1 One-way random effects model and BLUP estimation

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

## See also

[`DataSet10.1`](https://github.com/myaseen208/modernGLMM/reference/DataSet10.1.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r
data(DataSet10.1)
DataSet10.1$a <- factor(x = DataSet10.1$a)

## Random effects model
Exam10.1lmer <- lme4::lmer(y ~ 1 + (1|a), data = DataSet10.1)
summary(Exam10.1lmer)
#> Linear mixed model fit by REML ['lmerMod']
#> Formula: y ~ 1 + (1 | a)
#>    Data: DataSet10.1
#> 
#> REML criterion at convergence: 101.4
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -1.37988 -0.56281  0.05619  0.52242  1.44495 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev.
#>  a        (Intercept) 5.511    2.348   
#>  Residual             1.531    1.237   
#> Number of obs: 24, groups:  a, 12
#> 
#> Fixed effects:
#>             Estimate Std. Error t value
#> (Intercept)  15.9000     0.7232   21.98

## Fixed effects model (for comparison)
Exam10.1lm <- stats::lm(y ~ a, data = DataSet10.1)
summary(Exam10.1lm)
#> 
#> Call:
#> stats::lm(formula = y ~ a, data = DataSet10.1)
#> 
#> Residuals:
#>    Min     1Q Median     3Q    Max 
#>  -1.55  -0.85   0.00   0.85   1.55 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  16.1500     0.8749  18.460 3.55e-10 ***
#> a2            1.2000     1.2373   0.970  0.35125    
#> a3           -4.0000     1.2373  -3.233  0.00718 ** 
#> a4            0.2000     1.2373   0.162  0.87427    
#> a5           -1.7500     1.2373  -1.414  0.18266    
#> a6            1.7000     1.2373   1.374  0.19456    
#> a7            3.9000     1.2373   3.152  0.00834 ** 
#> a8            2.2500     1.2373   1.819  0.09401 .  
#> a9            1.3500     1.2373   1.091  0.29665    
#> a10          -3.5500     1.2373  -2.869  0.01411 *  
#> a11          -3.2500     1.2373  -2.627  0.02211 *  
#> a12          -1.0500     1.2373  -0.849  0.41269    
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 1.237 on 12 degrees of freedom
#> Multiple R-squared:  0.8826, Adjusted R-squared:  0.775 
#> F-statistic: 8.201 on 11 and 12 DF,  p-value: 0.0005143
#> 

## Overall mean — broad inference (random effects model)
emmeans::emmeans(Exam10.1lmer, specs = ~1)
#>  1       emmean    SE df lower.CL upper.CL
#>  overall   15.9 0.723 11     14.3     17.5
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 

## Overall mean — narrow inference (fixed effects model)
emmeans::emmeans(Exam10.1lm, specs = ~1)
#>  1       emmean    SE df lower.CL upper.CL
#>  overall   15.9 0.253 12     15.3     16.5
#> 
#> Results are averaged over the levels of: a 
#> Confidence level used: 0.95 

## BLUP Estimates and standard errors for each level of a
## SE from conditional variance: sqrt(postVar) matches book Table 10.1 SE = 0.82453
blup_coef <- unlist(lme4::ranef(Exam10.1lmer)$a)
rv_a      <- lme4::ranef(Exam10.1lmer, condVar = TRUE)
BLUPa_SE  <- sqrt(attr(rv_a$a, "postVar")[1, 1, ])
BLUPa     <- mean(DataSet10.1$y) + blup_coef
print(data.frame(level = rownames(rv_a$a), BLUP = BLUPa, SE = BLUPa_SE))
#>               level     BLUP        SE
#> (Intercept)1      1 16.11951 0.8198043
#> (Intercept)2      2 17.17318 0.8198043
#> (Intercept)3      3 12.60729 0.8198043
#> (Intercept)4      4 16.29513 0.8198043
#> (Intercept)5      5 14.58292 0.8198043
#> (Intercept)6      6 17.61221 0.8198043
#> (Intercept)7      7 19.54393 0.8198043
#> (Intercept)8      8 18.09514 0.8198043
#> (Intercept)9      9 17.30489 0.8198043
#> (Intercept)10    10 13.00241 0.8198043
#> (Intercept)11    11 13.26583 0.8198043
#> (Intercept)12    12 15.19755 0.8198043
```
