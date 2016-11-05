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
  }else if(is_url(x) || is_file(x)){
    TRUE
  }else{
    FALSE
  }
}

assertthat::on_failure(is_list_URL_file) <- function(call, env) {
  paste0(deparse(call$x), " is not a list, URL or file")
}

is_list_URL_file_string <- function(x){
  is_list_URL_file(x) || is_string(x)
}

assertthat::on_failure(is_list_URL_file_string) <- function(call, env) {
  paste0(deparse(call$x), " is not a string, list, URL or file")
}

is_list_HAR <- function(x){
  is.list(x) && identical(names(x), "log")
}

assertthat::on_failure(is_list_HAR) <- function(call, env) {
  paste0(deparse(call$x), " does not look like a HAR list/object")
}

contains_required <- function(x, required){
  # see https://github.com/ahmadnassri/har-spec/blob/master/versions/1.3.md
  is.list(x) && (required %in% names(x))
}

assertthat::on_failure(contains_required) <- function(call, env) {
  required <- eval(call$required, env)
  paste0(deparse(call$x),
         " does not have one of ",
         paste(required, collapse = ","),
         " as required by specification."
  )
}

fields_valid <- function(x,valid_fields){
  # see https://github.com/ahmadnassri/har-spec/blob/master/versions/1.3.md
  # custome fields starting with underscore are allowed in spec
  test_names <- grep("^_.*", names(x), value = TRUE, invert = TRUE)
  field_test <- identical(sum(!(test_names %in% valid_fields)), 0L)
  is.list(x) && field_test
}

assertthat::on_failure(fields_valid) <- function(call, env) {
  valid_fields<- eval(call$valid_fields, env)
  paste0(deparse(call$x),
         " has an invalid field:  ",
         paste(valid_fields, collapse = ","),
         " allowed by specification."
  )
}

is_HAR <- function(x){
  inherits(x, "har")
}

assertthat::on_failure(is_HAR) <- function(call, env) {
  paste0(deparse(call$x), " does not appear to be a 'har' object")
}

is_logical <- function(x){
  is.logical(x)
}

assertthat::on_failure(is_logical) <- function(call, env) {
  paste0(deparse(call$x), " should be a logical value.")
}

is_writeable_path <- function(x){
  is_string(x) && file.access(dirname(x), 2) == 0L &&
    dir.exists(dirname(x))
}

assertthat::on_failure(is_writeable_path) <-  function(call, env) {
  paste0(sub(caArgsReg, "\\1", deparse(call[["x"]])),
         " is not a writeable file/path")
}
