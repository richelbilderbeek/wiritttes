context("save_parameters_to_file")

test_that("basic use", {
  filename <- "test-save_parameters_to_file.RDa"
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
    sequence_length = 2,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename,
    fixed_crown_age = TRUE
  )
  testthat::expect_true(file.exists(filename))
  testthat::expect_true(wiritttes::is_valid_file(filename))
  file.remove(filename)
  testthat::expect_false(file.exists(filename))
})

test_that("abuse", {
  testthat::expect_silent(
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
      sequence_length = 2,
      nspp = 10,
      n_beast_runs = 1,
      filename = "test-save_parameters_to_file.RDa",
      fixed_crown_age = TRUE
    )
  )
  testthat::expect_error(
    wiritttes::save_parameters_to_file(
      rng_seed = "nonsense",
      sirg = 0.5,
      siri = 0.5,
      scr = 0.5,
      erg = 0.5,
      eri = 0.5,
      age = 5,
      mutation_rate = 0.1,
      n_alignments = 1,
      sequence_length = 2,
      nspp = 10,
      n_beast_runs = 1,
      filename = "test-save_parameters_to_file.RDa",
      fixed_crown_age = TRUE
    )
  )

  testthat::expect_error(
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
      sequence_length = 2,
      nspp = 10,
      n_beast_runs = 1,
      filename = "test-save_parameters_to_file.RDa",
      fixed_crown_age = "nonsense"
    )
  )

})
