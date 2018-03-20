context("run")

test_that("use", {

  testthat::expect_silent(
    run(
      speciation_initiation_rate = 0.1,
      speciation_completion_rate = 0.2,
      extinction_rate = 0.01,
      crown_age = 15,
      sampling_method = "youngest",
      mutation_rate = 0.1,
      sequence_length = 100,
      mcmc_length = 2000,
      minimal_ess = 1,
      tree_sim_rng_seed = 42,
      alignment_rng_seed = 42,
      beast2_rnd_seed = 42
    )
  )


})
