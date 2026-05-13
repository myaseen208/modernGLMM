#' @title Example 12.2 — Binomial GLMM: Nested Factorial Design
#' @name   Exam12.2
#'
#' @description
#' Analysis of binomial count data from a nested factorial design (10 blocks,
#' 6 treatments in 2 sets, 3 treatments per set) using a GLMM with binomial
#' response and logit link.  Implements Section 12.3.2 of Stroup et al. (2024),
#' Data Set 12.2.  Random block effects are modelled with a random intercept
#' plus a random set-by-block slope to allow varying set effects across blocks.
#'
#' @details
#' The nested factorial GLMM is:
#' \deqn{\text{logit}(\pi_{ijk}) = \eta + \alpha_i + \beta_{j(i)} + r_{k(i)}}
#' where \eqn{\alpha_i} denotes the set (A) effect, \eqn{\beta_{j(i)}}
#' denotes the treatment B nested within set, and
#' \eqn{r_{k(i)} \sim \mathcal{N}(0,\sigma^2_A)} is the block-within-A
#' random effect (whole-plot error for the nested factorial).  Blocks are
#' nested within A: blocks 1–5 receive setA, blocks 6–10 receive setB.
#'
#' Published results (2nd ed. p.382):
#' \eqn{\hat\sigma^2_A = 0.4784} (SE=0.2664);
#' A: F(1,8)=0.46, p=0.5187; B(A): F(4,16)=2.43, p=0.0907.
#'
#' @note
#' \strong{Dataset note:} \code{DataSet12.2} is reconstructed from the
#' published design description (5 blocks × setA + 5 blocks × setB, 3
#' treatments per block, N=20 per cell, 30 obs total) using the published
#' logit B(A) LSMeans (p.382) and block variance \eqn{\sigma^2_A=0.4784}
#' as generative parameters.  The actual data appear in the SAS Data and
#' Program Library as Data Set 12.2 (SAS name \code{ch11_ex_12C2}).
#' Numerical output will approximate but not exactly reproduce published
#' values.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#'     Applications}. CRC Press. Sections 12.3.2 and 12.4.1, pp.380–393.
#' }
#'
#' @seealso \code{\link{DataSet12.2}}
#'
#' @examples
#' data(DataSet12.2)
#'
#' ## -------------------------------------------------------
#' ## 1. Exploratory: observed proportions by set and treatment
#' ## -------------------------------------------------------
#' with(DataSet12.2, tapply(f / n, list(a, b), mean))
#'
#' ## -------------------------------------------------------
#' ## 2. Binomial GLMM — nested factorial
#' ## Blocks are nested within A: (1 | block) = whole-plot error
#' ## Matches book random a / subject=Block in GLIMMIX
#' ## -------------------------------------------------------
#' fit_lme4 <- lme4::glmer(
#'   cbind(f, n - f) ~ a / b + (1 | block),
#'   family  = stats::binomial(link = "logit"),
#'   data    = DataSet12.2,
#'   control = lme4::glmerControl(optimizer = "bobyqa")
#' )
#' summary(fit_lme4)
#'
#' ## -------------------------------------------------------
#' ## 3. Type III tests for A and B(A)
#' ## -------------------------------------------------------
#' if (requireNamespace("car", quietly = TRUE)) {
#'   car::Anova(fit_lme4, type = "III")
#' }
#'
#' ## -------------------------------------------------------
#' ## 4. Least-squares means for B(A) — treatment within set
#' ## -------------------------------------------------------
#' emm_ba <- emmeans::emmeans(fit_lme4, ~ b | a, type = "response")
#' print(emm_ba)
#' emmeans::contrast(emm_ba, method = "pairwise")
#'
#' ## -------------------------------------------------------
#' ## 5. Probit link (Section 12.4.1)
#' ## -------------------------------------------------------
#' fit_probit <- lme4::glmer(
#'   cbind(f, n - f) ~ a / b + (1 | block),
#'   family  = stats::binomial(link = "probit"),
#'   data    = DataSet12.2,
#'   control = lme4::glmerControl(optimizer = "bobyqa")
#' )
#' summary(fit_probit)
#'
#' ## Compare logit vs probit: F-test for B(A) within A=setA
#' emm_probit <- emmeans::emmeans(fit_probit, ~ b | a, type = "response")
#' print(emm_probit)
#'
#' ## -------------------------------------------------------
#' ## 6. Overdispersion check
#' ## -------------------------------------------------------
#' if (requireNamespace("DHARMa", quietly = TRUE)) {
#'   sim_r <- DHARMa::simulateResiduals(fit_lme4)
#'   DHARMa::testDispersion(sim_r)
#' }
NULL
