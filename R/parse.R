#' Title
#'
#' @param har
#' @param ...
#'
#' @return
#' @export
#'
#' @examples

readHAR <- function(har, ...){
  assert_that(is_list_URL_file(har))
  if(is.list(har)){
    return(readHARList(har, ...))
  }
  if(is_url(har)){
    return(readHARURL(har, ...))
  }
  if(is_file(har)){
    return(readHARfile(har, ...))
  }
}


readHARList <- function(har, ...){
  assert_that(is_list_HAR(har))
  return(har)
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
