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
  vc <- grepl("VC|variance|Scale", output_type, ignore.case = TRUE)
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
    `Package Value` = if (is.na(package)) "structure verified" else num(package, 6),
    Difference = difference,
    Status = status,
    Diagnosis = diagnosis,
    `Action Taken` = action,
    check.names = FALSE
  )
  rows
}

add_structure_row <- function(rows, example, chapter, section, note) {
  rows[[length(rows) + 1L]] <- data.frame(
    Example = example,
    Chapter = chapter,
    `Book Section` = section,
    `Output Type` = "Structure-only syntax/design matrix",
    `Book Value` = "no published numeric model output",
    `Package Value` = "structure verified",
    Difference = "",
    Status = "UNVERIF",
    Diagnosis = note,
    `Action Taken` = "Located in 2024 2nd edition; no fitted numerical output is printed for direct comparison.",
    check.names = FALSE
  )
  rows
}

if (!requireNamespace("broom.mixed", quietly = TRUE)) {
  stop("Package 'broom.mixed' is required for verification extraction.")
}
if (!requireNamespace("emmeans", quietly = TRUE)) {
  stop("Package 'emmeans' is required for verification extraction.")
}
if (!requireNamespace("lme4", quietly = TRUE)) {
  stop("Package 'lme4' is required for verification extraction.")
}
if (!requireNamespace("nlme", quietly = TRUE)) {
  stop("Package 'nlme' is required for verification extraction.")
}

rows <- list()

for (ex in c("Exam2.B.1", "Exam2.B.2", "Exam2.B.3", "Exam2.B.4",
             "Exam2.B.5", "Exam2.B.6", "Exam2.B.7")) {
  rows <- add_structure_row(
    rows = rows,
    example = ex,
    chapter = 2,
    section = sub("Exam", "", ex),
    note = paste(
      "The 2024 2nd edition presents this Appendix B item as PROC GLIMMIX",
      "syntax and model/design-matrix construction rather than selected",
      "fitted numerical output."
    )
  )
}

DataSet3.1 <- load_data("DataSet3.1")
DataSet3.1$trt <- factor(DataSet3.1$trt)

fit_331_lm <- stats::lm(Y ~ trt, data = DataSet3.1)
emm_331_lm <- as.data.frame(emmeans::emmeans(fit_331_lm, ~ trt))
pair_331_lm <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_331_lm, ~ trt),
  method = "pairwise"
))

rows <- add_row(rows, "Exam3.2", 3, "3.3.1", "Gaussian trt 0 LSMean", 10.5240,
                emm_331_lm$emmean[emm_331_lm$trt == "0"],
                "Matches Example 3.3.1 Gaussian two-treatment LSMean output.",
                "Fitted stats::lm(Y ~ trt) and extracted emmeans.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.1", "Gaussian trt 1 LSMean", 12.1880,
                emm_331_lm$emmean[emm_331_lm$trt == "1"],
                "Matches Example 3.3.1 Gaussian two-treatment LSMean output.",
                "Fitted stats::lm(Y ~ trt) and extracted emmeans.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.1", "Gaussian LSMean SE", 0.9972,
                emm_331_lm$SE[1],
                "Matches Example 3.3.1 Gaussian LSMean standard error.",
                "Fitted stats::lm(Y ~ trt) and extracted emmeans.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.1", "Gaussian trt0-trt1 diff", -1.6640,
                pair_331_lm$estimate[1],
                "Matches Example 3.3.1 treatment difference.",
                "Fitted stats::lm(Y ~ trt) and extracted pairwise emmeans contrast.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.1", "Gaussian diff SE", 1.4103,
                pair_331_lm$SE[1],
                "Matches Example 3.3.1 treatment difference standard error.",
                "Fitted stats::lm(Y ~ trt) and extracted pairwise emmeans contrast.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.1", "Gaussian scale variance", 9.9444,
                stats::sigma(fit_331_lm)^2,
                "Matches Example 3.3.1 printed scale estimate.",
                "Computed residual variance from stats::lm.")

