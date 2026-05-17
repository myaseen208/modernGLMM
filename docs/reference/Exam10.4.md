# Example 10.4 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam10.4 Relationship between BLUP and Fixed Effect Estimators

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

## See also

[`DataSet10.4`](https://github.com/myaseen208/modernGLMM/reference/DataSet10.4.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r

data(DataSet10.4)
DataSet10.4$a <- factor(x = DataSet10.4$a)
DataSet10.4$b <- factor(x = DataSet10.4$b)

Exam10.4lmer <- lme4::lmer(y ~ a + (1|b) + (1|a:b), data = DataSet10.4)
summary(Exam10.4lmer)
#> Linear mixed model fit by REML ['lmerMod']
#> Formula: y ~ a + (1 | b) + (1 | a:b)
#>    Data: DataSet10.4
#> 
#> REML criterion at convergence: 155.2
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -1.51149 -0.48873 -0.06897  0.59000  1.38365 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev.
#>  a:b      (Intercept) 6.256    2.501   
#>  b        (Intercept) 4.024    2.006   
#>  Residual             3.647    1.910   
#> Number of obs: 32, groups:  a:b, 16; b, 8
#> 
#> Fixed effects:
#>             Estimate Std. Error t value
#> (Intercept)   14.819      1.230   12.05
#> a2            -2.544      1.421   -1.79
#> 
#> Correlation of Fixed Effects:
#>    (Intr)
#> a2 -0.578

## BLUP vs fixed effects comparison
emmeans::emmeans(Exam10.4lmer, specs = ~a)
#>  a emmean   SE   df lower.CL upper.CL
#>  1   14.8 1.23 12.6    12.15     17.5
#>  2   12.3 1.23 12.6     9.61     14.9
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
```
