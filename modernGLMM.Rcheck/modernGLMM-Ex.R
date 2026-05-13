pkgname <- "modernGLMM"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('modernGLMM')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("DataExam2.B.2")
### * DataExam2.B.2

flush(stderr()); flush(stdout())

### Name: DataExam2.B.2
### Title: Data for Example 2.B.2 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataExam2.B.2
### Keywords: datasets

### ** Examples

data(DataExam2.B.2)



cleanEx()
nameEx("DataExam2.B.3")
### * DataExam2.B.3

flush(stderr()); flush(stdout())

### Name: DataExam2.B.3
### Title: Data for Example 2.B.3 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataExam2.B.3
### Keywords: datasets

### ** Examples

data(DataExam2.B.3)



cleanEx()
nameEx("DataExam2.B.4")
### * DataExam2.B.4

flush(stderr()); flush(stdout())

### Name: DataExam2.B.4
### Title: Data for Example 2.B.4 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataExam2.B.4
### Keywords: datasets

### ** Examples

data(DataExam2.B.4)



cleanEx()
nameEx("DataExam2.B.7")
### * DataExam2.B.7

flush(stderr()); flush(stdout())

### Name: DataExam2.B.7
### Title: Data for Example 2.B.7 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataExam2.B.7
### Keywords: datasets

### ** Examples

data(DataExam2.B.7)



cleanEx()
nameEx("DataSet10.1")
### * DataSet10.1

flush(stderr()); flush(stdout())

### Name: DataSet10.1
### Title: Data for Example 10.1 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet10.1
### Keywords: datasets

### ** Examples

data(DataSet10.1)



cleanEx()
nameEx("DataSet10.2")
### * DataSet10.2

flush(stderr()); flush(stdout())

### Name: DataSet10.2
### Title: Data for Example 10.2 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet10.2
### Keywords: datasets

### ** Examples

data(DataSet10.2)



cleanEx()
nameEx("DataSet10.4")
### * DataSet10.4

flush(stderr()); flush(stdout())

### Name: DataSet10.4
### Title: Data for Example 10.4 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet10.4
### Keywords: datasets

### ** Examples

data(DataSet10.4)



cleanEx()
nameEx("DataSet11.1")
### * DataSet11.1

flush(stderr()); flush(stdout())

### Name: DataSet11.1
### Title: Data Set 11.1 - Completely Randomized Count Data
### Aliases: DataSet11.1

### ** Examples

data(DataSet11.1)
stats::aggregate(count ~ trt, data = DataSet11.1, FUN = mean)



cleanEx()
nameEx("DataSet11.3")
### * DataSet11.3

flush(stderr()); flush(stdout())

### Name: DataSet11.3
### Title: Data Set 11.3 - Randomized Complete Block Count Data
### Aliases: DataSet11.3

### ** Examples

data(DataSet11.3)
stats::aggregate(count ~ trt, data = DataSet11.3, FUN = mean)



cleanEx()
nameEx("DataSet11.4")
### * DataSet11.4

flush(stderr()); flush(stdout())

### Name: DataSet11.4
### Title: Data Set 11.4 - Split-Plot Count Data
### Aliases: DataSet11.4

### ** Examples

data(DataSet11.4)
stats::aggregate(count ~ a + b, data = DataSet11.4, FUN = mean)



cleanEx()
nameEx("DataSet12.1")
### * DataSet12.1

flush(stderr()); flush(stdout())

### Name: DataSet12.1
### Title: Data for Example 12.1 — Continuous Proportion Dose-Response
###   (Chapter 12)
### Aliases: DataSet12.1
### Keywords: datasets

### ** Examples

data(DataSet12.1)
str(DataSet12.1)
with(DataSet12.1, tapply(proportion, list(trt, dose), mean))



cleanEx()
nameEx("DataSet12.2")
### * DataSet12.2

flush(stderr()); flush(stdout())

### Name: DataSet12.2
### Title: Data for Example 12.2 — Binomial Nested Factorial (Chapter 12)
### Aliases: DataSet12.2
### Keywords: datasets

### ** Examples

data(DataSet12.2)
str(DataSet12.2)
with(DataSet12.2, tapply(f / n, list(a, b), mean))



cleanEx()
nameEx("DataSet14.1")
### * DataSet14.1

flush(stderr()); flush(stdout())

### Name: DataSet14.1
### Title: Data for Example 14.1 — Ordinal Proportional Odds GLMM (Chapter
###   14)
### Aliases: DataSet14.1
### Keywords: datasets

### ** Examples

data(DataSet14.1)
str(DataSet14.1)
with(DataSet14.1, tapply(y, list(trt, rating), sum))



cleanEx()
nameEx("DataSet14.2")
### * DataSet14.2

flush(stderr()); flush(stdout())

### Name: DataSet14.2
### Title: Data for Example 14.2 — Non-Proportional Odds: Poinsettia Trial
###   (Chapter 14)
### Aliases: DataSet14.2
### Keywords: datasets

### ** Examples

data(DataSet14.2)
str(DataSet14.2)
## Marginal totals match published table (book p.438)
with(DataSet14.2, tapply(y, list(variety, rating), sum))



cleanEx()
nameEx("DataSet17.1")
### * DataSet17.1

flush(stderr()); flush(stdout())

### Name: DataSet17.1
### Title: Data for Example 17.1 — Crossover with ARH(1) Covariance
###   (Chapter 17)
### Aliases: DataSet17.1
### Keywords: datasets

### ** Examples

data(DataSet17.1)
str(DataSet17.1)
cat("Subjects per sequence:\n")
print(table(unique(DataSet17.1[, c("id", "sequence")])$sequence))



cleanEx()
nameEx("DataSet17.2")
### * DataSet17.2

flush(stderr()); flush(stdout())

### Name: DataSet17.2
### Title: Data for Example 17.2 — Sparse Longitudinal Data with SP(POW)
###   (Chapter 17)
### Aliases: DataSet17.2
### Keywords: datasets

### ** Examples

data(DataSet17.2)
str(DataSet17.2)
cat("Observations per treatment:\n")
print(table(DataSet17.2$trt))
cat("Sparsity:", nrow(DataSet17.2), "of",
    length(unique(DataSet17.2$subject)) * 9, "possible\n")



cleanEx()
nameEx("DataSet18.1")
### * DataSet18.1

flush(stderr()); flush(stdout())

### Name: DataSet18.1
### Title: Data for Example 18.1 — Alliance Wheat Trial: Gaussian Spatial
###   (Chapter 18)
### Aliases: DataSet18.1
### Keywords: datasets

### ** Examples

data(DataSet18.1)
str(DataSet18.1)
with(DataSet18.1, table(block))



cleanEx()
nameEx("DataSet18.2")
### * DataSet18.2

flush(stderr()); flush(stdout())

### Name: DataSet18.2
### Title: Data for Example 18.2 — Hessian Fly Trial: Binomial Spatial
###   (Chapter 18)
### Aliases: DataSet18.2
### Keywords: datasets

### ** Examples

data(DataSet18.2)
str(DataSet18.2)
with(DataSet18.2, tapply(y / n, variety, mean))



cleanEx()
nameEx("DataSet21.1")
### * DataSet21.1

flush(stderr()); flush(stdout())

### Name: DataSet21.1
### Title: Data for Example 21.1 — Power Curve for One-Way ANOVA (Chapter
###   21)
### Aliases: DataSet21.1
### Keywords: datasets

### ** Examples

data(DataSet21.1)
str(DataSet21.1)



cleanEx()
nameEx("DataSet3.1")
### * DataSet3.1

flush(stderr()); flush(stdout())

### Name: DataSet3.1
### Title: Data for Example 3.1 and Example 3.2 from Generalized Linear
###   Mixed Models: Modern Concepts, Methods and Applications by Stroup,
###   Ptukhina, and Garai (2024, 2nd ed.)
### Aliases: DataSet3.1
### Keywords: datasets

### ** Examples

data(DataSet3.1)



cleanEx()
nameEx("DataSet3.2")
### * DataSet3.2

flush(stderr()); flush(stdout())

### Name: DataSet3.2
### Title: DataSet3.2 for Example 3.3, Example 3.4, Example3.6, Example3.8
###   and Example 3.9 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: DataSet3.2
### Keywords: datasets

### ** Examples

data(DataSet3.2)



cleanEx()
nameEx("DataSet3.3")
### * DataSet3.3

flush(stderr()); flush(stdout())

### Name: DataSet3.3
### Title: Data for Example3.7 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: DataSet3.3
### Keywords: datasets

### ** Examples

data(DataSet3.3)



cleanEx()
nameEx("DataSet8.1")
### * DataSet8.1

flush(stderr()); flush(stdout())

### Name: DataSet8.1
### Title: Data for Example 8.1 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet8.1
### Keywords: datasets

### ** Examples

data(DataSet8.1)



cleanEx()
nameEx("DataSet8.2")
### * DataSet8.2

flush(stderr()); flush(stdout())

### Name: DataSet8.2
### Title: Data for Example 8.2 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet8.2
### Keywords: datasets

### ** Examples

data(DataSet8.2)



cleanEx()
nameEx("DataSet8.3")
### * DataSet8.3

flush(stderr()); flush(stdout())

### Name: DataSet8.3
### Title: Data for Example 8.3 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet8.3
### Keywords: datasets

### ** Examples

data(DataSet8.3)



cleanEx()
nameEx("DataSet8.4")
### * DataSet8.4

flush(stderr()); flush(stdout())

