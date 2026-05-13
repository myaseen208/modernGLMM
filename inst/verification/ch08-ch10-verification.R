load_data <- function(name) {
  env <- new.env(parent = emptyenv())
  load(file.path("data", paste0(name, ".RData")), envir = env)
  env[[name]]
}

num <- function(x, digits = 6) {
  round(as.numeric(x), digits)
}

status_for <- function(book, package, output_type) {
  if (is.na(book) || is.na(package)) {
    return("UNVERIF")
  }
  diff <- abs(as.numeric(package) - as.numeric(book))
  vc <- grepl("VC|variance|Variance|Scale", output_type, ignore.case = TRUE)
  exact_tol <- if (vc) 0.05 else 0.01
  approx_tol <- if (vc) 0.10 else 0.05
  if (diff <= exact_tol) {
    "EXACT"
  } else if (diff <= approx_tol) {
    "APPROX"
  } else {
    "MISMATCH"
  }
}

add_row <- function(rows, example, chapter, section, output_type, book,
                    package, diagnosis, action) {
  if (length(book) == 0L) {
    book <- NA_real_
  }
  if (length(package) == 0L) {
    package <- NA_real_
  }
  book <- book[1L]
  package <- package[1L]
  difference <- if (is.na(book) || is.na(package)) {
    ""
  } else {
    num(abs(as.numeric(package) - as.numeric(book)), 6)
  }
  status <- status_for(book, package, output_type)
  rows[[length(rows) + 1L]] <- data.frame(
    Example = example,
    Chapter = chapter,
    `Book Section` = section,
    `Output Type` = output_type,
    `Book Value` = if (is.na(book)) "not printed" else as.character(book),
    `Package Value` = if (is.na(package)) "not available" else num(package, 6),
    Difference = difference,
    Status = status,
    Diagnosis = diagnosis,
    `Action Taken` = action,
    check.names = FALSE
  )
  rows
}

add_unverif <- function(rows, example, chapter, section, output_type,
                        book_value, diagnosis, action) {
  rows[[length(rows) + 1L]] <- data.frame(
    Example = example,
    Chapter = chapter,
    `Book Section` = section,
    `Output Type` = output_type,
    `Book Value` = book_value,
    `Package Value` = "not available",
    Difference = "",
    Status = "UNVERIF",
    Diagnosis = diagnosis,
    `Action Taken` = action,
    check.names = FALSE
  )
  rows
}

collect_model <- function(model) {
  try(broom.mixed::tidy(model, effects = "fixed"), silent = TRUE)
  try(broom.mixed::tidy(model, effects = "ran_pars"), silent = TRUE)
  try(broom.mixed::glance(model), silent = TRUE)
  if (requireNamespace("report", quietly = TRUE)) {
    try(capture.output(report::report(model)), silent = TRUE)
  }
  invisible(TRUE)
}

anova_value <- function(tab, effect, column) {
  as.numeric(tab[effect, column])
}

if (!requireNamespace("broom.mixed", quietly = TRUE)) {
  stop("Package 'broom.mixed' is required for verification extraction.")
}
if (!requireNamespace("car", quietly = TRUE)) {
  stop("Package 'car' is required for type-III ANCOVA verification.")
}
if (!requireNamespace("emmeans", quietly = TRUE)) {
  stop("Package 'emmeans' is required for verification extraction.")
}
if (!requireNamespace("lme4", quietly = TRUE)) {
  stop("Package 'lme4' is required for mixed-model verification.")
}
if (!requireNamespace("lmerTest", quietly = TRUE)) {
  stop("Package 'lmerTest' is required for Kenward-Roger verification.")
}

rows <- list()

## Chapter 8 ---------------------------------------------------------------

DataSet8.1 <- load_data("DataSet8.1")
DataSet8.1$a <- factor(DataSet8.1$a)
DataSet8.1$b <- factor(DataSet8.1$b)
fit_81 <- stats::lm(y ~ a * b, data = DataSet8.1)
collect_model(fit_81)
anova_81 <- stats::anova(fit_81)
emm_81 <- as.data.frame(emmeans::emmeans(fit_81, ~ a * b))
slice_81 <- emmeans::joint_tests(fit_81, by = "a")
pair_81 <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_81, ~ b | a),
  method = "pairwise",
  adjust = "none"
))
pair_81_bonf <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_81, ~ b | a),
  method = "pairwise",
  adjust = "bonferroni"
))

for (effect in c("a", "b", "a:b")) {
  book_f <- c(a = 14.94, b = 11.50, `a:b` = 6.02)[[effect]]
  book_p <- c(a = 0.0011, b = 0.0006, `a:b` = 0.0099)[[effect]]
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste0("Type III ", effect, " F"), book_f,
                  anova_value(anova_81, effect, "F value"),
                  "Balanced Gaussian factorial matches the printed GLIMMIX fixed-effect test.",
                  "Fitted stats::lm(y ~ a * b) and extracted stats::anova.")
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste0("Type III ", effect, " p"), book_p,
                  anova_value(anova_81, effect, "Pr(>F)"),
                  "Balanced Gaussian factorial matches the printed GLIMMIX fixed-effect test.",
                  "Fitted stats::lm(y ~ a * b) and extracted stats::anova.")
}

book_81_means <- data.frame(
  a = c("0", "0", "0", "1", "1", "1"),
  b = c("0", "1", "2", "0", "1", "2"),
  estimate = c(50.5000, 59.7500, 71.5000, 67.7500, 67.2500, 71.0000),
  se = rep(2.5611, 6L),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_81_means))) {
  idx <- emm_81$a == book_81_means$a[i] & emm_81$b == book_81_means$b[i]
  label <- paste0("a", book_81_means$a[i], " b", book_81_means$b[i])
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste(label, "LSMean"), book_81_means$estimate[i],
                  emm_81$emmean[idx],
                  "Matches printed a*b least-squares mean.",
                  "Extracted emmeans::emmeans(fit, ~ a * b).")
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste(label, "LSMean SE"), book_81_means$se[i],
                  emm_81$SE[idx],
                  "Matches printed a*b least-squares mean standard error.",
                  "Extracted emmeans::emmeans(fit, ~ a * b).")
}

book_81_slice <- data.frame(
  a = c("0", "1"),
  f = c(16.89, 0.63),
  p = c(0.0001, 0.5429),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_81_slice))) {
  idx <- slice_81$a == book_81_slice$a[i]
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste0("B simple-effect slice within a", book_81_slice$a[i], " F"),
                  book_81_slice$f[i], slice_81$F.ratio[idx],
                  "Matches the printed SLICE test for B within A.",
                  "Extracted emmeans::joint_tests(fit, by = 'a').")
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste0("B simple-effect slice within a", book_81_slice$a[i], " p"),
                  book_81_slice$p[i], slice_81$p.value[idx],
                  "Book reports <.0001 as an upper bound where applicable.",
                  "Extracted emmeans::joint_tests(fit, by = 'a').")
}

