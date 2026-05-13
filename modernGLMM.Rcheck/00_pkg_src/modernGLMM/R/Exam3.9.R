#' @title Example 3.9 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)
#' @name   Exam3.9
#' @description Exam3.9 used to differentiate conditional and marginal binomial models with and without interaction for S2 variable.
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
#'    \code{\link{DataSet3.2}}
#'
#' @import parameters
#' @import emmeans
#' @importFrom MASS glmmPQL
#' @importFrom nlme lme
#'
#' @examples
#' #-----------------------------------------------------------------------------------
#' ## Binomial conditional GLMM without interaction, logit link
#' #-----------------------------------------------------------------------------------
#' data(DataSet3.2)
#' DataSet3.2$trt <- factor( x  =  DataSet3.2$trt )
#' DataSet3.2$loc <- factor( x  =  DataSet3.2$loc )
#'
#' Exam3.9.fm1   <-
#'   lme4::glmer(
#'       formula = cbind(S2, Nbin - S2) ~ trt + (1 | loc)
#'     , family  = stats::binomial(link = "logit")
#'     , data    = DataSet3.2
#'     , nAGQ    = 10
#'   )
#' summary(Exam3.9.fm1)
#' if (requireNamespace("parameters", quietly = TRUE)) {
#'   parameters::model_parameters(Exam3.9.fm1)
#' }
#'
#' #-------------------------------------------------------------
#' ##  treatment means
#' #-------------------------------------------------------------
#' emmeans::emmeans(object = Exam3.9.fm1, specs = ~trt, type = "response")
#' emmeans::emmeans(object = Exam3.9.fm1, specs = ~trt, type = "link")
#'
#' ##--- Normal Approximation
#' Exam3.9fm2 <-
#'   nlme::lme(
#'       fixed       = S2/Nbin~trt
#'     , data        = DataSet3.2
#'     , random      = ~1|loc
#'     , method      = c("REML", "ML")[1]
#'   )
#'
#' Exam3.9fm2
#' if (requireNamespace("parameters", quietly = TRUE)) {
#'   parameters::model_parameters(Exam3.9fm2)
#' }
#'
#' emmeans::emmeans(object  = Exam3.9fm2, specs = ~trt)
#'
#'
#' ##---Binomial GLMM with interaction
#' Exam3.9fm3   <-
#'   lme4::glmer(
#'       formula = cbind(S2, Nbin - S2) ~ trt + (1 | loc) + (1 | loc:trt)
#'     , family  = stats::binomial(link = "logit")
#'     , data    = DataSet3.2
#'     , nAGQ    = 0
#'     , control = lme4::glmerControl(optimizer = "bobyqa")
#'   )
#' summary(Exam3.9fm3)
#' if (requireNamespace("parameters", quietly = TRUE)) {
#'   parameters::model_parameters(Exam3.9fm3)
#' }
#' emmeans::emmeans(object = Exam3.9fm3, specs = ~trt, type = "response")
#'
#'
#' ##---Binomial Marginal GLMM(assuming compound symmetry)
#' Exam3.9fm4   <-
#'   MASS::glmmPQL(
#'       fixed       =  S2/Nbin~trt
#'     , random      = ~1|loc
#'     , family      =  stats::quasibinomial(link = "logit")
#'     , data        =  DataSet3.2
#'     , correlation =  nlme::corCompSymm(form = ~1|loc)
#'     , niter       = 10
#'     , verbose     = FALSE
#'   )
#' summary(Exam3.9fm4)
#' if (requireNamespace("parameters", quietly = TRUE)) {
#'   parameters::model_parameters(Exam3.9fm4)
#' }
#' emmeans::emmeans(object  = Exam3.9fm4, specs  = ~trt, type = "response")
#'
NULL
