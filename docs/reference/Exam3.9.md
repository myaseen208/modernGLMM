# Example 3.9 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam3.9 used to differentiate conditional and marginal binomial models
with and without interaction for S2 variable.

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
#-----------------------------------------------------------------------------------
## Binomial conditional GLMM without interaction, logit link
#-----------------------------------------------------------------------------------
data(DataSet3.2)
DataSet3.2$trt <- factor( x  =  DataSet3.2$trt )
DataSet3.2$loc <- factor( x  =  DataSet3.2$loc )

Exam3.9.fm1   <-
  lme4::glmer(
      formula = cbind(S2, Nbin - S2) ~ trt + (1 | loc)
    , family  = stats::binomial(link = "logit")
    , data    = DataSet3.2
    , nAGQ    = 10
  )
summary(Exam3.9.fm1)
#> Generalized linear mixed model fit by maximum likelihood (Adaptive
#>   Gauss-Hermite Quadrature, nAGQ = 10) [glmerMod]
#>  Family: binomial  ( logit )
#> Formula: cbind(S2, Nbin - S2) ~ trt + (1 | loc)
#>    Data: DataSet3.2
#> 
#>       AIC       BIC    logLik -2*log(L)  df.resid 
#>     221.3     228.7    -105.7     211.3        27 
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -5.6038 -1.0854 -0.4637  1.5889  5.8290 
#> 
#> Random effects:
#>  Groups Name        Variance Std.Dev.
#>  loc    (Intercept) 1.137    1.066   
#> Number of obs: 32, groups:  loc, 8
#> 
#> Fixed effects:
#>             Estimate Std. Error z value Pr(>|z|)    
#> (Intercept)  -1.9661     0.4017  -4.894 9.87e-07 ***
#> trt1          0.2910     0.1756   1.657   0.0975 .  
#> trt2          0.9140     0.1671   5.468 4.55e-08 ***
#> trt3          1.1003     0.1659   6.632 3.31e-11 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>      (Intr) trt1   trt2  
#> trt1 -0.237              
#> trt2 -0.253  0.567       
#> trt3 -0.257  0.571  0.604
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.9.fm1)
}
#> Package 'merDeriv' needs to be installed to compute confidence intervals
#>   for random effect parameters.
#> # Fixed Effects
#> 
#> Parameter   | Log-Odds |   SE |         95% CI |     z |      p
#> ---------------------------------------------------------------
#> (Intercept) |    -1.97 | 0.40 | [-2.75, -1.18] | -4.89 | < .001
#> trt [1]     |     0.29 | 0.18 | [-0.05,  0.64] |  1.66 | 0.097 
#> trt [2]     |     0.91 | 0.17 | [ 0.59,  1.24] |  5.47 | < .001
#> trt [3]     |     1.10 | 0.17 | [ 0.78,  1.43] |  6.63 | < .001
#> 
#> # Random Effects
#> 
#> Parameter           | Coefficient
#> ---------------------------------
#> SD (Intercept: loc) |        1.07
#> 
#> Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
#>   using a Wald z-distribution approximation.

#-------------------------------------------------------------
##  treatment means
#-------------------------------------------------------------
emmeans::emmeans(object = Exam3.9.fm1, specs = ~trt, type = "response")
#>  trt  prob     SE  df asymp.LCL asymp.UCL
#>  0   0.123 0.0433 Inf    0.0599     0.235
#>  1   0.158 0.0529 Inf    0.0790     0.290
#>  2   0.259 0.0756 Inf    0.1389     0.431
#>  3   0.296 0.0820 Inf    0.1629     0.476
#> 
#> Confidence level used: 0.95 
#> Intervals are back-transformed from the logit scale 
emmeans::emmeans(object = Exam3.9.fm1, specs = ~trt, type = "link")
#>  trt emmean    SE  df asymp.LCL asymp.UCL
#>  0   -1.966 0.402 Inf     -2.75    -1.179
#>  1   -1.675 0.399 Inf     -2.46    -0.894
#>  2   -1.052 0.394 Inf     -1.82    -0.280
#>  3   -0.866 0.393 Inf     -1.64    -0.095
#> 
#> Results are given on the logit (not the response) scale. 
#> Confidence level used: 0.95 

##--- Normal Approximation
Exam3.9fm2 <-
  nlme::lme(
      fixed       = S2/Nbin~trt
    , data        = DataSet3.2
    , random      = ~1|loc
    , method      = c("REML", "ML")[1]
  )

