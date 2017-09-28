context("read_files")

test_that("example", {

  files <- wiritttes::read_files(
    wiritttes::find_paths(c("toy_example_1.RDa", "toy_example_2.RDa")))
  testthat::expect_gt(extract_sirg(files[[1]]), expected = 0.0)
  testthat::expect_gt(extract_siri(files[[2]]), expected = 0.0)

})

test_that("no file causes a stop", {

  testthat::expect_error(
    wiritttes::read_files(NULL)
  )
})
