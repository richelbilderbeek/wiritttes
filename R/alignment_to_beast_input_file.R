#' Convert an alignment and parameters to a BEAST XML input file
#' @param alignment the DNA alignment of type DNAbin
#' @param nspp the number of states in a BEAST2 MCMC chain,
#'   typically there is one state per one thousand generations
#' @param rng_seed random number generator seed
#' @param beast_filename the filename of the XML BEAST2 input file created
#' @param temp_fasta_filename the name of a temporary file created
#' @param crown_age a postive value should the crown age be fixed at that value,
#'   NA if BEAST2 needs to estimate it
#' @return Nothing, creates a file called 'beast_filename'
#' @examples
#'
#'   # Simulate a phylogeny
#'   phylogeny <- ape::rcoal(n = 5)
#'
#'   # Simulate an alignment from that phylogeny
#'   alignment <- convert_phylogeny_to_alignment(
#'     phylogeny = phylogeny,
#'     sequence_length = 10
#'   )
#'
#'   # Create a BEAST2 input file
#'   beast_xml_input_file <- "alignment_to_beast_input_file_example.xml"
#'   fasta_filename <- "alignment_to_beast_input_file_examp.fasta"
#'   alignment_to_beast_input_file(
#'     alignment = alignment,
#'     nspp = 10,
#'     rng_seed = 42,
#'     beast_filename = beast_xml_input_file,
#'     temp_fasta_filename = fasta_filename,
#'     crown_age = NA
#'   )
#'
#'   # Check that the BEAST2 input file really exists
#'   testit::assert(file.exists(beast_xml_input_file))
#'
#' @export
#' @author Richel Bilderbeek
alignment_to_beast_input_file <- function(
  alignment,
  nspp,
  rng_seed = 42,
  beast_filename,
  temp_fasta_filename,
  crown_age = NA
) {
  if (!ribir::is_alignment(alignment)) {
    stop("alignment must be an alignment")
  }
  if (!is.numeric(nspp)) {
    stop("nspp must be numeric")
  }
  if (nspp < 1) {
    stop("nspp must at least be one")
  }
  if (!is.numeric(rng_seed)) {
    stop("rng_seed must be numeric")
  }
  if (!is.character(beast_filename)) {
    stop("beast_filename must be a word")
  }
  if (!is.character(temp_fasta_filename)) {
    stop("temp_fasta_filename must be a word")
  }
  if (is.numeric(crown_age) && crown_age < 0) {
    stop("crown_age must be NA or positive")
  }

  # Save to FASTA file
  wiritttes::convert_alignment_to_fasta(alignment, temp_fasta_filename)

  # So that mcmc_chainlength is written as 1000000 instead of 1e+7
  options(scipen = 20)
  beautier::create_beast2_input_file(
    input_filenames = temp_fasta_filename,
    output_filename = beast_filename,
    mcmc = beautier::create_mcmc(chain_length = nspp * 1000),
    tree_priors = beautier::create_bd_tree_prior(),
    posterior_crown_age = crown_age
  )

  testit::assert(file.exists(beast_filename))
  file.remove(temp_fasta_filename)
  testit::assert(!file.exists(temp_fasta_filename))

}
