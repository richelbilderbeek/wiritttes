#' Run the full simulation pipeline on a parameter file on a local computer.
#' @param filename name of the parameter file
#' @return Nothing. It does modify the input filename
#' @export
#' @author Richel Bilderbeek
do_simulation <- function(filename) {
  if (length(filename) != 1) {
    stop("supply exactly one parameter filename")
  }
  if (!is_valid_file(filename)) {
    stop("filename must be a valid file")
  }
  wiritttes::add_pbd_output(filename = filename)
  wiritttes::add_species_trees(filename = filename)
  wiritttes::add_alignments(filename = filename)
  wiritttes::add_posteriors(filename = filename)
}
