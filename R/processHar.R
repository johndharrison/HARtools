processHAR <- function(har, ...){
  harLog <- har[["log"]]
  assert_that(
    contains_required(harLog,c("version", "creator", "entries"))
  )
  assert_that(
    fields_valid(harLog, c("version", "creator", "entries",
                           "browser", "pages", "comment"))
  )
  har
}
