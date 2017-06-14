context("are_valid_filenames")

test_that("basic use", {

  filenames <- c(
    wiritttes::find_path("toy_example_1.RDa"),
    "inva.lid",
    wiritttes::find_path("toy_example_2.RDa")
  )
  is_valids <- wiritttes::are_valid_files(filenames)
  testthat::expect_true(length(is_valids) == 3)
  testthat::expect_true(is_valids[1] == TRUE)
  testthat::expect_true(is_valids[2] == FALSE)
  testthat::expect_true(is_valids[3] == TRUE)
})
