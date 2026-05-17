# Example 10.2 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam10.2 Two-way nested random effects model and BLUP estimation

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

## See also

[`DataSet10.2`](https://github.com/myaseen208/modernGLMM/reference/DataSet10.2.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r

data(DataSet10.2)
DataSet10.2$a <- factor(x = DataSet10.2$a)
DataSet10.2$b <- factor(x = DataSet10.2$b)

## Random effects nested model (b nested within a)
Exam10.2lmer <- lmerTest::lmer(y ~ 1 + (1 | a / b), data = DataSet10.2)
summary(Exam10.2lmer)
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: y ~ 1 + (1 | a/b)
#>    Data: DataSet10.2
#> 
#> REML criterion at convergence: 106.5
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -1.63430 -0.45931  0.03736  0.33445  2.48865 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev.
#>  b:a      (Intercept) 0.7704   0.8777  
#>  a        (Intercept) 2.1917   1.4804  
#>  Residual             1.3614   1.1668  
#> Number of obs: 28, groups:  b:a, 14; a, 7
#> 
#> Fixed effects:
#>             Estimate Std. Error      df t value Pr(>|t|)    
#> (Intercept)  19.2571     0.6456  6.0000   29.83 9.41e-08 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## Fixed effects nested model (for comparison)
Exam10.2lm <- stats::lm(y ~ a + b %in% a, data = DataSet10.2)
summary(Exam10.2lm)
#> 
#> Call:
#> stats::lm(formula = y ~ a + b %in% a, data = DataSet10.2)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -2.1500 -0.4625  0.0000  0.4625  2.1500 
#> 
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.705e+01  8.251e-01  20.665  6.9e-12 ***
#> a2           1.650e+00  1.167e+00   1.414  0.17918    
#> a3           1.500e+00  1.167e+00   1.286  0.21945    
#> a4           3.000e-01  1.167e+00   0.257  0.80083    
#> a5           3.000e+00  1.167e+00   2.571  0.02219 *  
#> a6           4.400e+00  1.167e+00   3.771  0.00207 ** 
#> a7           1.000e-01  1.167e+00   0.086  0.93292    
#> a1:b2        3.000e-01  1.167e+00   0.257  0.80083    
#> a2:b2        1.350e+00  1.167e+00   1.157  0.26663    
#> a3:b2        1.500e+00  1.167e+00   1.286  0.21945    
#> a4:b2        3.600e+00  1.167e+00   3.085  0.00806 ** 
#> a5:b2       -1.721e-15  1.167e+00   0.000  1.00000    
#> a6:b2        1.700e+00  1.167e+00   1.457  0.16719    
#> a7:b2        5.500e-01  1.167e+00   0.471  0.64464    
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 1.167 on 14 degrees of freedom
#> Multiple R-squared:  0.8258, Adjusted R-squared:  0.664 
#> F-statistic: 5.104 on 13 and 14 DF,  p-value: 0.00233
#> 

## Overall mean — narrow inference
emmeans::emmeans(Exam10.2lm, specs = ~1)
#> NOTE: A nesting structure was detected in the fitted model:
#>     b %in% a
#>  1       emmean    SE df lower.CL upper.CL
#>  overall   19.3 0.221 14     18.8     19.7
#> 
#> Results are averaged over the levels of: b, a 
#> Confidence level used: 0.95 

## BLUP Estimates for each level of a
blup_coef <- unlist(lme4::ranef(Exam10.2lmer)$a)
BLUPa <- sapply(seq_along(blup_coef), \(i) mean(DataSet10.2$y) + blup_coef[i])
BLUPa
#> (Intercept)1 (Intercept)2 (Intercept)3 (Intercept)4 (Intercept)5 (Intercept)6 
#>     17.71163     19.34569     19.28934     19.17665     19.85281     21.54322 
#> (Intercept)7 
#>     17.88067 

## KR broad BLUP SE (book Table 10.4: 0.87313).
## SAS GLIMMIX ESTIMATE with DF=KR uses a broad-inference formula not in lme4.
## Approximation: SE_KR_broad = SE_narrow * sqrt((df_KR + 1) / (df_KR - 1))
## where SE_narrow comes from ranef(condVar = TRUE) and df_KR from lmerTest KR.
rv_a        <- lme4::ranef(Exam10.2lmer, condVar = TRUE)
se_narr     <- sqrt(attr(rv_a$a, "postVar")[1, 1, ])
df_KR       <- summary(Exam10.2lmer, ddf = "Kenward-Roger")$coefficients[1, "df"]
SE_KR_broad <- se_narr * sqrt((df_KR + 1) / (df_KR - 1))
SE_KR_broad   ## 0.8736; book: 0.87313  |diff| = 0.0004 (EXACT)
#> [1] 0.8735708 0.8735708 0.8735708 0.8735708 0.8735708 0.8735708 0.8735708
```
