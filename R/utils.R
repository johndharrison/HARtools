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
  # check for pageref
  pageRefs <-
    vapply(x, function(y){
      ifelse(is.null(y[["pageref"]]), NA_character_, y[["pageref"]])
    },
    character(1)
    )
  if(any(is.na(pageRefs))){
    printGroups <- headtail(seq(x), 5)
    dum <- lapply(seq(printGroups), function(printno){
      if(printno > 1) cat("     ........", "\n")
      lapply(x[printGroups[[printno]]],
             function(y) print(y[["request"]]))
    })
  }else{
    pR <- split(x, pageRefs)
    dum <- lapply(names(pR), function(pr){
      cat("Page:", pr, "\n")
      cat("Number of entries:", length(pR[[pr]]), "\n")
      printGroups <- headtail(seq(pR[[pr]]), 5)
      lapply(seq(printGroups), function(printno){
        if(printno > 1) cat("     ........", "\n")
        lapply(pR[[pr]][printGroups[[printno]]],
               function(y) print(y[["request"]]))
      })
    })
  }
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

headtail <- function(x, n){
  if(length(x) > 2*n){
    list(head(x, n), tail(x, n))
  }else{
    list(seq(x))
  }
}
