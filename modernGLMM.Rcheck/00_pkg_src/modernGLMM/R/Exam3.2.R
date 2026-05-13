#' @title Example 3.2 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam3.2
#' @description Exam3.2 used binomial data, two treatment samples
#' @author \enumerate{
#'          \item  Muhammad Yaseen (\email{myaseen208@@gmail.com})
#'          \item Adeela Munawar (\email{adeela.uaf@@gmail.com})
#'          }
#' @references \enumerate{
#' \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'      \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and Applications (2nd ed.)}.
#'        CRC Press.
#'  }
#' @seealso
#'    \code{\link{DataSet3.1}}
#'
#' @import parameters
#' @import emmeans
#' @importFrom stats glm summary.glm
#'
#' @examples
#' #-------------------------------------------------------------
#' ## Linear Model and results discussed in Article 1.2.1 after Table1.1
#' #-------------------------------------------------------------
#' data(DataSet3.1)
#' DataSet3.1$trt <- factor(x = DataSet3.1$trt)
#' Exam3.2.glm <- stats::glm(
#'   formula = cbind(F, N - F) ~ trt,
#'   family  = stats::binomial(link = "logit"),
#'   data    = DataSet3.1
#' )
#' summary(Exam3.2.glm)
#' if (requireNamespace("parameters", quietly = TRUE)) {
#'   parameters::model_parameters(Exam3.2.glm)
#' }
#'
#' #-------------------------------------------------------------
#' ## Individual least squares treatment means
#' #-------------------------------------------------------------
#' emmeans::emmeans(object = Exam3.2.glm, specs = "trt")
#' emmeans::emmeans(object = Exam3.2.glm, specs = "trt", type = "response")
#'
#' #---------------------------------------------------
#' ## Overall mean (equal-weight average of treatment means)
#' #---------------------------------------------------
#' emmeans::emmeans(object = Exam3.2.glm, specs = ~1)
#' emmeans::emmeans(object = Exam3.2.glm, specs = ~1, type = "response")
#'
#' #---------------------------------------------------
#' ## Pairwise treatment means estimate
#' #---------------------------------------------------
#' emmeans::contrast(
#'   emmeans::emmeans(object = Exam3.2.glm, specs = "trt"),
#'   method = "pairwise"
#' )
#' emmeans::contrast(
#'   emmeans::emmeans(object = Exam3.2.glm, specs = "trt", type = "response"),
#'   method = "pairwise"
#' )
NULL
