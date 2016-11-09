#' Read HAR objects
#'
#' @param har a string, list/URL or file containing JSON HAR data
#' @param ... addtional arguments
#'
#' @return returns a parsed HAR object
#' @export
#'
#' @examples
#' har <- readHAR(system.file(package = "HARtools",
#'                         "exdata", "google.com.har"))

readHAR <- function(har, ...){
  assert_that(is_list_URL_file_string(har))
  if(is.list(har)){
    return(readHARList(har, ...))
  }
  if(is_url(har)){
    return(readHARURL(har, ...))
  }
  if(is_file(har)){
    return(readHARfile(har, ...))
  }
  if(is_string(har)){
    Encoding(har) <- "UTF-8" # as per spec
    chk <- tryCatch({
      fromJSON(har, simplifyVector = FALSE)
    },
    error = function(e){
      if(grepl("lexical error: invalid", e$message)){
        stop("har string does not appear to be valid JSON")
      }else{
        stop(e$message)
      }
    })
    return(readHARList(chk, ...))
  }
}


readHARList <- function(har, ...){
  assert_that(is_list_HAR(har))
  processHAR(har)
}

readHARURL <- function(har, ...){
  harList <- tryCatch({
    fromJSON(har, simplifyVector = FALSE)
  },
  error = function(e){
    if(grepl("lexical error: invalid char in json text.",
             e$message)){
      stop("Could not parse har does not appear to be in JSON format")
    }else{
      stop(e$message)
    }
  }
  )
  readHARList(harList)
}

readHARfile <- readHARURL
