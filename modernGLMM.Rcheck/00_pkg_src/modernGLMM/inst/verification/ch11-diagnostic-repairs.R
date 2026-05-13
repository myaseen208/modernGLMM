load_data <- function(name) {
  path <- file.path("data", paste0(name, ".RData"))
  env <- new.env(parent = emptyenv())
  load(path, envir = env)
  env[[name]]
}

fmt <- function(x, digits = 4) {
  if (length(x) == 0L) {
    return(NA_character_)
  }
  out <- rep(NA_character_, length(x))
  keep <- !is.na(x)
  out[keep] <- formatC(as.numeric(x[keep]), format = "f", digits = digits)
  out
}

pearson_df <- function(model) {
  sum(stats::residuals(model, type = "pearson")^2) / stats::df.residual(model)
}

extract_emm_response <- function(model, specs = ~ trt) {
  as.data.frame(emmeans::emmeans(model, specs = specs, type = "response"))
}

emm_value <- function(x) {
  candidates <- c("response", "rate", "prob", "emmean")
  col <- candidates[candidates %in% names(x)][1]
  x[[col]]
}

write_line <- function(...) {
  cat(paste0(..., collapse = ""), "\n", sep = "")
}

if (!requireNamespace("emmeans", quietly = TRUE)) {
  stop("Package 'emmeans' is required for Chapter 11 diagnostics.")
}
if (!requireNamespace("lme4", quietly = TRUE)) {
  stop("Package 'lme4' is required for Chapter 11 diagnostics.")
}
if (!requireNamespace("glmmTMB", quietly = TRUE)) {
  stop("Package 'glmmTMB' is required for Chapter 11 diagnostics.")
}

DataSet11.3 <- load_data("DataSet11.3")
DataSet11.3$block <- factor(DataSet11.3$block)
DataSet11.3$trt <- factor(DataSet11.3$trt)
DataSet11.3$unit <- seq_len(nrow(DataSet11.3))

write_line("# Chapter 11 Diagnostic Repair Runs")
write_line("")
write_line("Generated: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"))
write_line("")

write_line("## DataSet11.3")
write_line("")
means <- stats::aggregate(count ~ trt, data = DataSet11.3, FUN = mean)
write_line("Treatment sample means: ", paste(fmt(means$count, 1), collapse = ", "))
write_line("")

fit_naive_laplace <- lme4::glmer(
  count ~ trt + (1 | block),
  family = stats::poisson(link = "log"),
  data = DataSet11.3,
  nAGQ = 1,
  control = lme4::glmerControl(optimizer = "bobyqa")
)
emm_naive_laplace <- extract_emm_response(fit_naive_laplace)

fit_naive_pql <- MASS::glmmPQL(
  fixed = count ~ trt,
  random = ~ 1 | block,
  family = stats::poisson(link = "log"),
  data = DataSet11.3,
  verbose = FALSE
)
emm_naive_pql <- extract_emm_response(fit_naive_pql)

fit_naive_tmb <- glmmTMB::glmmTMB(
  count ~ trt + (1 | block),
  family = stats::poisson(link = "log"),
  data = DataSet11.3
)
emm_naive_tmb <- extract_emm_response(fit_naive_tmb)

write_line("## Naive Poisson Repair Attempts")
write_line("")
write_line("| Fit | Pearson Chi-square/DF | trt1 mean | trt2 mean | trt3 mean |")
write_line("|---|---:|---:|---:|---:|")
write_line(
  "| lme4 Laplace | ", fmt(pearson_df(fit_naive_laplace)), " | ",
  paste(fmt(emm_value(emm_naive_laplace)), collapse = " | "), " |"
)
write_line(
  "| MASS glmmPQL | NA | ",
  paste(fmt(emm_naive_pql$rate), collapse = " | "), " |"
)
write_line(
  "| glmmTMB ML | ", fmt(pearson_df(fit_naive_tmb)), " | ",
  paste(fmt(emm_naive_tmb$rate), collapse = " | "), " |"
)
write_line("")

