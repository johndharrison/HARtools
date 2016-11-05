context("parse")

test_that("nonURLFilestringGivesError", {
  expect_error(readHAR("jj"),
               "har string does not appear to be valid JSON")
})

test_that("nonHarListGivesError", {
  expect_error(readHAR(list(2)),
               "har does not look like a HAR list/object")
})

test_that("nonHarURLGivesError", {
  expect_error(readHAR("http://www.google.com/ncr"),
               "Could not parse har does not appear to be in JSON format")
})

test_that("nonHarFileGivesError", {
  expect_error(readHAR(system.file(package = "HARtools", "DESCRIPTION")),
               "Could not parse har does not appear to be in JSON format")
})

test_that("fileGivesfromJSONOtherError", {
  with_mock(
    `jsonlite::fromJSON` = function(txt, ...) stop("test this message"),
    expect_error(
      readHAR(system.file(package = "HARtools", "DESCRIPTION")),
      "test this message"
    )
  )
})

test_that("canParseHARUrl", {
  expect_silent(
    readHAR("http://www.janodvarko.cz/har/viewer/examples/google.com.har")
  )
})

test_that("canParseHARFile", {
  expect_silent(
    readHAR(system.file(package = "HARtools", "exdata", "google.com.har"))
  )
})

test_that("canParseHARList", {
  har <- jsonlite::fromJSON(system.file(package = "HARtools",
                                        "exdata", "google.com.har"),
                            simplifyVector = FALSE)
  expect_silent(readHAR(har))
})

test_that("canParseHARString", {
  fileName <- system.file(package = "HARtools", "exdata", "google.com.har")
  har <- readChar(fileName, file.info(fileName)$size)
  expect_silent(readHAR(har))
})
