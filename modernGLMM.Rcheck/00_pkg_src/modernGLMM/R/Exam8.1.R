#' @title Example 8.1 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam8.1
#' @description Exam8.1 explains multifactor models with all factors qualitative
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
#'  @seealso
#'    \code{\link{DataSet8.1}}
#'
#' @import parameters
#' @import emmeans
#' @importFrom car linearHypothesis
#'
#' @examples
#'
#' data(DataSet8.1)
#'
#' DataSet8.1$a <- factor(x = DataSet8.1$a)
#' DataSet8.1$b <- factor(x = DataSet8.1$b)
#'
#' Exam8.1.lm1 <- stats::lm(formula = y ~ a + b + a*b, data = DataSet8.1)
#' summary(Exam8.1.lm1)
#' parameters::model_parameters(Exam8.1.lm1)
#' stats::anova(Exam8.1.lm1)
#'
#' ##---Simple effects of b within each level of a (SAS SLICE equivalent)
#' emmeans::joint_tests(Exam8.1.lm1, by = "a")
#'
#' ##---Interaction plot
#' emmeans::emmip(
#'   object  = Exam8.1.lm1,
#'   formula = a ~ b,
#'   ylab    = "y LSMeans",
#'   main    = "LSMeans for a*b"
#' )
#'
#' #-------------------------------------------------------------
#' ## Individual least squares treatment means
#' #-------------------------------------------------------------
#' emmeans::emmeans(object = Exam8.1.lm1, specs = ~a*b)
#'
#' ##---Simple effects comparison of interaction by a
#' emmeans::emmeans(object = Exam8.1.lm1, specs = pairwise ~ b|a)$contrasts
#'
#' emm_b_by_a <- emmeans::emmeans(object = Exam8.1.lm1, specs = ~b|a)
#' pairs(emm_b_by_a, simple = "each", combine = TRUE)
#' pairs(emm_b_by_a, simple = "a")
#' pairs(emm_b_by_a, simple = "b")
#' pairs(emm_b_by_a)
#' emmeans::contrast(emmeans::emmeans(object = Exam8.1.lm1, specs = ~b|a))
#' emmeans::emmeans(object = Exam8.1.lm1, specs = pairwise ~ b|a)
#' emmeans::emmeans(object = Exam8.1.lm1, specs = pairwise ~ b|a)$contrasts
#'
#' ##---Alternative method of pairwise comparisons by applying contrast coefficients
#' emmeans::contrast(
#'   emmeans::emmeans(object = Exam8.1.lm1, specs = ~a*b),
#'   list(
#'     c1 = c(1, 0, -1, 0, 0, 0),
#'     c2 = c(1, 0, 0, 0, -1, 0),
#'     c3 = c(0, 0, 1, 0, -1, 0),
#'     c4 = c(0, 1, 0, -1, 0, 0),
#'     c5 = c(0, 1, 0, 0, 0, -1),
#'     c6 = c(0, 1, 0, 0, -1, 0)
#'   )
#' )
#'
#' ##---Nested Model
#' Exam8.1.lm2 <- stats::lm(formula = y ~ a + a %in% b, data = DataSet8.1)
#'
#' summary(Exam8.1.lm2)
#' parameters::model_parameters(Exam8.1.lm2)
#' stats::anova(Exam8.1.lm2)
#'
#' car::linearHypothesis(Exam8.1.lm2, c("a0:b1 = a0:b2"))
#' car::linearHypothesis(Exam8.1.lm2, c("a1:b1 = a1:b2"))
#'
#' ##---Bonferroni's adjusted p-values
#' emmeans::emmeans(
#'   object  = Exam8.1.lm2,
#'   specs   = pairwise ~ b|a,
#'   adjust  = "bonferroni"
#' )$contrasts
#'
#' ##--- Alternative method of pairwise comparisons with Bonferroni adjustment
#' emmeans::contrast(
#'   emmeans::emmeans(object = Exam8.1.lm1, specs = ~a*b),
#'   list(
#'     c1 = c(1, 0, -1, 0, 0, 0),
#'     c2 = c(1, 0, 0, 0, -1, 0),
#'     c3 = c(0, 0, 1, 0, -1, 0),
#'     c4 = c(0, 1, 0, -1, 0, 0),
#'     c5 = c(0, 1, 0, 0, 0, -1),
#'     c6 = c(0, 1, 0, 0, -1, 0)
#'   ),
#'   adjust = "bonferroni"
#' )
#'
#'
NULL
