#' @title Example 12.1 — Continuous Proportions: Beta GLMM
#' @name   Exam12.1
#'
#' @description
#' Analysis of continuous proportion data from a dose-response study using
#' a beta GLMM with a run-level random effect.  Implements the analysis of
#' Section 12.6.2 of Stroup et al. (2024), Data Set 12.7.  Two treatments
#' are compared across six dose levels (0–5), with 12 runs per treatment.
#' Demonstrates lack-of-fit testing, regression slope comparisons, and
#' treatment contrasts at specific dose levels.
#'
#' @details
#' The beta GLMM for continuous proportions is:
#' \deqn{y_{ijk} | r(\tau)_{ik} \sim \text{Beta}(\mu_{ijk}, \phi)}
#' \deqn{\text{logit}(\mu_{ijk}) = \beta_{0i} + \beta_{1i} D_j + r(\tau)_{ik}}
#' where \eqn{\beta_{0i}} is the treatment intercept, \eqn{\beta_{1i}} is the
#' dose-specific linear slope, \eqn{D_j} is the dose level (0–5), and
#' \eqn{r(\tau)_{ik} \sim \mathcal{N}(0,\sigma^2_r)} is the run random
#' effect nested within treatment.
#'
#' The key hypotheses are:
#' \itemize{
#'   \item \eqn{H_0: \beta_{0,0} = \beta_{0,1}} (equal intercepts)
#'   \item \eqn{H_0: \beta_{1,0} = \beta_{1,1}} (equal slopes)
#' }
#'
#' Published results (2nd ed. pp.406-407): equal intercepts F(1,22)=0.17,
#' p=0.6837; equal slopes F(1,118)=10.07, p=0.0019.
#'
#' @note
#' \strong{Dataset note:} \code{DataSet12.1} is reconstructed from the
#' published regression parameters (p.406) with run RE drawn from
#' \eqn{N(0,0.45^2)} and Beta precision \eqn{\phi=10} (\code{set.seed(2024)}).
#' The actual data appear in the SAS Data and Program Library as Data Set 12.7
#' (SAS name \code{rates}).  The contrast conclusions
#' (non-significant equal intercepts, significant unequal slopes) match the
#' book; individual fixed-effect estimates approximate the published values.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#'     Applications}. CRC Press. Section 12.6.2, pp.404–407.
#'   \item Ferrari, S., & Cribari-Neto, F. (2004).
#'     Beta regression for modelling rates and proportions.
#'     \emph{Journal of Applied Statistics}, 31(7), 799–815.
#' }
#'
#' @seealso \code{\link{DataSet12.1}}
#'
#' @examples
#' data(DataSet12.1)
#'
#' ## -------------------------------------------------------
#' ## 1. Exploratory: mean proportion by treatment and dose
#' ## -------------------------------------------------------
#' with(DataSet12.1, tapply(proportion, list(trt, dose), mean))
#'
#' ## -------------------------------------------------------
#' ## 2. Beta GLMM with run(trt) random effect via glmmTMB
#' ## -------------------------------------------------------
#' if (requireNamespace("glmmTMB", quietly = TRUE)) {
#'
#'   ## Step 1: lack-of-fit test (add trt×dose interaction)
#'   fit_full <- glmmTMB::glmmTMB(
#'     proportion ~ trt * dose + (1 | run),
#'     family = glmmTMB::beta_family(link = "logit"),
#'     data   = DataSet12.1
#'   )
#'   summary(fit_full)
#'
#'   ## Step 2: separate linear regressions per treatment
#'   fit_sep <- glmmTMB::glmmTMB(
#'     proportion ~ trt / dose - 1 + (1 | run),
#'     family = glmmTMB::beta_family(link = "logit"),
#'     data   = DataSet12.1
#'   )
#'   summary(fit_sep)
#'
#'   ## -------------------------------------------------------
#'   ## 3. Contrast: equal intercepts and equal slopes
#'   ## -------------------------------------------------------
#'   emm_int <- emmeans::emmeans(fit_sep, ~ trt, at = list(dose = 0))
#'   emmeans::contrast(emm_int, method = "pairwise")
#'
#'   emm_slope <- emmeans::emtrends(fit_sep, ~ trt, var = "dose")
#'   emmeans::contrast(emm_slope, method = "pairwise")
#'
#'   ## -------------------------------------------------------
#'   ## 4. Predicted proportions at dose=0 and dose=5
#'   ## -------------------------------------------------------
#'   emm_d0 <- emmeans::emmeans(fit_sep, ~ trt, at = list(dose = 0),
#'                               type = "response")
#'   emm_d5 <- emmeans::emmeans(fit_sep, ~ trt, at = list(dose = 5),
#'                               type = "response")
#'   print(emm_d0)
#'   print(emm_d5)
#'   emmeans::contrast(emm_d5, method = "pairwise")
#' }
NULL
