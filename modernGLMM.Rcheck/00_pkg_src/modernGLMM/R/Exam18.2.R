#' @title Example 18.2 — Binomial Spatial GLMM: Hessian Fly Trial
#' @name   Exam18.2
#'
#' @description
#' Analysis of Hessian fly resistance data from a 4×4 lattice trial of 16
#' wheat varieties on a 12×12 field grid using binomial spatial GLMMs.
#' Implements Section 18.4 of Stroup et al. (2024), Data Set 18.2.
#' Compares RCB (randomised complete block), incomplete block, and
#' spatial covariance models via AICC.
#'
#' @details
#' For plot \eqn{i,j} with \eqn{n_{ij}} plants, the G-side GLMM with
#' spherical spatial random effects is:
#' \deqn{y_{ij} | b_{ij} \sim \text{Binomial}(n_{ij}, \pi_{ij})}
#' \deqn{\text{logit}(\pi_{ij}) = \eta + \tau_v + b_{ij}}
#' where \eqn{\tau_v} is the variety effect, \eqn{b_{ij}} is the spatial
#' random effect with spherical covariance structure:
#' \deqn{\text{Cov}(b_{ij}, b_{i'j'}) = \sigma^2 \text{sph}(d_{ij,i'j'}/r)}
#'
#' The R-side marginal model replaces the random \eqn{b_{ij}} with a working
#' covariance structure.
#'
#' Published results (2nd ed. pp.573-579):
#' AICC: RCB=317.27, Incomplete block=296.64; F_entry(RCB)=6.81.
#' G-side spherical: SP(SPH)=3.2256, \eqn{\sigma^2}=0.5111, AICC=301.91.
#' R-side marginal spherical: SP(SPH)=3.3257, residual=3.9629.
#'
#' @note
#' \strong{Dataset note:} \code{DataSet18.2} is reconstructed from the
#' published design description: 16 varieties in a 4×4 lattice design (4
#' incomplete blocks of 16 plots each), 64 plots total, binomial response
#' (damaged plants / total plants).  Plot positions are assigned to an
#' 8×8 sub-grid within the 12×12 field.  Synthetic counts are generated
#' from variety effects + lattice block effects + approximate spatial error.
#' The actual data appear in the SAS Data and Program Library as Data Set 18.2
#' (SAS name \code{HessianFly}).  Published AICC values and spatial parameters
#' will not be reproduced exactly.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#'     Applications}. CRC Press. Section 18.4, pp.573–579.
#' }
#'
#' @seealso \code{\link{DataSet18.2}}
#'
#' @examples
#' data(DataSet18.2)
#'
#' ## -------------------------------------------------------
#' ## 1. Exploratory: observed resistance rates by variety
#' ## -------------------------------------------------------
#' with(DataSet18.2, tapply(y / n, variety, mean))
#'
#' ## -------------------------------------------------------
#' ## 2. RCB model (complete block — baseline)
#' ## -------------------------------------------------------
#' fit_rcb <- lme4::glmer(
#'   cbind(y, n - y) ~ variety + (1 | block),
#'   family  = stats::binomial(link = "logit"),
#'   data    = DataSet18.2,
#'   control = lme4::glmerControl(optimizer = "bobyqa")
#' )
#' summary(fit_rcb)
#'
#' ## Type III test for variety (F_entry in book)
#' if (requireNamespace("car", quietly = TRUE)) {
#'   car::Anova(fit_rcb, type = "III")
#' }
#'
#' ## -------------------------------------------------------
#' ## 3. Spatial binomial GLMM via glmmTMB (G-side spherical)
#' ## -------------------------------------------------------
#' if (requireNamespace("glmmTMB", quietly = TRUE)) {
#'
#'   ## Add spatial random effect via pos = numFactor(row, col)
#'   DataSet18.2$pos <- glmmTMB::numFactor(DataSet18.2$row, DataSet18.2$col)
#'
#'   fit_sp <- glmmTMB::glmmTMB(
#'     cbind(y, n - y) ~ variety + (1 | block) +
#'       exp(pos + 0 | block),
#'     family  = stats::binomial(link = "logit"),
#'     data    = DataSet18.2
#'   )
#'   summary(fit_sp)
#'
#'   ## Variety means adjusted for spatial effects
#'   emm_sp <- emmeans::emmeans(fit_sp, ~ variety, type = "response")
#'   print(emm_sp)
#' }
#'
#' ## -------------------------------------------------------
#' ## 4. Incomplete block model (next-best in book)
#' ## -------------------------------------------------------
#' ## Lattice incomplete blocks within rep
#' DataSet18.2$inc_block <- interaction(DataSet18.2$block,
#'                                       ceiling(as.integer(DataSet18.2$variety) / 4))
#' fit_ib <- lme4::glmer(
#'   cbind(y, n - y) ~ variety + (1 | inc_block),
#'   family  = stats::binomial(link = "logit"),
#'   data    = DataSet18.2,
#'   control = lme4::glmerControl(optimizer = "bobyqa")
#' )
#' summary(fit_ib)
#'
#' ## -------------------------------------------------------
#' ## 5. Residual diagnostics
#' ## -------------------------------------------------------
#' if (requireNamespace("DHARMa", quietly = TRUE)) {
#'   sim_r <- DHARMa::simulateResiduals(fit_rcb)
#'   DHARMa::testSpatialAutocorrelation(
#'     sim_r,
#'     x = DataSet18.2$col,
#'     y = DataSet18.2$row
#'   )
#' }
NULL
