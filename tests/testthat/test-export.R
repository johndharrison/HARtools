context("export")

test_that("canWriteAHARObject", {
  har1 <- readHAR(system.file(package = "HARtools",
                              "exdata", "google.com.har"))
  harFile <- tempfile(fileext = ".har")
  writeHAR(har1, harFile)
  har2 <- readHAR(harFile)
  expect_identical(har1, har2)
})
