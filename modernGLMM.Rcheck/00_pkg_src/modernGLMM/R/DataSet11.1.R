#' Data Set 11.1 - Completely Randomized Count Data
#'
#' @name DataSet11.1
#' @docType data
#' @usage data(DataSet11.1)
#'
#' @description
#' Two-treatment completely randomized count data used in Chapter 11,
#' Section 11.1.2 of Stroup, Ptukhina, and Garai (2024) to compare
#' pre-GLM ANOVA analyses, a Poisson GLM, and a Poisson-normal GLMM with
#' an observation-level random effect.
#'
#' @format A \code{data.frame} with 10 rows and 3 variables:
#' \describe{
#'   \item{trt}{Treatment factor with levels \code{1} and \code{2}.}
#'   \item{unit}{Replication unit within treatment.}
#'   \item{count}{Non-negative integer count response.}
#' }
#'
#' @details
#' The reconstructed counts are \code{2, 2, 3, 5, 12} for treatment 1 and
#' \code{6, 11, 12, 12, 34} for treatment 2.
#'
#' **Data provenance:** Reconstructed.
#'
#' **Reconstruction method:** The integer counts were solved from the
#' published treatment means, log-count means, ANOVA residual mean square,
#' and log-count ANOVA residual mean square in Chapter 11, Section 11.1.2.
#'
#' **Book agreement:** Exact for the published untransformed ANOVA treatment
#' means, F statistic, p-value, log-count treatment means, log-count standard
#' error, and log-count treatment comparison. Approximate for the Poisson-normal
#' GLMM when fitted in R because \pkg{lme4} uses likelihood-based estimation,
#' whereas the book reports SAS PROC GLIMMIX output.
#'
#' **Limitations:** The book references the SAS file \code{Data_Set_11_1},
#' but the raw SAS file is not included in this package or in the uploaded PDF.
#' The reconstruction is therefore based on printed numerical constraints.
#'
#' @references
#' Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#' \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and
#' Applications}, 2nd ed. CRC Press.
#'
#' @seealso \code{\link{Exam11.1}}
#'
#' @examples
#' data(DataSet11.1)
#' stats::aggregate(count ~ trt, data = DataSet11.1, FUN = mean)
NULL
