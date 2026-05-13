#' @title Example 18.1 — Gaussian Spatial Variability: Alliance Wheat Trial
#' @name   Exam18.1
#'
#' @description
#' Analysis of a 48-treatment Gaussian yield trial on a 12×12 field grid using
#' spatial covariance models (spherical, exponential, Gaussian).  Implements
#' Section 18.3 of Stroup et al. (2024), Data Set 18.1 (Alliance wheat trial).
#' Demonstrates spatial covariance model selection via AICC and estimation of
#' treatment means adjusted for spatial autocorrelation.
#'
#' @details
#' For plots \eqn{i} and \eqn{j} with Euclidean distance \eqn{d_{ij}}, the
#' spherical covariance model (SP(SPH)) is:
#' \deqn{C(d_{ij}) = \begin{cases}
#'   \sigma^2 \left[1 - \frac{3d_{ij}}{2r} + \frac{d_{ij}^3}{2r^3}\right]
#'   & d_{ij} < r \\
#'   0 & d_{ij} \ge r
#' \end{cases}}
#' where \eqn{r} is the range parameter and \eqn{\sigma^2} is the sill.
#'
#' The model includes three complete blocks (columns 1–4, 5–8, 9–12) as a
#' fixed block effect, plus the spatial R-side residual covariance.
#'
#' Published results (2nd ed. pp.569-571):
#' SP(SPH): range=4.1214, residual \eqn{\sigma^2}=14.0107.
#' AICC: Spherical=512.9, Exponential=521.9, Gaussian=530.9,
#' Incomplete block=588.8, Complete block=597.9.
#'
#' @note
#' \strong{Dataset note:} \code{DataSet18.1} is reconstructed from the
#' published design description: 48 treatments, 12×12 grid (144 plots),
#' 3 complete blocks (cols 1-4, 5-8, 9-12).  Synthetic yields are generated
#' from treatment means + block effects + approximate spherical spatial error.
#' The actual data appear in the SAS Data and Program Library as Data Set 18.1
#' (SAS names \code{ch15_ex1} / \code{asademo}).  Published AICC values and
#' spatial range estimates will not be reproduced exactly.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#'     Applications}. CRC Press. Section 18.3, pp.563–573.
#'   \item Pinheiro, J., & Bates, D. (2000).
#'     \emph{Mixed-Effects Models in S and S-PLUS}. Springer.
#' }
#'
#' @seealso \code{\link{DataSet18.1}}
#'
#' @examples
#' data(DataSet18.1)
#'
#' ## -------------------------------------------------------
#' ## 1. Baseline: complete block model (no spatial covariance)
#' ## -------------------------------------------------------
#' fit_rcb <- stats::lm(y ~ trt + block, data = DataSet18.1)
#' cat("RCB AIC:", stats::AIC(fit_rcb), "\n")
#'
#' ## -------------------------------------------------------
#' ## 2. Spatial models via nlme::gls
#' ## -------------------------------------------------------
#'
#' ## Spherical covariance (SP(SPH) — best model in book)
#' fit_sph <- nlme::gls(
#'   model       = y ~ trt + block,
#'   correlation = nlme::corSpher(
#'     form   = ~ row + col,
#'     nugget = FALSE
#'   ),
#'   data   = DataSet18.1,
#'   method = "REML"
#' )
#' summary(fit_sph)
#'
#' ## Exponential covariance
#' fit_exp <- nlme::gls(
#'   model       = y ~ trt + block,
#'   correlation = nlme::corExp(
#'     form   = ~ row + col,
#'     nugget = FALSE
#'   ),
#'   data   = DataSet18.1,
#'   method = "REML"
#' )
#'
#' ## Gaussian covariance
#' fit_gau <- nlme::gls(
#'   model       = y ~ trt + block,
#'   correlation = nlme::corGaus(
#'     form   = ~ row + col,
#'     nugget = FALSE
#'   ),
#'   data   = DataSet18.1,
#'   method = "REML"
#' )
#'
#' ## AICC comparison (smallest = best)
#' stats::AIC(fit_rcb, fit_sph, fit_exp, fit_gau)
#'
#' ## -------------------------------------------------------
#' ## 3. Estimated range and sill from best model
#' ## -------------------------------------------------------
#' tryCatch(
#'   nlme::intervals(fit_sph, which = "var-cov"),
#'   error = function(e) {
#'     cat("Intervals not available:", conditionMessage(e), "\n")
#'     cat("Range estimate:\n")
#'     print(stats::coef(fit_sph$modelStruct$corStruct, unconstrained = FALSE))
#'   }
#' )
#'
#' ## -------------------------------------------------------
#' ## 4. Spatial treatment means
#' ## -------------------------------------------------------
#' emm_sp <- emmeans::emmeans(fit_sph, ~ trt)
#' ## Top 10 treatment means (sorted)
#' head(as.data.frame(emm_sp)[order(-as.data.frame(emm_sp)$emmean), ], 10)
#'
#' ## -------------------------------------------------------
#' ## 5. Empirical variogram
#' ## -------------------------------------------------------
#' vario <- nlme::Variogram(fit_sph, form = ~ row + col, resType = "normalized")
#' plot(vario, smooth = TRUE)
NULL