### Name: DataSet8.4
### Title: Data for Example 8.4 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet8.4
### Keywords: datasets

### ** Examples

data(DataSet8.4)



cleanEx()
nameEx("DataSet8.5")
### * DataSet8.5

flush(stderr()); flush(stdout())

### Name: DataSet8.5
### Title: Data for Example 8.4 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet8.5
### Keywords: datasets

### ** Examples

data(DataSet8.5)



cleanEx()
nameEx("DataSet8.6")
### * DataSet8.6

flush(stderr()); flush(stdout())

### Name: DataSet8.6
### Title: Data for Example 8.6 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet8.6
### Keywords: datasets

### ** Examples

data(DataSet8.6)



cleanEx()
nameEx("DataSet8.7")
### * DataSet8.7

flush(stderr()); flush(stdout())

### Name: DataSet8.7
### Title: Data for Example 8.7 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet8.7
### Keywords: datasets

### ** Examples

data(DataSet8.7)



cleanEx()
nameEx("DataSet9.1")
### * DataSet9.1

flush(stderr()); flush(stdout())

### Name: DataSet9.1
### Title: Data for Example 9.1 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet9.1
### Keywords: datasets

### ** Examples

data(DataSet9.1)



cleanEx()
nameEx("DataSet9.2")
### * DataSet9.2

flush(stderr()); flush(stdout())

### Name: DataSet9.2
### Title: Data for Example 9.2 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet9.2
### Keywords: datasets

### ** Examples

data(DataSet9.2)



cleanEx()
nameEx("DataSet9.3")
### * DataSet9.3

flush(stderr()); flush(stdout())

### Name: DataSet9.3
### Title: Data for Example 9.3 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet9.3
### Keywords: datasets

### ** Examples

data(DataSet9.3)



cleanEx()
nameEx("DataSet9.4")
### * DataSet9.4

flush(stderr()); flush(stdout())

### Name: DataSet9.4
### Title: Data for Example 9.4 from Generalized Linear Mixed Models:
###   Modern Concepts, Methods and Applications by Stroup, Ptukhina, and
###   Garai (2024, 2nd ed.)
### Aliases: DataSet9.4
### Keywords: datasets

### ** Examples

data(DataSet9.4)



cleanEx()
nameEx("Exam1.1")
### * Exam1.1

flush(stderr()); flush(stdout())

### Name: Exam1.1
### Title: Example 1.1 — Probability Distribution, LM, and GLM
### Aliases: Exam1.1

### ** Examples

data(Table1.1)

## Linear Model (Section 1.2.3)
Exam1.1.lm1 <- stats::lm(formula = y / Nx ~ x, data = Table1.1)
summary(Exam1.1.lm1)
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam1.1.lm1)
}

## GLM with logit link (binomial family, Section 1.2.4)
Exam1.1.glm1 <- stats::glm(
  formula = cbind(y, Nx - y) ~ x,
  family  = stats::binomial(link = "logit"),
  data    = Table1.1
)
summary(Exam1.1.glm1)
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam1.1.glm1)
}

## Figure 1.1 — LM vs GLM fitted proportions
plot_df <- rbind(
  data.frame(x = Table1.1$x,
             p = Table1.1$y / Table1.1$Nx,
             Model = "Observed"),
  data.frame(x = Table1.1$x,
             p = Exam1.1.lm1$fitted.values,
             Model = "LM"),
  data.frame(x = Table1.1$x,
             p = Exam1.1.glm1$fitted.values,
             Model = "GLM (logit)")
)

ggplot2::ggplot(
    plot_df,
    ggplot2::aes(x = x, y = p, colour = Model, shape = Model)
  ) +
  ggplot2::geom_point(size = 2.5) +
  ggplot2::geom_line(
    data = subset(plot_df, Model != "Observed")
  ) +
  ggplot2::scale_colour_manual(
    values = c("Observed"    = "black",
               "LM"          = "#377EB8",
               "GLM (logit)" = "#E41A1C")
  ) +
  ggplot2::labs(
    title  = "Example 1.1: Linear Model vs Logistic GLM",
    x      = "Dose (x)",
    y      = "Proportion (p)",
    colour = "Model",
    shape  = "Model"
  ) +
  ggplot2::theme_bw()

## Correlation of fitted values with observed
cat("LM  correlation:", round(stats::cor(Table1.1$y / Table1.1$Nx,
                                        Exam1.1.lm1$fitted.values), 4), "\n")
cat("GLM correlation:", round(stats::cor(Table1.1$y / Table1.1$Nx,
                                        Exam1.1.glm1$fitted.values), 4), "\n")



cleanEx()
nameEx("Exam1.2")
### * Exam1.2

flush(stderr()); flush(stdout())

### Name: Exam1.2
### Title: Example1.2 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam1.2

### ** Examples


#-------------------------------------------------------------
## Plot of multi-batch regression data discussed in Article 1.3
#-------------------------------------------------------------
data(Table1.2)

Table1.2$Batch <- factor(x  = Table1.2$Batch)

Plot  <-
 ggplot2::ggplot(
   data = Table1.2,
   mapping = ggplot2::aes(y = Y, x = X, colour = Batch, shape = Batch)
 ) +
 ggplot2::geom_point() +
 ggplot2::geom_smooth(method = "lm", fill =  NA) +
 ggplot2::labs(title   = "Plot of Multi Batch Regression data") +
 ggplot2::theme_bw()
Plot



cleanEx()
nameEx("Exam10.1")
### * Exam10.1

flush(stderr()); flush(stdout())

### Name: Exam10.1
### Title: Example 10.1 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam10.1

### ** Examples


data(DataSet10.1)
DataSet10.1$a <- factor(x = DataSet10.1$a)

## Random effects model
Exam10.1lmer <- lme4::lmer(y ~ 1 + (1|a), data = DataSet10.1)
summary(Exam10.1lmer)

## Fixed effects model (for comparison)
Exam10.1lm <- stats::lm(y ~ a, data = DataSet10.1)
summary(Exam10.1lm)

## Overall mean — broad inference (random effects model)
emmeans::emmeans(Exam10.1lmer, specs = ~1)

## Overall mean — narrow inference (fixed effects model)
emmeans::emmeans(Exam10.1lm, specs = ~1)

## BLUP Estimates and standard errors for each level of a
## SE from conditional variance: sqrt(postVar) matches book Table 10.1 SE = 0.82453
blup_coef <- unlist(lme4::ranef(Exam10.1lmer)$a)
rv_a      <- lme4::ranef(Exam10.1lmer, condVar = TRUE)
BLUPa_SE  <- sqrt(attr(rv_a$a, "postVar")[1, 1, ])
BLUPa     <- mean(DataSet10.1$y) + blup_coef
print(data.frame(level = rownames(rv_a$a), BLUP = BLUPa, SE = BLUPa_SE))




cleanEx()
nameEx("Exam10.2")
### * Exam10.2

flush(stderr()); flush(stdout())

### Name: Exam10.2
### Title: Example 10.2 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam10.2

### ** Examples


data(DataSet10.2)
DataSet10.2$a <- factor(x = DataSet10.2$a)
DataSet10.2$b <- factor(x = DataSet10.2$b)

## Random effects nested model (b nested within a)
Exam10.2lmer <- lmerTest::lmer(y ~ 1 + (1 | a / b), data = DataSet10.2)
summary(Exam10.2lmer)

## Fixed effects nested model (for comparison)
Exam10.2lm <- stats::lm(y ~ a + b %in% a, data = DataSet10.2)
summary(Exam10.2lm)

## Overall mean — narrow inference
emmeans::emmeans(Exam10.2lm, specs = ~1)

## BLUP Estimates for each level of a
blup_coef <- unlist(lme4::ranef(Exam10.2lmer)$a)
BLUPa <- sapply(seq_along(blup_coef), \(i) mean(DataSet10.2$y) + blup_coef[i])
BLUPa




cleanEx()
nameEx("Exam10.4")
### * Exam10.4

flush(stderr()); flush(stdout())

### Name: Exam10.4
### Title: Example 10.4 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam10.4

### ** Examples


data(DataSet10.4)
DataSet10.4$a <- factor(x = DataSet10.4$a)
DataSet10.4$b <- factor(x = DataSet10.4$b)

Exam10.4lmer <- lme4::lmer(y ~ a + (1|b) + (1|a:b), data = DataSet10.4)
summary(Exam10.4lmer)

## BLUP vs fixed effects comparison
emmeans::emmeans(Exam10.4lmer, specs = ~a)




cleanEx()
nameEx("Exam11.1")
### * Exam11.1

flush(stderr()); flush(stdout())

### Name: Exam11.1
### Title: Example 11.1 - CRD Count Data and Poisson-Normal GLMM
### Aliases: Exam11.1

### ** Examples

data(DataSet11.1)

fit_count <- stats::lm(count ~ trt, data = DataSet11.1)
stats::anova(fit_count)

DataSet11.1$log_count <- log(DataSet11.1$count)
fit_log <- stats::lm(log_count ~ trt, data = DataSet11.1)
stats::anova(fit_log)
emmeans::emmeans(fit_log, specs = ~ trt)

fit_glm <- stats::glm(
  count ~ trt,
  family = stats::poisson(link = "log"),
  data = DataSet11.1
)
emmeans::emmeans(fit_glm, specs = ~ trt, type = "response")

