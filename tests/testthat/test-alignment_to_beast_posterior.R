context("alignment_to_beast_posterior")

test_that("alignment_to_beast_posterior: basic", {
  base_filename <- "test-alignment_to_beast_posterior"

  beast_log_filename <- paste0(base_filename, ".log")
  beast_trees_filename <- paste0(base_filename, ".trees")
  beast_state_filename <- paste0(base_filename, ".xml.state")

  # Pre cleaning up
  if (file.exists(beast_log_filename)) {
    file.remove(beast_log_filename)
  }
  if (file.exists(beast_trees_filename)) {
    file.remove(beast_trees_filename)
  }
  if (file.exists(beast_state_filename)) {
    file.remove(beast_state_filename)
  }

  alignment <- convert_phylogeny_to_alignment(
    phylogeny = ape::rcoal(5),
    sequence_length = 10,
    mutation_rate = 1
  )
  beast_jar_path <- find_beast_jar_path()
  expect_true(file.exists(beast_jar_path))

  posterior <- alignment_to_beast_posterior(
    alignment = alignment,
    nspp = 2,
    base_filename = base_filename,
    rng_seed = 42,
    beast_jar_path = beast_jar_path
  )

  expect_true(RBeast::is_posterior(posterior))
  expect_true(RBeast::is_trees_posterior(posterior$trees))
})

test_that("alignment_to_beast_posterior: abuse", {

  alignment <- convert_phylogeny_to_alignment(
    phylogeny = ape::rcoal(5),
    sequence_length = 10,
    mutation_rate = 1
  )

  # Will never be created
  base_filename <- "test-alignment_to_beast_posterior"

  expect_error(
    alignment_to_beast_posterior(
      alignment = "not an alignment",
      nspp = 2,
      base_filename = base_filename,
      rng_seed = 42,
      beast_jar_path = find_beast_jar_path()
    ),
    "alignment must be an alignment"
  )

  expect_error(
    alignment_to_beast_posterior(
      alignment = alignment,
      nspp = 3.14, # Not a whole number
      base_filename = base_filename,
      rng_seed = 42,
      beast_jar_path = find_beast_jar_path()
    ),
    "nspp must be a whole number"
  )

  expect_error(
    alignment_to_beast_posterior(
      alignment = alignment,
      nspp = -10000, # Not a positive non-zero value
      base_filename = base_filename,
      rng_seed = 42,
      beast_jar_path = find_beast_jar_path()
    ),
    "nspp must non-zero and positive"
  )
  expect_error(
    alignment_to_beast_posterior(
      alignment = alignment,
      nspp = 2,
      base_filename = c(1, 2, 3), # Not a character string
      rng_seed = 42,
      beast_jar_path = find_beast_jar_path()
    ),
    "base_filename must be a character string"
  )
  expect_error(
    alignment_to_beast_posterior(
      alignment = alignment,
      nspp = 2,
      base_filename = base_filename,
      rng_seed = 3.14,   # Not a whole number
      beast_jar_path = find_beast_jar_path()
    ),
    "rng_seed must be a whole number"
  )
  expect_error(
    alignment_to_beast_posterior(
      alignment = alignment,
      nspp = 2,
      base_filename = base_filename,
      rng_seed = 42,
      beast_jar_path = c(1, 2, 3) # Not NULL nor a character string
    ),
    "beast_jar_path must be NULL or a character string" # nolint sometimes error messages are long
  )
  expect_error(
    alignment_to_beast_posterior(
      alignment = alignment,
      nspp = 2,
      base_filename = base_filename,
      rng_seed = 42,
      beast_jar_path = "invalid/path_too"
    ),
    "beast_jar_path not found" # nolint sometimes error messages are long
  )
})
