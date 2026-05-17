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
#' ## Full model matching book specification: (1|block) + (1|block:a) + (1|block:b)
#' ## The block:a VC is at the boundary (= 0) in REML estimation.
#' Exam9.4lmer <- lmerTest::lmer(
#'   y ~ a * b + (1|block) + (1|block:a) + (1|block:b),
#'   data = DataSet9.4
#' )
#' lme4::VarCorr(Exam9.4lmer)
#'
#' ## BOUNDED F statistics (book values: a=4.86, b=17.14, a:b=3.86).
#' ## When block:a VC = 0 at boundary, SAS GLIMMIX effectively removes it from
#' ## the KR denominator df calculation; dropping the term in R matches SAS output.
#' Exam9.4lmer_bounded <- lmerTest::lmer(
#'   y ~ a * b + (1|block) + (1|block:b),
#'   data = DataSet9.4
#' )
#' stats::anova(Exam9.4lmer_bounded, ddf = "Kenward-Roger")
#'
#' ## NOBOUND estimates: SAS GLIMMIX NOBOUND lifts the VC >= 0 constraint,
#' ## yielding block:a VC = -6.595. lme4, nlme, and glmmTMB all enforce VC >= 0
#' ## and cannot reproduce this value; documented as irreducible MISMATCH.
#'
#' emmeans::emmeans(object = Exam9.4lmer_bounded, specs = ~a | b)
NULL
