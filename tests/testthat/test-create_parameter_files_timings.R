context("create_parameter_files_timings")

test_that("create_parameter_files_timings works", {
  filenames <- create_parameter_files_timings()

  for (filename in filenames) {
    file.remove(filename)
  }
})
