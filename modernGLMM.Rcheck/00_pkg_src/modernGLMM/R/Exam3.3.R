#' @title Example 3.3 — RCBD with Estimable Functions
#' @name   Exam3.3
#' @description
#' Example 3.3 (Stroup et al., 2024) demonstrates the use of
#' estimable functions for an RCBD with fixed location effects.
#' Uses \code{DataSet3.2} and illustrates treatment contrast estimation
#' via \pkg{emmeans}.
#'
#' @author
#' \enumerate{
#'   \item Muhammad Yaseen (\email{myaseen208@@gmail.com})
#'   \item Adeela Munawar (\email{adeela.uaf@@gmail.com})
#' }
#'
#' @references
#' \enumerate{
#'   \item Stroup, W. W., Ptukhina, M., and Garai, S. (2024).
#'     \emph{Generalized Linear Mixed Models: Modern Concepts, Methods and Applications (2nd ed.)}.
#'     CRC Press.
#' }
#'
#' @seealso \code{\link{DataSet3.2}}
#'
#' @importFrom stats lm
#'
#' @examples
#' data(DataSet3.2)
#' DataSet3.2$trt <- factor(x = DataSet3.2$trt, levels = c(3, 0, 1, 2))
#' DataSet3.2$loc <- factor(x = DataSet3.2$loc, levels = c(8, 1, 2, 3, 4, 5, 6, 7))
#'
#' ## Linear model
#' Exam3.3.lm1 <- stats::lm(formula = Y ~ trt + loc, data = DataSet3.2)
#' summary(Exam3.3.lm1)
#'
#' if (requireNamespace("emmeans", quietly = TRUE)) {
#'   ## Estimated marginal means for treatment
#'   Lsm3.3 <- emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt)
#'   print(Lsm3.3)
#'
#'   ## Pairwise contrasts
#'   emmeans::contrast(object = Lsm3.3, method = "pairwise")
#'
#'   ## Reverse pairwise contrasts
#'   emmeans::contrast(object = Lsm3.3, method = "revpairwise")
#'
#'   ## LSM Trt0 (Table 3.4, p. 77)
#'   emmeans::contrast(
#'     object = emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(0, 1, 0, 0))
#'   )
#'
#'   ## Trt0 vs Trt1
#'   emmeans::contrast(
#'     emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(0, 1, -1, 0))
#'   )
#'
#'   ## Average Trt0 + Trt1
#'   emmeans::contrast(
#'     emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(0, 1/2, 1/2, 0))
#'   )
#'
#'   ## Average Trt0+2+3
#'   emmeans::contrast(
#'     emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(1/3, 1/3, 0, 1/3))
#'   )
#'
#'   ## Trt2 vs Trt3
#'   emmeans::contrast(
#'     emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(-1, 0, 0, 1))
#'   )
#'
#'   ## Trt1 vs Trt2
#'   emmeans::contrast(
#'     emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(0, 0, 1, -1))
#'   )
#'
#'   ## Trt1 vs Trt3
#'   emmeans::contrast(
#'     emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(-1, 0, 1, 0))
#'   )
#'
#'   ## Average (Trt0+1) vs Average (Trt2+3)
#'   emmeans::contrast(
#'     emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(-1/2, 1/2, 1/2, -1/2))
#'   )
#'
#'   ## Trt1 vs Average (Trt0+1+2)
#'   emmeans::contrast(
#'     emmeans::emmeans(object = Exam3.3.lm1, specs = ~ trt),
#'     list(trt = c(1/3, 1/3, -1, 1/3))
#'   )
#' }
NULL
