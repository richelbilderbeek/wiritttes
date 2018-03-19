#' Convert an alignment to a BEAST2 XML input file
#' @param alignment The alignment of type DNAbin
#' @param nspp The number of states in the MCMC chain BEAST2 will generate,
#'   typically one state per one thousand moves
#' @param crown_age a positive value if the phylogeny needs a fixed crown
#'   age, NA if the crown age needs to be estimated by BEAST2
#' @param base_filename The base of the filename
#'   (the part without the extension). Must not start with '/tmp/'
#'   (in '/tmp/' the intermediate files are deleted)
#' @param rng_seed The random number generator seed used by BEAST2
#' @param beast_jar_path Where the jar 'beast.jar' can be found
#' @return the phylogenies of the BEAST2 posterior
#' @examples
#'
#'   # Prepare the many filenames
#'   base_filename <- "alignment_to_beast_posterior_example"
#'   beast_log_filename <- paste0(base_filename, ".log")
#'   beast_trees_filename <- paste0(base_filename, ".trees")
#'   beast_state_filename <- paste0(base_filename, ".xml.state")
#'
#'   # Simulate a random phylogeny its alignment
#'   alignment <- convert_phylogeny_to_alignment(
#'     phylogeny = ape::rcoal(5),
#'     sequence_length = 2,
#'     mutation_rate = 1
#'   )
#'
#'   # See if the BEAST2 .jar file is present
#'   beast_jar_path <- find_beast_jar_path()
#'   testit::assert(file.exists(beast_jar_path))
#'
#'   # Run BEAST2 and extract the phylogenies of its posterior
#'   posterior <- alignment_to_beast_posterior(
#'     alignment = alignment,
#'     nspp = 10,
#'     crown_age = 5,
#'     base_filename = base_filename,
#'     rng_seed = 42,
#'     beast_jar_path = beast_jar_path
#'   )
#'
#'   # Check the posterior
#'   testit::assert(tracerer::is_posterior(posterior))
#'   testit::assert(tracerer::is_trees_posterior(posterior$trees))
#'
#' @export
#' @author Richel Bilderbeek
alignment_to_beast_posterior <- function(
  alignment,
  nspp,
  base_filename,
  crown_age = NA,
  rng_seed = 42,
  beast_jar_path = tracererfind_beast_jar_path()
) {
  if (!ribir::is_alignment(alignment)) {
    stop("alignment must be an alignment")
  }
  if (!ribir::is_whole_number(nspp)) {
    stop("nspp must be a whole number")
  }
  if (nspp < 2) {
    stop("nspp must be at least 2")
  }
  if (!is.character(base_filename)) {
    stop("base_filename must be a character string")
  }
  if (!ribir::is_whole_number(rng_seed)) {
    stop("rng_seed must be a whole number")
  }
  if (!is.null(beast_jar_path) && !is.character(beast_jar_path)) {
    stop("beast_jar_path must be NULL or a character string")
  }
  if (!file.exists(beast_jar_path)) {
    stop("beast_jar_path not found")
  }
  if (nchar(base_filename) >= 5 &&
      substr(base_filename, start = 1, stop = 5) == "/tmp/") {
    stop("base_filename must not start with '/tmp/'")
  }

  # Save to FASTA file
  temp_fasta_filename <- paste0(base_filename, ".fasta")
  wiritttes::convert_alignment_to_fasta(alignment, temp_fasta_filename)

  out <- babette::run(
    fasta_filenames = temp_fasta_filename,
    site_models = beautier::create_jc69_site_model(),
    clock_models = beautier::create_strict_clock_model(),
    mrca_priors = NA,
    mcmc = beautier::create_mcmc(chain_length = nspp * 1000),
    tree_priors = beautier::create_bd_tree_prior(),
    posterior_crown_age = crown_age,
    rng_seed = rng_seed,
    cleanup = TRUE
  )

  file.remove(temp_fasta_filename)

  posterior <- list(
    trees = out[[grep(x = names(out), pattern = "trees")]],
    estimates = out$estimates
  )

  testit::assert(tracerer::is_posterior(posterior))

  posterior
}