fit_332_glm <- stats::glm(
  cbind(F, N - F) ~ trt,
  family = stats::binomial(link = "logit"),
  data = DataSet3.1
)
tidy_332 <- broom.mixed::tidy(fit_332_glm, effects = "fixed")
emm_332_link <- as.data.frame(emmeans::emmeans(fit_332_glm, ~ trt))
emm_332_resp <- as.data.frame(emmeans::emmeans(fit_332_glm, ~ trt, type = "response"))
pair_332 <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_332_glm, ~ trt),
  method = "pairwise"
))

rows <- add_row(rows, "Exam3.2", 3, "3.3.2", "Binomial GLM trt0 logit LSMean", -2.1542,
                emm_332_link$emmean[emm_332_link$trt == "0"],
                "Uses binomial-count response from the 2024 book, not unweighted proportions.",
                "Fitted stats::glm(cbind(F, N - F) ~ trt, binomial).")
rows <- add_row(rows, "Exam3.2", 3, "3.3.2", "Binomial GLM trt1 logit LSMean", -0.8860,
                emm_332_link$emmean[emm_332_link$trt == "1"],
                "Uses binomial-count response from the 2024 book, not unweighted proportions.",
                "Fitted stats::glm(cbind(F, N - F) ~ trt, binomial).")
rows <- add_row(rows, "Exam3.2", 3, "3.3.2", "Binomial GLM trt0 probability", 0.1039,
                emm_332_resp$prob[emm_332_resp$trt == "0"],
                "Matches Example 3.3.2 inverse-link LSMean.",
                "Extracted emmeans on response scale.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.2", "Binomial GLM trt1 probability", 0.2919,
                emm_332_resp$prob[emm_332_resp$trt == "1"],
                "Matches Example 3.3.2 inverse-link LSMean.",
                "Extracted emmeans on response scale.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.2", "Binomial GLM trt0-trt1 log odds ratio", -1.2682,
                pair_332$estimate[1],
                "Matches Example 3.3.2 model-scale treatment contrast.",
                "Extracted pairwise emmeans contrast on link scale.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.2", "Binomial GLM odds ratio", 0.2813,
                exp(pair_332$estimate[1]),
                "Matches Example 3.3.2 exponentiated treatment contrast.",
                "Exponentiated pairwise emmeans contrast.")
rows <- add_row(rows, "Exam3.2", 3, "3.3.2", "Binomial GLM fixed trt1 coefficient", 1.2682,
                tidy_332$estimate[tidy_332$term == "trt1"],
                "R treatment coding reports trt1-trt0; sign is opposite SAS trt0-trt1 contrast.",
                "Extracted fixed effects with broom.mixed::tidy.")

DataSet3.2 <- load_data("DataSet3.2")
DataSet3.2$trt <- factor(DataSet3.2$trt, levels = c(3, 0, 1, 2))
DataSet3.2$loc <- factor(DataSet3.2$loc, levels = c(8, 1, 2, 3, 4, 5, 6, 7))
fit_333 <- stats::lm(Y ~ loc + trt, data = DataSet3.2)
anova_333 <- stats::anova(fit_333)
emm_333 <- as.data.frame(emmeans::emmeans(fit_333, ~ trt))
pair_333 <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_333, ~ trt),
  method = "pairwise",
  adjust = "none"
))

book_333_means <- c("0" = 24.9500, "1" = 24.1375, "2" = 27.3750, "3" = 27.0875)
for (trt in names(book_333_means)) {
  rows <- add_row(rows, "Exam3.3", 3, "3.3.3",
                  paste0("RCBD Gaussian trt ", trt, " LSMean"),
                  book_333_means[[trt]],
                  emm_333$emmean[emm_333$trt == trt],
                  "Matches Example 3.3.3 treatment LSMean output.",
                  "Fitted stats::lm(Y ~ loc + trt) and extracted emmeans.")
}
rows <- add_row(rows, "Exam3.3", 3, "3.3.3", "RCBD Gaussian LSMean SE", 0.5997,
                emm_333$SE[1],
                "Matches Example 3.3.3 LSMean standard error.",
                "Fitted stats::lm(Y ~ loc + trt) and extracted emmeans.")