fit_pn_lme4_0 <- lme4::glmer(
  count ~ trt + (1 | block) + (1 | block:trt),
  family = stats::poisson(link = "log"),
  data = DataSet11.3,
  nAGQ = 0,
  control = lme4::glmerControl(optimizer = "bobyqa")
)
fit_pn_lme4_1 <- lme4::glmer(
  count ~ trt + (1 | block) + (1 | block:trt),
  family = stats::poisson(link = "log"),
  data = DataSet11.3,
  nAGQ = 1,
  control = lme4::glmerControl(optimizer = "bobyqa")
)
fit_pn_tmb <- glmmTMB::glmmTMB(
  count ~ trt + (1 | block) + (1 | block:trt),
  family = stats::poisson(link = "log"),
  data = DataSet11.3
)

vc_lme4_0 <- as.data.frame(lme4::VarCorr(fit_pn_lme4_0))
vc_lme4_1 <- as.data.frame(lme4::VarCorr(fit_pn_lme4_1))
vc_tmb <- glmmTMB::VarCorr(fit_pn_tmb)$cond

get_vc <- function(vc, grp) {
  vc$vcov[vc$grp == grp][1]
}

write_line("## Poisson-Normal Repair Attempts")
write_line("")
write_line("| Fit | block VC | unit VC | Pearson Chi-square/DF |")
write_line("|---|---:|---:|---:|")
write_line(
  "| lme4 nAGQ=0 | ", fmt(get_vc(vc_lme4_0, "block")), " | ",
  fmt(get_vc(vc_lme4_0, "block:trt")), " | ", fmt(pearson_df(fit_pn_lme4_0)), " |"
)
write_line(
  "| lme4 nAGQ=1 | ", fmt(get_vc(vc_lme4_1, "block")), " | ",
  fmt(get_vc(vc_lme4_1, "block:trt")), " | ", fmt(pearson_df(fit_pn_lme4_1)), " |"
)
write_line(
  "| glmmTMB ML | ", fmt(as.numeric(vc_tmb$block[1])), " | ",
  fmt(as.numeric(vc_tmb$`block:trt`[1])), " | ", fmt(pearson_df(fit_pn_tmb)), " |"
)
write_line("")

fit_nb2 <- glmmTMB::glmmTMB(
  count ~ trt + (1 | block),
  family = glmmTMB::nbinom2(link = "log"),
  data = DataSet11.3
)
fit_nb1 <- glmmTMB::glmmTMB(
  count ~ trt + (1 | block),
  family = glmmTMB::nbinom1(link = "log"),
  data = DataSet11.3
)
fit_nb2_reml <- glmmTMB::glmmTMB(
  count ~ trt + (1 | block),
  family = glmmTMB::nbinom2(link = "log"),
  data = DataSet11.3,
  REML = TRUE
)

vc_nb2 <- glmmTMB::VarCorr(fit_nb2)$cond
vc_nb1 <- glmmTMB::VarCorr(fit_nb1)$cond
vc_nb2_reml <- glmmTMB::VarCorr(fit_nb2_reml)$cond

nb_scale <- function(model) {
  1 / as.numeric(stats::sigma(model))
}

write_line("## Negative-Binomial Repair Attempts")
write_line("")
write_line("| Fit | block VC | book-scale phi approximation | AIC |")
write_line("|---|---:|---:|---:|")
write_line(
  "| glmmTMB nbinom2 ML | ", fmt(as.numeric(vc_nb2$block[1])), " | ",
  fmt(nb_scale(fit_nb2)), " | ", fmt(stats::AIC(fit_nb2)), " |"
)
write_line(
  "| glmmTMB nbinom1 ML | ", fmt(as.numeric(vc_nb1$block[1])), " | ",
  fmt(stats::sigma(fit_nb1)), " | ", fmt(stats::AIC(fit_nb1)), " |"
)
write_line(
  "| glmmTMB nbinom2 REML | ", fmt(as.numeric(vc_nb2_reml$block[1])), " | ",
  fmt(nb_scale(fit_nb2_reml)), " | ", fmt(stats::AIC(fit_nb2_reml)), " |"
)
write_line("")
