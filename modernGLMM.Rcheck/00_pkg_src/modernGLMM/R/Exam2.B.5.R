#' @title Example 2.B.5 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam2.B.5
#' @description Exam2.B.5 is related to multi batch regression data assuming different forms of linear models.
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
#'    \code{\link{Table1.2}}
#'
#' @import parameters
#' @importFrom stats lm summary.lm model.matrix
#'
#' @examples
#' #-----------------------------------------------------------------------------------
#' ## Nested Model with no intercept
#' #-----------------------------------------------------------------------------------
#'
#' data(Table1.2)
#' Table1.2$Batch <- factor(x = Table1.2$Batch)
#'
#' Exam2.B.5.lm1 <- lm(formula = Y ~ 0 + Batch + Batch/X, data = Table1.2)
#' DesignMatrix.lm1 <- model.matrix (object = Exam2.B.5.lm1)
#' DesignMatrix.lm1
#'
#' #-----------------------------------------------------------------------------------
#' ## Interaction Model with intercept
#' #-----------------------------------------------------------------------------------
#' Exam2.B.5.lm2 <-lm(formula = Y ~ Batch + X + Batch*X, data  = Table1.2)
#' DesignMatrix.lm2 <-   model.matrix (object = Exam2.B.5.lm2)
#' DesignMatrix.lm2
#'
#' #-----------------------------------------------------------------------------------
#' ## Interaction Model with no intercept
#' #-----------------------------------------------------------------------------------
#' Exam2.B.5.lm3 <- lm(formula = Y ~ 0 + Batch + Batch*X, data = Table1.2)
#' DesignMatrix.lm3 <-   model.matrix(object = Exam2.B.5.lm3)
#' DesignMatrix.lm3
#'
#' #-----------------------------------------------------------------------------------
#' ## Interaction Model with intercept  but omitting X term as main effect
#' #-----------------------------------------------------------------------------------
#' Exam2.B.5.lm4 <- lm(formula = Y ~ Batch + Batch*X, data = Table1.2)
#' DesignMatrix.lm4 <-   model.matrix(object = Exam2.B.5.lm4)
#' DesignMatrix.lm4
#'
NULL
