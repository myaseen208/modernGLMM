#' @title Example 8.3 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam8.3
#' @description Exam8.3 explains multifactor models with some factors qualitative and some quantitative(Unequal slopes ANCOVA)
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
#'
#'  @seealso
#'    \code{\link{DataSet8.3}}
#'
#' @import parameters
#' @import emmeans ggplot2
#' @importFrom car Anova
#'
#' @examples
#'
#' data(DataSet8.3)
#'
#' DataSet8.3$trt <- factor(x = DataSet8.3$trt )
#'
#' ##----ANCOVA(Unequal slope Model)
#' Exam9.3fm1 <- aov(formula = y ~ trt*x, data = DataSet8.3)
#' car::Anova( mod = Exam9.3fm1 , type = "III")
#'
#' Plot <-
#'    ggplot2::ggplot(
#'           data    = DataSet8.3
#'         , mapping = ggplot2::aes(x = factor(trt), y = x)
#'          )                              +
#'    ggplot2::geom_boxplot(width = 0.5)  +
#'    ggplot2::coord_flip()               +
#'    ggplot2::geom_point()               +
#'    ggplot2::stat_summary(
#'          fun    = "mean"
#'        , geom   = "point"
#'        , shape  =  23
#'        , size   =  2
#'        , fill   = "red"
#'        )                               +
#'    ggplot2::theme_bw()                 +
#'    ggplot2::ggtitle("Covariate by treatment Box Plot") +
#'    ggplot2::xlab("Treatment")
#' print(Plot)
#'
#' ##----ANCOVA(Unequal slope Model without intercept at page 224)
#' Exam9.3fm2 <- lm(formula = y ~ 0 + trt/x, data = DataSet8.3)
#' summary(Exam9.3fm2)
#' parameters::model_parameters(Exam9.3fm2)
#'
#' ##--Lsmeans treatment at x=7 & 12 at page 225
#' emmeans::emmeans(object = Exam9.3fm2, specs = ~trt|x, at = list(x = c(7, 12)))
#'
NULL
