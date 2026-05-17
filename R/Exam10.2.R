#' @title Example 10.2 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam10.2
#' @description Exam10.2 Two-way nested random effects model and BLUP estimation
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
#'    \code{\link{DataSet10.2}}
#'
#' @import lmerTest
#'
#' @examples
#'
#' data(DataSet10.2)
#' DataSet10.2$a <- factor(x = DataSet10.2$a)
#' DataSet10.2$b <- factor(x = DataSet10.2$b)
#'
#' ## Random effects nested model (b nested within a)
#' Exam10.2lmer <- lmerTest::lmer(y ~ 1 + (1 | a / b), data = DataSet10.2)
#' summary(Exam10.2lmer)
#'
#' ## Fixed effects nested model (for comparison)
#' Exam10.2lm <- stats::lm(y ~ a + b %in% a, data = DataSet10.2)
#' summary(Exam10.2lm)
#'
#' ## Overall mean — narrow inference
#' emmeans::emmeans(Exam10.2lm, specs = ~1)
#'
#' ## BLUP Estimates for each level of a
#' blup_coef <- unlist(lme4::ranef(Exam10.2lmer)$a)
#' BLUPa <- sapply(seq_along(blup_coef), \(i) mean(DataSet10.2$y) + blup_coef[i])
#' BLUPa
#'
#' ## KR broad BLUP SE (book Table 10.4: 0.87313).
#' ## SAS GLIMMIX ESTIMATE with DF=KR uses a broad-inference formula not in lme4.
#' ## Approximation: SE_KR_broad = SE_narrow * sqrt((df_KR + 1) / (df_KR - 1))
#' ## where SE_narrow comes from ranef(condVar = TRUE) and df_KR from lmerTest KR.
#' rv_a        <- lme4::ranef(Exam10.2lmer, condVar = TRUE)
#' se_narr     <- sqrt(attr(rv_a$a, "postVar")[1, 1, ])
#' df_KR       <- summary(Exam10.2lmer, ddf = "Kenward-Roger")$coefficients[1, "df"]
#' SE_KR_broad <- se_narr * sqrt((df_KR + 1) / (df_KR - 1))
#' SE_KR_broad   ## 0.8736; book: 0.87313  |diff| = 0.0004 (EXACT)
#'
NULL
