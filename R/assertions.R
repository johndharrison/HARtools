is_string <- function(x) {
  is.character(x) && length(x) == 1 && !is.na(x)
}

assertthat::on_failure(is_string) <-  function(call, env) {
  paste0(deparse(call$x), " is not a string")
}

is_url <- function(x){
  is_string(x) && grepl("^https?://", x, useBytes=TRUE)
}

assertthat::on_failure(is_url) <-  function(call, env) {
  paste0(deparse(call$x), " is not a url")
}

is_file <- function(x){
  is_string(x) && file.exists(x)
}

assertthat::on_failure(is_file) <-  function(call, env) {
  paste0(deparse(call$x), " is not a file")
}


is_list_URL_file <- function(x){
  if(is.list(x)){
    TRUE
  }else{
    if(is_url(x) || is_file(x)){
      TRUE
    }else{
      FALSE
    }
  }
}

assertthat::on_failure(is_list_URL_file) <- function(call, env) {
  paste0(deparse(call$x), " is not a list, URL or file")
}

is_list_HAR <- function(x){
  is.list(x) && identical(names(x), "log")
}

assertthat::on_failure(is_list_HAR) <- function(call, env) {
  paste0(deparse(call$x), " does not look like a HAR list/object")
}

contains_required_HARlog <- function(x){
  # see https://github.com/ahmadnassri/har-spec/blob/master/versions/1.3.md
  is.list(x) && (c("version", "creator", "entries") %in% names(x))
}

assertthat::on_failure(contains_required_HARlog) <- function(call, env) {
  paste0(deparse(call$x),
         " does not have one of ",
         paste("version", "creator", "entries", sep = ","),
         " as required by specification."
         )
}

