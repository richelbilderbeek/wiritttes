context("has_species_trees")

test_that("has_species_trees use", {

  # Create a parameter file
  filename <- "~/test-has_species_trees"
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
    nspp = 2,
    n_beast_runs = 1,
    filename = filename
  )

  # Simulate an incipient species tree
  add_pbd_output(filename)

  # No species tree added yet
  testthat::expect_true(file.exists(filename))
  testthat::expect_true(!has_species_trees(file = read_file(filename)))

  # Add the species trees
  add_species_trees(filename = filename)

  # Now species tree is added
  testthat::expect_true(has_species_trees(read_file(filename)))

})
