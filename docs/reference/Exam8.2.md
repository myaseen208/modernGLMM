# Example 8.2 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam8.2 explains multifactor models with some factors qualitative and
some quantitative(Equal slopes ANCOVA)

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

@seealso
[`DataSet8.2`](https://github.com/myaseen208/modernGLMM/reference/DataSet8.2.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r
data(DataSet8.2)
DataSet8.2$trt <- factor( x = DataSet8.2$trt )

##----ANCOVA(Equal slope Model)
Exam9.2fm1 <- aov(formula = y ~ trt*x, data = DataSet8.2)
car::Anova(mod = Exam9.2fm1 , type = "III")
#> Anova Table (Type III tests)
#> 
#> Response: y
#>              Sum Sq Df  F value    Pr(>F)    
#> (Intercept) 1225.64  1 199.1846 7.785e-09 ***
#> trt           55.55  3   3.0091   0.07225 .  
#> x            209.27  1  34.0093 8.064e-05 ***
#> trt:x         25.96  3   1.4062   0.28893    
#> Residuals     73.84 12                       
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

##---ANCOVA(without interaction because of non significant slope effect)
Exam9.2fm2 <- aov(formula = y ~ trt + x, data    = DataSet8.2)
car::Anova(mod = Exam9.2fm2 , type = "III")
#> Anova Table (Type III tests)
#> 
#> Response: y
#>              Sum Sq Df F value    Pr(>F)    
#> (Intercept) 2994.45  1 450.076 1.340e-12 ***
#> trt          302.16  3  15.138 8.301e-05 ***
#> x            542.90  1  81.599 1.871e-07 ***
#> Residuals     99.80 15                      
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

##---Ls means for 2nd model
emmeans::emmeans(object  = Exam9.2fm2, specs = ~trt)
#>  trt emmean   SE df lower.CL upper.CL
#>  1     47.7 1.17 15     45.2     50.2
#>  2     54.6 1.19 15     52.1     57.1
#>  3     44.9 1.23 15     42.3     47.5
#>  4     53.1 1.26 15     50.4     55.8
#> 
#> Confidence level used: 0.95 

##---Anova without covariate
Exam9.2fm3 <- aov(formula = y ~ trt, data = DataSet8.2)
car::Anova(mod = Exam9.2fm3, type = "III")
#> Anova Table (Type III tests)
#> 
#> Response: y
#>              Sum Sq Df  F value    Pr(>F)    
#> (Intercept) 10448.2  1 260.1115 2.564e-11 ***
#> trt           385.3  3   3.1972   0.05183 .  
#> Residuals     642.7 16                       
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

##---Ls means for 3rd model
emmeans::emmeans(object = Exam9.2fm3, specs = ~trt)
#>  trt emmean   SE df lower.CL upper.CL
#>  1     45.7 2.83 16     39.7     51.7
#>  2     57.4 2.83 16     51.4     63.4
#>  3     48.7 2.83 16     42.7     54.8
#>  4     48.4 2.83 16     42.4     54.5
#> 
#> Confidence level used: 0.95 

##---Box Plot of Covariate by treatment
Plot <-
   ggplot2::ggplot(
          data    = DataSet8.2
        , mapping = ggplot2::aes(x = factor(trt), y = x)
         )                              +
   ggplot2::geom_boxplot(width = 0.5)  +
   ggplot2::coord_flip()               +
   ggplot2::geom_point()               +
   ggplot2::stat_summary(
         fun    = "mean"
       , geom   = "point"
       , shape  =  23
       , size   =  2
       , fill   = "red"
       )                               +
   ggplot2::theme_bw()                 +
   ggplot2::ggtitle("Covariate by treatment Box Plot") +
   ggplot2::xlab("Treatment")
print(Plot)

```
