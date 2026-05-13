#' @title Example 10.4 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam10.4
#' @description Exam10.4 Relationship between BLUP and Fixed Effect Estimators
#' @author \enumerate{
#'          \item  Muhammad Yaseen (\email{myaseen208@@gmail.com})
#'          \item Adeela Munawar (\email{adeela.uaf@@gmail.com})
#'          }
#' @references \enumerate{
#' \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'      \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and Applications (2nd ed.)}.
#'        CRC Press.
#'  }
#'
#' @seealso
#'    \code{\link{DataSet10.4}}
#'
#' @import emmeans lmerTest
#'
#' @examples
#'
#' data(DataSet10.4)
#' DataSet10.4$a <- factor(x = DataSet10.4$a)
#' DataSet10.4$b <- factor(x = DataSet10.4$b)
#'
#' Exam10.4lmer <- lme4::lmer(y ~ a + (1|b) + (1|a:b), data = DataSet10.4)
#' summary(Exam10.4lmer)
#'
#' ## BLUP vs fixed effects comparison
#' emmeans::emmeans(Exam10.4lmer, specs = ~a)
#'
NULL
