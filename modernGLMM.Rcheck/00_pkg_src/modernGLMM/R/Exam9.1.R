#' @title Example 9.1 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam9.1
#' @description Exam9.1 Nested factorial structure
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
#'    \code{\link{DataSet9.1}}
#'
#' @import emmeans lmerTest
#' @examples
#'
#' data(DataSet9.1)
#' DataSet9.1$block <- factor(x = DataSet9.1$block)
#' DataSet9.1$set   <- factor(x = DataSet9.1$set)
#' DataSet9.1$trt   <- factor(x = DataSet9.1$trt)
#'
#' ## EMS-correct ANOVA: set tested against block(set) error (8 df),
#' ## trt(set) tested against within-block residual (16 df).
#' ## Reproduces SAS GLIMMIX exactly: set F(1,8)=0.04, trt(set) F(4,16)=4.91.
#' ## The lmerTest KR approach gives the wrong denominator df for set
#' ## (11.67 instead of 8) due to rank-deficient fixed-effects parameterisation
#' ## when treatments are fully nested within sets.
#' Exam9.1Aov <- stats::aov(
#'   y ~ set + trt %in% set + Error(block),
#'   data = DataSet9.1
#' )
#' print(summary(Exam9.1Aov))
#'
#' ## Mixed model for LS means and contrasts.
#' ## Fixed effects are rank-deficient (set is a linear combination of set:trt
#' ## columns); emmeans resolves estimability and produces correct LS means.
#' Exam9.1Lmer <- lmerTest::lmer(
#'   y ~ set + set:trt + (1 | block),
#'   data = DataSet9.1
#' )
#'
#' emm91 <- emmeans::emmeans(object = Exam9.1Lmer, specs = ~trt | set)
#' print(emm91)
#' emmeans::contrast(emm91, method = "pairwise", by = "set")
#'
NULL