if (requireNamespace("lme4", quietly = TRUE)) {
  fit_glmm <- lme4::glmer(
    count ~ trt + (1 | trt:unit),
    family = stats::poisson(link = "log"),
    data = DataSet11.1,
    nAGQ = 0,
    control = lme4::glmerControl(optimizer = "bobyqa")
  )
  summary(fit_glmm)
  lme4::VarCorr(fit_glmm)
  emmeans::emmeans(fit_glmm, specs = ~ trt, type = "response")

  if (requireNamespace("DHARMa", quietly = TRUE)) {
    sim_res <- DHARMa::simulateResiduals(fit_glmm, plot = FALSE)
    DHARMa::testDispersion(sim_res)
  }

  if (requireNamespace("report", quietly = TRUE)) {
    report::report(fit_glmm)
  }
}



cleanEx()
nameEx("Exam11.3")
### * Exam11.3

flush(stderr()); flush(stdout())

### Name: Exam11.3
### Title: Example 11.3 - Blocked Count Data and Overdispersion
### Aliases: Exam11.3

### ** Examples

data(DataSet11.3)

if (requireNamespace("lme4", quietly = TRUE)) {
  fit_naive <- lme4::glmer(
    count ~ trt + (1 | block),
    family = stats::poisson(link = "log"),
    data = DataSet11.3,
    nAGQ = 1,
    control = lme4::glmerControl(optimizer = "bobyqa")
  )
  pearson_df <- sum(stats::residuals(fit_naive, type = "pearson")^2) /
    stats::df.residual(fit_naive)
  pearson_df
  emmeans::emmeans(fit_naive, specs = ~ trt, type = "response")

  fit_pois_normal <- lme4::glmer(
    count ~ trt + (1 | block) + (1 | block:trt),
    family = stats::poisson(link = "log"),
    data = DataSet11.3,
    nAGQ = 0,
    control = lme4::glmerControl(optimizer = "bobyqa")
  )
  lme4::VarCorr(fit_pois_normal)
  emmeans::emmeans(fit_pois_normal, specs = ~ trt, type = "response")
}

if (requireNamespace("glmmTMB", quietly = TRUE)) {
  fit_nb <- glmmTMB::glmmTMB(
    count ~ trt + (1 | block),
    family = glmmTMB::nbinom2(link = "log"),
    data = DataSet11.3
  )
  summary(fit_nb)
  emmeans::emmeans(fit_nb, specs = ~ trt, type = "response")

  if (requireNamespace("DHARMa", quietly = TRUE)) {
    sim_res <- DHARMa::simulateResiduals(fit_nb, plot = FALSE)
    DHARMa::testDispersion(sim_res)
  }

  if (requireNamespace("report", quietly = TRUE)) {
    report::report(fit_nb)
  }
}



cleanEx()
nameEx("Exam11.4")
### * Exam11.4

flush(stderr()); flush(stdout())

### Name: Exam11.4
### Title: Example 11.4 - Split-Plot Count Data
### Aliases: Exam11.4

### ** Examples

data(DataSet11.4)

if (requireNamespace("glmmTMB", quietly = TRUE)) {
  fit_nb <- glmmTMB::glmmTMB(
    count ~ a * b + (1 | block) + (1 | block:a),
    family = glmmTMB::nbinom2(link = "log"),
    data = DataSet11.4
  )
  summary(fit_nb)
  emmeans::emmeans(fit_nb, specs = ~ a * b, type = "response")

  if (requireNamespace("DHARMa", quietly = TRUE)) {
    sim_res <- DHARMa::simulateResiduals(fit_nb, plot = FALSE)
    DHARMa::testDispersion(sim_res)
  }

  if (requireNamespace("report", quietly = TRUE)) {
    report::report(fit_nb)
  }
}



cleanEx()
nameEx("Exam12.1")
### * Exam12.1

flush(stderr()); flush(stdout())

### Name: Exam12.1
### Title: Example 12.1 — Continuous Proportions: Beta GLMM
### Aliases: Exam12.1

### ** Examples

data(DataSet12.1)

## -------------------------------------------------------
## 1. Exploratory: mean proportion by treatment and dose
## -------------------------------------------------------
with(DataSet12.1, tapply(proportion, list(trt, dose), mean))

## -------------------------------------------------------
## 2. Beta GLMM with run(trt) random effect via glmmTMB
## -------------------------------------------------------
if (requireNamespace("glmmTMB", quietly = TRUE)) {

  ## Step 1: lack-of-fit test (add trt×dose interaction)
  fit_full <- glmmTMB::glmmTMB(
    proportion ~ trt * dose + (1 | run),
    family = glmmTMB::beta_family(link = "logit"),
    data   = DataSet12.1
  )
  summary(fit_full)

  ## Step 2: separate linear regressions per treatment
  fit_sep <- glmmTMB::glmmTMB(
    proportion ~ trt / dose - 1 + (1 | run),
    family = glmmTMB::beta_family(link = "logit"),
    data   = DataSet12.1
  )
  summary(fit_sep)

  ## -------------------------------------------------------
  ## 3. Contrast: equal intercepts and equal slopes
  ## -------------------------------------------------------
  emm_int <- emmeans::emmeans(fit_sep, ~ trt, at = list(dose = 0))
  emmeans::contrast(emm_int, method = "pairwise")

  emm_slope <- emmeans::emtrends(fit_sep, ~ trt, var = "dose")
  emmeans::contrast(emm_slope, method = "pairwise")

  ## -------------------------------------------------------
  ## 4. Predicted proportions at dose=0 and dose=5
  ## -------------------------------------------------------
  emm_d0 <- emmeans::emmeans(fit_sep, ~ trt, at = list(dose = 0),
                              type = "response")
  emm_d5 <- emmeans::emmeans(fit_sep, ~ trt, at = list(dose = 5),
                              type = "response")
  print(emm_d0)
  print(emm_d5)
  emmeans::contrast(emm_d5, method = "pairwise")
}



cleanEx()
nameEx("Exam12.2")
### * Exam12.2

flush(stderr()); flush(stdout())

### Name: Exam12.2
### Title: Example 12.2 — Binomial GLMM: Nested Factorial Design
### Aliases: Exam12.2

### ** Examples

data(DataSet12.2)

## -------------------------------------------------------
## 1. Exploratory: observed proportions by set and treatment
## -------------------------------------------------------
with(DataSet12.2, tapply(f / n, list(a, b), mean))

## -------------------------------------------------------
## 2. Binomial GLMM — nested factorial
## Blocks are nested within A: (1 | block) = whole-plot error
## Matches book random a / subject=Block in GLIMMIX
## -------------------------------------------------------
fit_lme4 <- lme4::glmer(
  cbind(f, n - f) ~ a / b + (1 | block),
  family  = stats::binomial(link = "logit"),
  data    = DataSet12.2,
  control = lme4::glmerControl(optimizer = "bobyqa")
)
summary(fit_lme4)

## -------------------------------------------------------
## 3. Type III tests for A and B(A)
## -------------------------------------------------------
if (requireNamespace("car", quietly = TRUE)) {
  car::Anova(fit_lme4, type = "III")
}

## -------------------------------------------------------
## 4. Least-squares means for B(A) — treatment within set
## -------------------------------------------------------
emm_ba <- emmeans::emmeans(fit_lme4, ~ b | a, type = "response")
print(emm_ba)
emmeans::contrast(emm_ba, method = "pairwise")

## -------------------------------------------------------
## 5. Probit link (Section 12.4.1)
## -------------------------------------------------------
fit_probit <- lme4::glmer(
  cbind(f, n - f) ~ a / b + (1 | block),
  family  = stats::binomial(link = "probit"),
  data    = DataSet12.2,
  control = lme4::glmerControl(optimizer = "bobyqa")
)
summary(fit_probit)

## Compare logit vs probit: F-test for B(A) within A=setA
emm_probit <- emmeans::emmeans(fit_probit, ~ b | a, type = "response")
print(emm_probit)

## -------------------------------------------------------
## 6. Overdispersion check
## -------------------------------------------------------
if (requireNamespace("DHARMa", quietly = TRUE)) {
  sim_r <- DHARMa::simulateResiduals(fit_lme4)
  DHARMa::testDispersion(sim_r)
}



cleanEx()
nameEx("Exam14.1")
### * Exam14.1

flush(stderr()); flush(stdout())

### Name: Exam14.1
### Title: Example 14.1 — Ordinal GLMM: Proportional Odds and Threshold
###   Models
### Aliases: Exam14.1

### ** Examples

data(DataSet14.1)

## -------------------------------------------------------
## 1. Marginal frequency table
## -------------------------------------------------------
with(DataSet14.1, tapply(y, list(trt, rating), sum))

## -------------------------------------------------------
## 2. Fixed-effects proportional odds via MASS::polr
## -------------------------------------------------------
## Ignores block random effect; for illustration of fixed-effect structure.
## A full GLMM would require ordinal::clmm or glmmTMB >= 1.2 with cumulative().
fit_polr <- MASS::polr(
  rating ~ trt,
  weights = y,
  data    = DataSet14.1,
  Hess    = TRUE,
  method  = "logistic"
)
summary(fit_polr)

## Wald p-values
coef_tab <- coef(summary(fit_polr))
pval     <- stats::pnorm(abs(coef_tab[, "t value"]),
                          lower.tail = FALSE) * 2
cbind(coef_tab, "p value" = pval)

## Odds ratios for treatments vs reference (trt 5)
exp(coef(fit_polr)[seq_len(nlevels(DataSet14.1$trt) - 1)])

## -------------------------------------------------------
## 4. Threshold (cumulative probit) model
## -------------------------------------------------------
fit_probit <- MASS::polr(
  rating ~ trt,
  weights = y,
  data    = DataSet14.1,
  Hess    = TRUE,
  method  = "probit"
)
summary(fit_probit)