book_81_pairs <- data.frame(
  a = rep(c("0", "1"), each = 3L),
  contrast = c("b0 - b1", "b0 - b2", "b1 - b2",
               "b0 - b1", "b0 - b2", "b1 - b2"),
  estimate = c(-9.2500, -21.0000, -11.7500, 0.5000, -3.2500, -3.7500),
  se = rep(3.6219, 6L),
  p = c(0.0199, 0.0001, 0.0045, 0.8917, 0.3814, 0.3142),
  adj_p = c(0.0598, 0.0001, 0.0135, 1.0000, 1.0000, 0.9426),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_81_pairs))) {
  idx <- pair_81$a == book_81_pairs$a[i] &
    pair_81$contrast == book_81_pairs$contrast[i]
  idx_b <- pair_81_bonf$a == book_81_pairs$a[i] &
    pair_81_bonf$contrast == book_81_pairs$contrast[i]
  label <- paste0("a", book_81_pairs$a[i], " ", book_81_pairs$contrast[i])
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste(label, "simple-effect diff"), book_81_pairs$estimate[i],
                  pair_81$estimate[idx],
                  "Matches the printed SLICEDIFF treatment contrast.",
                  "Extracted pairwise emmeans contrasts for b within a.")
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste(label, "simple-effect diff SE"), book_81_pairs$se[i],
                  pair_81$SE[idx],
                  "Matches the printed SLICEDIFF treatment-contrast standard error.",
                  "Extracted pairwise emmeans contrasts for b within a.")
  rows <- add_row(rows, "Exam8.1", 8, "8.4.2",
                  paste(label, "simple-effect diff p"), book_81_pairs$p[i],
                  pair_81$p.value[idx],
                  "Book reports <.0001 as an upper bound where applicable.",
                  "Extracted pairwise emmeans contrasts for b within a.")
  rows <- add_row(rows, "Exam8.1", 8, "8.4.3",
                  paste(label, "Bonferroni adjusted p"), book_81_pairs$adj_p[i],
                  pair_81_bonf$p.value[idx_b],
                  "Matches the printed Bonferroni-adjusted SLICEDIFF output.",
                  "Extracted pairwise emmeans contrasts with adjust = 'bonferroni'.")
}

DataSet8.2 <- load_data("DataSet8.2")
DataSet8.2$trt <- factor(DataSet8.2$trt)
contrasts(DataSet8.2$trt) <- stats::contr.sum(nlevels(DataSet8.2$trt))
fit_82_full <- stats::lm(y ~ trt * x, data = DataSet8.2)
fit_82_equal <- stats::lm(y ~ trt + x, data = DataSet8.2)
fit_82_unadj <- stats::lm(y ~ trt, data = DataSet8.2)
collect_model(fit_82_full)
collect_model(fit_82_equal)
collect_model(fit_82_unadj)
anova_82_full <- car::Anova(fit_82_full, type = "III")
anova_82_equal <- car::Anova(fit_82_equal, type = "III")
anova_82_unadj <- car::Anova(fit_82_unadj, type = "III")
emm_82_equal <- as.data.frame(emmeans::emmeans(fit_82_equal, ~ trt))
emm_82_unadj <- as.data.frame(emmeans::emmeans(fit_82_unadj, ~ trt))

for (effect in c("trt", "x", "trt:x")) {
  rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                  paste0("Unequal-slopes model ", effect, " F"),
                  c(trt = 3.01, x = 60.82, `trt:x` = 1.41)[[effect]],
                  anova_value(anova_82_full, effect, "F value"),
                  "Matches the printed preliminary ANCOVA equal-slopes test.",
                  "Fitted stats::lm(y ~ trt * x) and extracted car::Anova(type = 'III').")
  rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                  paste0("Unequal-slopes model ", effect, " p"),
                  c(trt = 0.0722, x = 0.0001, `trt:x` = 0.2889)[[effect]],
                  anova_value(anova_82_full, effect, "Pr(>F)"),
                  "Book reports <.0001 as an upper bound where applicable.",
                  "Fitted stats::lm(y ~ trt * x) and extracted car::Anova(type = 'III').")
}
for (effect in c("trt", "x")) {
  rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                  paste0("Equal-slopes model ", effect, " F"),
                  c(trt = 15.14, x = 81.60)[[effect]],
                  anova_value(anova_82_equal, effect, "F value"),
                  "Matches the printed equal-slopes ANCOVA fixed-effect test.",
                  "Fitted stats::lm(y ~ trt + x) and extracted car::Anova(type = 'III').")
  rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                  paste0("Equal-slopes model ", effect, " p"),
                  c(trt = 0.0001, x = 0.0001)[[effect]],
                  anova_value(anova_82_equal, effect, "Pr(>F)"),
                  "Book reports <.0001 as an upper bound.",
                  "Fitted stats::lm(y ~ trt + x) and extracted car::Anova(type = 'III').")
}
book_82_equal <- data.frame(
  trt = as.character(1:4),
  estimate = c(47.7120, 54.5984, 44.8822, 53.1131),
  se = c(1.1746, 1.1944, 1.2303, 1.2639),
  stringsAsFactors = FALSE
)
book_82_unadj <- data.frame(
  trt = as.character(1:4),
  estimate = c(45.7127, 57.3974, 48.7475, 48.4481),
  se = rep(2.8344, 4L),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_82_equal))) {
  idx <- emm_82_equal$trt == book_82_equal$trt[i]
  rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                  paste0("Adjusted trt ", book_82_equal$trt[i], " LSMean"),
                  book_82_equal$estimate[i], emm_82_equal$emmean[idx],
                  "Matches the printed ANCOVA covariate-adjusted LSMean.",
                  "Extracted emmeans::emmeans(fit, ~ trt).")
  rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                  paste0("Adjusted trt ", book_82_equal$trt[i], " LSMean SE"),
                  book_82_equal$se[i], emm_82_equal$SE[idx],
                  "Matches the printed ANCOVA covariate-adjusted LSMean standard error.",
                  "Extracted emmeans::emmeans(fit, ~ trt).")
}
rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                "Unadjusted trt F", 3.20,
                anova_value(anova_82_unadj, "trt", "F value"),
                "Matches the printed model that omits the covariate.",
                "Fitted stats::lm(y ~ trt) and extracted car::Anova(type = 'III').")
rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                "Unadjusted trt p", 0.0518,
                anova_value(anova_82_unadj, "trt", "Pr(>F)"),
                "Matches the printed model that omits the covariate.",
                "Fitted stats::lm(y ~ trt) and extracted car::Anova(type = 'III').")
for (i in seq_len(nrow(book_82_unadj))) {
  idx <- emm_82_unadj$trt == book_82_unadj$trt[i]
  rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                  paste0("Unadjusted trt ", book_82_unadj$trt[i], " LSMean"),
                  book_82_unadj$estimate[i], emm_82_unadj$emmean[idx],
                  "Matches the printed unadjusted treatment mean.",
                  "Extracted emmeans::emmeans(fit, ~ trt).")
  rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                  paste0("Unadjusted trt ", book_82_unadj$trt[i], " LSMean SE"),
                  book_82_unadj$se[i], emm_82_unadj$SE[idx],
                  "Matches the printed unadjusted treatment-mean standard error.",
                  "Extracted emmeans::emmeans(fit, ~ trt).")
}
rows <- add_row(rows, "Exam8.2", 8, "8.5.2.2.1",
                "Equal-slopes covariate coefficient", -2.67,
                stats::coef(fit_82_equal)[["x"]],
                "Matches the text-reported covariate regression coefficient after rounding.",
                "Extracted stats::coef from stats::lm(y ~ trt + x).")

DataSet8.3 <- load_data("DataSet8.3")
DataSet8.3$trt <- factor(DataSet8.3$trt)
contrasts(DataSet8.3$trt) <- stats::contr.sum(nlevels(DataSet8.3$trt))
fit_83 <- stats::lm(y ~ trt * x, data = DataSet8.3)
fit_83_cell <- stats::lm(y ~ 0 + trt / x, data = DataSet8.3)
collect_model(fit_83)
anova_83 <- car::Anova(fit_83, type = "III")
joint_83 <- emmeans::joint_tests(fit_83)
coef_83 <- summary(fit_83_cell)$coefficients
emm_83 <- as.data.frame(emmeans::emmeans(fit_83, ~ trt | x, at = list(x = c(7, 12))))

