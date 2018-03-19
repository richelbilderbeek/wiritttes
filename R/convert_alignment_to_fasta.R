#' Convert an alignment (of type DNAbin) to a FASTA file
#' @param alignment DNA alignment of type DNAbin
#' @param filename FASTA filename the alignment will be saved to
#' @return Nothing, it will create a FASTA file
#' @export
#' @author Richel Bilderbeek
convert_alignment_to_fasta <- function(
  alignment,
  filename
) {
  if (!ribir::is_alignment(alignment)) {
    stop("alignment must be an alignment")
  }
  phangorn::write.phyDat(alignment, file = filename, format = "fasta")
}
