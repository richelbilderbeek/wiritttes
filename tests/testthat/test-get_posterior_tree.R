context("get_posterior_tree")

test_that("examples", {

  # Read a file with one or more posteriors
  file <- wiritttes::read_file(find_path("toy_example_1.RDa"))
  # Pick the indices of the posterior to extract
  sti  <- 1 # Species tree index
  ai   <- 1 # Alignment index
  pi   <- 1 # Posterior index
  si   <- 1 # Posterior state index
  # Extract the posterior
  tree <- wiritttes::get_posterior_tree(file = file, sti = sti, ai = 1, pi = 1, si = 1)
  # Check that it is indeed a phylogeny
  testthat::expect_true(ribir::is_phylogeny(tree))

})

test_that("abuse", {

  testthat::expect_silent(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = 1,
      ai = 1,
      pi = 1,
      si = 1
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = -1, # error
      ai = 1,
      pi = 1,
      si = 1
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = 3, # error
      ai = 1,
      pi = 1,
      si = 1
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = 1,
      ai = -1, # error
      pi = 1,
      si = 1
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = 1,
      ai = 42, # error
      pi = 1,
      si = 1
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = 1,
      ai = 1,
      pi = -1, # error
      si = 1
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = 1,
      ai = 1,
      pi = 4242, # error
      si = 1
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = 1,
      ai = 1,
      pi = 1,
      si = -1 # error
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = wiritttes::read_file(find_path("toy_example_1.RDa")),
      sti = 1,
      ai = 1,
      pi = 1,
      si = 4242 # error
    )
  )

  testthat::expect_error(
    wiritttes::get_posterior_tree(
      file = "nonsense", # error
      sti = 1,
      ai = 1,
      pi = 1,
      si = 1
    )
  )

})
