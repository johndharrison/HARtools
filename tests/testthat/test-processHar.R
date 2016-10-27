context("processHar")

test_that("harLogWithoutRequiredFieldsGivesError", {
  expect_error(readHAR(list(log = list())),
               paste("version", "creator", "entries", sep = ","))
})

test_that("harLogWithInvalidFieldsGivesError", {
  expect_error(
    readHAR(
      list(
        log = list(
          version = "",
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

test_that("harLogWithInvalidVersionError", {
  expect_error(
    readHAR(
      list(
        log = list(
          version = 1L,
          creator = list(),
          entries = list()
        )
      )
    ),
    "is not a string"
  )
})

test_that("harLogWithInvalidCreatorFieldGivesError", {
  expect_error(
    readHAR(
      list(
        log = list(
          version = "1.2",
          creator = list(name = "aa", version = "ss", someField = ""),
          entries = list()
        )
      )
    ),
    "has an invalid field:"
  )
})

test_that("harLogWithMissingCreatorFieldGivesError", {
  expect_error(
    readHAR(
      list(
        log = list(
          version = "1.2",
          creator = list(version = "ss", comment = ""),
          entries = list()
        )
      )
    ),
    "does not have one of"
  )
})

test_that("harLogWithMissingEntryFieldGivesError", {
  expect_error(
    readHAR(
      list(
        log = list(
          version = "1.2",
          creator = list(name = "aa", version = "ss"),
          entries = list(list())
        )
      )
    ),
    "as required by specification"
  )
})

test_that("harLogWithMissingPageFieldGivesError", {
  expect_error(
    readHAR(
      list(
        log = list(
          version = "1.2",
          creator = list(name = "aa", version = "ss"),
          entries = list(),
          pages = list(list())
        )
      )
    ),
    "as required by specification"
  )
})
