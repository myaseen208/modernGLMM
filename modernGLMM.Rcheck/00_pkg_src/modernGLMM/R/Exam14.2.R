#' @title Example 14.2 — Ordinal GLMM: Non-Proportional Odds (Poinsettia Trial)
#' @name   Exam14.2
#'
#' @description
#' Analysis of ordinal rating data from a poinsettia quality trial (3 varieties,
#' 12 growers, ratings A/B/C) demonstrating why the proportional-odds assumption
#' fails and how a non-proportional odds cumulative logit model provides an
#' adequate alternative.  Implements Section 14.4 of Stroup et al. (2024),
#' Data Set 14.2.
#'
#' @details
#' The proportional-odds model restricts treatment effects \eqn{\tau_i} to be
#' the same for both category boundaries.  When this restriction does not hold,
#' the non-proportional (partial proportional) odds model allows
#' category-specific variety effects:
#' \deqn{\eta_{c,ij} = \eta_c + \tau_{ci} + b_{cj}, \quad c = 0,1}
#' where \eqn{\tau_{ci}} is the variety effect for boundary \eqn{c} and
#' \eqn{b_{cj}} are grower random effects specific to each boundary.
#'
#' For the poinsettia data, variety has a strong effect but operates differently
#' for the lower boundary (A vs. B+C) and upper boundary (A+B vs. C):
#' Variety 2 has high probability of B (lower tau for A, higher for C), while
#' Variety 3 is the opposite.
#'
#' Published results (2nd ed. p.442):
#' "Separate variety effect by link?" F(2,8)=139.23, p<0.0001;
#' "Variety effect?" F(4,8)=69.65, p<0.0001.
#' Marginal totals (book p.438): Variety 1: A=192, B=174, C=176;
#' Variety 2: A=65, B=395, C=68; Variety 3: A=262, B=30, C=244.
#'
#' @note
#' \strong{Dataset note:} The marginal variety×rating frequency table in
#' \code{DataSet14.2} is transcribed exactly from book p.438.  Within-grower
#' allocation across the 12 growers is constructed proportionally from the
#' marginal totals; the actual per-grower counts appear in the SAS Data and
#' Program Library as Data Set 14.2 (SAS name \code{Plant_Ratings}).
#' Variance component estimates and test statistics will approximate but
#' differ from published values due to the reconstructed within-grower
#' distribution.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#'     Applications}. CRC Press. Section 14.4, pp.438–443.
#' }
#'
#' @seealso \code{\link{DataSet14.2}}
#'
#' @examples
#' data(DataSet14.2)
#'
#' ## -------------------------------------------------------
#' ## 1. Raw frequency table (should match book p.438 exactly)
#' ## -------------------------------------------------------
#' (tab <- with(DataSet14.2, tapply(y, list(variety, rating), sum)))
#' round(sweep(tab, 1, rowSums(tab), "/") * 100, 2)   # row percentages
#'
#' ## -------------------------------------------------------
#' ## 2. Proportional odds model — expected to fail (F≈0.02, p≈0.98)
#' ## -------------------------------------------------------
#' fit_po <- MASS::polr(
#'   rating ~ variety,
#'   weights = y,
#'   data    = DataSet14.2,
#'   Hess    = TRUE,
#'   method  = "logistic"
#' )
#' summary(fit_po)
#'
#' ## -------------------------------------------------------
#' ## 3. Illustration of proportional odds failure
#' ## -------------------------------------------------------
#' ## Fit separate logistic regressions for each boundary:
#' ## Boundary 1: P(rating == "A") vs P(rating %in% c("B","C"))
#' ## Boundary 2: P(rating %in% c("A","B")) vs P(rating == "C")
#' dat_b1 <- DataSet14.2
#' dat_b1$y_A   <- dat_b1$y * (dat_b1$rating == "A")
#' dat_b1$y_BC  <- dat_b1$y * (dat_b1$rating != "A")
#' agg1 <- aggregate(cbind(y_A, y_BC) ~ variety + grower, data = dat_b1, FUN = sum)
#' if (requireNamespace("lme4", quietly = TRUE)) {
#'   fit_b1 <- lme4::glmer(
#'     cbind(y_A, y_BC) ~ variety + (1 | grower),
#'     family  = stats::binomial(link = "logit"),
#'     data    = agg1,
#'     control = lme4::glmerControl(optimizer = "bobyqa")
#'   )
#'   cat("Boundary 1 (A vs B+C) — variety effects:\n")
#'   print(round(stats::coef(summary(fit_b1))[, "Estimate"], 3))
#' }
NULL