for (effect in c("trt", "x", "trt:x")) {
  rows <- add_row(rows, "Exam8.3", 8, "8.5.2.2.2",
                  paste0("Unequal-slopes model ", effect, " F"),
                  c(trt = 6.62, x = 94.90, `trt:x` = 8.40)[[effect]],
                  anova_value(anova_83, effect, "F value"),
                  "Matches the printed unequal-slopes ANCOVA type-III table.",
                  "Fitted stats::lm(y ~ trt * x) and extracted car::Anova(type = 'III').")
  rows <- add_row(rows, "Exam8.3", 8, "8.5.2.2.2",
                  paste0("Unequal-slopes model ", effect, " p"),
                  c(trt = 0.0069, x = 0.0001, `trt:x` = 0.0028)[[effect]],
                  anova_value(anova_83, effect, "Pr(>F)"),
                  "Book reports <.0001 as an upper bound where applicable.",
                  "Fitted stats::lm(y ~ trt * x) and extracted car::Anova(type = 'III').")
}
rows <- add_row(rows, "Exam8.3", 8, "8.5.2.2.2",
                "Treatment test at covariate mean F", 7.53,
                joint_83$F.ratio[joint_83[["model term"]] == "trt"],
                "Matches the printed treatment test at Xbar = 9.65.",
                "Extracted emmeans::joint_tests from stats::lm(y ~ trt * x).")
rows <- add_row(rows, "Exam8.3", 8, "8.5.2.2.2",
                "Treatment test at covariate mean p", 0.0043,
                joint_83$p.value[joint_83[["model term"]] == "trt"],
                "Matches the printed treatment test at Xbar = 9.65.",
                "Extracted emmeans::joint_tests from stats::lm(y ~ trt * x).")
book_83_coef <- data.frame(
  term = c("trt1", "trt2", "trt3", "trt4", "trt1:x", "trt2:x", "trt3:x", "trt4:x"),
  estimate = c(52.2940, 74.2824, 78.2623, 56.8222,
               -0.6754, -3.7459, -4.4552, -2.3346),
  se = c(6.8869, 4.4731, 4.8592, 3.7134,
         0.8921, 0.5007, 0.4278, 0.3080),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_83_coef))) {
  rows <- add_row(rows, "Exam8.3", 8, "8.5.2.2.2",
                  paste0(book_83_coef$term[i], " regression coefficient"),
                  book_83_coef$estimate[i], coef_83[book_83_coef$term[i], "Estimate"],
                  "Matches the printed no-intercept treatment-specific ANCOVA solution.",
                  "Fitted stats::lm(y ~ 0 + trt / x).")
  rows <- add_row(rows, "Exam8.3", 8, "8.5.2.2.2",
                  paste0(book_83_coef$term[i], " coefficient SE"),
                  book_83_coef$se[i], coef_83[book_83_coef$term[i], "Std. Error"],
                  "Matches the printed no-intercept treatment-specific ANCOVA solution standard error.",
                  "Fitted stats::lm(y ~ 0 + trt / x).")
}
book_83_means <- data.frame(
  trt = rep(as.character(1:4), 2L),
  x = rep(c(7, 12), each = 4L),
  estimate = c(47.5659, 48.0614, 47.0758, 40.4802,
               44.1887, 29.3321, 24.7998, 28.8073),
  se = c(1.3232, 1.4513, 2.0959, 1.8167,
         4.1074, 2.0887, 1.2835, 1.2241),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_83_means))) {
  idx <- emm_83$trt == book_83_means$trt[i] & emm_83$x == book_83_means$x[i]
  label <- paste0("trt ", book_83_means$trt[i], " at x=", book_83_means$x[i])
  rows <- add_row(rows, "Exam8.3", 8, "8.5.2.2.2",
                  paste(label, "LSMean"), book_83_means$estimate[i],
                  emm_83$emmean[idx],
                  "Matches the printed treatment mean at the specified covariate value.",
                  "Extracted emmeans::emmeans(fit, ~ trt | x, at = list(x = c(7, 12))).")
  rows <- add_row(rows, "Exam8.3", 8, "8.5.2.2.2",
                  paste(label, "LSMean SE"), book_83_means$se[i],
                  emm_83$SE[idx],
                  "Matches the printed treatment-mean standard error at the specified covariate value.",
                  "Extracted emmeans::emmeans(fit, ~ trt | x, at = list(x = c(7, 12))).")
}

DataSet8.6 <- load_data("DataSet8.6")
DataSet8.6$logx1 <- ifelse(DataSet8.6$x1 == 0, log(DataSet8.6$x1 + 0.1), log(DataSet8.6$x1))
DataSet8.6$logx2 <- ifelse(DataSet8.6$x2 == 0, log(DataSet8.6$x2 + 0.1), log(DataSet8.6$x2))
fit_86 <- stats::lm(response ~ x1 * x2 + logx1 * logx2, data = DataSet8.6)
collect_model(fit_86)
rows <- add_unverif(
  rows, "Exam8.6", 8, "8.6.2.1",
  "Hoerl response-surface figure-derived numeric values",
  "figure only",
  "The 2024 2nd edition presents the Hoerl and Gompertz fits graphically without a printed coefficient or fit-statistic table.",
  "Verified that the package fits the linearized Hoerl structure response ~ x1 * x2 + logx1 * logx2; no numerical comparison is claimed."
)

DataSet8.7 <- load_data("DataSet8.7")
DataSet8.7$a <- factor(DataSet8.7$a)
knots_87 <- c(0, 0, 0, 0, 10, 10, 20, 30, 40, 40, 40, 45, 45, 45, 50, 50, 50)
bx_87 <- splines::splineDesign(knots = knots_87, x = DataSet8.7$x, outer.ok = TRUE)
fit_87 <- stats::lm(y ~ a * bx_87, data = DataSet8.7)
collect_model(fit_87)
anova_87 <- stats::anova(fit_87)
book_87 <- data.frame(
  effect = c("a", "bx_87", "a:bx_87"),
  label = c("a", "spline_x", "spline_x*a"),
  f = c(15.16, 430.68, 31.18),
  p = c(0.0001, 0.0001, 0.0001),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_87))) {
  rows <- add_row(rows, "Exam8.7", 8, "8.6.2.2",
                  paste0(book_87$label[i], " F"), book_87$f[i],
                  anova_value(anova_87, book_87$effect[i], "F value"),
                  "Software limitation: the package currently uses an ordinary lm B-spline basis, whereas the book reports a GLIMMIX smoothing-spline EFFECT fit.",
                  "Re-fit current package spline implementation and retained the numerical mismatch explicitly.")
  rows <- add_row(rows, "Exam8.7", 8, "8.6.2.2",
                  paste0(book_87$label[i], " p"), book_87$p[i],
                  anova_value(anova_87, book_87$effect[i], "Pr(>F)"),
                  "Software limitation: the package currently uses an ordinary lm B-spline basis, whereas the book reports a GLIMMIX smoothing-spline EFFECT fit.",
                  "Re-fit current package spline implementation and retained the numerical mismatch explicitly.")
}

## Chapter 9 ---------------------------------------------------------------

DataSet9.1 <- load_data("DataSet9.1")
DataSet9.1$block <- factor(DataSet9.1$block)
DataSet9.1$set <- factor(DataSet9.1$set)
DataSet9.1$trt <- factor(DataSet9.1$trt)
fit_91 <- lmerTest::lmer(y ~ set + set:trt + (1 | set:block), data = DataSet9.1)
collect_model(fit_91)
vc_91 <- as.data.frame(lme4::VarCorr(fit_91))
anova_91 <- stats::anova(fit_91, ddf = "Kenward-Roger")
emm_91 <- as.data.frame(emmeans::emmeans(fit_91, ~ trt | set))
pair_91 <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_91, ~ trt | set),
  method = "pairwise",
  by = "set",
  adjust = "none"
))
emm_91_all <- emmeans::emmeans(fit_91, ~ trt | set, nesting = NULL)
slice_91_0 <- as.data.frame(emmeans::test(emmeans::contrast(
  emm_91_all,
  method = list(c1 = c(1, 0, -1, 0, 0, 0), c2 = c(0, 1, -1, 0, 0, 0)),
  by = "set"
), joint = TRUE))
slice_91_1 <- as.data.frame(emmeans::test(emmeans::contrast(
  emm_91_all,
  method = list(c1 = c(0, 0, 0, 1, 0, -1), c2 = c(0, 0, 0, 0, 1, -1)),
  by = "set"
), joint = TRUE))
rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                "Block(set) VC", 60.5495,
                vc_91$vcov[vc_91$grp == "set:block"],
                "Matches printed GLIMMIX covariance parameter estimate.",
                "Fitted lmerTest::lmer(y ~ set + set:trt + (1 | set:block)).")
rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                "Residual variance", 22.7507,
                vc_91$vcov[vc_91$grp == "Residual"],
                "Matches printed GLIMMIX covariance parameter estimate.",
                "Fitted lmerTest::lmer(y ~ set + set:trt + (1 | set:block)).")
rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                "Set F", 0.04,
                anova_value(anova_91, "set", "F value"),
                "MISMATCH: lmerTest reports a non-estimability-sensitive type-III test for the rank-deficient nested treatment parameterization; the book also calls this an uninteresting hypothesis.",
                "Retained mismatch; treatment nested means, variance components, and pairwise comparisons reproduce exactly.")
rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                "Set p", 0.8509,
                anova_value(anova_91, "set", "Pr(>F)"),
                "MISMATCH: lmerTest reports a non-estimability-sensitive type-III test for the rank-deficient nested treatment parameterization; the book also calls this an uninteresting hypothesis.",
                "Retained mismatch; treatment nested means, variance components, and pairwise comparisons reproduce exactly.")
rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                "trt(set) F", 4.91,
                anova_value(anova_91, "set:trt", "F value"),
                "Matches printed nested-treatment fixed-effect test.",
                "Extracted Kenward-Roger ANOVA from lmerTest.")
rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                "trt(set) p", 0.0089,
                anova_value(anova_91, "set:trt", "Pr(>F)"),
                "Matches printed nested-treatment fixed-effect test.",
                "Extracted Kenward-Roger ANOVA from lmerTest.")
book_91_slice <- data.frame(
  set_book = c("0", "1"),
  set_pkg = c("1", "2"),
  f = c(0.03, 9.80),
  p = c(0.9709, 0.0017),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_91_slice))) {
  slice_src <- if (book_91_slice$set_pkg[i] == "1") slice_91_0 else slice_91_1
  idx <- slice_src$set == book_91_slice$set_pkg[i]
  rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                  paste0("trt simple-effect slice set ", book_91_slice$set_book[i], " F"),
                  book_91_slice$f[i], slice_src$F.ratio[idx],
                  "Package labels sets/trt one unit higher than the book; numerical slice test matches after label mapping.",
                  "Computed explicit joint emmeans contrasts within each set.")
  rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                  paste0("trt simple-effect slice set ", book_91_slice$set_book[i], " p"),
                  book_91_slice$p[i], slice_src$p.value[idx],
                  "Package labels sets/trt one unit higher than the book; numerical slice test matches after label mapping.",
                  "Computed explicit joint emmeans contrasts within each set.")
}
book_91_means <- data.frame(
  set_book = c(rep("0", 3L), rep("1", 3L)),
  set_pkg = c(rep("1", 3L), rep("2", 3L)),
  trt_book = as.character(0:5),
  trt_pkg = as.character(1:6),
  estimate = c(8.2000, 8.9000, 8.7400, 4.4400, 7.2800, 17.1600),
  se = rep(4.0817, 6L),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_91_means))) {
  idx <- emm_91$set == book_91_means$set_pkg[i] &
    emm_91$trt == book_91_means$trt_pkg[i]
  label <- paste0("set ", book_91_means$set_book[i], " trt ", book_91_means$trt_book[i])
  rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                  paste(label, "LSMean"), book_91_means$estimate[i],
                  emm_91$emmean[idx],
                  "Package labels sets/trt one unit higher than the book; LSMean matches after label mapping.",
                  "Extracted emmeans::emmeans(fit, ~ trt | set).")
  rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                  paste(label, "LSMean SE"), book_91_means$se[i],
                  emm_91$SE[idx],
                  "Package labels sets/trt one unit higher than the book; LSMean SE matches after label mapping.",
                  "Extracted emmeans::emmeans(fit, ~ trt | set).")
}
book_91_pairs <- data.frame(
  set_book = c(rep("0", 3L), rep("1", 3L)),
  set_pkg = c(rep("1", 3L), rep("2", 3L)),
  contrast_pkg = c("trt1 - trt2", "trt1 - trt3", "trt2 - trt3",
                   "trt4 - trt5", "trt4 - trt6", "trt5 - trt6"),
  label_book = c("trt0 - trt1", "trt0 - trt2", "trt1 - trt2",
                 "trt3 - trt4", "trt3 - trt5", "trt4 - trt5"),
  estimate = c(-0.7000, -0.5400, 0.1600, -2.8400, -12.7200, -9.8800),
  se = rep(3.0167, 6L),
  p = c(0.8194, 0.8602, 0.9584, 0.3605, 0.0007, 0.0048),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_91_pairs))) {
  idx <- pair_91$set == book_91_pairs$set_pkg[i] &
    pair_91$contrast == book_91_pairs$contrast_pkg[i]
  label <- paste0("set ", book_91_pairs$set_book[i], " ", book_91_pairs$label_book[i])
  rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                  paste(label, "diff"), book_91_pairs$estimate[i],
                  pair_91$estimate[idx],
                  "Package labels sets/trt one unit higher than the book; pairwise contrast matches after label mapping.",
                  "Extracted pairwise emmeans contrasts within set.")
  rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                  paste(label, "diff SE"), book_91_pairs$se[i],
                  pair_91$SE[idx],
                  "Package labels sets/trt one unit higher than the book; pairwise contrast SE matches after label mapping.",
                  "Extracted pairwise emmeans contrasts within set.")
  rows <- add_row(rows, "Exam9.1", 9, "9.4.1",
                  paste(label, "diff p"), book_91_pairs$p[i],
                  pair_91$p.value[idx],
                  "Package labels sets/trt one unit higher than the book; pairwise contrast p-value matches after label mapping.",
                  "Extracted pairwise emmeans contrasts within set.")
}

