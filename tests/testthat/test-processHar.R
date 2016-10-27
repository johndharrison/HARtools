context("processHar")

test_that("harLogWithoutRequiredFieldsGivesError", {
  expect_error(readHAR(list(log = list())),
               paste("version", "creator", "entries", sep = ","))
})