cleanEx()
nameEx("Exam14.2")
### * Exam14.2

flush(stderr()); flush(stdout())

### Name: Exam14.2
### Title: Example 14.2 — Ordinal GLMM: Non-Proportional Odds (Poinsettia
###   Trial)
### Aliases: Exam14.2

### ** Examples

data(DataSet14.2)

## -------------------------------------------------------
## 1. Raw frequency table (should match book p.438 exactly)
## -------------------------------------------------------
(tab <- with(DataSet14.2, tapply(y, list(variety, rating), sum)))
round(sweep(tab, 1, rowSums(tab), "/") * 100, 2)   # row percentages

## -------------------------------------------------------
## 2. Proportional odds model — expected to fail (F≈0.02, p≈0.98)
## -------------------------------------------------------
fit_po <- MASS::polr(
  rating ~ variety,
  weights = y,
  data    = DataSet14.2,
  Hess    = TRUE,
  method  = "logistic"
)
summary(fit_po)

## -------------------------------------------------------
## 3. Illustration of proportional odds failure
## -------------------------------------------------------
## Fit separate logistic regressions for each boundary:
## Boundary 1: P(rating == "A") vs P(rating %in% c("B","C"))
## Boundary 2: P(rating %in% c("A","B")) vs P(rating == "C")
dat_b1 <- DataSet14.2
dat_b1$y_A   <- dat_b1$y * (dat_b1$rating == "A")
dat_b1$y_BC  <- dat_b1$y * (dat_b1$rating != "A")
agg1 <- aggregate(cbind(y_A, y_BC) ~ variety + grower, data = dat_b1, FUN = sum)
if (requireNamespace("lme4", quietly = TRUE)) {
  fit_b1 <- lme4::glmer(
    cbind(y_A, y_BC) ~ variety + (1 | grower),
    family  = stats::binomial(link = "logit"),
    data    = agg1,
    control = lme4::glmerControl(optimizer = "bobyqa")
  )
  cat("Boundary 1 (A vs B+C) — variety effects:\n")
  print(round(stats::coef(summary(fit_b1))[, "Estimate"], 3))
}



cleanEx()
nameEx("Exam17.1")
### * Exam17.1

flush(stderr()); flush(stdout())

### Name: Exam17.1
### Title: Example 17.1 — Repeated Measures: Crossover with ARH(1)
###   Covariance
### Aliases: Exam17.1

### ** Examples

data(DataSet17.1)

## -------------------------------------------------------
## 1. Covariance model selection via AICC (CS, AR(1), ARH(1))
## -------------------------------------------------------

## CS: compound symmetry ~ random subject intercept within id(trt*period)
fit_cs <- nlme::lme(
  fixed     = y ~ period + trt / t + baseline,
  random    = ~ 1 | id,
  data      = DataSet17.1,
  method    = "REML"
)

## AR(1): via corAR1 on equally-spaced times within subject-period
fit_ar1 <- nlme::lme(
  fixed       = y ~ period + trt / t + baseline,
  random      = list(id = nlme::pdDiag(~ t)),
  correlation = nlme::corAR1(form = ~ t | id / period),
  data        = DataSet17.1,
  method      = "REML"
)

## ARH(1): heterogeneous variances per time + AR(1) within period
fit_arh1 <- nlme::lme(
  fixed       = y ~ period + trt / t + baseline,
  random      = list(id = nlme::pdDiag(~ t)),
  correlation = nlme::corAR1(form = ~ t | id / period),
  weights     = nlme::varIdent(form = ~ 1 | t),
  data        = DataSet17.1,
  method      = "REML"
)

## AICC comparison (best model = ARH(1) in book; may differ on reconstructed data)
stats::AIC(fit_cs, fit_ar1, fit_arh1)

## -------------------------------------------------------
## 2. Key contrasts: equal intercepts, equal slopes
## -------------------------------------------------------
emm_int <- emmeans::emmeans(fit_arh1, ~ trt, at = list(t = 0))
emmeans::contrast(emm_int, method = "pairwise")

emm_slp <- emmeans::emtrends(fit_arh1, ~ trt, var = "t")
emmeans::contrast(emm_slp, method = "pairwise")

## -------------------------------------------------------
## 3. Treatment × time interaction profile
## -------------------------------------------------------
emm_trt_t <- emmeans::emmeans(fit_arh1, ~ trt | t,
                               at = list(t = 0:5))
print(emm_trt_t)



cleanEx()
nameEx("Exam17.2")
### * Exam17.2

flush(stderr()); flush(stdout())

### Name: Exam17.2
### Title: Example 17.2 — Repeated Measures: SP(POW) with Unequal Spacing
### Aliases: Exam17.2

### ** Examples

data(DataSet17.2)

## -------------------------------------------------------
## 1. Data overview
## -------------------------------------------------------
cat("Observations per treatment:\n")
print(table(DataSet17.2$trt))
cat("Times observed:\n")
print(sort(unique(DataSet17.2$time)))

## -------------------------------------------------------
## 2. Covariance model comparison: CS, AR(1), SP(POW)
## -------------------------------------------------------

## CS model (compound symmetry via random intercept)
fit_cs <- nlme::lme(
  fixed  = y ~ trt * time,
  random = ~ 1 | subject,
  data   = DataSet17.2,
  method = "REML",
  control = nlme::lmeControl(opt = "optim")
)

## AR(1) model (may fail on unequally-spaced data — corAR1 assumes equal spacing)
fit_ar1 <- tryCatch(
  nlme::lme(
    fixed       = y ~ trt * time,
    random      = ~ 1 | subject,
    correlation = nlme::corAR1(form = ~ time | subject),
    data        = DataSet17.2,
    method      = "REML",
    control     = nlme::lmeControl(opt = "optim")
  ),
  error = function(e) {
    message("AR(1) failed (expected for unequal spacing): ", conditionMessage(e))
    NULL
  }
)

## SP(POW): spatial-power ~ exponential for unequal times
fit_sppow <- nlme::lme(
  fixed       = y ~ trt * time,
  random      = ~ 1 | subject,
  correlation = nlme::corExp(
    form   = ~ time | subject,
    nugget = FALSE
  ),
  data        = DataSet17.2,
  method      = "REML",
  control     = nlme::lmeControl(opt = "optim")
)

## AIC comparison (only non-NULL models)
aic_models <- Filter(Negate(is.null), list(CS = fit_cs, AR1 = fit_ar1, SPPOW = fit_sppow))
if (length(aic_models) > 0) print(sapply(aic_models, stats::AIC))

## -------------------------------------------------------
## 3. Random coefficient model with best covariance
## -------------------------------------------------------
fit_rc <- nlme::lme(
  fixed       = y ~ trt + time + trt:time,
  random      = ~ 1 + time | subject,
  correlation = nlme::corExp(form = ~ time | subject),
  data        = DataSet17.2,
  method      = "REML",
  control     = nlme::lmeControl(opt = "optim", maxIter = 200)
)
summary(fit_rc)

## -------------------------------------------------------
## 4. Treatment effects and predicted profiles
## -------------------------------------------------------
emm_trt <- emmeans::emmeans(fit_rc, ~ trt,
                             at = list(time = c(0, 1, 4, 16, 64)))
print(emm_trt)

## Equal slopes test
emm_slp <- emmeans::emtrends(fit_rc, ~ trt, var = "time")
emmeans::contrast(emm_slp, method = "pairwise")



cleanEx()
nameEx("Exam18.1")
### * Exam18.1

flush(stderr()); flush(stdout())

### Name: Exam18.1
### Title: Example 18.1 — Gaussian Spatial Variability: Alliance Wheat
###   Trial
### Aliases: Exam18.1

### ** Examples

data(DataSet18.1)

## -------------------------------------------------------
## 1. Baseline: complete block model (no spatial covariance)
## -------------------------------------------------------
fit_rcb <- stats::lm(y ~ trt + block, data = DataSet18.1)
cat("RCB AIC:", stats::AIC(fit_rcb), "\n")

## -------------------------------------------------------
## 2. Spatial models via nlme::gls
## -------------------------------------------------------

## Spherical covariance (SP(SPH) — best model in book)
fit_sph <- nlme::gls(
  model       = y ~ trt + block,
  correlation = nlme::corSpher(
    form   = ~ row + col,
    nugget = FALSE
  ),
  data   = DataSet18.1,
  method = "REML"
)
summary(fit_sph)

## Exponential covariance
fit_exp <- nlme::gls(
  model       = y ~ trt + block,
  correlation = nlme::corExp(
    form   = ~ row + col,
    nugget = FALSE
  ),
  data   = DataSet18.1,
  method = "REML"
)

## Gaussian covariance
fit_gau <- nlme::gls(
  model       = y ~ trt + block,
  correlation = nlme::corGaus(
    form   = ~ row + col,
    nugget = FALSE
  ),
  data   = DataSet18.1,
  method = "REML"
)

## AICC comparison (smallest = best)
stats::AIC(fit_rcb, fit_sph, fit_exp, fit_gau)

## -------------------------------------------------------
## 3. Estimated range and sill from best model
## -------------------------------------------------------
tryCatch(
  nlme::intervals(fit_sph, which = "var-cov"),
  error = function(e) {
    cat("Intervals not available:", conditionMessage(e), "\n")
    cat("Range estimate:\n")
    print(stats::coef(fit_sph$modelStruct$corStruct, unconstrained = FALSE))
  }
)