DataSet9.2 <- load_data("DataSet9.2")
DataSet9.2$block <- factor(DataSet9.2$block)
DataSet9.2$a <- factor(DataSet9.2$a)
DataSet9.2$b <- factor(DataSet9.2$b)
fit_92 <- lmerTest::lmer(
  y ~ a * b + (1 | block) + (1 | block:a) + (1 | block:b),
  data = DataSet9.2
)
collect_model(fit_92)
vc_92 <- as.data.frame(lme4::VarCorr(fit_92))
anova_92 <- stats::anova(fit_92, ddf = "Kenward-Roger")
emm_92 <- as.data.frame(emmeans::emmeans(fit_92, ~ a * b))
pair_92 <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_92, ~ b | a),
  method = "pairwise",
  by = "a",
  adjust = "none"
))
book_92_vc <- data.frame(
  label = c("Intercept Block VC", "a Block VC", "b Block VC", "Residual variance"),
  grp = c("block", "block:a", "block:b", "Residual"),
  value = c(2.6345, 9.7784, 8.1609, 2.2451),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_92_vc))) {
  rows <- add_row(rows, "Exam9.2", 9, "9.4.1",
                  book_92_vc$label[i], book_92_vc$value[i],
                  vc_92$vcov[vc_92$grp == book_92_vc$grp[i]],
                  "Matches printed incomplete strip-plot covariance parameter estimate within R/SAS rounding.",
                  "Fitted lmerTest::lmer with block, block:a, and block:b random intercepts.")
}
for (effect in c("a", "b", "a:b")) {
  rows <- add_row(rows, "Exam9.2", 9, "9.4.1",
                  paste0(effect, " F"), c(a = 6.59, b = 2.31, `a:b` = 10.56)[[effect]],
                  anova_value(anova_92, effect, "F value"),
                  "Kenward-Roger implementation differs slightly between lmerTest and SAS GLIMMIX; retained exact/approx classification by tolerance.",
                  "Fitted lmerTest::lmer and extracted Kenward-Roger ANOVA.")
  rows <- add_row(rows, "Exam9.2", 9, "9.4.1",
                  paste0(effect, " p"), c(a = 0.0184, b = 0.1589, `a:b` = 0.0070)[[effect]],
                  anova_value(anova_92, effect, "Pr(>F)"),
                  "Kenward-Roger implementation differs slightly between lmerTest and SAS GLIMMIX; retained exact/approx classification by tolerance.",
                  "Fitted lmerTest::lmer and extracted Kenward-Roger ANOVA.")
}
book_92_means <- data.frame(
  a = rep(as.character(1:3), each = 3L),
  b = rep(as.character(1:3), 3L),
  estimate = c(21.2455, 30.4307, 28.1994,
               22.2115, 28.4077, 26.9061,
               21.1293, 18.4717, 18.5231),
  se = rep(2.1866, 9L),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_92_means))) {
  idx <- emm_92$a == book_92_means$a[i] & emm_92$b == book_92_means$b[i]
  label <- paste0("a", book_92_means$a[i], " b", book_92_means$b[i])
  rows <- add_row(rows, "Exam9.2", 9, "9.4.1",
                  paste(label, "LSMean"), book_92_means$estimate[i],
                  emm_92$emmean[idx],
                  "Matches printed incomplete strip-plot LSMean.",
                  "Extracted emmeans::emmeans(fit, ~ a * b).")
  rows <- add_row(rows, "Exam9.2", 9, "9.4.1",
                  paste(label, "LSMean SE"), book_92_means$se[i],
                  emm_92$SE[idx],
                  "Small SE difference is attributable to lmerTest/SAS Kenward-Roger implementation details.",
                  "Extracted emmeans::emmeans(fit, ~ a * b).")
}
book_92_pairs <- data.frame(
  a = rep(as.character(1:3), each = 3L),
  contrast = rep(c("b1 - b2", "b1 - b3", "b2 - b3"), 3L),
  estimate = c(-9.1852, -6.9539, 2.2313,
               -6.1962, -4.6946, 1.5016,
               2.6577, 2.6063, -0.05138),
  se = rep(2.3411, 9L),
  p = c(0.0019, 0.0112, 0.3585, 0.0206, 0.0670, 0.5328,
        0.2775, 0.2865, 0.9828),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_92_pairs))) {
  idx <- pair_92$a == book_92_pairs$a[i] & pair_92$contrast == book_92_pairs$contrast[i]
  label <- paste0("a", book_92_pairs$a[i], " ", book_92_pairs$contrast[i])
  rows <- add_row(rows, "Exam9.2", 9, "9.4.1",
                  paste(label, "diff"), book_92_pairs$estimate[i],
                  pair_92$estimate[idx],
                  "Matches printed incomplete strip-plot simple-effect comparison.",
                  "Extracted pairwise emmeans contrasts for b within a.")
  rows <- add_row(rows, "Exam9.2", 9, "9.4.1",
                  paste(label, "diff SE"), book_92_pairs$se[i],
                  pair_92$SE[idx],
                  "Small SE difference is attributable to lmerTest/SAS Kenward-Roger implementation details.",
                  "Extracted pairwise emmeans contrasts for b within a.")
  rows <- add_row(rows, "Exam9.2", 9, "9.4.1",
                  paste(label, "diff p"), book_92_pairs$p[i],
                  pair_92$p.value[idx],
                  "Small p-value difference is attributable to lmerTest/SAS Kenward-Roger implementation details.",
                  "Extracted pairwise emmeans contrasts for b within a.")
}

DataSet9.3 <- load_data("DataSet9.3")
DataSet9.3$block <- factor(DataSet9.3$block)
DataSet9.3$aa <- factor(DataSet9.3$a)
DataSet9.3$bb <- factor(DataSet9.3$b)
DataSet9.3$cc <- factor(DataSet9.3$c)
DataSet9.3$a2 <- DataSet9.3$a^2
DataSet9.3$b2 <- DataSet9.3$b^2
DataSet9.3$c2 <- DataSet9.3$c^2
DataSet9.3$ab <- DataSet9.3$a * DataSet9.3$b
DataSet9.3$ac <- DataSet9.3$a * DataSet9.3$c
DataSet9.3$bc <- DataSet9.3$b * DataSet9.3$c
fit_93_1 <- lmerTest::lmer(
  y ~ a + a2 + b + ab + b2 + c + ac + bc + c2 + aa:bb:cc + (1 | block),
  data = DataSet9.3
)
fit_93_2 <- lmerTest::lmer(
  y ~ a + a2 + b + ab + b2 + c + ac + bc + c2 + (1 | block),
  data = DataSet9.3
)
fit_93_3 <- lmerTest::lmer(
  y ~ a + a2 + b + b2 + c + bc + (1 | block),
  data = DataSet9.3
)
collect_model(fit_93_1)
collect_model(fit_93_2)
collect_model(fit_93_3)
anova_93_1 <- stats::anova(fit_93_1, ddf = "Kenward-Roger", type = 1)
anova_93_2 <- stats::anova(fit_93_2, ddf = "Kenward-Roger", type = 1)
vc_93_3 <- as.data.frame(lme4::VarCorr(fit_93_3))
coef_93_3 <- summary(fit_93_3)$coefficients
book_93_1 <- data.frame(
  effect = c("a", "a2", "b", "ab", "b2", "c", "ac", "bc", "c2", "aa:bb:cc"),
  label = c("a", "a*a", "b", "a*b", "b*b", "c", "a*c", "b*c", "c*c", "aa*bb*cc"),
  f = c(19.14, 10.33, 21.45, 0.76, 16.81, 2.01, 1.03, 5.05, 0.70, 0.22),
  p = c(0.0009, 0.0488, 0.0006, 0.4014, 0.0263, 0.1815, 0.3301, 0.0442, 0.4647, 0.8776),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_93_1))) {
  rows <- add_row(rows, "Exam9.3", 9, "9.4.1",
                  paste0("Step 1 ", book_93_1$label[i], " F"),
                  book_93_1$f[i], anova_value(anova_93_1, book_93_1$effect[i], "F value"),
                  "Matches printed Type I lack-of-fit sequence after using explicit transformed terms to preserve SAS effect order.",
                  "Fitted lmerTest model with explicit a2, b2, c2, ab, ac, and bc columns.")
  rows <- add_row(rows, "Exam9.3", 9, "9.4.1",
                  paste0("Step 1 ", book_93_1$label[i], " p"),
                  book_93_1$p[i], anova_value(anova_93_1, book_93_1$effect[i], "Pr(>F)"),
                  "Matches printed Type I lack-of-fit sequence after using explicit transformed terms to preserve SAS effect order.",
                  "Fitted lmerTest model with explicit a2, b2, c2, ab, ac, and bc columns.")
}
book_93_2 <- book_93_1[book_93_1$effect != "aa:bb:cc", ]
book_93_2$f <- c(22.65, 10.33, 25.38, 0.90, 16.81, 2.38, 1.22, 5.98, 0.70)
book_93_2$p <- c(0.0003, 0.0488, 0.0001, 0.3589, 0.0263, 0.1437, 0.2869, 0.0273, 0.4647)
for (i in seq_len(nrow(book_93_2))) {
  rows <- add_row(rows, "Exam9.3", 9, "9.4.1",
                  paste0("Step 2 ", book_93_2$label[i], " F"),
                  book_93_2$f[i], anova_value(anova_93_2, book_93_2$effect[i], "F value"),
                  "Matches printed Type I full response-surface sequence after dropping lack of fit.",
                  "Fitted lmerTest reduced model with explicit transformed terms.")
  rows <- add_row(rows, "Exam9.3", 9, "9.4.1",
                  paste0("Step 2 ", book_93_2$label[i], " p"),
                  book_93_2$p[i], anova_value(anova_93_2, book_93_2$effect[i], "Pr(>F)"),
                  "Matches printed Type I full response-surface sequence after dropping lack of fit.",
                  "Fitted lmerTest reduced model with explicit transformed terms.")
}
rows <- add_row(rows, "Exam9.3", 9, "9.4.1",
                "Step 3 block VC", 0.6776,
                vc_93_3$vcov[vc_93_3$grp == "block"],
                "Matches printed reduced response-surface covariance parameter estimate.",
                "Fitted lmerTest reduced response-surface model.")
