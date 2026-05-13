# 

# Chapter 20: Five Bayesian GLMM Examples

Five Applied Bayesian GLMM Analyses

Muhammad Yaseen

May 12, 2026

``` r
library(modernGLMM)
library(lme4)
library(emmeans)
library(ggplot2)
```

### 1 Overview

Chapter 20 presents five applied Bayesian GLMM analyses that parallel
the frequentist examples from earlier chapters. The analyses
demonstrate:

1.  **Gaussian LMM** (BLUP, Chapter 10) — Bayesian one-way random
    effects
2.  **Poisson GLMM** (Count data, Chapter 11) — Bayesian insect count
    model
3.  **Binomial GLMM** — Bayesian proportion analysis
4.  **Ordinal GLMM** (Multinomial, Chapter 14) — Bayesian cumulative
    link model
5.  **Repeated measures LMM** (Chapter 17) — Bayesian CS covariance
    structure

All examples use `brms` with weakly informative priors.

### 2 Example 20.1 — Bayesian One-Way Random Effects (Gaussian)

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  data(DataSet10.1)
  DataSet10.1$a <- factor(DataSet10.1$a)

  fit20.1 <- brms::brm(
    y ~ 1 + (1 | a),
    data   = DataSet10.1,
    prior  = brms::prior(normal(0, 10), class = Intercept) +
             brms::prior(cauchy(0, 2.5), class = sd) +
             brms::prior(exponential(1), class = sigma),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  print(summary(fit20.1))
  brms::pp_check(fit20.1, ndraws = 100)
}
```

### 3 Example 20.2 — Bayesian Poisson GLMM (Count Data)

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  # Simulated count data
  set.seed(20)
  count_ex <- data.frame(
    trt   = factor(rep(c("A","B","C"), each = 12)),
    block = factor(rep(1:4, 9)),
    count = c(rpois(12, 5), rpois(12, 10), rpois(12, 15))
  )

  fit20.2 <- brms::brm(
    count ~ trt + (1 | block),
    data   = count_ex,
    family = poisson(),
    prior  = brms::prior(normal(0, 2), class = b) +
             brms::prior(normal(2, 1), class = Intercept) +
             brms::prior(cauchy(0, 1), class = sd),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  print(emmeans::emmeans(fit20.2, ~ trt, type = "response"))
}
```

### 4 Example 20.3 — Bayesian Binomial GLMM (Proportions)

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  data(DataSet12.2)
  DataSet12.2$a <- factor(DataSet12.2$a)
  DataSet12.2$b <- factor(DataSet12.2$b)

  fit20.3 <- brms::brm(
    count | trials(total) ~ a * b + (1 | rep),
    data   = DataSet12.2,
    family = binomial(),
    prior  = brms::prior(normal(0, 5), class = b) +
             brms::prior(cauchy(0, 2), class = sd),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  summary(fit20.3)
}
```

### 5 Example 20.4 — Bayesian Ordinal GLMM

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  data(DataSet14.1)
  DataSet14.1$trt   <- factor(DataSet14.1$trt)
  DataSet14.1$block <- factor(DataSet14.1$block)
  DataSet14.1$score <- ordered(DataSet14.1$score)

  fit20.4 <- brms::brm(
    score ~ trt + (1 | block),
    data   = DataSet14.1,
    family = brms::cumulative("probit"),
    prior  = brms::prior(normal(0, 5), class = b) +
             brms::prior(cauchy(0, 2), class = sd),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  summary(fit20.4)
}
```

