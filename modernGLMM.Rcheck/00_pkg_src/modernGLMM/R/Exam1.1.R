#' @title Example 1.1 — Probability Distribution, LM, and GLM
#' @name   Exam1.1
#' @description
#' Example 1.1 (Stroup et al., 2024) illustrates the difference between fitting
#' a Gaussian linear model and a logistic GLM to binary proportion data.
#' Using Table 1.1 dose–response data, it shows that the logistic GLM provides
#' better fit to bounded proportions than a linear model that can exceed [0,1].
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
#' @seealso \link{Table1.1}
#'
#' @importFrom stats lm glm cor
#' @importFrom ggplot2 ggplot
#'
#' @examples
#' data(Table1.1)
#'
#' ## Linear Model (Section 1.2.3)
#' Exam1.1.lm1 <- stats::lm(formula = y / Nx ~ x, data = Table1.1)
#' summary(Exam1.1.lm1)
#' if (requireNamespace("parameters", quietly = TRUE)) {
#'   parameters::model_parameters(Exam1.1.lm1)
#' }
#'
#' ## GLM with logit link (binomial family, Section 1.2.4)
#' Exam1.1.glm1 <- stats::glm(
#'   formula = cbind(y, Nx - y) ~ x,
#'   family  = stats::binomial(link = "logit"),
#'   data    = Table1.1
#' )
#' summary(Exam1.1.glm1)
#' if (requireNamespace("parameters", quietly = TRUE)) {
#'   parameters::model_parameters(Exam1.1.glm1)
#' }
#'
#' ## Figure 1.1 — LM vs GLM fitted proportions
#' plot_df <- rbind(
#'   data.frame(x = Table1.1$x,
#'              p = Table1.1$y / Table1.1$Nx,
#'              Model = "Observed"),
#'   data.frame(x = Table1.1$x,
#'              p = Exam1.1.lm1$fitted.values,
#'              Model = "LM"),
#'   data.frame(x = Table1.1$x,
#'              p = Exam1.1.glm1$fitted.values,
#'              Model = "GLM (logit)")
#' )
#'
#' ggplot2::ggplot(
#'     plot_df,
#'     ggplot2::aes(x = x, y = p, colour = Model, shape = Model)
#'   ) +
#'   ggplot2::geom_point(size = 2.5) +
#'   ggplot2::geom_line(
#'     data = subset(plot_df, Model != "Observed")
#'   ) +
#'   ggplot2::scale_colour_manual(
#'     values = c("Observed"    = "black",
#'                "LM"          = "#377EB8",
#'                "GLM (logit)" = "#E41A1C")
#'   ) +
#'   ggplot2::labs(
#'     title  = "Example 1.1: Linear Model vs Logistic GLM",
#'     x      = "Dose (x)",
#'     y      = "Proportion (p)",
#'     colour = "Model",
#'     shape  = "Model"
#'   ) +
#'   ggplot2::theme_bw()
#'
#' ## Correlation of fitted values with observed
#' cat("LM  correlation:", round(stats::cor(Table1.1$y / Table1.1$Nx,
#'                                         Exam1.1.lm1$fitted.values), 4), "\n")
#' cat("GLM correlation:", round(stats::cor(Table1.1$y / Table1.1$Nx,
#'                                         Exam1.1.glm1$fitted.values), 4), "\n")
NULL
