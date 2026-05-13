test_that("lm on Table1.1 returns expected coefficient sign", {
  data(Table1.1, package = "modernGLMM")
  fit <- stats::lm(formula = y / Nx ~ x, data = Table1.1)
  coefs <- stats::coef(fit)
  expect_true(coefs["x"] > 0, label = "positive slope for proportion vs x")
})

test_that("glm binomial on Table1.1 converges", {
  data(Table1.1, package = "modernGLMM")
  fit <- stats::glm(
    formula = y / Nx ~ x,
    family  = stats::quasibinomial(link = "logit"),
    data    = Table1.1
  )
  expect_s3_class(fit, "glm")
  expect_false(fit$converged == FALSE, label = "model converged")
})

test_that("lmer on DataSet9.1 returns variance components > 0", {
  data(DataSet9.1, package = "modernGLMM")
  DataSet9.1$block <- factor(DataSet9.1$block)
  DataSet9.1$set <- factor(DataSet9.1$set)
  DataSet9.1$trt <- factor(DataSet9.1$trt)
  fit <- lmerTest::lmer(
    y ~ set + (1 | block),
    data = DataSet9.1,
    control = lme4::lmerControl(optimizer = "bobyqa")
  )
  vc <- as.data.frame(lme4::VarCorr(fit))
  expect_true(any(vc$vcov > 0))
})

test_that("lm on DataSet8.1 handles two-way structure", {
  data(DataSet8.1, package = "modernGLMM")
  DataSet8.1$a <- factor(DataSet8.1$a)
  DataSet8.1$b <- factor(DataSet8.1$b)
  fit <- stats::lm(y ~ a * b, data = DataSet8.1)
  expect_s3_class(fit, "lm")
  expect_true(all(stats::fitted(fit) > 0))
})

test_that("glm Gaussian on DataSet9.2 gives non-negative fitted values", {
  data(DataSet9.2, package = "modernGLMM")
  DataSet9.2$a <- factor(DataSet9.2$a)
  DataSet9.2$b <- factor(DataSet9.2$b)
  fit <- stats::lm(y ~ a + b, data = DataSet9.2)
  expect_true(all(stats::fitted(fit) > 0))
})

test_that("emmeans works on a two-way lm", {
  data(DataSet8.1, package = "modernGLMM")
  DataSet8.1$a <- factor(DataSet8.1$a)
  DataSet8.1$b <- factor(DataSet8.1$b)
  fit <- stats::lm(y ~ a * b, data = DataSet8.1)
  emm <- emmeans::emmeans(fit, ~ a * b)
  expect_s4_class(emm, "emmGrid")
  expect_equal(nrow(as.data.frame(emm)), 6L)
})

test_that("emmeans pairwise contrasts return expected columns", {
  data(DataSet3.1, package = "modernGLMM")
  DataSet3.1$trt <- factor(DataSet3.1$trt)
  fit  <- stats::glm(
    F / N ~ trt,
    family = stats::quasibinomial(link = "logit"),
    data   = DataSet3.1
  )
  emm   <- emmeans::emmeans(fit, ~ trt)
  contr <- as.data.frame(emmeans::contrast(emm, method = "pairwise"))
  expect_true("p.value" %in% names(contr))
})

test_that("lmer on DataSet9.2 two-way structure converges", {
  data(DataSet9.2, package = "modernGLMM")
  DataSet9.2$block <- factor(DataSet9.2$block)
  DataSet9.2$a <- factor(DataSet9.2$a)
  DataSet9.2$b <- factor(DataSet9.2$b)
  fit <- lmerTest::lmer(y ~ a * b + (1 | block), data = DataSet9.2,
                        control = lme4::lmerControl(optimizer = "bobyqa"))
  expect_s4_class(fit, "lmerModLmerTest")
})
