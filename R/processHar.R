processHAR <- function(har, ...){
  harLog <- har[["log"]]
  assert_that(contains_required_HARlog(harLog))
  har
}
