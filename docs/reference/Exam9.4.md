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

Exam9.4lmer <- lmerTest::lmer(
  y ~ a * b + (1|block) + (1|block:a) + (1|block:b),
  data = DataSet9.4
)
#> boundary (singular) fit: see help('isSingular')
stats::anova(Exam9.4lmer, ddf = "Kenward-Roger")
#> Type III Analysis of Variance Table with Kenward-Roger's method
#>     Sum Sq Mean Sq NumDF   DenDF F value    Pr(>F)    
#> a    96.32  48.162     2  6.2595  4.7148 0.0563709 .  
#> b   352.20 176.100     2  9.2097 17.2391 0.0007702 ***
#> a:b 124.95  31.238     4 11.3911  3.0580 0.0619877 .  
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

emmeans::emmeans(object = Exam9.4lmer, specs = ~a | b)
#> b = 1:
#>  a emmean   SE   df lower.CL upper.CL
#>  1    9.2 2.39 26.3     4.29     14.1
#>  2   14.3 2.39 26.3     9.42     19.2
#>  3   12.8 2.39 26.3     7.92     17.7
#> 
#> b = 2:
#>  a emmean   SE   df lower.CL upper.CL
#>  1   28.7 2.39 26.3    23.79     33.6
#>  2   24.5 2.39 26.3    19.55     29.4
#>  3   21.1 2.39 26.3    16.14     26.0
#> 
#> b = 3:
#>  a emmean   SE   df lower.CL upper.CL
#>  1   27.6 2.39 26.3    22.65     32.5
#>  2   25.3 2.39 26.3    20.40     30.2
#>  3   18.9 2.39 26.3    13.95     23.8
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
```
