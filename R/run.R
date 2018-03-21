#' Run one point of the experiment
#' @param speciation_initiation_rate speciation rate
#'   of good and incipient species,
#'   per lineage probability per time unit
#' @param speciation_completion_rate speciation completion rate (of
#'   incipient species),
#'   per lineage probability per time unit
#' @param extinction_rate extinction rate of good and incipient species,
#'   per lineage probability per time unit
#' @param crown_age crown age, in time units
#' @param crown_age_sigma the standard deviation of MRCA prior's
#'   distribution, in time units
#' @param sampling_method method how the incipient species representing a
#'   species is picked. Must be 'youngest', 'oldest' or 'random'
#' @param mutation_rate per-nucleotide probability to mutate per time unit
#' @param sequence_length length of simulated DNA alignment,
#'   number of base pairs
#' @param mcmc_length length of the MCMC chain,
#'   number of MCMC states
#' @param minimal_ess the minimal Effective Sample Size the posterior
#'   estimate may be. Will stop if the resulting ESS is below this
#'   value
#' @param tree_sim_rng_seed RNG seed used in the creation of the true
#'   phylogenetic tree
#' @param alignment_rng_seed RNG seed used in the creation of the simulated
#'   alignment (from the true phylogenetic tree)
#' @param beast2_rnd_seed RNG seed in the creation of the BEAST2 posterior
#'   (based on the alignment)
#' @param beast_jar_path the path of beast.jar
#' @param verbose set to TRUE for more (debug) output
#' @export
run <- function(
  parameters,
  beast_jar_path = beastier::get_default_beast2_jar_path(),
  verbose = FALSE
) {
  set.seed(parameters$tree_sim_rng_seed)
  pbd_parameters <- c(
    parameters$speciation_initiation_rate,
    parameters$speciation_completion_rate,
    parameters$speciation_initiation_rate,
    parameters$extinction_rate,
    parameters$extinction_rate
  )

  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  pbd_output <- PBD::pbd_sim(
    pbd_parameters,
    age = parameters$crown_age,
    soc = 2, # crown
    plotit = FALSE
  )
  true_phylogeny <- NA
  if (parameters$sampling_method == "youngest") {
    true_phylogeny <- pbd_output$stree_youngest
  } else if (parameters$sampling_method == "oldest") {
    true_phylogeny <- pbd_output$stree_oldest
  } else {
    testit::assert(parameters$sampling_method == "random")
    true_phylogeny <- pbd_output$stree_random
  }
  out <- pirouette::run(
    phylogeny = true_phylogeny,
    sequence_length = parameters$sequence_length,
    mutation_rate = parameters$mutation_rate,
    chain_length = parameters$mcmc_length,
    mrca_distr = beautier::create_normal_distr(
      mean = beautier::create_mean_param(value = parameters$crown_age),
      sigma = beautier::create_sigma_param(value = 0.01)
    ),
    alignment_rng_seed = parameters$alignment_rng_seed,
    beast2_rng_seed = parameters$beast2_rnd_seed,
    verbose = verbose,
    beast_jar_path = beast_jar_path
  )
  out$incipient_tree <- pbd_output$igtree.extant
  out$species_tree <- true_phylogeny
  out
}