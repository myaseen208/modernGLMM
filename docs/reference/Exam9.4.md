# Example 9.4 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam9.4 Multifactor treatment and Multilevel design structures

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

## See also

[`DataSet9.4`](https://github.com/myaseen208/modernGLMM/reference/DataSet9.4.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r
data(DataSet9.4)
DataSet9.4$block <- factor(x = DataSet9.4$block)
DataSet9.4$a <- factor(x = DataSet9.4$a)
DataSet9.4$b <- factor(x = DataSet9.4$b)

## Full model matching book specification: (1|block) + (1|block:a) + (1|block:b)
## The block:a VC is at the boundary (= 0) in REML estimation.
Exam9.4lmer <- lmerTest::lmer(
  y ~ a * b + (1|block) + (1|block:a) + (1|block:b),
  data = DataSet9.4
)
#> boundary (singular) fit: see help('isSingular')
lme4::VarCorr(Exam9.4lmer)
#>  Groups   Name        Std.Dev.
#>  block:b  (Intercept) 2.8712  
#>  block:a  (Intercept) 0.0000  
#>  block    (Intercept) 1.9065  
#>  Residual             3.1961  

## BOUNDED F statistics (book values: a=4.86, b=17.14, a:b=3.86).
## When block:a VC = 0 at boundary, SAS GLIMMIX effectively removes it from
## the KR denominator df calculation; dropping the term in R matches SAS output.
Exam9.4lmer_bounded <- lmerTest::lmer(
  y ~ a * b + (1|block) + (1|block:b),
  data = DataSet9.4
)
stats::anova(Exam9.4lmer_bounded, ddf = "Kenward-Roger")
#> Type III Analysis of Variance Table with Kenward-Roger's method
#>     Sum Sq Mean Sq NumDF   DenDF F value    Pr(>F)    
#> a    99.06  49.529     2 14.0024  4.8485 0.0251171 *  
#> b   352.23 176.115     2  9.2123 17.2406 0.0007692 ***
#> a:b 157.99  39.498     4 14.8835  3.8666 0.0238613 *  
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## NOBOUND estimates: SAS GLIMMIX NOBOUND lifts the VC >= 0 constraint,
## yielding block:a VC = -6.595. lme4, nlme, and glmmTMB all enforce VC >= 0
## and cannot reproduce this value; documented as irreducible MISMATCH.

emmeans::emmeans(object = Exam9.4lmer_bounded, specs = ~a | b)
#> b = 1:
#>  a emmean  SE   df lower.CL upper.CL
#>  1    9.2 2.3 26.3     4.47     13.9
#>  2   14.3 2.3 26.3     9.60     19.1
#>  3   12.8 2.3 26.3     8.10     17.6
#> 
#> b = 2:
#>  a emmean  SE   df lower.CL upper.CL
#>  1   28.7 2.3 26.3    23.97     33.4
#>  2   24.5 2.3 26.3    19.73     29.2
#>  3   21.1 2.3 26.3    16.33     25.8
#> 
#> b = 3:
#>  a emmean  SE   df lower.CL upper.CL
#>  1   27.6 2.3 26.3    22.83     32.3
#>  2   25.3 2.3 26.3    20.58     30.0
#>  3   18.9 2.3 26.3    14.13     23.6
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
```
