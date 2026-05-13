#' @title Example 2.B.1 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam2.B.1
#' @description Exam2.B.1 is used to visualize the effect of lm model statement with Gaussian data and their design matrix
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
#'    \code{\link{Table1.1}}
#'
#' @import parameters
#' @importFrom stats lm summary.lm
#'
#' @examples
#' #-----------------------------------------------------------------------------------
#' ## Linear Model  discussed in Example 2.B.1 using simple regression data of Table1.1
#' #-----------------------------------------------------------------------------------
#'
#' data(Table1.1)
#'
#' Exam2.B.1.lm1 <- lm(formula = y~x, data = Table1.1)
#' summary(Exam2.B.1.lm1)
#' parameters::model_parameters(Exam2.B.1.lm1)
#'
#' DesignMatrix.lm1 <- model.matrix (object = Exam2.B.1.lm1)
#' DesignMatrix.lm1
#'
NULL
