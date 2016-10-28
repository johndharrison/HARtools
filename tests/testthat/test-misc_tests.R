context("misctests")

test_that("canPrintHar", {
  expect_output(
    print(
      readHAR(system.file(package = "HARtools",
                          "exdata",
                          "google.com.har"))
    )
  )
})

test_that("canPrintHarNoPageRef", {
  har <- jsonlite::fromJSON(system.file(package = "HARtools",
                                        "exdata",
                                        "google.com.har"),
                            simplifyVector = FALSE)
  har[["log"]][["entries"]] <-
    lapply(har[["log"]][["entries"]],
           function(x){x[["pageref"]] <- NULL; x})
  expect_output(print(readHAR(har)))
})

test_that("canPrintHarPageLongEntries", {
  har <- jsonlite::fromJSON(system.file(package = "HARtools",
                                        "exdata",
                                        "softwareishard.com.har"),
                            simplifyVector = FALSE)
  expect_output(print(readHAR(har)))
})