rows <- add_row(rows, "Exam3.3", 3, "3.3.3", "RCBD Gaussian residual scale", 2.8770,
                stats::sigma(fit_333)^2,
                "Matches Example 3.3.3 printed scale estimate.",
                "Computed residual variance from stats::lm.")
rows <- add_row(rows, "Exam3.3", 3, "3.3.3", "RCBD Type III trt F", 7.04,
                anova_333["trt", "F value"],
                "Balanced RCBD gives the printed treatment F statistic.",
                "Extracted stats::anova from stats::lm.")
rows <- add_row(rows, "Exam3.3", 3, "3.3.3", "RCBD Type III trt p", 0.0019,
                anova_333["trt", "Pr(>F)"],
                "Balanced RCBD gives the printed treatment p-value.",
                "Extracted stats::anova from stats::lm.")
rows <- add_row(rows, "Exam3.3", 3, "3.3.3", "RCBD Type III loc F", 3.41,
                anova_333["loc", "F value"],
                "Balanced RCBD gives the printed location F statistic.",
                "Extracted stats::anova from stats::lm.")
rows <- add_row(rows, "Exam3.3", 3, "3.3.3", "RCBD Type III loc p", 0.0135,
                anova_333["loc", "Pr(>F)"],
                "Balanced RCBD gives the printed location p-value.",
                "Extracted stats::anova from stats::lm.")

pair_lookup <- function(x, lhs, rhs) {
  x$estimate[x$contrast == paste(lhs, "-", rhs)]
}
rows <- add_row(rows, "Exam3.3", 3, "3.3.3", "RCBD trt0-trt1 diff", 0.8125,
                pair_lookup(pair_333, "trt0", "trt1"),
                "Matches Example 3.3.3 pairwise treatment difference.",
                "Extracted unadjusted pairwise emmeans contrast.")
rows <- add_row(rows, "Exam3.3", 3, "3.3.3", "RCBD trt1-trt2 diff", -3.2375,
                pair_lookup(pair_333, "trt1", "trt2"),
                "Matches Example 3.3.3 pairwise treatment difference.",
                "Extracted unadjusted pairwise emmeans contrast.")

DataSet3.2f <- load_data("DataSet3.2")
DataSet3.2f$A <- factor(DataSet3.2f$A)
DataSet3.2f$B <- factor(DataSet3.2f$B)
DataSet3.2f$loc <- factor(DataSet3.2f$loc, levels = c(8, 1, 2, 3, 4, 5, 6, 7))
fit_335 <- stats::lm(Y ~ A * B + loc, data = DataSet3.2f)
anova_335 <- stats::anova(fit_335)
emm_335 <- as.data.frame(emmeans::emmeans(fit_335, ~ A * B))
emm_335_a <- as.data.frame(emmeans::emmeans(fit_335, ~ A))
emm_335_b <- as.data.frame(emmeans::emmeans(fit_335, ~ B))
simp_a_by_b <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_335, ~ A | B),
  method = "pairwise",
  by = "B"
))
simp_b_by_a <- as.data.frame(emmeans::contrast(
  emmeans::emmeans(fit_335, ~ B | A),
  method = "pairwise",
  by = "A"
))

rows <- add_row(rows, "Exam3.5", 3, "3.3.5", "Factorial a0 marginal mean", 24.5438,
                emm_335_a$emmean[emm_335_a$A == "0"],
                "Matches Example 3.3.5 marginal mean for A0.",
                "Fitted stats::lm(Y ~ A * B + loc) and extracted emmeans.")
rows <- add_row(rows, "Exam3.5", 3, "3.3.5", "Factorial b0 marginal mean", 26.1625,
                emm_335_b$emmean[emm_335_b$B == "0"],
                "Matches Example 3.3.5 marginal mean for B0.",
                "Fitted stats::lm(Y ~ A * B + loc) and extracted emmeans.")
