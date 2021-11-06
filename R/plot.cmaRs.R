#' A plot function designed for prediction of CMARS 
#'
#' This function allows you to construct three different plots, 
#' namely actual versus predicted response; 
#' fitted values versus standardized residuals; 
#' and standardized residuals versus order if the model is 
#' constructed for prediction purpose.
#' @param x A cmaRs object which is obtained by prediction.
#' @param ... Additional parameters.
#' @importFrom stats model.response
#' @return An S3 model of class "plot.cmaRs"
#' @export
#' @examples
#' \dontrun{
#' # Without \code{MOSEK}, the example code is not executable.
#' # For installation of Mosek, plese see the documentation of 'Rmosek'.
#' data("trees", package = "datasets")
#' model.prediction <- cmaRs(Volume~., degree = 5, nk = 20, data = trees)
#' plot.cmaRs(model.prediction)}
#' @importFrom graphics par
#' @importFrom graphics abline
#' @importFrom graphics text

plot.cmaRs <- function(x, ...)
{
if(x$classification == TRUE){stop("Graphs are designed for prediction!\n")}
fitted.values <- x$fitted.values
actual.values <- x$y
r <- x$r
residuals <- scale(x$residuals, scale = TRUE, center = TRUE)[,1]

oldpar <- par(no.readonly = TRUE)
on.exit(par(oldpar))


all.plots <- par(mfrow = c(3,1))
plot(actual.values, fitted.values, 
  col = "firebrick", main = "Actual versus Predicted Response Values",
  xlab = "Actual Response", ylab = "Predicted Response")
abline(a = 0, b = 1,  col = "gray0")
text(x = min(actual.values) + 0.0001, 
y = max(fitted.values) - ((max(fitted.values) - min(fitted.values))/2), 
bquote(paste(rho(Y, hat(Y))) == .(r)), cex = 1, pos = 4)
plot(fitted.values, residuals,  col = "firebrick", 
main = "Fitted Values versus Standardized Residuals", xlab = "Fitted Values", 
ylab = "Standardized Residuals")
abline(h = 0, col="black")
plot(residuals, type = "o", col = "black", 
main = "Standardized Residuals versus Order", 
xlab = "Observation Order", ylab = "Standardized Residuals")
class(all.plots) <- "plot.cmaRs"
invisible(all.plots)
}
