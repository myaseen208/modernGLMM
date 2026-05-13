#' @title Example 9.4 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam9.4
#' @description Exam9.4 Multifactor treatment and Multilevel design structures
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
#'    \code{\link{DataSet9.4}}
#'
#' @import emmeans lmerTest
#'
#' @examples
#'
#' data(DataSet9.4)
#' DataSet9.4$block <- factor(x = DataSet9.4$block)
#' DataSet9.4$a <- factor(x = DataSet9.4$a)
#' DataSet9.4$b <- factor(x = DataSet9.4$b)
#'
#' Exam9.4lmer <- lmerTest::lmer(
#'   y ~ a * b + (1|block) + (1|block:a) + (1|block:b),
#'   data = DataSet9.4
#' )
#' stats::anova(Exam9.4lmer, ddf = "Kenward-Roger")
#'
#' emmeans::emmeans(object = Exam9.4lmer, specs = ~a | b)
NULL
