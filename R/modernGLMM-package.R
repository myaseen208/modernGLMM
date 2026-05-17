#' @title modernGLMM: Unified R Workflows for Generalized Linear Mixed Models
#'
#' @description
#' `modernGLMM` provides unified, reproducible R implementations of examples
#' from Stroup, W. W., Ptukhina, M., and Garai, S. (2024),
#' \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#' Applications}, second edition, CRC Press.
#'
#' The 2024 book uses SAS for the worked examples and notes that the R GLMM
#' ecosystem is powerful but fragmented. This package responds to that gap by
#' collecting coherent R workflows for the book examples and by documenting how
#' modern R tools fit together for estimation, inference, diagnostics,
#' visualization, and reporting.
#'
#' @section Scope:
#' The package includes datasets, example code, vignettes, and verification
#' artifacts for linear models, generalized linear models, linear mixed models,
#' and generalized linear mixed models. Coverage spans designed experiments,
#' best linear unbiased prediction, treatment structures, multi-level designs,
#' count data, rates and proportions, multinomial responses, time-to-event data,
#' smoothing splines, repeated measures, correlated errors, Bayesian GLMMs, and
#' power analysis.
#'
#' @section R Ecosystem:
#' Workflows use explicit namespaces and draw from the R mixed-model ecosystem:
#' \describe{
#'   \item{\pkg{lme4}}{Linear and generalized linear mixed models.}
#'   \item{\pkg{glmmTMB}}{Flexible GLMMs, including count and zero-inflated models.}
#'   \item{\pkg{nlme}}{Correlated-error and repeated-measures models.}
#'   \item{\pkg{mgcv} and \pkg{gamm4}}{Smoothing splines and additive mixed models.}
#'   \item{\pkg{brms}}{Bayesian GLMM implementations.}
#'   \item{\pkg{survival} and \pkg{coxme}}{Time-to-event and frailty models.}
#'   \item{\pkg{emmeans}}{Estimated marginal means and contrasts.}
#'   \item{\pkg{DHARMa}}{Simulation-based residual diagnostics.}
#'   \item{\pkg{report}}{Readable model summaries.}
#' }
#'
#' @section Workflow Example:
#' \preformatted{
#'
#' data(DataSet11.1)
#' fit <- stats::glm(y ~ trt, family = stats::poisson(link = "log"), data = DataSet11.1)
#' summary(fit)
#'
#' if (requireNamespace("emmeans", quietly = TRUE)) {
#'   emmeans::emmeans(fit, specs = ~ trt, type = "response")
#' }
#'
#' if (requireNamespace("report", quietly = TRUE)) {
#'   report::report(fit)
#' }
#' }
#'
#' @section GLMM Model Framework:
#' A generalized linear mixed model can be written as
#' \deqn{g(\mu_{ij}) = \mathbf{x}_{ij}^\top \boldsymbol{\beta} + \mathbf{z}_{ij}^\top \mathbf{b}_i}
#' with random effects \eqn{\mathbf{b}_i \sim \mathcal{N}(\mathbf{0}, \mathbf{G})}
#' and conditional responses drawn from an exponential-family distribution.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#'     Applications} (2nd ed.). CRC Press.
#'   \item Bates, D., Maechler, M., Bolker, B., and Walker, S. (2015).
#'     Fitting linear mixed-effects models using lme4.
#'     \emph{Journal of Statistical Software}, 67(1), 1-48.
#'   \item Lenth, R. V. (2023). emmeans: Estimated Marginal Means,
#'     aka Least-Squares Means. R package.
#' }
#'
#' @seealso
#' \itemize{
#'   \item \url{https://github.com/myaseen208/modernGLMM}
#' }
#'
#' @author
#' \enumerate{
#'   \item Muhammad Yaseen (\email{myaseen208@@gmail.com})
#'   \item Adeela Munawar (\email{adeela.uaf@@gmail.com})
#'   \item Walter W. Stroup (\email{wstroup@@unl.edu})
#'   \item Marina Ptukhina (\email{ptukhim@@whitman.edu})
#'   \item Soumit Garai
#' }
#'
#' @keywords internal
#' @importFrom collapse fmutate
"_PACKAGE"