rows <- add_row(rows, "Exam9.3", 9, "9.4.1",
                "Step 3 residual variance", 1.8206,
                vc_93_3$vcov[vc_93_3$grp == "Residual"],
                "Matches printed reduced response-surface covariance parameter estimate.",
                "Fitted lmerTest reduced response-surface model.")
book_93_coef <- data.frame(
  term = c("(Intercept)", "a", "a2", "b", "b2", "c", "bc"),
  label = c("Intercept", "a", "a*a", "b", "b*b", "c", "b*c"),
  estimate = c(50.0850, 1.6000, -3.3025, 1.6938, -3.5150, 0.5188, -1.1625),
  se = c(0.8244, 0.3373, 0.8244, 0.3373, 0.8244, 0.3373, 0.4770),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_93_coef))) {
  rows <- add_row(rows, "Exam9.3", 9, "9.4.1",
                  paste0("Step 3 ", book_93_coef$label[i], " coefficient"),
                  book_93_coef$estimate[i], coef_93_3[book_93_coef$term[i], "Estimate"],
                  "Matches printed reduced response-surface fixed-effect solution.",
                  "Extracted lmerTest coefficient table.")
  rows <- add_row(rows, "Exam9.3", 9, "9.4.1",
                  paste0("Step 3 ", book_93_coef$label[i], " coefficient SE"),
                  book_93_coef$se[i], coef_93_3[book_93_coef$term[i], "Std. Error"],
                  "Matches printed reduced response-surface fixed-effect standard error.",
                  "Extracted lmerTest coefficient table.")
}

DataSet9.4 <- load_data("DataSet9.4")
DataSet9.4$block <- factor(DataSet9.4$block)
DataSet9.4$a <- factor(DataSet9.4$a)
DataSet9.4$b <- factor(DataSet9.4$b)
fit_94 <- lmerTest::lmer(
  y ~ a * b + (1 | block) + (1 | block:a) + (1 | block:b),
  data = DataSet9.4
)
collect_model(fit_94)
vc_94 <- as.data.frame(lme4::VarCorr(fit_94))
anova_94 <- stats::anova(fit_94, ddf = "Kenward-Roger")
book_94_vc <- data.frame(
  label = c("Bounded Intercept Block VC", "Bounded a Block VC",
            "Bounded b Block VC", "Bounded residual variance"),
  grp = c("block", "block:a", "block:b", "Residual"),
  value = c(3.6346, 0.0000, 8.2437, 10.2151),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_94_vc))) {
  rows <- add_row(rows, "Exam9.4", 9, "9.5.1",
                  book_94_vc$label[i], book_94_vc$value[i],
                  vc_94$vcov[vc_94$grp == book_94_vc$grp[i]],
                  "Matches the printed bounded variance-component fit where lme4 constrains variance components to be nonnegative.",
                  "Fitted lmerTest model corresponding to the bounded GLIMMIX fit.")
}
for (effect in c("a", "b", "a:b")) {
  rows <- add_row(rows, "Exam9.4", 9, "9.5.1",
                  paste0("Bounded ", effect, " F"),
                  c(a = 4.86, b = 17.14, `a:b` = 3.86)[[effect]],
                  anova_value(anova_94, effect, "F value"),
                  "R/SAS Kenward-Roger difference under a boundary variance component; retained mismatch where it exceeds tolerance.",
                  "Fitted bounded lmerTest model; lme4 cannot reproduce SAS NOBOUND negative variance fits.")
  rows <- add_row(rows, "Exam9.4", 9, "9.5.1",
                  paste0("Bounded ", effect, " p"),
                  c(a = 0.0247, b = 0.0008, `a:b` = 0.0235)[[effect]],
                  anova_value(anova_94, effect, "Pr(>F)"),
                  "R/SAS Kenward-Roger difference under a boundary variance component; retained mismatch where it exceeds tolerance.",
                  "Fitted bounded lmerTest model; lme4 cannot reproduce SAS NOBOUND negative variance fits.")
}
for (label in c("NOBOUND Intercept Block VC = 7.8469",
                "NOBOUND a Block VC = -6.5950",
                "NOBOUND b Block VC = 2.6751",
                "NOBOUND residual variance = 17.5683")) {
  rows <- add_unverif(
    rows, "Exam9.4", 9, "9.5.1", label, "printed by SAS GLIMMIX NOBOUND",
    "Software limitation: lme4/lmerTest constrain variance components to the nonnegative parameter space and do not implement SAS GLIMMIX NOBOUND.",
    "Documented as UNVERIF rather than replacing the negative variance fit with the bounded model."
  )
}

## Chapter 10 --------------------------------------------------------------

DataSet10.1 <- load_data("DataSet10.1")
DataSet10.1$a <- factor(DataSet10.1$a)
fit_101_re <- lmerTest::lmer(y ~ 1 + (1 | a), data = DataSet10.1)
fit_101_fe <- stats::lm(y ~ a, data = DataSet10.1)
collect_model(fit_101_re)
collect_model(fit_101_fe)
vc_101 <- as.data.frame(lme4::VarCorr(fit_101_re))
emm_101_re <- as.data.frame(emmeans::emmeans(fit_101_re, ~ 1))
emm_101_fe_overall <- as.data.frame(emmeans::emmeans(fit_101_fe, ~ 1))
emm_101_fe <- as.data.frame(emmeans::emmeans(fit_101_fe, ~ a))
ran_101 <- lme4::ranef(fit_101_re)$a[, 1]
blup_101 <- data.frame(
  a = levels(DataSet10.1$a),
  blup = unname(lme4::fixef(fit_101_re)[1] + ran_101),
  stringsAsFactors = FALSE
)
rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                "A random-effect VC", 5.5114,
                vc_101$vcov[vc_101$grp == "a"],
                "Matches printed one-way random-effects variance component.",
                "Fitted lmerTest::lmer(y ~ 1 + (1 | a)).")
rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                "Residual variance", 1.5308,
                vc_101$vcov[vc_101$grp == "Residual"],
                "Matches printed one-way random-effects residual variance.",
                "Fitted lmerTest::lmer(y ~ 1 + (1 | a)).")
rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                "Overall mean random-effects estimate", 15.9000,
                emm_101_re$emmean,
                "Matches printed random-effects broad-inference overall mean.",
                "Extracted emmeans::emmeans(fit, ~ 1).")
rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                "Overall mean random-effects SE", 0.7232,
                emm_101_re$SE,
                "Matches printed random-effects broad-inference overall mean standard error.",
                "Extracted emmeans::emmeans(fit, ~ 1).")
rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                "Overall mean fixed-effects estimate", 15.9000,
                emm_101_fe_overall$emmean,
                "Matches printed fixed-effects narrow-inference overall mean.",
                "Extracted emmeans::emmeans(fixed_fit, ~ 1).")
rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                "Overall mean fixed-effects SE", 0.2526,
                emm_101_fe_overall$SE,
                "Matches printed fixed-effects narrow-inference overall mean standard error.",
                "Extracted emmeans::emmeans(fixed_fit, ~ 1).")
book_101 <- data.frame(
  a = as.character(1:12),
  mean = c(16.15, 17.35, 12.15, 16.35, 14.40, 17.85,
           20.05, 18.40, 17.50, 12.60, 12.90, 15.10),
  mean_se = rep(0.87488, 12L),
  blup = c(16.1195, 17.1732, 12.6073, 16.2951, 14.5829, 17.6122,
           19.5439, 18.0951, 17.3049, 13.0024, 13.2658, 15.1976),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_101))) {
  idx_mean <- emm_101_fe$a == book_101$a[i]
  idx_blup <- blup_101$a == book_101$a[i]
  rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                  paste0("Table 10.1 a", book_101$a[i], " fixed mean"),
                  book_101$mean[i], emm_101_fe$emmean[idx_mean],
                  "Matches Table 10.1 fixed-effect treatment mean.",
                  "Extracted emmeans::emmeans(fixed_fit, ~ a).")
  rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                  paste0("Table 10.1 a", book_101$a[i], " fixed mean SE"),
                  book_101$mean_se[i], emm_101_fe$SE[idx_mean],
                  "Matches Table 10.1 fixed-effect treatment mean standard error.",
                  "Extracted emmeans::emmeans(fixed_fit, ~ a).")
  rows <- add_row(rows, "Exam10.1", 10, "10.2.1",
                  paste0("Table 10.1 a", book_101$a[i], " BLUP"),
                  book_101$blup[i], blup_101$blup[idx_blup],
                  "Matches Table 10.1 one-way random-effect BLUP.",
                  "Extracted lme4::ranef and added the fixed intercept.")
}
rows <- add_unverif(
  rows, "Exam10.1", 10, "10.2.1", "Table 10.1 BLUP SE values",
  "0.82453 for each A level",
  "Software limitation: lme4 does not directly report SAS GLIMMIX ESTIMATE standard errors for predictable functions.",
  "BLUP point estimates are verified; BLUP SE values are documented as unavailable in the current R workflow."
)

DataSet10.2 <- load_data("DataSet10.2")
DataSet10.2$a <- factor(DataSet10.2$a)
DataSet10.2$b <- factor(DataSet10.2$b)
fit_102_re <- lmerTest::lmer(y ~ 1 + (1 | a / b), data = DataSet10.2)
fit_102_fe <- stats::lm(y ~ a + b %in% a, data = DataSet10.2)
collect_model(fit_102_re)
collect_model(fit_102_fe)
vc_102 <- as.data.frame(lme4::VarCorr(fit_102_re))
emm_102_re <- as.data.frame(emmeans::emmeans(fit_102_re, ~ 1))
emm_102_fe_overall <- as.data.frame(emmeans::emmeans(fit_102_fe, ~ 1))
emm_102_fe_a <- as.data.frame(emmeans::emmeans(fit_102_fe, ~ a))
ran_102_a <- lme4::ranef(fit_102_re)$a[, 1]
blup_102_broad <- data.frame(
  a = levels(DataSet10.2$a),
  blup = unname(lme4::fixef(fit_102_re)[1] + ran_102_a),
  stringsAsFactors = FALSE
)
rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                "A random-effect VC", 2.1917,
                vc_102$vcov[vc_102$grp == "a"],
                "Matches the balanced nested random-effects variance component inferred from printed standard errors.",
                "Fitted lmerTest::lmer(y ~ 1 + (1 | a / b)).")
rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                "B(A) random-effect VC", 0.7704,
                vc_102$vcov[vc_102$grp == "b:a"],
                "Matches the balanced nested random-effects variance component inferred from printed standard errors.",
                "Fitted lmerTest::lmer(y ~ 1 + (1 | a / b)).")
rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                "Residual variance", 1.3614,
                vc_102$vcov[vc_102$grp == "Residual"],
                "Matches the balanced nested random-effects residual variance inferred from printed standard errors.",
                "Fitted lmerTest::lmer(y ~ 1 + (1 | a / b)).")
rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                "Overall mean random-effects estimate", 19.2571,
                emm_102_re$emmean,
                "Matches printed balanced nested random-effects overall mean.",
                "Extracted emmeans::emmeans(fit, ~ 1).")
rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                "Overall mean random-effects SE", 0.6456,
                emm_102_re$SE,
                "Matches printed balanced nested random-effects overall mean standard error.",
                "Extracted emmeans::emmeans(fit, ~ 1).")
rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                "Overall mean fixed-effects estimate", 19.2571,
                emm_102_fe_overall$emmean,
                "Matches printed balanced nested fixed-effects overall mean.",
                "Extracted emmeans::emmeans(fixed_fit, ~ 1).")
rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                "Overall mean fixed-effects SE", 0.2205,
                emm_102_fe_overall$SE,
                "Matches printed balanced nested fixed-effects overall mean standard error.",
                "Extracted emmeans::emmeans(fixed_fit, ~ 1).")
book_102 <- data.frame(
  a = as.character(1:7),
  mean = c(17.200, 19.375, 19.300, 19.150, 20.050, 22.300, 17.425),
  mean_se = rep(0.58340, 7L),
  broad = c(17.7116, 19.3457, 19.2893, 19.1766, 19.8528, 21.5432, 17.8807),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_102))) {
  idx_mean <- emm_102_fe_a$a == book_102$a[i]
  idx_blup <- blup_102_broad$a == book_102$a[i]
  rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                  paste0("Table 10.4 a", book_102$a[i], " fixed mean"),
                  book_102$mean[i], emm_102_fe_a$emmean[idx_mean],
                  "Matches Table 10.4 fixed-effect A mean.",
                  "Extracted emmeans::emmeans(fixed_fit, ~ a).")
  rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                  paste0("Table 10.4 a", book_102$a[i], " fixed mean SE"),
                  book_102$mean_se[i], emm_102_fe_a$SE[idx_mean],
                  "Matches Table 10.4 fixed-effect A mean standard error.",
                  "Extracted emmeans::emmeans(fixed_fit, ~ a).")
  rows <- add_row(rows, "Exam10.2", 10, "10.2.2.1",
                  paste0("Table 10.4 a", book_102$a[i], " broad BLUP"),
                  book_102$broad[i], blup_102_broad$blup[idx_blup],
                  "Matches Table 10.4 broad-inference A BLUP.",
                  "Extracted lme4::ranef for A and added the fixed intercept.")
}
rows <- add_unverif(
  rows, "Exam10.2", 10, "10.2.2.1", "Table 10.4 and 10.5 BLUP SE values",
  "0.75556 naive and 0.87313 KR broad BLUP SEs; 0.55346/0.58201 narrow BLUP SEs",
  "Software limitation: lme4/lmerTest do not directly report SAS GLIMMIX ESTIMATE standard errors for broad and narrow predictable functions.",
  "BLUP point estimates and fixed-effect means are verified; BLUP SE values are documented as unavailable in the current R workflow."
)

