context("processHar")

test_that("harLogWithoutRequiredFieldsGivesError", {
  expect_error(readHAR(list(log = list())),
               paste("version", "creator", "entries", sep = ","))
})

test_that("harLogWithinvalidFieldsGivesError", {
  expect_error(
    readHAR(
      list(
        log = list(
          version = list(),
          creator = list(),
          entries = list(),
          somefield = list()
        )
      )
    ),
    paste("version", "creator", "entries",
          "browser", "pages", "comment", sep = ",")
  )
})