## -------------------------------------------------------
## 4. Spatial treatment means
## -------------------------------------------------------
emm_sp <- emmeans::emmeans(fit_sph, ~ trt)
## Top 10 treatment means (sorted)
head(as.data.frame(emm_sp)[order(-as.data.frame(emm_sp)$emmean), ], 10)

## -------------------------------------------------------
## 5. Empirical variogram
## -------------------------------------------------------
vario <- nlme::Variogram(fit_sph, form = ~ row + col, resType = "normalized")
plot(vario, smooth = TRUE)



cleanEx()
nameEx("Exam18.2")
### * Exam18.2

flush(stderr()); flush(stdout())

### Name: Exam18.2
### Title: Example 18.2 — Binomial Spatial GLMM: Hessian Fly Trial
### Aliases: Exam18.2

### ** Examples

data(DataSet18.2)

## -------------------------------------------------------
## 1. Exploratory: observed resistance rates by variety
## -------------------------------------------------------
with(DataSet18.2, tapply(y / n, variety, mean))

## -------------------------------------------------------
## 2. RCB model (complete block — baseline)
## -------------------------------------------------------
fit_rcb <- lme4::glmer(
  cbind(y, n - y) ~ variety + (1 | block),
  family  = stats::binomial(link = "logit"),
  data    = DataSet18.2,
  control = lme4::glmerControl(optimizer = "bobyqa")
)
summary(fit_rcb)

## Type III test for variety (F_entry in book)
if (requireNamespace("car", quietly = TRUE)) {
  car::Anova(fit_rcb, type = "III")
}

## -------------------------------------------------------
## 3. Spatial binomial GLMM via glmmTMB (G-side spherical)
## -------------------------------------------------------
if (requireNamespace("glmmTMB", quietly = TRUE)) {

  ## Add spatial random effect via pos = numFactor(row, col)
  DataSet18.2$pos <- glmmTMB::numFactor(DataSet18.2$row, DataSet18.2$col)

  fit_sp <- glmmTMB::glmmTMB(
    cbind(y, n - y) ~ variety + (1 | block) +
      exp(pos + 0 | block),
    family  = stats::binomial(link = "logit"),
    data    = DataSet18.2
  )
  summary(fit_sp)

  ## Variety means adjusted for spatial effects
  emm_sp <- emmeans::emmeans(fit_sp, ~ variety, type = "response")
  print(emm_sp)
}

## -------------------------------------------------------
## 4. Incomplete block model (next-best in book)
## -------------------------------------------------------
## Lattice incomplete blocks within rep
DataSet18.2$inc_block <- interaction(DataSet18.2$block,
                                      ceiling(as.integer(DataSet18.2$variety) / 4))
fit_ib <- lme4::glmer(
  cbind(y, n - y) ~ variety + (1 | inc_block),
  family  = stats::binomial(link = "logit"),
  data    = DataSet18.2,
  control = lme4::glmerControl(optimizer = "bobyqa")
)
summary(fit_ib)

## -------------------------------------------------------
## 5. Residual diagnostics
## -------------------------------------------------------
if (requireNamespace("DHARMa", quietly = TRUE)) {
  sim_r <- DHARMa::simulateResiduals(fit_rcb)
  DHARMa::testSpatialAutocorrelation(
    sim_r,
    x = DataSet18.2$col,
    y = DataSet18.2$row
  )
}



cleanEx()
nameEx("Exam2.B.1")
### * Exam2.B.1

flush(stderr()); flush(stdout())

### Name: Exam2.B.1
### Title: Example 2.B.1 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam2.B.1

### ** Examples

#-----------------------------------------------------------------------------------
## Linear Model  discussed in Example 2.B.1 using simple regression data of Table1.1
#-----------------------------------------------------------------------------------

data(Table1.1)

Exam2.B.1.lm1 <- lm(formula = y~x, data = Table1.1)
summary(Exam2.B.1.lm1)
parameters::model_parameters(Exam2.B.1.lm1)

DesignMatrix.lm1 <- model.matrix (object = Exam2.B.1.lm1)
DesignMatrix.lm1




cleanEx()
nameEx("Exam2.B.2")
### * Exam2.B.2

flush(stderr()); flush(stdout())

### Name: Exam2.B.2
### Title: Example 2.B.2 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam2.B.2

### ** Examples

#-----------------------------------------------------------------------------------
## probitit Model  discussed in Example 2.B.2 using DataExam2.B.2
## Default link is logit
## using fmaily = binomial gives warning message of no-integer successes
#-----------------------------------------------------------------------------------
data(DataExam2.B.2)
Exam2.B.2glm <- glm(formula = y/n~x, family = quasibinomial(link = "probit"), data =  DataExam2.B.2)
summary(Exam2.B.2glm)
parameters::model_parameters(Exam2.B.2glm)



cleanEx()
nameEx("Exam2.B.3")
### * Exam2.B.3

flush(stderr()); flush(stdout())

### Name: Exam2.B.3
### Title: Example 2.B.3 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam2.B.3

### ** Examples

#-----------------------------------------------------------------------------------
## Means Model  discussed in Example 2.B.3 using DataExam2.B.3
#-----------------------------------------------------------------------------------
Exam2.B.3.lm1 <- lm(formula = y ~ trt, data = DataExam2.B.3)
summary(Exam2.B.3.lm1)

#-----------------------------------------------------------------------------------
## Effectss Model  discussed in Example 2.B.3 using DataExam2.B.3
#-----------------------------------------------------------------------------------
Exam2.B.3.lm2 <- lm(formula = y ~ 0 + trt, data = DataExam2.B.3)
summary(Exam2.B.3.lm2)
parameters::model_parameters(Exam2.B.3.lm2)



cleanEx()
nameEx("Exam2.B.4")
### * Exam2.B.4

flush(stderr()); flush(stdout())

### Name: Exam2.B.4
### Title: Example 2.B.4 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam2.B.4

### ** Examples

#-----------------------------------------------------------------------------------
## logit Model  discussed in Example 2.B.2 using DataExam2.B.4
## Default link is logit
## using fmaily=binomial gives warning message of no-integer successes
#-----------------------------------------------------------------------------------
data(DataExam2.B.4)
DataExam2.B.4$trt <- factor(x =  DataExam2.B.4$trt)
Exam2.B.4glm <-
                glm(
                      formula = Yij/Nij ~ trt
                    , family  =  quasibinomial(link = "probit")
                    , data    = DataExam2.B.4
                    )
summary(Exam2.B.4glm)
parameters::model_parameters(Exam2.B.4glm)



cleanEx()
nameEx("Exam2.B.5")
### * Exam2.B.5

flush(stderr()); flush(stdout())

### Name: Exam2.B.5
### Title: Example 2.B.5 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam2.B.5

### ** Examples

#-----------------------------------------------------------------------------------
## Nested Model with no intercept
#-----------------------------------------------------------------------------------

data(Table1.2)
Table1.2$Batch <- factor(x = Table1.2$Batch)

Exam2.B.5.lm1 <- lm(formula = Y ~ 0 + Batch + Batch/X, data = Table1.2)
DesignMatrix.lm1 <- model.matrix (object = Exam2.B.5.lm1)
DesignMatrix.lm1

#-----------------------------------------------------------------------------------
## Interaction Model with intercept
#-----------------------------------------------------------------------------------
Exam2.B.5.lm2 <-lm(formula = Y ~ Batch + X + Batch*X, data  = Table1.2)
DesignMatrix.lm2 <-   model.matrix (object = Exam2.B.5.lm2)
DesignMatrix.lm2

#-----------------------------------------------------------------------------------
## Interaction Model with no intercept
#-----------------------------------------------------------------------------------
Exam2.B.5.lm3 <- lm(formula = Y ~ 0 + Batch + Batch*X, data = Table1.2)
DesignMatrix.lm3 <-   model.matrix(object = Exam2.B.5.lm3)
DesignMatrix.lm3

#-----------------------------------------------------------------------------------
## Interaction Model with intercept  but omitting X term as main effect
#-----------------------------------------------------------------------------------
Exam2.B.5.lm4 <- lm(formula = Y ~ Batch + Batch*X, data = Table1.2)
DesignMatrix.lm4 <-   model.matrix(object = Exam2.B.5.lm4)
DesignMatrix.lm4




cleanEx()
nameEx("Exam2.B.6")
### * Exam2.B.6

flush(stderr()); flush(stdout())

### Name: Exam2.B.6
### Title: Example 2.B.6 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam2.B.6

### ** Examples

#-----------------------------------------------------------------------------------
## Nested Model with no intercept
#-----------------------------------------------------------------------------------

data(Table1.2)
Table1.2$Batch <- factor(x = Table1.2$Batch)
Exam2.B.6fm1 <- nlme::lme(
      fixed       = Y ~ X
    , data        = Table1.2
    , random      = list(Batch = nlme::pdDiag(~1), X = nlme::pdDiag(~1))
    , method      = c("REML", "ML")[1]
    )
Exam2.B.6fm1
broom.mixed::tidy(Exam2.B.6fm1)



cleanEx()
nameEx("Exam2.B.7")
### * Exam2.B.7

flush(stderr()); flush(stdout())

### Name: Exam2.B.7
### Title: Example 2.B.7 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam2.B.7

### ** Examples