Exam3.9fm2
#> Linear mixed-effects model fit by REML
#>   Data: DataSet3.2 
#>   Log-restricted-likelihood: 2.381826
#>   Fixed: S2/Nbin ~ trt 
#> (Intercept)        trt1        trt2        trt3 
#>  0.16041667  0.03958333  0.14375000  0.17916667 
#> 
#> Random effects:
#>  Formula: ~1 | loc
#>         (Intercept)  Residual
#> StdDev:   0.1218281 0.1659259
#> 
#> Number of Observations: 32
#> Number of Groups: 8 
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.9fm2)
}
#> # Fixed Effects
#> 
#> Parameter   | Coefficient |   SE |        95% CI | t(21) |     p
#> ----------------------------------------------------------------
#> (Intercept) |        0.16 | 0.07 | [ 0.01, 0.31] |  2.20 | 0.039
#> trt [1]     |        0.04 | 0.08 | [-0.13, 0.21] |  0.48 | 0.638
#> trt [2]     |        0.14 | 0.08 | [-0.03, 0.32] |  1.73 | 0.098
#> trt [3]     |        0.18 | 0.08 | [ 0.01, 0.35] |  2.16 | 0.043
#> 
#> # Random Effects
#> 
#> Parameter           | Coefficient
#> ---------------------------------
#> SD (Intercept: loc) |        0.12
#> SD (Residual)       |        0.17
#> 
#> Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
#>   using a Wald t-distribution approximation.

emmeans::emmeans(object  = Exam3.9fm2, specs = ~trt)
#>  trt emmean     SE df lower.CL upper.CL
#>  0    0.160 0.0728  7  -0.0117    0.333
#>  1    0.200 0.0728  7   0.0279    0.372
#>  2    0.304 0.0728  7   0.1321    0.476
#>  3    0.340 0.0728  7   0.1675    0.512
#> 
#> Degrees-of-freedom method: containment 
#> Confidence level used: 0.95 


##---Binomial GLMM with interaction
Exam3.9fm3   <-
  lme4::glmer(
      formula = cbind(S2, Nbin - S2) ~ trt + (1 | loc) + (1 | loc:trt)
    , family  = stats::binomial(link = "logit")
    , data    = DataSet3.2
    , nAGQ    = 0
    , control = lme4::glmerControl(optimizer = "bobyqa")
  )
summary(Exam3.9fm3)
#> Generalized linear mixed model fit by maximum likelihood (Adaptive
#>   Gauss-Hermite Quadrature, nAGQ = 0) [glmerMod]
#>  Family: binomial  ( logit )
#> Formula: cbind(S2, Nbin - S2) ~ trt + (1 | loc) + (1 | loc:trt)
#>    Data: DataSet3.2
#> Control: lme4::glmerControl(optimizer = "bobyqa")
#> 
#>       AIC       BIC    logLik -2*log(L)  df.resid 
#>     235.5     244.3    -111.7     223.5        26 
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -1.11996 -0.25338 -0.03089  0.19847  0.89111 
#> 
#> Random effects:
#>  Groups  Name        Variance Std.Dev.
#>  loc:trt (Intercept) 0.7039   0.839   
#>  loc     (Intercept) 1.2030   1.097   
#> Number of obs: 32, groups:  loc:trt, 32; loc, 8
#> 
#> Fixed effects:
#>             Estimate Std. Error z value Pr(>|z|)    
#> (Intercept)  -2.1224     0.5206  -4.077 4.57e-05 ***
#> trt1          0.3209     0.4812   0.667  0.50481    
#> trt2          1.0917     0.4713   2.316  0.02055 *  
#> trt3          1.2208     0.4737   2.577  0.00996 ** 
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>      (Intr) trt1   trt2  
#> trt1 -0.474              
#> trt2 -0.490  0.523       
#> trt3 -0.484  0.521  0.534
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.9fm3)
}
#> Package 'merDeriv' needs to be installed to compute confidence intervals
#>   for random effect parameters.
#> # Fixed Effects
#> 
#> Parameter   | Log-Odds |   SE |         95% CI |     z |      p
#> ---------------------------------------------------------------
#> (Intercept) |    -2.12 | 0.52 | [-3.14, -1.10] | -4.08 | < .001
#> trt [1]     |     0.32 | 0.48 | [-0.62,  1.26] |  0.67 | 0.505 
#> trt [2]     |     1.09 | 0.47 | [ 0.17,  2.02] |  2.32 | 0.021 
#> trt [3]     |     1.22 | 0.47 | [ 0.29,  2.15] |  2.58 | 0.010 
#> 
#> # Random Effects
#> 
#> Parameter               | Coefficient
#> -------------------------------------
#> SD (Intercept: loc:trt) |        0.84
#> SD (Intercept: loc)     |        1.10
#> 
#> Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
#>   using a Wald z-distribution approximation.
emmeans::emmeans(object = Exam3.9fm3, specs = ~trt, type = "response")
#>  trt  prob     SE  df asymp.LCL asymp.UCL
#>  0   0.107 0.0497 Inf    0.0414     0.249
#>  1   0.142 0.0626 Inf    0.0568     0.312
#>  2   0.263 0.0975 Inf    0.1175     0.489
#>  3   0.289 0.1040 Inf    0.1307     0.523
#> 
#> Confidence level used: 0.95 
#> Intervals are back-transformed from the logit scale 


