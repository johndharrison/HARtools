library(testthat)
library(HARtools)

if(Sys.getenv("NOT_CRAN") == "true"){
  test_check("HARtools")
}
