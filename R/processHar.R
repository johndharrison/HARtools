processHAR <- function(har, ...){
  harLog <- har[["log"]]
  assert_that(
    contains_required(harLog, c("version", "creator", "entries"))
  )
  assert_that(
    fields_valid(harLog, c("version", "creator", "entries",
                           "browser", "pages", "comment"))
  )
  har[["log"]] <- processHARLog(har[["log"]], ...)

  assignClass(har, "har")
}

processHARLog <- function(harlog, ...){
  assert_that(is_string(harlog[["version"]]))
  harlog[["version"]] <- processHARVersion(harlog[["version"]])


  assert_that(
    contains_required(harlog[["creator"]], c("name", "version"))
  )
  assert_that(
    fields_valid(harlog[["creator"]], c("name", "version", "comment"))
  )
  harlog[["creator"]] <- processHARCreator(harlog[["creator"]])

  if(!is.null(harlog[["browser"]])){
    assert_that(
      contains_required(harlog[["browser"]], c("name", "version"))
    )
    assert_that(
      fields_valid(harlog[["browser"]], c("name", "version", "comment"))
    )
    harlog[["browser"]] <- processHARBrowser(harlog[["browser"]])
  }

  if(!is.null(harlog[["pages"]])){
    harlog[["pages"]] <- processHARPages(harlog[["pages"]])
  }

  harlog[["entries"]] <- processHAREntries(harlog[["entries"]])
  assignClass(harlog, "harlog")
}

processHARVersion <- function(harversion, ...){
  assignClass(harversion, "harversion")
}

processHARCreator <- function(harcreator, ...){
  assignClass(harcreator, "harcreator")
}

processHARBrowser <- function(harbrowser, ...){
  assignClass(harbrowser, "harbrowser")
}

processHARPages <- function(harpages, ...){
  harpages <- lapply(harpages, function(x){
    assert_that(
      contains_required(x, c("startedDateTime", "id",
                             "title", "pageTimings"))
    )
    assert_that(
      fields_valid(x, c("startedDateTime", "id",
                        "title", "pageTimings", "comment"))
    )
    processHARPage(x)
  }
  )
  assignClass(harpages, "harpages")
}

processHARPage <- function(harpage, ...){
  assignClass(harpage, "harpage")
}

processHAREntries <- function(harentries, ...){
  assignClass(harentries, "harentries")
}

