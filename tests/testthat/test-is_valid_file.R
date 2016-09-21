context("is_valid_file")

test_that("is_valid_file: use", {
  filename <- find_path("toy_example_1.RDa")
  expect_true(file.exists(filename))
  expect_true(is_valid_file(filename))
})

test_that("is_valid_file: abuse", {

  expect_false(
    is_valid_file(filename = "inva.lid")
  )
  # Rest is a lot of work to check

  filename <- "test-is_valid_file.RDa"
  saveRDS("I am not a list", file = filename)
  expect_false(
    is_valid_file(filename = filename)
  )
  df <- list()
  saveRDS(df, file = filename)
  expect_false(
    is_valid_file(filename = filename)
  )
  df$parameters <- list()
  saveRDS(df, file = filename)
  expect_false(
    is_valid_file(filename = filename)
  )
  df$pbd_output <- list()
  saveRDS(df, file = filename)
  expect_false(
    is_valid_file(filename = filename)
  )
  df$species_trees <- list()
  saveRDS(df, file = filename)
  expect_false(
    is_valid_file(filename = filename)
  )
  df$alignments <- list()
  saveRDS(df, file = filename)
  expect_false(
    is_valid_file(filename = filename)
  )
  df$posteriors <- list()
  saveRDS(df, file = filename)

  # Should become: expect_false, no idea why this fails yet
  expect_false(
    is_valid_file(filename = filename)
  )

  file.remove(filename)
})
