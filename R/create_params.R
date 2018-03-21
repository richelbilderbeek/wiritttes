#' Create the parameters
#' @author Richel J.C. Bilderbeek
#' @export
create_params <- function(
  speciation_initiation_rate,
  speciation_completion_rate,
  extinction_rate,
  crown_age,
  crown_age_sigma = 0.01,
  sampling_method,
  mutation_rate,
  sequence_length,
  mcmc_length,
  minimal_ess = 200,
  tree_sim_rng_seed,
  alignment_rng_seed,
  beast2_rnd_seed
) {
  # TODO: Error checking

  list(
    speciation_initiation_rate = speciation_initiation_rate,
    speciation_completion_rate = speciation_completion_rate,
    extinction_rate = extinction_rate,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mutation_rate = mutation_rate,
    sequence_length = sequence_length,
    mcmc_length = mcmc_length,
    minimal_ess = minimal_ess,
    tree_sim_rng_seed = tree_sim_rng_seed,
    alignment_rng_seed = alignment_rng_seed,
    beast2_rnd_seed = beast2_rnd_seed
  )
}