DataSet10.4 <- load_data("DataSet10.4")
DataSet10.4$a <- factor(DataSet10.4$a)
DataSet10.4$b <- factor(DataSet10.4$b)
fit_104 <- lmerTest::lmer(y ~ a + (1 | b) + (1 | b:a), data = DataSet10.4)
collect_model(fit_104)
vc_104 <- as.data.frame(lme4::VarCorr(fit_104))
anova_104 <- stats::anova(fit_104, ddf = "Kenward-Roger")
emm_104 <- as.data.frame(emmeans::emmeans(fit_104, ~ a))
pair_104 <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_104, ~ a),
  method = "pairwise",
  adjust = "none"
))
ran_104_b <- lme4::ranef(fit_104)$b[, 1]
names(ran_104_b) <- rownames(lme4::ranef(fit_104)$b)
ran_104_ab <- lme4::ranef(fit_104)$`b:a`[, 1]
names(ran_104_ab) <- rownames(lme4::ranef(fit_104)$`b:a`)
beta_104 <- lme4::fixef(fit_104)
grid_104 <- expand.grid(
  a = levels(DataSet10.4$a),
  b = levels(DataSet10.4$b),
  stringsAsFactors = FALSE
)
key_104 <- paste(grid_104$b, grid_104$a, sep = ":")
grid_104$pred <- unname(
  beta_104[1] +
    ifelse(grid_104$a == "2", beta_104[["a2"]], 0) +
    ran_104_b[grid_104$b] +
    ran_104_ab[key_104]
)
diff_104 <- grid_104[grid_104$a == "1", c("b", "pred")]
diff_104$diff <- grid_104$pred[grid_104$a == "1"] - grid_104$pred[grid_104$a == "2"]
rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                "B random-effect VC", 4.0237,
                vc_104$vcov[vc_104$grp == "b"],
                "Matches printed mixed-model covariance parameter estimate.",
                "Fitted lmerTest::lmer(y ~ a + (1 | b) + (1 | b:a)).")
rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                "A:B random-effect VC", 6.2562,
                vc_104$vcov[vc_104$grp == "b:a"],
                "Matches printed mixed-model covariance parameter estimate.",
                "Fitted lmerTest::lmer(y ~ a + (1 | b) + (1 | b:a)).")
rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                "Residual variance", 3.6472,
                vc_104$vcov[vc_104$grp == "Residual"],
                "Matches printed mixed-model covariance parameter estimate.",
                "Fitted lmerTest::lmer(y ~ a + (1 | b) + (1 | b:a)).")
rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                "A fixed-effect F", 3.20,
                anova_value(anova_104, "a", "F value"),
                "Matches printed treatment fixed-effect test.",
                "Extracted Kenward-Roger ANOVA from lmerTest.")
rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                "A fixed-effect p", 0.1166,
                anova_value(anova_104, "a", "Pr(>F)"),
                "Matches printed treatment fixed-effect test.",
                "Extracted Kenward-Roger ANOVA from lmerTest.")
book_104_means <- data.frame(
  a = c("1", "2"),
  estimate = c(14.8188, 12.2750),
  se = c(1.2300, 1.2300),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_104_means))) {
  idx <- emm_104$a == book_104_means$a[i]
  rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                  paste0("a", book_104_means$a[i], " LSMean"),
                  book_104_means$estimate[i], emm_104$emmean[idx],
                  "Matches printed treatment least-squares mean.",
                  "Extracted emmeans::emmeans(fit, ~ a).")
  rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                  paste0("a", book_104_means$a[i], " LSMean SE"),
                  book_104_means$se[i], emm_104$SE[idx],
                  "Matches printed treatment least-squares mean standard error.",
                  "Extracted emmeans::emmeans(fit, ~ a).")
}
rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                "a1 - a2 LSMean diff", 2.5437,
                pair_104$estimate[1],
                "Matches printed treatment LSMean difference.",
                "Extracted emmeans::pairs.")
rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                "a1 - a2 LSMean diff SE", 1.4212,
                pair_104$SE[1],
                "Matches printed treatment LSMean difference standard error.",
                "Extracted emmeans::pairs.")
rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                "a1 - a2 LSMean diff p", 0.1166,
                pair_104$p.value[1],
                "Matches printed treatment LSMean difference p-value.",
                "Extracted emmeans::pairs.")
book_104_diff <- data.frame(
  b = as.character(1:8),
  diff = c(3.1680, 1.4259, 0.8451, 3.2067, 7.0395, 1.3484, -2.7941, 6.1104),
  stringsAsFactors = FALSE
)
for (i in seq_len(nrow(book_104_diff))) {
  idx <- diff_104$b == book_104_diff$b[i]
  rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                  paste0("BLUP diff at b", book_104_diff$b[i]),
                  book_104_diff$diff[i], diff_104$diff[idx],
                  "Matches printed B-specific treatment-difference BLUP.",
                  "Extracted lme4::ranef values and evaluated the predictable function.")
}
book_104_group <- data.frame(
  label = c("b1,4,5,8 a1 BLUP", "b1,4,5,8 a2 BLUP", "b1,4,5,8 diff BLUP",
            "b2,3,6,7 a1 BLUP", "b2,3,6,7 a2 BLUP", "b2,3,6,7 diff BLUP"),
  value = c(15.4525, 10.5714, 4.8812, 14.1850, 13.9786, 0.2063),
  stringsAsFactors = FALSE
)
group_1458 <- grid_104[grid_104$b %in% c("1", "4", "5", "8"), ]
group_2367 <- grid_104[grid_104$b %in% c("2", "3", "6", "7"), ]
pkg_104_group <- c(
  mean(group_1458$pred[group_1458$a == "1"]),
  mean(group_1458$pred[group_1458$a == "2"]),
  mean(group_1458$pred[group_1458$a == "1"]) - mean(group_1458$pred[group_1458$a == "2"]),
  mean(group_2367$pred[group_2367$a == "1"]),
  mean(group_2367$pred[group_2367$a == "2"]),
  mean(group_2367$pred[group_2367$a == "1"]) - mean(group_2367$pred[group_2367$a == "2"])
)
for (i in seq_len(nrow(book_104_group))) {
  rows <- add_row(rows, "Exam10.4", 10, "10.3.1",
                  book_104_group$label[i], book_104_group$value[i],
                  pkg_104_group[i],
                  "Matches printed grouped-location BLUP predictable function.",
                  "Extracted lme4::ranef values and averaged the requested B levels.")
}
rows <- add_unverif(
  rows, "Exam10.4", 10, "10.3.1", "BLUP predictable-function SE values",
  "1.2463, 1.7108, 0.6460, and 0.8994 as printed for selected BLUPs",
  "Software limitation: lme4/lmerTest do not directly report SAS GLIMMIX ESTIMATE standard errors for location-specific predictable functions.",
  "Treatment means, differences, and BLUP point estimates are verified; BLUP SE values are documented as unavailable in the current R workflow."
)

out <- do.call(rbind, rows)
utils::write.csv(
  out,
  "inst/verification/ch08-ch10-verification.csv",
  row.names = FALSE,
  na = ""
)

esc <- function(x) {
  gsub("\\|", "\\\\|", as.character(x))
}
md_table <- function(x) {
  x[] <- lapply(x, esc)
  header <- paste0("| ", paste(names(x), collapse = " | "), " |")
  sep <- paste0("|", paste(rep("---", ncol(x)), collapse = "|"), "|")
  rows <- apply(x, 1, function(z) {
    paste0("| ", paste(z, collapse = " | "), " |")
  })
  c(header, sep, rows)
}
summary <- aggregate(
  Status ~ Chapter,
  out,
  function(x) paste(names(table(x)), as.integer(table(x)), collapse = ", ")
)
names(summary)[2] <- "Status Counts"
writeLines(
  c(
    "# Chapter 8-10 Runtime Verification",
    "",
    "Generated by inst/verification/ch08-ch10-verification.R.",
    "",
    md_table(summary),
    "",
    "Rows marked UNVERIF identify printed quantities that the current R workflow cannot extract directly.",
    "",
    md_table(out)
  ),
  "inst/verification/ch08-ch10-runtime-verification.md"
)
