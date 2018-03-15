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
#'     sequence_length = 10,
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
  beast_jar_path = find_beast_jar_path()
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


  # File paths
  beast_filename <- paste0(base_filename, ".xml")
  beast_log_filename <- paste0(base_filename, ".log")
  beast_trees_filename <- paste0(base_filename, ".trees")
  beast_state_filename <- paste0(base_filename, ".xml.state")
  temp_fasta_filename <- paste0(base_filename, ".fasta")

  # Create a BEAST2 XML input file
  alignment_to_beast_input_file(
    alignment = alignment,
    nspp = nspp,
    rng_seed = rng_seed,
    beast_filename = beast_filename,
    temp_fasta_filename = temp_fasta_filename,
    crown_age = crown_age
  )
  testit::assert(file.exists(beast_filename))

  # Run BEAST2, needs the BEAST2 .XML parameter file
  beastier::run_beast2(
    input_filename = beast_filename,
    output_log_filename = beast_log_filename,
    output_trees_filenames = beast_trees_filename,
    output_state_filename = beast_state_filename,
    rng_seed = rng_seed,
    n_threads = 8,
    use_beagle = TRUE,
    overwrite_state_file = TRUE,
    verbose = FALSE
  )

  # assert everything until I can reproduce these errors
  testit::assert(file.exists(beast_trees_filename))
  testit::assert(file.exists(beast_log_filename))
  testit::assert(file.exists(beast_state_filename))

  trees_posterior <- tracerer::parse_beast_trees(beast_trees_filename)
  estimates_posterior <- tracerer::parse_beast_log(beast_log_filename)

  testit::assert(tracerer::is_trees_posterior(x = trees_posterior))

  posterior <- list(
    trees = trees_posterior,
    estimates = estimates_posterior
  )

  testit::assert(tracerer::is_posterior(posterior))

  posterior
}
