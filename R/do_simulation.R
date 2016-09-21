#' Run the full simulation pipeline on a parameter file on a local computer.
#' @param filename name of the parameter file
#' @param verbose give verbose output, should be TRUE or FALSE
#' @return Nothing. It does modify the input filename
#' @export
#' @author Richel Bilderbeek
do_simulation <- function(
  filename,
  verbose = FALSE
) {
  if (verbose != TRUE && verbose != FALSE) {
    stop("verbose should be TRUE or FALSE")
  }
  if (length(filename) != 1) {
    stop("supply exactly one parameter filename")
  }
  if (!is_valid_file(filename)) {
    stop("filename must be a valid file")
  }
  wiritttes::add_pbd_output(filename, verbose = verbose)
  wiritttes::add_species_trees(filename)
  wiritttes::add_alignments(filename)
  wiritttes::add_posteriors(
    filename = filename,
    verbose = verbose
  )
}