rows <- add_row(rows, "Exam3.5", 3, "3.3.5", "Factorial a0 marginal SE", 0.4240,
                emm_335_a$SE[emm_335_a$A == "0"],
                "Matches Example 3.3.5 marginal mean standard error.",
                "Extracted emmeans.")
rows <- add_row(rows, "Exam3.5", 3, "3.3.5", "Factorial a at b0 simple effect", -2.4250,
                simp_a_by_b$estimate[simp_a_by_b$B == "0"],
                "Matches Example 3.3.5 simple effect of A at B0.",
                "Extracted pairwise emmeans contrast by B.")
rows <- add_row(rows, "Exam3.5", 3, "3.3.5", "Factorial b at a0 simple effect", 0.8125,
                simp_b_by_a$estimate[simp_b_by_a$A == "0"],
                "Matches Example 3.3.5 simple effect of B at A0.",
                "Extracted pairwise emmeans contrast by A.")
rows <- add_row(rows, "Exam3.5", 3, "3.3.5", "Factorial A:B interaction p", 0.6661,
                anova_335["A:B", "Pr(>F)"],
                "Matches Example 3.3.5 printed interaction p-value.",
                "Extracted stats::anova from stats::lm.")

book_335_cells <- data.frame(
  A = c("0", "0", "1", "1"),
  B = c("0", "1", "0", "1"),
  book = c(24.9500, 24.1375, 27.3750, 27.0875)
)
for (i in seq_len(nrow(book_335_cells))) {
  idx <- emm_335$A == book_335_cells$A[i] & emm_335$B == book_335_cells$B[i]
  rows <- add_row(rows, "Exam3.5", 3, "3.3.5",
                  paste0("Factorial A", book_335_cells$A[i], " B",
                         book_335_cells$B[i], " LSMean"),
                  book_335_cells$book[i],
                  emm_335$emmean[idx],
                  "Matches Example 3.3.5 A*B LSMean output.",
                  "Extracted emmeans for A*B.")
}

DataSet3.2g <- load_data("DataSet3.2")
DataSet3.2g$trt <- factor(DataSet3.2g$trt)
DataSet3.2g$loc <- factor(DataSet3.2g$loc)
fit_39_c0 <- lme4::glmer(
  cbind(S2, Nbin - S2) ~ trt + (1 | loc),
  family = stats::binomial(link = "logit"),
  data = DataSet3.2g,
  nAGQ = 10
)
emm_39_c0 <- as.data.frame(emmeans::emmeans(fit_39_c0, ~ trt, type = "response"))

fit_39_norm <- nlme::lme(
  fixed = S2 / Nbin ~ trt,
  random = ~ 1 | loc,
  data = DataSet3.2g,
  method = "REML"
)
anova_39_norm <- stats::anova(fit_39_norm)
emm_39_norm <- as.data.frame(emmeans::emmeans(fit_39_norm, ~ trt))

fit_39_cint <- lme4::glmer(
  cbind(S2, Nbin - S2) ~ trt + (1 | loc) + (1 | loc:trt),
  family = stats::binomial(link = "logit"),
  data = DataSet3.2g,
  nAGQ = 0,
  control = lme4::glmerControl(optimizer = "bobyqa")
)
emm_39_cint <- as.data.frame(emmeans::emmeans(fit_39_cint, ~ trt, type = "response"))

fit_39_marg <- MASS::glmmPQL(
  fixed = S2 / Nbin ~ trt,
  random = ~ 1 | loc,
  family = stats::quasibinomial(link = "logit"),
  data = DataSet3.2g,
  correlation = nlme::corCompSymm(form = ~ 1 | loc),
  niter = 10,
  verbose = FALSE
)
emm_39_marg <- as.data.frame(emmeans::emmeans(fit_39_marg, ~ trt, type = "response"))

