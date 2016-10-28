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
