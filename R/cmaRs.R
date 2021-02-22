#' A cmaRs Function
#'
#' This function allows you to construct a CMARS Model.
#' @param formula A symbolic description of the model to be fitted. 
#' @param degree Maximum degree of interaction (Friedman's mi). 
#' Default is 1, meaning build an additive model (i.e., no interaction terms). 
#' @param nk Maximum number of model terms before pruning,
#' i.e., the maximum number of terms created by the forward pass. 
#' Includes the intercept.
#' @param Auto.linpreds Default is TRUE, 
#' for detailed explanation please check earth package.
#' @param classification Logical: If FALSE, a prediction 
#' model will be constructed.
#' @param data An optional data frame, list or environment 
#' containing the variables in the model.
#' @importFrom stats model.response
#' @importFrom stats model.matrix
#' @return An S3 model of class "cmaRs"
#' @export
#' @examples
#' \dontrun{
#' # Without \code{MOSEK}, the example code is not executable.
#' # For installation of Mosek, plese see the documentation of 'Rmosek'.
#' data("trees", package = "datasets")
#' model.prediction <- cmaRs(Volume~., degree = 5, nk = 20, data = trees)
#' data("etitanic", package = "earth")
#' model.classification <- cmaRs(survived~age, 
#' data = etitanic, classification = TRUE)}




cmaRs <- function(formula, data, classification = FALSE,  
       degree = 1,  nk = 20, Auto.linpreds = FALSE)
{

    mf <- match.call(expand.dots = FALSE)
    m <- match(c("formula", "data"), names(mf), 0L)
    mf <- mf[c(1L, m)]
    mf$drop.unused.levels <- TRUE
    mf[[1L]] <- quote(model.frame)
    mf <- eval(expr = mf, envir = parent.frame())  
    terms <- attr(mf, "terms")
    x <- model.matrix(terms, mf)
    y <- model.response(mf)
    x <- as.data.frame(x)
    c.names <- colnames(x)
    c.names <- c.names[-1]
    x <- as.data.frame(x[, -1])
    colnames(x) <- c.names
      fit <- cmaRs.fit(x, y, degree = degree, nk = nk, 
      classification = classification, data)
    fit$call <- match.call()
    fit$formula <- formula
    fit$terms <- terms
    fit$data <- data
    fit

}

