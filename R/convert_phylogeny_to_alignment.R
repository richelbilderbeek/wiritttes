#' Converts a phylogeny to a random DNA alignment
#' @param phylogeny a phylogeny
#' @param sequence_length the number of nucleotides to alignment
#'   will have per taxon
#' @param mutation_rate the rate per nucleotide to change,
#'   per million years
#' @return an alignment
#' @examples
#' alignment <- convert_phylogeny_to_alignment(
#'    phylogeny = ape::rcoal(5),
#'    sequence_length = 2,
#'    mutation_rate = 1
#'  )
#'  testit::assert(ribir::is_alignment(alignment))
#' @author Richel Bilderbeek
#' @export
convert_phylogeny_to_alignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) {
  pirouette::sim_alignment(
    phylogeny = phylogeny,
    sequence_length = sequence_length,
    mutation_rate = mutation_rate
  )
}
