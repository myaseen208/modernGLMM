#' @title Data for Example 17.1 — Crossover with ARH(1) Covariance (Chapter 17)
#' @name   DataSet17.1
#' @docType data
#' @keywords datasets
#' @usage data(DataSet17.1)
#'
#' @description
#' Longitudinal data from a two-treatment crossover study with 41 subjects
#' measured at 6 equally-spaced time points per period (2 periods), plus a
#' baseline covariate.  Implements Example 17.3.1 of Stroup et al. (2024),
#' Data Set 17.1 (SAS name \code{x_over_ante1}).  Demonstrates covariance
#' model selection (CS, AR(1), ARH(1)) for repeated measures within a
#' crossover design.
#'
#' \strong{Reconstruction note:} The actual data appear in the SAS Data and
#' Program Library as Data Set 17.1.  This version is reconstructed from the
#' published design description (41 subjects: 17 in sequence 0→1, 24 in
#' sequence 1→0; 2 periods × 6 times; baseline covariate) and published
#' regression contrasts (pp.513-516) using \code{set.seed(2024)}.
#' Published AICC and F-statistics will not be reproduced exactly.
#'
#' @format A \code{data.frame} with 492 rows and 7 variables:
#' \describe{
#'   \item{id}{Subject identifier (factor with 41 levels)}
#'   \item{sequence}{Crossover sequence: \code{"01"} (trt 0 then 1) or
#'     \code{"10"} (trt 1 then 0); 17 and 24 subjects respectively}
#'   \item{period}{Period factor with 2 levels (1, 2)}
#'   \item{trt}{Treatment factor with 2 levels (0, 1)}
#'   \item{t}{Time index within period: 0, 1, 2, 3, 4, 5 (equally spaced)}
#'   \item{baseline}{Subject-level baseline covariate (continuous)}
#'   \item{y}{Continuous Gaussian response}
#' }
#'
#' @details
#' The random coefficient model with ARH(1) within-subject covariance is:
#' \deqn{y_{ijkl} = \beta_{0i} + b_{0ik} + (\beta_{1i} + b_{1ik}) T_j +
#'       \rho_p + \beta_b X_k + e_{ijkl}}
#' where \eqn{b_{0ik}} and \eqn{b_{1ik}} are subject-specific random
#' intercept and slope, \eqn{\rho_p} is the period effect, \eqn{X_k} is
#' the baseline covariate, and \eqn{e_{ijkl}} follows an ARH(1) structure
#' (heterogeneous variances per time point with AR(1) lag-1 correlation).
#'
#' Published results (2nd ed. p.516):
#' Best covariance = ARH(1), AICC=3035.25.
#' Equal intercepts: F(1,526)=1.16, p=0.2818;
#' Equal slopes: F(1,104)=4.18, p=0.0434.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts,
#'     Methods and Applications}. CRC Press. Section 17.3.1, pp.513-516.
#'   \item Verbeke, G., & Molenberghs, G. (2000).
#'     \emph{Linear Mixed Models for Longitudinal Data}. Springer.
#' }
#'
#'
#' @examples
#' data(DataSet17.1)
#' str(DataSet17.1)
#' cat("Subjects per sequence:\n")
#' print(table(unique(DataSet17.1[, c("id", "sequence")])$sequence))
NULL