### 6 Example 20.5 — Bayesian Repeated Measures LMM

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  data(DataSet17.1)
  DataSet17.1$subject <- factor(DataSet17.1$subject)
  DataSet17.1$trt     <- factor(DataSet17.1$trt)
  DataSet17.1$time    <- factor(DataSet17.1$time)

  fit20.5 <- brms::brm(
    y ~ trt * time + (1 | subject),
    data   = DataSet17.1,
    prior  = brms::prior(normal(0, 10), class = b) +
             brms::prior(cauchy(0, 5), class = sd) +
             brms::prior(exponential(1), class = sigma),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  summary(fit20.5)
  emmeans::emmeans(fit20.5, ~ trt | time)
}
```

### 7 Key Takeaways

- The `brms` formula syntax mirrors `lme4`, making Bayesian conversion
  straightforward.
- Prior specification should reflect domain knowledge; weakly
  informative defaults are safe starting points.
- `emmeans` works with `brms` objects for posterior marginal means.
- Posterior predictive checks (`brms::pp_check`) verify model fit.

### 8 References

Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
Mixed Models: Modern Concepts, Methods and Applications (2nd ed.)*. CRC
Press.

``` r
library(modernGLMM)
library(lme4)
library(emmeans)
library(ggplot2)
```

### 1 Overview

Chapter 20 presents five applied Bayesian GLMM analyses that parallel
the frequentist examples from earlier chapters. The analyses
demonstrate:

1.  **Gaussian LMM** (BLUP, Chapter 10) — Bayesian one-way random
    effects
2.  **Poisson GLMM** (Count data, Chapter 11) — Bayesian insect count
    model
3.  **Binomial GLMM** — Bayesian proportion analysis
4.  **Ordinal GLMM** (Multinomial, Chapter 14) — Bayesian cumulative
    link model
5.  **Repeated measures LMM** (Chapter 17) — Bayesian CS covariance
    structure

All examples use `brms` with weakly informative priors.

### 2 Example 20.1 — Bayesian One-Way Random Effects (Gaussian)

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  data(DataSet10.1)
  DataSet10.1$a <- factor(DataSet10.1$a)

  fit20.1 <- brms::brm(
    y ~ 1 + (1 | a),
    data   = DataSet10.1,
    prior  = brms::prior(normal(0, 10), class = Intercept) +
             brms::prior(cauchy(0, 2.5), class = sd) +
             brms::prior(exponential(1), class = sigma),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  print(summary(fit20.1))
  brms::pp_check(fit20.1, ndraws = 100)
}
```

### 3 Example 20.2 — Bayesian Poisson GLMM (Count Data)

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  # Simulated count data
  set.seed(20)
  count_ex <- data.frame(
    trt   = factor(rep(c("A","B","C"), each = 12)),
    block = factor(rep(1:4, 9)),
    count = c(rpois(12, 5), rpois(12, 10), rpois(12, 15))
  )

  fit20.2 <- brms::brm(
    count ~ trt + (1 | block),
    data   = count_ex,
    family = poisson(),
    prior  = brms::prior(normal(0, 2), class = b) +
             brms::prior(normal(2, 1), class = Intercept) +
             brms::prior(cauchy(0, 1), class = sd),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  print(emmeans::emmeans(fit20.2, ~ trt, type = "response"))
}
```

### 4 Example 20.3 — Bayesian Binomial GLMM (Proportions)

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  data(DataSet12.2)
  DataSet12.2$a <- factor(DataSet12.2$a)
  DataSet12.2$b <- factor(DataSet12.2$b)

  fit20.3 <- brms::brm(
    count | trials(total) ~ a * b + (1 | rep),
    data   = DataSet12.2,
    family = binomial(),
    prior  = brms::prior(normal(0, 5), class = b) +
             brms::prior(cauchy(0, 2), class = sd),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  summary(fit20.3)
}
```

### 5 Example 20.4 — Bayesian Ordinal GLMM

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  data(DataSet14.1)
  DataSet14.1$trt   <- factor(DataSet14.1$trt)
  DataSet14.1$block <- factor(DataSet14.1$block)
  DataSet14.1$score <- ordered(DataSet14.1$score)

  fit20.4 <- brms::brm(
    score ~ trt + (1 | block),
    data   = DataSet14.1,
    family = brms::cumulative("probit"),
    prior  = brms::prior(normal(0, 5), class = b) +
             brms::prior(cauchy(0, 2), class = sd),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  summary(fit20.4)
}
```

### 6 Example 20.5 — Bayesian Repeated Measures LMM

``` r
if (requireNamespace("brms", quietly = TRUE)) {
  data(DataSet17.1)
  DataSet17.1$subject <- factor(DataSet17.1$subject)
  DataSet17.1$trt     <- factor(DataSet17.1$trt)
  DataSet17.1$time    <- factor(DataSet17.1$time)

  fit20.5 <- brms::brm(
    y ~ trt * time + (1 | subject),
    data   = DataSet17.1,
    prior  = brms::prior(normal(0, 10), class = b) +
             brms::prior(cauchy(0, 5), class = sd) +
             brms::prior(exponential(1), class = sigma),
    chains = 4, iter = 2000, seed = 20,
    silent = 2
  )
  summary(fit20.5)
  emmeans::emmeans(fit20.5, ~ trt | time)
}
```

### 7 Key Takeaways

- The `brms` formula syntax mirrors `lme4`, making Bayesian conversion
  straightforward.
- Prior specification should reflect domain knowledge; weakly
  informative defaults are safe starting points.
- `emmeans` works with `brms` objects for posterior marginal means.
- Posterior predictive checks (`brms::pp_check`) verify model fit.

### 8 References

Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
Mixed Models: Modern Concepts, Methods and Applications (2nd ed.)*. CRC
Press.