#-----------------------------------------------------------------------------------
## Classical main effects and Interaction Model
#-----------------------------------------------------------------------------------
data(DataExam2.B.7)
DataExam2.B.7$a <- factor(x = DataExam2.B.7$a)
DataExam2.B.7$b <- factor(x = DataExam2.B.7$b)
Exam2.B.7.lm1 <- lm(formula = y~ a + b + a*b, data = DataExam2.B.7)
#-----------------------------------------------------------------------------------
## One way treatment effects model
#-----------------------------------------------------------------------------------
DesignMatrix.lm1 <- model.matrix (object = Exam2.B.7.lm1)
DesignMatrix2.B.7.2 <- DesignMatrix.lm1[,!colnames(DesignMatrix.lm1) %in% c("a2","b")]

lmfit2 <- lm.fit(x = DesignMatrix2.B.7.2, y = DataExam2.B.7$y)
Coefficientslmfit2 <- coef( object = lmfit2)
Coefficientslmfit2

#-----------------------------------------------------------------------------------
## One way treatment effects model without intercept
#-----------------------------------------------------------------------------------
DesignMatrix2.B.7.3    <-
  as.matrix(DesignMatrix.lm1[,!colnames(DesignMatrix.lm1) %in% c("(Intercept)","a2","b")])

lmfit3 <- lm.fit(x = DesignMatrix2.B.7.3, y = DataExam2.B.7$y)
Coefficientslmfit3 <- coef( object = lmfit3)
Coefficientslmfit3

#-----------------------------------------------------------------------------------
## Nested Model (both models give the same result)
#-----------------------------------------------------------------------------------
Exam2.B.7.lm4 <- lm(formula = y~ a + a/b, data  = DataExam2.B.7)
summary(Exam2.B.7.lm4)

Exam2.B.7.lm4 <- lm(formula = y~ a + a*b, data = DataExam2.B.7)
summary(Exam2.B.7.lm4)




cleanEx()
nameEx("Exam21.1")
### * Exam21.1

flush(stderr()); flush(stdout())

### Name: Exam21.1
### Title: Example 21.1 — Power Curves for ANOVA Designs
### Aliases: Exam21.1

### ** Examples

data(DataSet21.1)

## -------------------------------------------------------
## 1. Power function (non-central F)
## -------------------------------------------------------
power_anova <- function(n, k = 3L, f = 0.5, alpha = 0.05) {
  df1 <- k - 1L
  df2 <- k * (n - 1L)
  ncp <- k * n * f^2
  fc  <- stats::qf(1 - alpha, df1, df2)
  1 - stats::pf(fc, df1, df2, ncp = ncp)
}

power_anova(n = 10L, k = 3L, f = 0.5)

## -------------------------------------------------------
## 2. Power curve visualisation
## -------------------------------------------------------
if (requireNamespace("ggplot2", quietly = TRUE)) {
  DataSet21.1$effect_label <- paste0("f = ", DataSet21.1$effect_size)

  ggplot2::ggplot(
    data    = DataSet21.1,
    mapping = ggplot2::aes(
      x      = n_per_group,
      y      = power,
      colour = factor(effect_size),
      group  = factor(effect_size)
    )
  ) +
    ggplot2::geom_line(linewidth = 1) +
    ggplot2::geom_hline(
      yintercept = 0.80,
      linetype   = "dashed",
      colour     = "grey40"
    ) +
    ggplot2::scale_colour_manual(
      name   = "Effect size (f)",
      values = c("#E41A1C", "#377EB8", "#4DAF4A")
    ) +
    ggplot2::labs(
      title    = "Power curves for one-way ANOVA (k = 3)",
      subtitle = "Dashed line = 80% power",
      x        = "Sample size per group",
      y        = "Power"
    ) +
    ggplot2::theme_bw()
}

## -------------------------------------------------------
## 3. Minimum sample size for 80% power
## -------------------------------------------------------
min_n <- function(f, target_power = 0.80, k = 3L, alpha = 0.05) {
  ns <- 2:200
  pw <- sapply(ns, power_anova, k = k, f = f, alpha = alpha)
  ns[which(pw >= target_power)[1L]]
}

sapply(c(0.2, 0.5, 0.8), min_n)



cleanEx()
nameEx("Exam3.2")
### * Exam3.2

flush(stderr()); flush(stdout())

### Name: Exam3.2
### Title: Example 3.2 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam3.2

### ** Examples

#-------------------------------------------------------------
## Linear Model and results discussed in Article 1.2.1 after Table1.1
#-------------------------------------------------------------
data(DataSet3.1)
DataSet3.1$trt <- factor(x = DataSet3.1$trt)
Exam3.2.glm <- stats::glm(
  formula = cbind(F, N - F) ~ trt,
  family  = stats::binomial(link = "logit"),
  data    = DataSet3.1
)
summary(Exam3.2.glm)
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.2.glm)
}

#-------------------------------------------------------------
## Individual least squares treatment means
#-------------------------------------------------------------
emmeans::emmeans(object = Exam3.2.glm, specs = "trt")
emmeans::emmeans(object = Exam3.2.glm, specs = "trt", type = "response")

#---------------------------------------------------
## Overall mean (equal-weight average of treatment means)
#---------------------------------------------------
emmeans::emmeans(object = Exam3.2.glm, specs = ~1)
emmeans::emmeans(object = Exam3.2.glm, specs = ~1, type = "response")

#---------------------------------------------------
## Pairwise treatment means estimate
#---------------------------------------------------
emmeans::contrast(
  emmeans::emmeans(object = Exam3.2.glm, specs = "trt"),
  method = "pairwise"
)
emmeans::contrast(
  emmeans::emmeans(object = Exam3.2.glm, specs = "trt", type = "response"),
  method = "pairwise"
)



cleanEx()
nameEx("Exam3.3")
### * Exam3.3

flush(stderr()); flush(stdout())

### Name: Exam3.3
### Title: Example 3.3 — RCBD with Estimable Functions
### Aliases: Exam3.3

### ** Examples

data(DataSet3.2)
DataSet3.2$trt <- factor(x = DataSet3.2$trt, levels = c(3, 0, 1, 2))
DataSet3.2$loc <- factor(x = DataSet3.2$loc, levels = c(8, 1, 2, 3, 4, 5, 6, 7))

## Linear model
Exam3.3.lm1 <- stats::lm(formula = Y ~ trt + loc, data = DataSet3.2)
summary(Exam3.3.lm1)

if (requireNamespace("emmeans", quietly = TRUE)) {
  ## Estimated marginal means for treatment
  Lsm3.3 <- emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt)
  print(Lsm3.3)

  ## Pairwise contrasts
  emmeans::contrast(object = Lsm3.3, method = "pairwise")

  ## Reverse pairwise contrasts
  emmeans::contrast(object = Lsm3.3, method = "revpairwise")

  ## LSM Trt0 (Table 3.4, p. 77)
  emmeans::contrast(
    object = emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(0, 1, 0, 0))
  )

  ## Trt0 vs Trt1
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(0, 1, -1, 0))
  )

  ## Average Trt0 + Trt1
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(0, 1/2, 1/2, 0))
  )

  ## Average Trt0+2+3
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(1/3, 1/3, 0, 1/3))
  )

  ## Trt2 vs Trt3
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(-1, 0, 0, 1))
  )

  ## Trt1 vs Trt2
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(0, 0, 1, -1))
  )

  ## Trt1 vs Trt3
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(-1, 0, 1, 0))
  )

  ## Average (Trt0+1) vs Average (Trt2+3)
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(-1/2, 1/2, 1/2, -1/2))
  )

  ## Trt1 vs Average (Trt0+1+2)
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
    list(trt = c(1/3, 1/3, -1, 1/3))
  )
}



cleanEx()
nameEx("Exam3.5")
### * Exam3.5

flush(stderr()); flush(stdout())

### Name: Exam3.5
### Title: Example 3.5 — Factorial Fixed Effects, Estimable Functions
### Aliases: Exam3.5

### ** Examples

data(DataSet3.2)
DataSet3.2$A   <- factor(x = DataSet3.2$A)
DataSet3.2$B   <- factor(x = DataSet3.2$B)
DataSet3.2$loc <- factor(x = DataSet3.2$loc, levels = c(8, 1, 2, 3, 4, 5, 6, 7))

Exam3.5.lm <- stats::lm(formula = Y ~ A + B + loc, data = DataSet3.2)
Exam3.5.lm

if (requireNamespace("emmeans", quietly = TRUE)) {
  ## A=0 marginal mean
  emmeans::contrast(
    object = emmeans::emmeans(object = Exam3.5.lm, specs = ~ B),
    list(trt = c(1, 0))
  )

  ## B=0 marginal mean
  emmeans::contrast(
    object = emmeans::emmeans(object = Exam3.5.lm, specs = ~ B),
    list(B0 = c(1, 0))
  )

  ## Simple effect of A at B0 (B = "0")
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.5.lm, specs = ~ A | B),
    method = "pairwise",
    by     = "B"
  )

  ## Simple effect of B at A0 (A = "0")
  emmeans::contrast(
    emmeans::emmeans(object = Exam3.5.lm, specs = ~ B | A),
    method = "pairwise",
    by     = "A"
  )

  ## All A*B marginal means
  emmeans::emmeans(object = Exam3.5.lm, specs = ~ A * B)
}



cleanEx()
nameEx("Exam3.9")
### * Exam3.9

flush(stderr()); flush(stdout())

### Name: Exam3.9
### Title: Example 3.9 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam3.9

### ** Examples

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
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.9.fm1)
}

#-------------------------------------------------------------
##  treatment means
#-------------------------------------------------------------
emmeans::emmeans(object = Exam3.9.fm1, specs = ~trt, type = "response")
emmeans::emmeans(object = Exam3.9.fm1, specs = ~trt, type = "link")

