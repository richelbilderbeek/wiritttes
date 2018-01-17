context("add_posteriors")

test_that("add_posteriors: two posteriors are added", {
  if (!has_beast2()) {
    skip("BEAST2 absent")
  }

  # Must not be a temporary (e.g. 'filename <- tempfile(pattern = "test-add_posteriors_1_", fileext = ".RDa")')
  # else the intermediate BEAST2 files will be deleted in the process
  filename <- "test-add_posteriors_1.RDa"

  wiritttes::save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10, # Needs MCM chain length of 10K
    n_beast_runs = 1,
    filename = filename
  )
  wiritttes::add_pbd_output(filename = filename)
  wiritttes::add_species_trees(filename = filename)
  wiritttes::add_alignments(filename = filename)

  testthat::expect_error(
    wiritttes::get_posterior(
      file = wiritttes::read_file(filename),
      sti = 1, ai = 1, pi = 1
    ),
    "posterior absent at index 1"
  )

  n_posteriors_added <- wiritttes::add_posteriors(filename = filename)

  testthat::expect_equal(n_posteriors_added, 2)

  posterior_1 <- wiritttes::get_posterior_by_index(
    file = read_file(filename),
    i = 1
  )
  posterior_2 <- get_posterior_by_index(
    file = read_file(filename),
    i = 2
  )
  expect_true(beastier::is_posterior(posterior_1))
  expect_true(beastier::is_posterior(posterior_2))

  # Cleaning up
  # Post clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  log_filename <- "add_posteriors.log"
  if (file.exists(log_filename)) {
    file.remove(log_filename)
  }
  expect_false(file.exists(filename))
  expect_false(file.exists(log_filename))
})


test_that("four posteriors are added", {
  if (!has_beast2()) {
    skip("BEAST2 absent")
  }

  filename <- "test-add_posteriors_2.RDa"

  # Pre clean
  if (file.exists(filename)) {
    file.remove(filename)
  }
  expect_false(file.exists(filename))

  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 2,
    filename = filename
  )
  add_pbd_output(filename = filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)

  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 1
    ),
    "posterior absent at index 1"
  )
  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 2
    ),
    "posterior absent at index 2"
  )

  n_posteriors_added <- add_posteriors(
    filename = filename
  )
  expect_equal(n_posteriors_added, 4)

  posterior_1 <- get_posterior_by_index(
    file = read_file(filename),
    i = 1
  )
  posterior_2 <- get_posterior_by_index(
    file = read_file(filename),
    i = 2
  )
  posterior_3 <- get_posterior_by_index(
    file = read_file(filename),
    i = 3
  )
  posterior_4 <- get_posterior_by_index(
    file = read_file(filename),
    i = 4
  )
  expect_true(beastier::is_posterior(posterior_1))
  expect_true(beastier::is_posterior(posterior_2))
  expect_true(beastier::is_posterior(posterior_3))
  expect_true(beastier::is_posterior(posterior_4))

  file.remove(filename)

  expect_false(file.exists(filename))

})

test_that("three posteriors are added, middle is deleted and added again", {

  if (!has_beast2()) {
    skip("BEAST2 absent")
  }

  filename <- "test-add_posteriors_3.RDa"

  # Pre clean
  if (file.exists(filename)) {
    file.remove(filename)
  }

  expect_false(file.exists(filename))

  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 3,
    filename = filename
  )
  add_pbd_output(filename = filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)

  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 1
    ),
    "posterior absent at index 1"
  )
  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 2
    ),
    "posterior absent at index 2"
  )
  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 3
    ),
    "posterior absent at index 3"
  )

  n_posteriors_added <- add_posteriors(
    filename = filename
  )

  expect_equal(n_posteriors_added, 6)

  posterior_1 <- get_posterior_by_index(
    file = read_file(filename),
    i = 1
  )
  posterior_2 <- get_posterior_by_index(
    file = read_file(filename),
    i = 2
  )
  posterior_3 <- get_posterior_by_index(
    file = read_file(filename),
    i = 3
  )

  expect_true(beastier::is_posterior(posterior_1))
  expect_true(beastier::is_posterior(posterior_2))
  expect_true(beastier::is_posterior(posterior_3))

  # Delete middle
  file <- read_file(filename)
  file <- set_posterior_by_index(
    file = file,
    i = 2,
    posterior = NA
  )
  saveRDS(file, file = filename)

  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 1
    )
  )
  expect_error(
    get_posterior_by_index(
      file = read_file(filename),
      i = 2
    ),
    "posterior absent at index 2"
  )
  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 3
    )
  )

  # Add middle again
  n_posteriors_added <- add_posteriors(filename = filename)

  expect_equal(n_posteriors_added, 1)
  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 1
    )
  )
  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 2
    )
  )
  expect_silent(
    get_posterior_by_index(
      file = read_file(filename),
      i = 3
    )
  )

  # Clean up
  expect_true(file.exists(filename))
  file.remove(filename)
  expect_false(file.exists(filename))
})


test_that("add_posteriors: abuse", {

  expect_error(
    add_posteriors(filename = "inva.lid"),
    "invalid filename"
  )
})





test_that(paste("add_posteriors with fixed crown age",
    "should have fixed crown age in posterior"), {
  if (!has_beast2()) {
    skip("BEAST2 absent")
  }

  # Must not be a temporary (e.g. 'filename <- tempfile(pattern = "test-add_posteriors_2_", fileext = ".RDa")')
  # else the intermediate BEAST2 files will be deleted in the process
  filename <- "test-add_posteriors_2.RDa"
  crown_age <- 12.34
  nspp <- 10
  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = crown_age,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = nspp,
    n_beast_runs = 1,
    filename = filename,
    fixed_crown_age = TRUE
  )
  add_pbd_output(filename = filename)
  add_species_trees(filename = filename)
  add_alignments(filename = filename)
  add_posteriors(filename = filename)

  posterior <- wiritttes::get_posterior(
    file = wiritttes::read_file(filename),
    sti = 1, ai = 1, pi = 1)
  crown_age_estimates <- posterior$estimates$TreeHeight
  testthat::expect_equivalent(crown_age_estimates, rep(crown_age, nspp + 1)) # +1, as timestep 0 is already sampled

  file.remove(filename)
})
