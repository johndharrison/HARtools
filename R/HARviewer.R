#' View HAR object
#'
#' Create a waterfall view of a HAR object
#' @param har A parsed har object output from \code{\link{readHAR}}
#' @param width Optional width of the HAR viewer
#' @param height Optional height of the HAR viewer
#' @param elementId Optional element id to assign to the HAR viewer
#'
#' @return Returns a \code{\link[htmlwidgets]{createWidget}} object. A
#'    waterfall of the HAR using the
#'    \href{https://github.com/micmro/PerfCascade}{PerfCascade}
#'    JavaScript library.
#' @export
#'
#' @examples
#' \dontrun{
#' har <- readHAR(system.file(package = "HARtools", "exdata",
#'                            "r-project.org.161028_W2_11MA.har"))
#' hv <- HARviewer(har)
#' # view in R
#' hv
#'
#' # save and view
#' tFile <- tempfile(fileext = ".html")
#' htmlwidgets::saveWidget(hv,file = tFile)
#' browseURL(tFile)
#' }

HARviewer <- function(har, width = NULL, height = NULL, elementId = NULL){
  x <- list(
    data = har,
    options = list(
      rowHeight = 23,
      showAlignmentHelpers = TRUE,
      showIndicatorIcons = TRUE,
      leftColumnWith = 25
    )
  )
  htmlwidgets::createWidget("HARviewer", x, width = width, height = height,
                            package = "HARtools", elementId = elementId)
}

HARviewer_html <- function(id, style, class, ...){
  htmltools::renderTags(
    htmltools::tags$div(
      htmltools::tags$select(id="page-selector"),
      htmltools::tags$div(id = id, style = style, class = class)
    )
  )
}

#' Shiny bindings for HARviewer
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'    \code{'400px'}, \code{'auto'}) or a number, which will be coerced to
#'    a string and have \code{'px'} appended. \code{height} will probably
#'    not have an effect; instead, use the \code{height} parameter in
#'    \code{\link{HARviewer}}.
#' @param expr An expression that generates a \code{\link{HARviewer}}
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})?
#'    This is useful if you want to save an expression in a variable.
#'
#' @name HARviewer-shiny
#' @export
#'
#' @examples
#' \dontrun{
#' library(shiny)
#' library(HARtools)
#' har <- readHAR(system.file(package = "HARtools", "exdata",
#'                            "r-project.org.161028_W2_11MA.har"))
#' hv <- HARviewer(har)
#'
#' shinyApp(
#'   ui = fluidPage(
#'     HARviewerOutput("myHAR")
#'   ),
#'   server = function(input, output) {
#'     output$myHAR <- renderHARviewer(hv)
#'   }
#' )
#' }

HARviewerOutput <- function(outputId, width = "100%", height = "400px") {
  shinyWidgetOutput(outputId, "HARviewer", width, height,
                    package = "HARtools")
}

#' @rdname HARviewer-shiny
#' @export

renderHARviewer <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, HARviewerOutput, env, quoted = TRUE)
}