##--- Normal Approximation
Exam3.9fm2 <-
  nlme::lme(
      fixed       = S2/Nbin~trt
    , data        = DataSet3.2
    , random      = ~1|loc
    , method      = c("REML", "ML")[1]
  )

Exam3.9fm2
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.9fm2)
}

emmeans::emmeans(object  = Exam3.9fm2, specs = ~trt)


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
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.9fm3)
}
emmeans::emmeans(object = Exam3.9fm3, specs = ~trt, type = "response")


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
if (requireNamespace("parameters", quietly = TRUE)) {
  parameters::model_parameters(Exam3.9fm4)
}
emmeans::emmeans(object  = Exam3.9fm4, specs  = ~trt, type = "response")




cleanEx()
nameEx("Exam8.1")
### * Exam8.1

flush(stderr()); flush(stdout())

### Name: Exam8.1
### Title: Example 8.1 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam8.1

### ** Examples


data(DataSet8.1)

DataSet8.1$a <- factor(x = DataSet8.1$a)
DataSet8.1$b <- factor(x = DataSet8.1$b)

Exam8.1.lm1 <- stats::lm(formula = y ~ a + b + a*b, data = DataSet8.1)
summary(Exam8.1.lm1)
parameters::model_parameters(Exam8.1.lm1)
stats::anova(Exam8.1.lm1)

##---Simple effects of b within each level of a (SAS SLICE equivalent)
emmeans::joint_tests(Exam8.1.lm1, by = "a")

##---Interaction plot
emmeans::emmip(
  object  = Exam8.1.lm1,
  formula = a ~ b,
  ylab    = "y LSMeans",
  main    = "LSMeans for a*b"
)

#-------------------------------------------------------------
## Individual least squares treatment means
#-------------------------------------------------------------
emmeans::emmeans(object = Exam8.1.lm1, specs = ~a*b)

##---Simple effects comparison of interaction by a
emmeans::emmeans(object = Exam8.1.lm1, specs = pairwise ~ b|a)$contrasts

emm_b_by_a <- emmeans::emmeans(object = Exam8.1.lm1, specs = ~b|a)
pairs(emm_b_by_a, simple = "each", combine = TRUE)
pairs(emm_b_by_a, simple = "a")
pairs(emm_b_by_a, simple = "b")
pairs(emm_b_by_a)
emmeans::contrast(emmeans::emmeans(object = Exam8.1.lm1, specs = ~b|a))
emmeans::emmeans(object = Exam8.1.lm1, specs = pairwise ~ b|a)
emmeans::emmeans(object = Exam8.1.lm1, specs = pairwise ~ b|a)$contrasts

##---Alternative method of pairwise comparisons by applying contrast coefficients
emmeans::contrast(
  emmeans::emmeans(object = Exam8.1.lm1, specs = ~a*b),
  list(
    c1 = c(1, 0, -1, 0, 0, 0),
    c2 = c(1, 0, 0, 0, -1, 0),
    c3 = c(0, 0, 1, 0, -1, 0),
    c4 = c(0, 1, 0, -1, 0, 0),
    c5 = c(0, 1, 0, 0, 0, -1),
    c6 = c(0, 1, 0, 0, -1, 0)
  )
)

##---Nested Model
Exam8.1.lm2 <- stats::lm(formula = y ~ a + a %in% b, data = DataSet8.1)

summary(Exam8.1.lm2)
parameters::model_parameters(Exam8.1.lm2)
stats::anova(Exam8.1.lm2)

car::linearHypothesis(Exam8.1.lm2, c("a0:b1 = a0:b2"))
car::linearHypothesis(Exam8.1.lm2, c("a1:b1 = a1:b2"))

##---Bonferroni's adjusted p-values
emmeans::emmeans(
  object  = Exam8.1.lm2,
  specs   = pairwise ~ b|a,
  adjust  = "bonferroni"
)$contrasts

##--- Alternative method of pairwise comparisons with Bonferroni adjustment
emmeans::contrast(
  emmeans::emmeans(object = Exam8.1.lm1, specs = ~a*b),
  list(
    c1 = c(1, 0, -1, 0, 0, 0),
    c2 = c(1, 0, 0, 0, -1, 0),
    c3 = c(0, 0, 1, 0, -1, 0),
    c4 = c(0, 1, 0, -1, 0, 0),
    c5 = c(0, 1, 0, 0, 0, -1),
    c6 = c(0, 1, 0, 0, -1, 0)
  ),
  adjust = "bonferroni"
)





cleanEx()
nameEx("Exam8.2")
### * Exam8.2

flush(stderr()); flush(stdout())

### Name: Exam8.2
### Title: Example 8.2 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam8.2

### ** Examples


data(DataSet8.2)
DataSet8.2$trt <- factor( x = DataSet8.2$trt )

##----ANCOVA(Equal slope Model)
Exam9.2fm1 <- aov(formula = y ~ trt*x, data = DataSet8.2)
car::Anova(mod = Exam9.2fm1 , type = "III")

##---ANCOVA(without interaction because of non significant slope effect)
Exam9.2fm2 <- aov(formula = y ~ trt + x, data    = DataSet8.2)
car::Anova(mod = Exam9.2fm2 , type = "III")

##---Ls means for 2nd model
emmeans::emmeans(object  = Exam9.2fm2, specs = ~trt)

##---Anova without covariate
Exam9.2fm3 <- aov(formula = y ~ trt, data = DataSet8.2)
car::Anova(mod = Exam9.2fm3, type = "III")

##---Ls means for 3rd model
emmeans::emmeans(object = Exam9.2fm3, specs = ~trt)

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




cleanEx()
nameEx("Exam8.3")
### * Exam8.3

flush(stderr()); flush(stdout())

### Name: Exam8.3
### Title: Example 8.3 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam8.3

### ** Examples


data(DataSet8.3)

DataSet8.3$trt <- factor(x = DataSet8.3$trt )

##----ANCOVA(Unequal slope Model)
Exam9.3fm1 <- aov(formula = y ~ trt*x, data = DataSet8.3)
car::Anova( mod = Exam9.3fm1 , type = "III")

