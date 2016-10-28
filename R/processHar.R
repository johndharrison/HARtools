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
  harlog[["version"]] <- processHARVersion(harlog[["version"]], ...)


  assert_that(
    contains_required(harlog[["creator"]], c("name", "version"))
  )
  assert_that(
    fields_valid(harlog[["creator"]], c("name", "version", "comment"))
  )
  harlog[["creator"]] <- processHARCreator(harlog[["creator"]], ...)

  if(!is.null(harlog[["browser"]])){
    assert_that(
      contains_required(harlog[["browser"]], c("name", "version"))
    )
    assert_that(
      fields_valid(harlog[["browser"]], c("name", "version", "comment"))
    )
    harlog[["browser"]] <- processHARBrowser(harlog[["browser"]], ...)
  }

  if(!is.null(harlog[["pages"]])){
    harlog[["pages"]] <- processHARPages(harlog[["pages"]], ...)
  }

  harlog[["entries"]] <- processHAREntries(harlog[["entries"]], ...)
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
  harpages <- lapply(harpages, function(harpage){
    assert_that(
      contains_required(harpage, c("startedDateTime", "id",
                             "title", "pageTimings"))
    )
    assert_that(
      fields_valid(harpage, c("startedDateTime", "id",
                        "title", "pageTimings", "comment"))
    )
    processHARPage(harpage, ...)
  }
  )
  assignClass(harpages, "harpages")
}

processHARPage <- function(harpage, ...){
  assignClass(harpage, "harpage")
}

processHAREntries <- function(harentries, ...){
  harentries <- lapply(harentries, function(harentry){
    assert_that(
      contains_required(harentry, c("startedDateTime", "time", "request",
                                    "response", "cache", "timings"))
    )
    assert_that(
      fields_valid(harentry, c("startedDateTime", "time", "request",
                               "response", "cache", "timings", "pageref",
                               "serverIPAddress", "connection", "comment"))
    )
    processHAREntry(harentry, ...)
  }
  )
  assignClass(harentries, "harentries")
}

processHAREntry <- function(harentry, ...){
  #REQUEST
  req <- harentry[["request"]]
  assert_that(
    contains_required(req, c("method", "url", "httpVersion", "cookies",
                             "headers", "queryString",
                             "headersSize", "bodySize"))
  )
  assert_that(
    fields_valid(req, c("method", "url", "httpVersion", "cookies",
                        "headers", "queryString", "headersSize", "bodySize",
                        "postData", "headersCompression", "comment"))
  )
  harentry[["request"]] <- processHARRequest(req, ...)

  #RESPONSE
  res <- harentry[["response"]]
  assert_that(
    contains_required(res, c("status", "statusText", "httpVersion",
                             "cookies", "headers", "content",
                             "redirectURL", "headersSize", "bodySize"))
  )
  assert_that(
    fields_valid(res, c("status", "statusText", "httpVersion",
                        "cookies", "headers", "content",
                        "redirectURL", "headersSize", "bodySize",
                        "headersCompression", "comment"))
  )
  harentry[["response"]] <- processHARResponse(res, ...)

  assignClass(harentry, "harentry")
}

processHARRequest <- function(harrequest, ...){
  assignClass(harrequest, "harrequest")
}

processHARResponse <- function(harresponse, ...){
  assignClass(harresponse, "harresponse")
}

