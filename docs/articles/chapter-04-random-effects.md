# Chapter 4: Pre-GLMM Estimation and Inference Basics

## 1 Overview

Chapter 4 of Stroup, Ptukhina & Garai (2024) establishes the **pre-GLMM
estimation and inference framework** that underlies the mixed model
machinery developed in subsequent chapters. This chapter is entirely
theoretical — it contains no applied examples or datasets. The core
topics are:

- Ordinary Least Squares (OLS) and Generalised Least Squares (GLS)
- Best Linear Unbiased Estimators (BLUE)
- Estimable functions and testable hypotheses
- Quadratic forms and their distributions

## 2 Ordinary Least Squares

For a linear model \\\mathbf{y} = \mathbf{X}\boldsymbol{\beta} +
\boldsymbol{\varepsilon}\\ with \\\boldsymbol{\varepsilon} \sim
\mathcal{N}(\mathbf{0}, \sigma^2 \mathbf{I})\\, the OLS estimator is:

\\\hat{\boldsymbol{\beta}}\_{\text{OLS}} = (\mathbf{X}^\top
\mathbf{X})^{-} \mathbf{X}^\top \mathbf{y}\\

where \\(-)\\ denotes a generalised inverse. OLS is BLUE when errors are
homoscedastic and uncorrelated (Gauss-Markov theorem).

## 3 Generalised Least Squares

When \\\text{Var}(\boldsymbol{\varepsilon}) = \sigma^2 \mathbf{V}\\ with
\\\mathbf{V} \ne \mathbf{I}\\, GLS applies:

\\\hat{\boldsymbol{\beta}}\_{\text{GLS}} = (\mathbf{X}^\top
\mathbf{V}^{-1} \mathbf{X})^{-} \mathbf{X}^\top \mathbf{V}^{-1}
\mathbf{y}\\

GLS is BLUE under the correctly specified \\\mathbf{V}\\. In practice
\\\mathbf{V}\\ is unknown and must be estimated, leading to the REML/ML
estimation machinery of Chapter 5.

## 4 Best Linear Unbiased Estimators (BLUE)

An estimator \\\hat{\boldsymbol{\ell}} = \mathbf{c}^\top
\hat{\boldsymbol{\beta}}\\ is BLUE for \\\boldsymbol{\ell} =
\mathbf{c}^\top \boldsymbol{\beta}\\ if:

1.  It is **linear** in \\\mathbf{y}\\.
2.  It is **unbiased**: \\\mathsf{E}\[\hat{\boldsymbol{\ell}}\] =
    \boldsymbol{\ell}\\.
3.  It has **minimum variance** among all linear unbiased estimators.

The GLS estimator achieves this under the correct \\\mathbf{V}\\.

## 5 Estimable Functions

A linear combination \\\mathbf{c}^\top \boldsymbol{\beta}\\ is
**estimable** if and only if \\\mathbf{c}^\top\\ lies in the row space
of \\\mathbf{X}\\, i.e., \\\mathbf{c}^\top = \mathbf{t}^\top
\mathbf{X}\\ for some \\\mathbf{t}\\.

Non-estimable combinations — arising from rank deficiency or aliased
parameters — cannot be uniquely estimated regardless of the data, and
any hypothesis test involving them is not meaningful. The `emmeans`
package performs estimability checks automatically.

``` r
## Illustration: rank-deficient design leads to non-estimable contrasts
X <- matrix(c(1,1,0, 1,0,1, 1,1,0), nrow = 3, byrow = TRUE)
rankX <- qr(X)$rank
cat("Rank of X:", rankX, "  (columns:", ncol(X), ")\n")
```

    Rank of X: 2   (columns: 3 )

``` r
cat("Columns span a", rankX, "-dimensional space —",
    ncol(X) - rankX, "parameter(s) are not independently estimable.\n")
```

    Columns span a 2 -dimensional space — 1 parameter(s) are not independently estimable.

## 6 Quadratic Forms

Hypothesis tests in linear models rely on **quadratic forms**
\\\mathbf{y}^\top \mathbf{A} \mathbf{y}\\. Key results:

- If \\\mathbf{y} \sim \mathcal{N}(\boldsymbol{\mu}, \sigma^2
  \mathbf{I})\\ and \\\mathbf{A}\\ is idempotent of rank \\r\\, then
  \\\mathbf{y}^\top \mathbf{A} \mathbf{y} / \sigma^2 \sim
  \chi^2_r(\lambda)\\ with non-centrality \\\lambda =
  \boldsymbol{\mu}^\top \mathbf{A} \boldsymbol{\mu} / \sigma^2\\.
- The F-statistic is a ratio of two chi-squared quadratic forms divided
  by their respective degrees of freedom.

``` r
## Non-centrality parameter for a one-way ANOVA (k=3, n=5, sigma^2=9)
mu    <- c(20, 25, 25)
mubar <- mean(mu)
sigma2 <- 9
n      <- 5
lambda <- n * sum((mu - mubar)^2) / sigma2
cat("Non-centrality parameter lambda =", round(lambda, 5), "\n")
```

    Non-centrality parameter lambda = 9.25926 

``` r
## Power at F_{2,12} critical value
df1 <- 2; df2 <- 12
Fc  <- stats::qf(0.95, df1, df2)
pow <- 1 - stats::pf(Fc, df1, df2, ncp = lambda)
cat("Power (n = 5):", round(pow, 5), "\n")
```

    Power (n = 5): 0.66605 

## 7 Key Takeaways

- OLS is BLUE only when errors are i.i.d.; correlated or heteroscedastic
  errors require GLS.
- Estimability is a prerequisite for meaningful inference — `emmeans`
  checks this automatically.
- Quadratic form theory underpins all ANOVA and F-tests in the LMM/GLMM
  framework developed in Chapters 6–21.
- Chapter 4 has no applied examples; its applied manifestations appear
  in Chapters 8–10 (Gaussian LMMs) and beyond.

## 8 References

Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
Mixed Models: Modern Concepts, Methods and Applications* (2nd ed.). CRC
Press. Chapter 4: Pre-GLMM Estimation and Inference Basics, pp. 137–145.
