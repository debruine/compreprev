#' Launch Shiny App
#'
#' @param ... arguments to pass to shiny::runApp
#'
#' @export
#'
app <- function(...) {
  appDir <- system.file("app", package = "compreprev")
  if (appDir == "") stop("The shiny app does not exist")
  shiny::runApp(appDir, ...)
}