#' @title Example 14.1 — Ordinal GLMM: Proportional Odds and Threshold Models
#' @name   Exam14.1
#'
#' @description
#' Analysis of ordinal frequency data from a nested factorial design (10 blocks,
#' 6 treatments, 3-category response) using proportional odds (cumulative logit)
#' and threshold (cumulative probit) GLMMs.  Implements Section 14.3 of Stroup
#' et al. (2024), Data Set 14.1.  Each block-treatment combination contributes a
#' triplet of frequency counts (slight, modrat, severe).
#'
#' @details
#' The proportional-odds GLMM has one link function per category boundary:
#' \deqn{\eta_{c,ij} = \eta_c + \tau_i + b_j, \quad c = 0,1}
#' \deqn{\eta_{0,ij} = \log\!\left(\frac{\pi_{\text{slight},ij}}
#'       {1-\pi_{\text{slight},ij}}\right), \quad
#'       \eta_{1,ij} = \log\!\left(\frac{\pi_{\text{slight},ij}+
#'       \pi_{\text{modrat},ij}}{1-(\pi_{\text{slight},ij}+
#'       \pi_{\text{modrat},ij})}\right)}
#' where \eqn{\eta_c} are the category-boundary intercepts (shared across
#' treatments in the proportional-odds model), \eqn{\tau_i} is the treatment
#' effect, and \eqn{b_j \sim \mathcal{N}(0,\sigma^2_b)} is the block random
#' effect.
#'
#' Published results (2nd ed. p.436):
#' \eqn{\hat\eta_0 = 0.3492} (slight boundary), \eqn{\hat\eta_1 = 1.9956}
#' (modrat boundary); TRT effects: trt0=\eqn{-2.83}, \ldots, trt5=0 (reference);
#' F(5,768)=17.67, p<0.0001.
#'
#' @note
#' \strong{Dataset note:} The first 9 rows of \code{DataSet14.1} are transcribed
#' exactly from book p.435 (blk=1, trt=0,1,2; slight/modrat/severe counts).
#' Rows 10–180 are reconstructed from the published cumulative-logit parameters.
#' The actual data appear in the SAS Data and Program Library as Data Set 14.1
#' (SAS name \code{univar_multinom}).  Published F and intercept values will
#' approximate the book's output but differ due to reconstruction.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#'     Applications}. CRC Press. Section 14.3, pp.434–438.
#'   \item Agresti, A. (2010). \emph{Analysis of Ordinal Categorical Data},
#'     2nd ed. Wiley.
#' }
#'
#' @seealso \code{\link{DataSet14.1}}
#'
#' @examples
#' data(DataSet14.1)
#'
#' ## -------------------------------------------------------
#' ## 1. Marginal frequency table
#' ## -------------------------------------------------------
#' with(DataSet14.1, tapply(y, list(trt, rating), sum))
#'
#' ## -------------------------------------------------------
#' ## 2. Fixed-effects proportional odds via MASS::polr
#' ## -------------------------------------------------------
#' ## Ignores block random effect; for illustration of fixed-effect structure.
#' ## A full GLMM would require ordinal::clmm or glmmTMB >= 1.2 with cumulative().
#' fit_polr <- MASS::polr(
#'   rating ~ trt,
#'   weights = y,
#'   data    = DataSet14.1,
#'   Hess    = TRUE,
#'   method  = "logistic"
#' )
#' summary(fit_polr)
#'
#' ## Wald p-values
#' coef_tab <- coef(summary(fit_polr))
#' pval     <- stats::pnorm(abs(coef_tab[, "t value"]),
#'                           lower.tail = FALSE) * 2
#' cbind(coef_tab, "p value" = pval)
#'
#' ## Odds ratios for treatments vs reference (trt 5)
#' exp(coef(fit_polr)[seq_len(nlevels(DataSet14.1$trt) - 1)])
#'
#' ## -------------------------------------------------------
#' ## 4. Threshold (cumulative probit) model
#' ## -------------------------------------------------------
#' fit_probit <- MASS::polr(
#'   rating ~ trt,
#'   weights = y,
#'   data    = DataSet14.1,
#'   Hess    = TRUE,
#'   method  = "probit"
#' )
#' summary(fit_probit)
NULL