##---Binomial Marginal GLMM(assuming compound symmetry)
Exam3.9fm4   <-
  MASS::glmmPQL(
      fixed       =  S2/Nbin~trt
    , random      = ~1|loc
    , family      =  stats::quasibinomial(link = "logit")
    , data        =  DataSet3.2
    , correlation =  nlme::corCompSymm(form = ~1|loc)
    , niter       = 10
    , verbose     = FALSE
  )
summary(Exam3.9fm4)
#> Linear mixed-effects model fit by maximum likelihood
#>   Data: DataSet3.2 
#>   AIC BIC logLik
#>    NA  NA     NA
#> 
#> Random effects:
#>  Formula: ~1 | loc
#>          (Intercept)  Residual
#> StdDev: 0.0007465953 0.4412173
#> 
#> Correlation Structure: Compound symmetry
#>  Formula: ~1 | loc 
#>  Parameter estimate(s):
#>       Rho 
#> 0.3817414 
#> Variance function:
#>  Structure: fixed weights
#>  Formula: ~invwt 
#> Fixed effects:  S2/Nbin ~ trt 
#>                  Value Std.Error DF   t-value p-value
#> (Intercept) -1.6551311 0.4544041 21 -3.642421  0.0015
#> trt1         0.2688368 0.4854471 21  0.553792  0.5856
#> trt2         0.8275968 0.4605683 21  1.796903  0.0867
#> trt3         0.9899796 0.4564203 21  2.169008  0.0417
#>  Correlation: 
#>      (Intr) trt1   trt2  
#> trt1 -0.608              
#> trt2 -0.686  0.577       
#> trt3 -0.701  0.583  0.624
#> 
#> Standardized Within-Group Residuals:
#>        Min         Q1        Med         Q3        Max 
#> -1.6252165 -0.6846589 -0.3489664  0.6677812  2.6023420 
#> 
#> Number of Observations: 32
#> Number of Groups: 8 
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.9fm4)
}
#> # Fixed Effects
#> 
#> Parameter   | Log-Odds |   SE |         95% CI | t(21) |     p
#> --------------------------------------------------------------
#> (Intercept) |    -1.66 | 0.45 | [-2.54, -0.77] | -3.64 | 0.002
#> trt [1]     |     0.27 | 0.49 | [-0.68,  1.21] |  0.55 | 0.586
#> trt [2]     |     0.83 | 0.46 | [-0.07,  1.72] |  1.80 | 0.087
#> trt [3]     |     0.99 | 0.46 | [ 0.10,  1.88] |  2.17 | 0.042
#> 
#> # Random Effects
#> 
#> Parameter           | Coefficient
#> ---------------------------------
#> SD (Intercept: loc) |    7.47e-04
#> SD (Residual)       |        0.44
#> 
#> Uncertainty intervals (equal-tailed) and p-values (two-tailed) computed
#>   using a Wald t-distribution approximation.
emmeans::emmeans(object  = Exam3.9fm4, specs  = ~trt, type = "response")
#>  trt  prob     SE df lower.CL upper.CL
#>  0   0.160 0.0612  7   0.0612    0.359
#>  1   0.200 0.0667  7   0.0853    0.401
#>  2   0.304 0.0767  7   0.1565    0.507
#>  3   0.340 0.0790  7   0.1827    0.542
#> 
#> Degrees-of-freedom method: containment 
#> Confidence level used: 0.95 
#> Intervals are back-transformed from the logit scale 
```
