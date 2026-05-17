# Example 9.1 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam9.1 Nested factorial structure

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

## See also

[`DataSet9.1`](https://github.com/myaseen208/modernGLMM/reference/DataSet9.1.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r

data(DataSet9.1)
DataSet9.1$block <- factor(x = DataSet9.1$block)
DataSet9.1$set   <- factor(x = DataSet9.1$set)
DataSet9.1$trt   <- factor(x = DataSet9.1$trt)

## EMS-correct ANOVA: set tested against block(set) error (8 df),
## trt(set) tested against within-block residual (16 df).
## Reproduces SAS GLIMMIX exactly: set F(1,8)=0.04, trt(set) F(4,16)=4.91.
## The lmerTest KR approach gives the wrong denominator df for set
## (11.67 instead of 8) due to rank-deficient fixed-effects parameterisation
## when treatments are fully nested within sets.
Exam9.1Aov <- stats::aov(
  y ~ set + trt %in% set + Error(block),
  data = DataSet9.1
)
print(summary(Exam9.1Aov))
#> 
#> Error: block
#>           Df Sum Sq Mean Sq F value Pr(>F)
#> set        1    7.7     7.7   0.038  0.851
#> Residuals  8 1635.2   204.4               
#> 
#> Error: Within
#>           Df Sum Sq Mean Sq F value Pr(>F)   
#> set:trt    4  447.1  111.79   4.914 0.0089 **
#> Residuals 16  364.0   22.75                  
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

## Mixed model for LS means and contrasts.
## Fixed effects are rank-deficient (set is a linear combination of set:trt
## columns); emmeans resolves estimability and produces correct LS means.
Exam9.1Lmer <- lmerTest::lmer(
  y ~ set + set:trt + (1 | block),
  data = DataSet9.1
)
#> fixed-effect model matrix is rank deficient so dropping 6 columns / coefficients

emm91 <- emmeans::emmeans(object = Exam9.1Lmer, specs = ~trt | set)
#> NOTE: A nesting structure was detected in the fitted model:
#>     trt %in% set
print(emm91)
#> set = 1:
#>  trt emmean   SE   df lower.CL upper.CL
#>  1     8.20 4.08 11.7  -0.7212     17.1
#>  2     8.90 4.08 11.7  -0.0212     17.8
#>  3     8.74 4.08 11.7  -0.1812     17.7
#> 
#> set = 2:
#>  trt emmean   SE   df lower.CL upper.CL
#>  4     4.44 4.08 11.7  -4.4812     13.4
#>  5     7.28 4.08 11.7  -1.6412     16.2
#>  6    17.16 4.08 11.7   8.2388     26.1
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
emmeans::contrast(emm91, method = "pairwise", by = "set")
#> set = 1:
#>  contrast    estimate   SE df t.ratio p.value
#>  trt1 - trt2    -0.70 3.02 16  -0.232  0.9999
#>  trt1 - trt3    -0.54 3.02 16  -0.179  1.0000
#>  trt2 - trt3     0.16 3.02 16   0.053  1.0000
#> 
#> set = 2:
#>  contrast    estimate   SE df t.ratio p.value
#>  trt4 - trt5    -2.84 3.02 16  -0.941  0.9295
#>  trt4 - trt6   -12.72 3.02 16  -4.217  0.0071
#>  trt5 - trt6    -9.88 3.02 16  -3.275  0.0452
#> 
#> Degrees-of-freedom method: kenward-roger 
#> P value adjustment: tukey method for comparing a family of 6 estimates 
```