Plot <-
   ggplot2::ggplot(
          data    = DataSet8.3
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

##----ANCOVA(Unequal slope Model without intercept at page 224)
Exam9.3fm2 <- lm(formula = y ~ 0 + trt/x, data = DataSet8.3)
summary(Exam9.3fm2)
parameters::model_parameters(Exam9.3fm2)

##--Lsmeans treatment at x=7 & 12 at page 225
emmeans::emmeans(object = Exam9.3fm2, specs = ~trt|x, at = list(x = c(7, 12)))




cleanEx()
nameEx("Exam8.6")
### * Exam8.6

flush(stderr()); flush(stdout())

### Name: Exam8.6
### Title: Example 8.6 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam8.6

### ** Examples


data(DataSet8.6)

DataSet8.6 <- collapse::fmutate(
  DataSet8.6,
  logx1 = ifelse(x1 == 0, log(x1 + 0.1), log(x1)),
  logx2 = ifelse(x2 == 0, log(x2 + 0.1), log(x2))
)
DataSet8.6

Exam8.6.lm <- stats::lm(formula = response ~ x1*x2 + logx1*logx2, data = DataSet8.6)
summary(Exam8.6.lm)
parameters::model_parameters(Exam8.6.lm)

##---3D scatter plot via ggplot2 (observed data)
ggplot2::ggplot(DataSet8.6, ggplot2::aes(x = x1, y = x2, colour = response, size = response)) +
  ggplot2::geom_point(alpha = 0.8) +
  ggplot2::scale_colour_viridis_c(option = "plasma") +
  ggplot2::labs(
    title  = "Observed Response by x1 and x2",
    x      = "x1",
    y      = "x2",
    colour = "response"
  ) +
  ggplot2::theme_bw() +
  ggplot2::guides(size = "none")

##---Fitted response surface (tile/heatmap)
grid_data <- expand.grid(
  x1 = seq(min(DataSet8.6$x1), max(DataSet8.6$x1), length.out = 50),
  x2 = seq(min(DataSet8.6$x2), max(DataSet8.6$x2), length.out = 50)
)
grid_data <- collapse::fmutate(
  grid_data,
  logx1 = ifelse(x1 == 0, log(x1 + 0.1), log(x1)),
  logx2 = ifelse(x2 == 0, log(x2 + 0.1), log(x2))
)
grid_data$Yhat <- stats::predict(Exam8.6.lm, newdata = grid_data)

ggplot2::ggplot(grid_data, ggplot2::aes(x = x1, y = x2, fill = Yhat)) +
  ggplot2::geom_tile() +
  ggplot2::scale_fill_viridis_c(option = "plasma", name = expression(hat(Y))) +
  ggplot2::geom_point(
    data   = DataSet8.6,
    mapping = ggplot2::aes(x = x1, y = x2, colour = response),
    inherit.aes = FALSE,
    size   = 2
  ) +
  ggplot2::scale_colour_viridis_c(option = "inferno", name = "Observed") +
  ggplot2::labs(
    title = "Fitted Response Surface by Hoerl Function",
    x     = "x1",
    y     = "x2"
  ) +
  ggplot2::theme_bw()




cleanEx()
nameEx("Exam8.7")
### * Exam8.7

flush(stderr()); flush(stdout())

### Name: Exam8.7
### Title: Example 8.7 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam8.7

### ** Examples


DataSet8.7$a <- factor(x = DataSet8.7$a)

## Cubic B-spline with GLIMMIX-equivalent RANGEFRACTION knots
## (knotmethod=rangefractions (0.1 0.2 ... 0.9) on range 0-44)
x_min <- min(DataSet8.7$x)
x_max <- max(DataSet8.7$x)
inner_knots <- x_min + seq(0.1, 0.9, by = 0.1) * (x_max - x_min)

bx <- splines::bs(DataSet8.7$x, knots = inner_knots, degree = 3, intercept = FALSE)
colnames(bx) <- paste0("bx", seq_len(ncol(bx)))

## SAS-style effect coding: a=1 -> +1, a=2 -> -1 (required to reproduce
## GLIMMIX Type III F statistics for spline_x and spline_x*a)
a_eff    <- ifelse(DataSet8.7$a == "1", 1, -1)
a_eff_bx <- a_eff * bx
colnames(a_eff_bx) <- paste0("aebx", seq_len(ncol(bx)))

df87 <- data.frame(DataSet8.7, a_eff = a_eff, bx, a_eff_bx)

bx_cols  <- paste0("bx",   seq_len(ncol(bx)))
aebx_cols <- paste0("aebx", seq_len(ncol(bx)))
fmla <- stats::as.formula(
  paste("y ~ a_eff +",
        paste(bx_cols,  collapse = "+"), "+",
        paste(aebx_cols, collapse = "+")))

Exam8.7fm <- stats::lm(formula = fmla, data = df87)

## Type III joint F tests (matching SAS GLIMMIX "Type III Tests of Fixed Effects")
cn <- names(stats::coef(Exam8.7fm))

## F for a (1 df) -- Type III via car::Anova
## Note: car::Anova gives F=3.19 (R) vs 15.16 (book); this residual
## mismatch is due to GLIMMIX using a different estimable-function
## construction for qualitative factors in spline models.
## spline_x and spline_x*a match exactly.
Exam8.7_TypeIII_a        <- car::Anova(Exam8.7fm, type = 3)["a_eff", , drop = FALSE]

L_bx <- matrix(0, length(bx_cols), length(cn))
colnames(L_bx) <- cn
for (k in seq_along(bx_cols)) L_bx[k, bx_cols[k]] <- 1

L_ae <- matrix(0, length(aebx_cols), length(cn))
colnames(L_ae) <- cn
for (k in seq_along(aebx_cols)) L_ae[k, aebx_cols[k]] <- 1

## Joint F for spline_x (12 df): F = 430.68, book 430.68 -- EXACT
Exam8.7_F_spline_x  <- car::linearHypothesis(Exam8.7fm, L_bx)

## Joint F for spline_x*a (12 df): F = 31.18, book 31.18 -- EXACT
Exam8.7_F_spline_xa <- car::linearHypothesis(Exam8.7fm, L_ae)

print(Exam8.7_TypeIII_a)
print(Exam8.7_F_spline_x)
print(Exam8.7_F_spline_xa)

##---Estimated response surface by segmented regression
Plot <-
  ggplot2::ggplot(
    data    = data.frame(df87, fit = stats::fitted(Exam8.7fm)),
    mapping = ggplot2::aes(x = x, y = y, colour = factor(a_eff))) +
  ggplot2::geom_point() +
  ggplot2::geom_line(
    mapping = ggplot2::aes(y = fit),
    linewidth = 1) +
  ggplot2::labs(colour = "a", title = "Response surface by segmented regression")

print(Plot)



cleanEx()
nameEx("Exam9.1")
### * Exam9.1

flush(stderr()); flush(stdout())

### Name: Exam9.1
### Title: Example 9.1 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam9.1

### ** Examples


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

## Mixed model for LS means and contrasts.
## Fixed effects are rank-deficient (set is a linear combination of set:trt
## columns); emmeans resolves estimability and produces correct LS means.
Exam9.1Lmer <- lmerTest::lmer(
  y ~ set + set:trt + (1 | block),
  data = DataSet9.1
)

emm91 <- emmeans::emmeans(object = Exam9.1Lmer, specs = ~trt | set)
print(emm91)
emmeans::contrast(emm91, method = "pairwise", by = "set")




cleanEx()
nameEx("Exam9.2")
### * Exam9.2

flush(stderr()); flush(stdout())

### Name: Exam9.2
### Title: Example 9.2 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam9.2

### ** Examples


data(DataSet9.2)
DataSet9.2$block <- factor(x = DataSet9.2$block)
DataSet9.2$a <- factor(x = DataSet9.2$a)
DataSet9.2$b <- factor(x = DataSet9.2$b)


Exam9.2lmer <- lmerTest::lmer(
  formula = y ~ a * b + (1|block) + (1|block:a) + (1|block:b),
  data    = DataSet9.2
)
stats::anova(Exam9.2lmer, ddf = "Kenward-Roger")

emmeans::emmeans(object = Exam9.2lmer, specs = ~a | b)
emmeans::emmip(
  object  = emmeans::emmeans(object = Exam9.2lmer, specs = ~a | b),
  formula = a ~ b,
  ylab    = "y Lsmeans",
  main    = "Lsmeans for a*b"
)

## Simple effect comparisons of a*b Least Squares Means by a
emmeans::emmeans(Exam9.2lmer, pairwise ~ b | a)





cleanEx()
nameEx("Exam9.3")
### * Exam9.3

flush(stderr()); flush(stdout())

### Name: Exam9.3
### Title: Example 9.3 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam9.3

### ** Examples


## Response Surface Design with incomplete blocking
data(DataSet9.3)
DataSet9.3$block <- factor(x = DataSet9.3$block)
DataSet9.3$aa    <- factor(x = DataSet9.3$a)
DataSet9.3$bb    <- factor(x = DataSet9.3$b)
DataSet9.3$cc    <- factor(x = DataSet9.3$c)
DataSet9.3$a2    <- DataSet9.3$a^2
DataSet9.3$b2    <- DataSet9.3$b^2
DataSet9.3$c2    <- DataSet9.3$c^2
DataSet9.3$ab    <- DataSet9.3$a * DataSet9.3$b
DataSet9.3$ac    <- DataSet9.3$a * DataSet9.3$c
DataSet9.3$bc    <- DataSet9.3$b * DataSet9.3$c

Exam9.3.fm1 <- lmerTest::lmer(
  y ~ a + a2 + b + ab + b2 + c + ac + bc + c2 +
      aa:bb:cc + (1 | block),
  data = DataSet9.3
)
stats::anova(Exam9.3.fm1, ddf = "Kenward-Roger", type = 1)

Exam9.3.fm2 <- lmerTest::lmer(
  y ~ a + a2 + b + ab + b2 + c + ac + bc + c2 + (1 | block),
  data = DataSet9.3
)
stats::anova(Exam9.3.fm2, ddf = "Kenward-Roger", type = 1)

Exam9.3.fm3 <- lmerTest::lmer(
  y ~ a + a2 + b + b2 + c + bc + (1 | block),
  data = DataSet9.3
)
stats::anova(Exam9.3.fm3, ddf = "Kenward-Roger", type = 1)

## Predicted response surface (three panels at c = -1, 0, 1)
agrid <- seq(from = -1, to = 1, by = 0.1)
bgrid <- seq(from = -1, to = 1, by = 0.1)
cgrid <- c(-1, 0, 1)
Newdata <- expand.grid(a = agrid, b = bgrid, c = cgrid)
Newdata$Yhat <- with(Newdata,
  50.08500 + 1.6*a + 1.69375*b + 0.51875*c -
  3.30250*a^2 - 3.51500*b^2 - 1.16250*b*c
)
Newdata$c_label <- factor(
  Newdata$c,
  levels = c(-1, 0, 1),
  labels = c("C = -1", "C = 0", "C = 1")
)

ggplot2::ggplot(Newdata, ggplot2::aes(x = a, y = b, fill = Yhat)) +
  ggplot2::geom_tile() +
  ggplot2::scale_fill_viridis_c(option = "plasma", name = expression(hat(Y))) +
  ggplot2::facet_wrap(~c_label) +
  ggplot2::labs(
    title = "Predicted Response Surface",
    x     = "Factor A",
    y     = "Factor B"
  ) +
  ggplot2::theme_bw()




cleanEx()
nameEx("Exam9.4")
### * Exam9.4

flush(stderr()); flush(stdout())

### Name: Exam9.4
### Title: Example 9.4 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Exam9.4

### ** Examples


data(DataSet9.4)
DataSet9.4$block <- factor(x = DataSet9.4$block)
DataSet9.4$a <- factor(x = DataSet9.4$a)
DataSet9.4$b <- factor(x = DataSet9.4$b)

Exam9.4lmer <- lmerTest::lmer(
  y ~ a + b %in% a + (1|block) + (1|block:a) + (1|block:b),
  data = DataSet9.4
)
stats::anova(Exam9.4lmer, ddf = "Kenward-Roger")

emmeans::emmeans(object = Exam9.4lmer, specs = ~a | b)



cleanEx()
nameEx("Table1.1")
### * Table1.1

flush(stderr()); flush(stdout())

### Name: Table1.1
### Title: Data for Table1.1 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Table1.1
### Keywords: datasets

### ** Examples

data(Table1.1)



cleanEx()
nameEx("Table1.2")
### * Table1.2

flush(stderr()); flush(stdout())

### Name: Table1.2
### Title: Data for Table1.2 from Generalized Linear Mixed Models: Modern
###   Concepts, Methods and Applications by Stroup, Ptukhina, and Garai
###   (2024, 2nd ed.)
### Aliases: Table1.2
### Keywords: datasets

### ** Examples

data(Table1.2)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
