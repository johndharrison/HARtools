#' Write HAR object to file
#'
#' @param har A parsed har object output from \code{\link{readHAR}}
#' @param file A string indicating the file name to write the HAR data to.
#' @param force If the file exists overwrite it. Defaults to TRUE
#' @param ... addtional arguments
#'
#' @export
#'
#' @examples
#' \dontrun{
#' har1 <- readHAR(system.file(package = "HARtools",
#'                            "exdata", "google.com.har"))
#' harFile <- tempfile(fileext = ".har")
#' writeHAR(har1, harFile)
#' har2 <- readHAR(harFile)
#' identical(har1, har2)
#' }

writeHAR <- function(har, file, force = TRUE, ...){
  assert_that(is_HAR(har))
  assert_that(is_writeable_path(file))
  assert_that(is_logical(force))
  HARJSON <- toJSON(har, auto_unbox = TRUE)
  if(file.exists(file) || !force){
    stop("file already exists")
  }
  writeLines(HARJSON, file, useBytes = TRUE)
}
