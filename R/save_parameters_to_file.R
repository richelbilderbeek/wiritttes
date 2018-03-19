#' Creates a valid parameter file
#' @param rng_seed the random number generator seed
#' @param sirg the species initiation rate of the good species
#' @param siri the speciation-initiation rate of the incipient species
#' @param scr the rate at which incipient species become good
#' @param erg the rate at which good species get extinct
#' @param eri the rate at which incipient species get extinct
#' @param age crown age of the phylogeny
#' @param mutation_rate the probability per nucleotide to
#'   mutate at a DNA replication
#' @param n_alignments the number of alignments simulated per species tree
#' @param sequence_length the simulated DNA sequence length in nucleotides
#' @param nspp the number of states in the MCMC chain that BEAST2 will run
#' @param n_beast_runs the number of BEAST2 runs per DNA alignments
#' @param filename the name of the parameter file that will be created
#'   by this function
#' @param fixed_crown_age the crown age is fixed (for TRUE) or estimated
#'   with lambda and mu (for FALSE)
#' @return Nothing, it will create a file with filename `filename`
#' @examples
#' filename <- "save_parameters_to_file_example.RDa"
#' save_parameters_to_file(
#'   rng_seed = 42,
#'   sirg = 0.5,
#'   siri = 0.5,
#'   scr = 0.5,
#'   erg = 0.5,
#'   eri = 0.5,
#'   age = 5,
#'   mutation_rate = 0.1,
#'   n_alignments = 1,
#'   sequence_length = 2,
#'   nspp = 10,
#'   n_beast_runs = 1,
#'   filename = filename
#' )
#' testit::assert(is_valid_file(filename))
#' @export
#' @author Richel Bilderbeek
save_parameters_to_file <- function(
  rng_seed,
  sirg,
  siri,
  scr,
  erg,
  eri,
  age,
  mutation_rate,
  n_alignments,
  sequence_length,
  nspp,
  n_beast_runs,
  filename,
  fixed_crown_age = FALSE
) {
  if (!is.numeric(rng_seed)) {
    stop("rng_seed must be a whole number")
  }
  if (!is.logical(fixed_crown_age)) {
    stop("fixed_crown_age must be a TRUE or FALSE")
  }
  my_table <- data.frame(row.names = c("Description", "Value"))
  my_table[, "rng_seed"] <- c(
    "Random number generate seed", rng_seed
  )
  my_table[, "sirg"] <- c(
    "species initiation rate good species", sirg
  )
  my_table[, "siri"] <- c(
    "species initiation rate incipient species", siri
  )
  my_table[, "scr"] <- c(
    "speciation_completion_rate", scr
  )
  my_table[, "erg"] <- c(
    "extinction_rate_good_species", erg
  )
  my_table[, "eri"] <- c(
    "extinction_rate_incipient_species", eri
  )
  my_table[, "age"] <- c(
    "Phylogenetic tree crown age", age
  )
  my_table[, "mutation_rate"] <- c(
    "DNA mutation rate", mutation_rate
  )
  my_table[, "n_alignments"] <- c(
    "Number of DNA alignments per species tree", n_alignments
  )
  my_table[, "sequence_length"] <- c(
    "DNA sequence length", sequence_length
  )
  my_table[, "nspp"] <- c(
    "Number of states per posterior", nspp
  )
  my_table[, "n_beast_runs"] <- c(
    "Number of BEAST2 runs per alignment", n_beast_runs
  )
  my_table[, "fixed_crown_age"] <- c(
    "Is the crown age fixed yes or no", fixed_crown_age
  )
  # Create the slots for the results
  my_list <- list(
    my_table, #parameters
    NA, # pbd_output
    # species_trees
    rep(x = NA, times = 2),
    # alignments
    rep(x = NA, times = 2 * n_alignments),
    # posteriors
    rep(x = NA, times = 2 * n_alignments * n_beast_runs)
  )
  names(my_list) <- c(
      "parameters", "pbd_output",
      "species_trees", "alignments", "posteriors"
    )
  testit::assert(length(my_list$pbd_output) == 1)
  testit::assert(length(my_list$species_trees) == 2)
  testit::assert(length(my_list$alignments)
    == 2 * n_alignments
  )
  testit::assert(length(my_list$posteriors)
    == 2 * n_alignments * n_beast_runs
  )
  saveRDS(my_list, file = filename)
}