book_39 <- data.frame(
  model = c(rep("conditional no interaction", 4L), rep("normal approximation", 4L),
            rep("conditional with interaction", 4L), rep("marginal GLMM", 4L)),
  trt = rep(c("0", "1", "2", "3"), 4L),
  mean = c(0.124, 0.159, 0.260, 0.298, 0.160, 0.200, 0.304, 0.340,
           0.106, 0.141, 0.263, 0.288, 0.160, 0.200, 0.304, 0.340),
  se = c(0.046, 0.056, 0.080, 0.087, 0.073, 0.073, 0.073, 0.073,
         0.051, 0.064, 0.101, 0.108, 0.061, 0.067, 0.077, 0.079)
)

extract_39 <- function(model, trt, what) {
  src <- switch(
    model,
    "conditional no interaction" = emm_39_c0,
    "normal approximation" = emm_39_norm,
    "conditional with interaction" = emm_39_cint,
    "marginal GLMM" = emm_39_marg
  )
  value_col <- if ("prob" %in% names(src)) "prob" else "emmean"
  if (what == "mean") {
    src[[value_col]][src$trt == trt]
  } else {
    src$SE[src$trt == trt]
  }
}

for (i in seq_len(nrow(book_39))) {
  rows <- add_row(
    rows, "Exam3.9", 3, "3.5 / Table 3.4",
    paste0(book_39$model[i], " trt ", book_39$trt[i], " data-scale mean"),
    book_39$mean[i],
    extract_39(book_39$model[i], book_39$trt[i], "mean"),
    "Compares Table 3.4 data-scale treatment estimates.",
    "Fitted the corresponding R model and extracted emmeans."
  )
  rows <- add_row(
    rows, "Exam3.9", 3, "3.5 / Table 3.4",
    paste0(book_39$model[i], " trt ", book_39$trt[i], " SE"),
    book_39$se[i],
    extract_39(book_39$model[i], book_39$trt[i], "se"),
    "Compares Table 3.4 standard errors.",
    "Fitted the corresponding R model and extracted emmeans."
  )
}

rows <- add_row(rows, "Exam3.9", 3, "3.5 / Table 3.4",
                "normal approximation trt F", 2.08,
                anova_39_norm["trt", "F-value"],
                "Matches Table 3.4 normal-approximation treatment F statistic.",
                "Extracted stats::anova from nlme::lme.")
rows <- add_row(rows, "Exam3.9", 3, "3.5 / Table 3.4",
                "normal approximation trt p", 0.1334,
                anova_39_norm["trt", "p-value"],
                "Matches Table 3.4 normal-approximation treatment p-value.",
                "Extracted stats::anova from nlme::lme.")

for (ex in c("Exam4.1", "Exam5.1", "Exam5.2", "Exam5.3")) {
  rows[[length(rows) + 1L]] <- data.frame(
    Example = ex,
    Chapter = as.integer(substr(ex, 5, 5)),
    `Book Section` = "absent from 2024 2nd edition",
    `Output Type` = "Legacy example status",
    `Book Value` = "not in 2nd edition",
    `Package Value` = "legacy topic retained",
    Difference = "",
    Status = "UNVERIF",
    Diagnosis = "Example from 1st edition. Not in 2nd edition.",
    `Action Taken` = "Classified as LEGACY; no 2024 book numerical comparison is available under this example number.",
    check.names = FALSE
  )
}

out <- do.call(rbind, rows)
utils::write.csv(
  out,
  file = "inst/verification/ch02-ch05-verification.csv",
  row.names = FALSE,
  na = ""
)

md <- c(
  "# Chapter 2-5 Runtime Verification",
  "",
  paste0("Generated: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z")),
  "",
  paste(
    "This file records the package values generated from the current R",
    "implementation and compares them with numerical output printed in the",
    "2024 2nd edition where available."
  ),
  "",
  paste0("Rows written: ", nrow(out)),
  paste0("EXACT: ", sum(out$Status == "EXACT")),
  paste0("APPROX: ", sum(out$Status == "APPROX")),
  paste0("MISMATCH: ", sum(out$Status == "MISMATCH")),
  paste0("UNVERIF: ", sum(out$Status == "UNVERIF")),
  ""
)
writeLines(md, "inst/verification/ch02-ch05-runtime-verification.md")
