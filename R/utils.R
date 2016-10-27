#' @export
print.har <- function(x, ...){
  print(x[["log"]], ...)
}

#' @export
print.harlog <- function(x, ...){
  print(x[["version"]], ...)
  print(x[["creator"]], ...)
  print_if_not_null(x[["browser"]], ...)
  print_if_not_null(x[["pages"]], ...)
  print(x[["entries"]], ...)
}

#' @export
print.harversion <- function(x, ...){
  cat("--------HAR VERSION--------", "\n")
  cat("HAR specification version:", x, "\n")
}

#' @export
print.harcreator <- function(x, ...){
  cat("--------HAR CREATOR--------", "\n")
  cat("Created by:", x[["name"]], "\n")
  cat("version:", x[["version"]], "\n")
}

#' @export
print.harbrowser <- function(x, ...){
  cat("--------HAR BROWSER--------", "\n")
  cat("Browser:", x[["name"]], "\n")
  cat("version:", x[["version"]], "\n")
}

#' @export
print.harpages <- function(x, ...){
  cat("--------HAR PAGES--------", "\n")
  lapply(x, print)
}

#' @export
print.harpage <- function(x, ...){
  cat("Page id:", x[["id"]], ", Page title:", x[["title"]], "\n")
}

#' @export
print.harentries <- function(x, ...){
  cat("--------HAR ENTRIES--------", "\n")
  cat("Number of entries:", length(x), "\n")
  cat("REQUESTS:", "\n")
  lapply(x, function(y) print(y[["request"]]))
}

#' @export
print.harrequest <- function(x, ..., width = getOption("width")){
  reqUrl <- if(nchar(x[["url"]]) > width - 7){
    paste0(substr(x[["url"]], 1, width - 7), "...")
  }else{
    x[["url"]]
  }
  cat("  - ", reqUrl, "\n")
}

assignClass <- function(x, classx){
  if(!inherits(x, classx)){
    class(x) <- c(classx, class(x))
  }
  x
}

print_if_not_null <- function(x, ...){
  if(!is.null(x)) print(x, ...)
}
