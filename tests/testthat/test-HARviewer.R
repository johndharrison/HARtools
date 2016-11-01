context("HARviewer")

test_that("canCreateaHARviewer", {
  har <- readHAR(system.file(package = "HARtools", "exdata",
                             "r-project.org.161028_W2_11MA.har"))
  hv <- HARviewer(har)
  expect_s3_class(hv, "HARviewer")
})

test_that("canCreateHARviewerOutput", {
  hvOutput <- HARviewerOutput("myHAR")
  expect_s3_class(hvOutput, "shiny.tag.list")
})

test_that("canRenderHARviewer", {
  har <- readHAR(system.file(package = "HARtools", "exdata",
                             "r-project.org.161028_W2_11MA.har"))
  hv <- HARviewer(har)
  rHV <- renderHARviewer(hv)
  expect_s3_class(rHV, "shiny.render.function")
})
