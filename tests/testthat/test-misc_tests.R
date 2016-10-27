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
