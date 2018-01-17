context("extract_parameters")

test_that("extract_erg: use", {

  file <- read_file(find_path("toy_example_1.RDa"))
  erg <- extract_erg(file)
  expect_true(erg >= 0.0)
})

test_that("extract_erg: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_erg(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$erg <- NULL
  expect_error(
    extract_erg(file),
    "parameter 'erg' absent"
  )

})

test_that("extract_eri", {

  file <- read_file(find_path("toy_example_1.RDa"))
  eri <- extract_eri(file)
  expect_true(eri >= 0.0)
})

test_that("extract_eri: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_eri(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$eri <- NULL
  expect_error(
    extract_eri(file),
    "parameter 'eri' absent"
  )

})

test_that("extract_scr", {

  file <- read_file(find_path("toy_example_1.RDa"))
  scr <- extract_scr(file)
  expect_true(scr >= 0.0)
})

test_that("extract_scr: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_scr(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$scr <- NULL
  expect_error(
    extract_scr(file),
    "parameter 'scr' absent"
  )

})

test_that("extract_sirg", {

  file <- read_file(find_path("toy_example_1.RDa"))
  expect_true("sirg" %in% names(file$parameters))
  expect_false(
    "species_initiation_rate_good_species" %in% names(file$parameters)
  )
  sirg <- extract_sirg(file)
  expect_true(sirg >= 0.0)
})

test_that("extract_sirg: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_sirg(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$sirg <- NULL
  expect_error(
    extract_sirg(file),
    "parameter 'sirg' absent"
  )

})

test_that("extract_siri", {

  file <- read_file(find_path("toy_example_1.RDa"))
  siri <- extract_siri(file)
  expect_true(siri >= 0.0)
})

test_that("extract_siri: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_siri(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$siri <- NULL
  expect_error(
    extract_siri(file),
    "parameter 'siri' absent"
  )

})

test_that("extract_napst", {
  file <- read_file(find_path("toy_example_1.RDa"))
  napst <- extract_napst(file)
  expect_equal(napst, 1)
})

test_that("extract_napst: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_napst(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$n_alignments <- NULL
  expect_error(
    extract_napst(file),
    "parameter 'n_alignments' absent"
  )

})

test_that("extract_nppa: use", {
  file <- read_file(find_path("toy_example_1.RDa"))
  nppa <- extract_nppa(file)
  expect_equal(nppa, 1)
})

test_that("extract_nppa: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_nppa(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$n_beast_runs <- NULL
  expect_error(
    extract_nppa(file),
    "parameter 'n_beast_runs' absent"
  )

})


test_that("extract_nspp: use", {
  file <- read_file(find_path("toy_example_1.RDa"))
  nspp <- extract_nspp(file)
  expect_equal(nspp, 10)
})


test_that("extract_nspp: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_nspp(file),
    "file\\$parameters not found"
  )

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters$mcmc_chainlength <- NULL
  file$parameters$nspp <- NULL
  expect_error(
    extract_nspp(file),
    "parameter 'nspp' absent"
  )

})

test_that("extract_fixed_crown_age returns FALSE per default", {
  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  fixed_crown_age <- wiritttes::extract_fixed_crown_age(file)
  testthat::expect_false(fixed_crown_age)
})

test_that("extract_fixed_crown_age returns TRUE when set", {
  filename <- tempfile("extract_fixed_crown_age_true")
  wiritttes::save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.2,
    siri = 0.2,
    scr = 0.2,
    erg = 0.1,
    eri = 0.1,
    age = 10,
    mutation_rate  = 0.01,
    n_alignments = 1,
    sequence_length = 5,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename,
    fixed_crown_age = TRUE
  )
  fixed_crown_age <- wiritttes::extract_fixed_crown_age(
    wiritttes::read_file(filename = filename))
  testthat::expect_true(fixed_crown_age)
  file.remove(filename)
})



test_that("extract_fixed_crown_age: abuse", {

  file <- read_file(find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  expect_error(
    extract_fixed_crown_age(file),
    "file\\$parameters not found"
  )
})





test_that("extract_age: use", {
  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  age <- wiritttes::extract_age(file)
  testthat::expect_equal(age, 5)
})


test_that("extract_age abuse", {

  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  testthat::expect_error(
    wiritttes::extract_age(file),
    "file\\$parameters not found"
  )

  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  file$parameters$age <- NULL
  testthat::expect_error(
    wiritttes::extract_age(file),
    "parameter 'age' absent"
  )

})

test_that("extract_mutation_rate: use", {
  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  mutation_rate <- wiritttes::extract_mutation_rate(file)
  testthat::expect_equal(mutation_rate, 0.01, tolerance = 0.0001)
})

test_that("extract_mutation_rate abuse", {

  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  testthat::expect_error(
    wiritttes::extract_mutation_rate(file),
    "file\\$parameters not found"
  )

  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  file$parameters$mutation_rate <- NULL
  testthat::expect_error(
    wiritttes::extract_mutation_rate(file),
    "parameter 'mutation_rate' absent"
  )
})


test_that("extract_seed: use", {
  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  seed <- wiritttes::extract_seed(file)
  testthat::expect_equal(seed, 1)
})

test_that("extract_seed abuse", {

  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  testthat::expect_error(
    wiritttes::extract_seed(file),
    "file\\$parameters not found"
  )

  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  file$parameters$rng_seed <- NULL
  testthat::expect_error(
    wiritttes::extract_seed(file),
    "parameter 'rng_seed' absent"
  )
})

test_that("extract_sequence_length: use", {
  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  sequence_length <- wiritttes::extract_sequence_length(file)
  testthat::expect_equal(sequence_length, 1000)
})

test_that("extract_sequence_length abuse", {

  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  file$parameters <- NULL
  testthat::expect_error(
    wiritttes::extract_sequence_length(file),
    "file\\$parameters not found"
  )

  file <- wiritttes::read_file(wiritttes::find_path("toy_example_1.RDa"))
  file$parameters$sequence_length <- NULL
  testthat::expect_error(
    wiritttes::extract_sequence_length(file),
    "parameter 'sequence_length' absent"
  )
})
