#' @title Example1.2 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam1.2
#' @description Exam1.2 is used to see types of model effects by plotting regression data
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

#' @importFrom ggplot2 ggplot
#'
#' @examples
#'
#' #-------------------------------------------------------------
#' ## Plot of multi-batch regression data discussed in Article 1.3
#' #-------------------------------------------------------------
#' data(Table1.2)
#'
#' Table1.2$Batch <- factor(x  = Table1.2$Batch)
#'
#' Plot  <-
#'  ggplot2::ggplot(
#'    data = Table1.2,
#'    mapping = ggplot2::aes(y = Y, x = X, colour = Batch, shape = Batch)
#'  ) +
#'  ggplot2::geom_point() +
#'  ggplot2::geom_smooth(method = "lm", fill =  NA) +
#'  ggplot2::labs(title   = "Plot of Multi Batch Regression data") +
#'  ggplot2::theme_bw()
#' Plot
NULL
