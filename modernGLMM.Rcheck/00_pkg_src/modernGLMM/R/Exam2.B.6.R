#' @title Example 2.B.6 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam2.B.6
#' @description Exam2.B.6 is related to multi batch regression data assuming different forms of linear models keeping batch effect random.
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
#' @import broom.mixed
#'
#' @examples
#' #-----------------------------------------------------------------------------------
#' ## Nested Model with no intercept
#' #-----------------------------------------------------------------------------------
#'
#' data(Table1.2)
#' Table1.2$Batch <- factor(x = Table1.2$Batch)
#' Exam2.B.6fm1 <- nlme::lme(
#'       fixed       = Y ~ X
#'     , data        = Table1.2
#'     , random      = list(Batch = nlme::pdDiag(~1), X = nlme::pdDiag(~1))
#'     , method      = c("REML", "ML")[1]
#'     )
#' Exam2.B.6fm1
#' broom.mixed::tidy(Exam2.B.6fm1)
NULL


