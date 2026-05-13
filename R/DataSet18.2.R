#' @title Data for Example 18.2 — Hessian Fly Trial: Binomial Spatial (Chapter 18)
#' @name   DataSet18.2
#' @docType data
#' @keywords datasets
#' @usage data(DataSet18.2)
#'
#' @description
#' Binomial resistance data from a 4×4 lattice trial of 16 wheat varieties
#' on a 12×12 field grid, with 64 plots.  Implements Section 18.4 of Stroup
#' et al. (2024), Data Set 18.2 (SAS name \code{HessianFly}).  Demonstrates
#' spatial binomial GLMM analysis with model comparison across RCB, incomplete
#' block, and spatial covariance structures via AICC.
#'
#' \strong{Reconstruction note:} The actual data appear in the SAS Data and
#' Program Library as Data Set 18.2.  This version is reconstructed from the
#' published design description (16 varieties, 4×4 lattice, 4 incomplete
#' blocks, 64 plots, binomial response) and published spatial parameters
#' (SP(SPH)=3.2256, \eqn{\sigma^2}=0.5111, pp.573-579) using
#' \code{set.seed(2024)}.  Published AICC values will not be reproduced exactly.
#'
#' @format A \code{data.frame} with 64 rows and 6 variables:
#' \describe{
#'   \item{block}{Complete block (replicate) factor with 4 levels;
#'     each block contains all 16 varieties}
#'   \item{variety}{Wheat variety factor with 16 levels (v01–v16)}
#'   \item{row}{Plot row position in the 12×12 field grid (integer)}
#'   \item{col}{Plot column position in the 12×12 field grid (integer)}
#'   \item{y}{Number of Hessian fly-damaged plants (integer count)}
#'   \item{n}{Total number of plants per plot (integer)}
#' }
#'
#' @details
#' The G-side binomial GLMM with spherical spatial random effects is:
#' \deqn{y_{ij} | b_{ij} \sim \text{Binomial}(n_{ij}, \pi_{ij})}
#' \deqn{\text{logit}(\pi_{ij}) = \eta + \tau_v + b_{ij}}
#' where \eqn{\tau_v} is the variety fixed effect and \eqn{b_{ij}} is a
#' spatial random effect with spherical covariance structure:
#' \deqn{\text{Cov}(b_{ij}, b_{i'j'}) = \sigma^2 \text{sph}(d_{ij,i'j'}/r)}
#'
#' Published results (2nd ed. pp.573-579):
#' AICC: RCB=317.27, Incomplete block=296.64; F_entry(RCB)=6.81.
#' G-side spherical: SP(SPH)=3.2256, \eqn{\sigma^2}=0.5111, AICC=301.91.
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts,
#'     Methods and Applications}. CRC Press. Section 18.4, pp.573-579.
#' }
#'
#'
#' @examples
#' data(DataSet18.2)
#' str(DataSet18.2)
#' with(DataSet18.2, tapply(y / n, variety, mean))
NULL
