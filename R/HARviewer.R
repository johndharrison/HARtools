#' @import htmlwidgets
#' @export

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
  htmltools::tags$div(
    htmltools::tags$select(id="page-selector"),
    htmltools::tags$div(id = id, style = style, class = class)
  )
}
