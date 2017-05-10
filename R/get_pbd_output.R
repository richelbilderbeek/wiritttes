#' Get the PBD simulation output
#' @param file A loaded parameter file
#' @return the PBD simulation output
#' @export
#' @author Richel Bilderbeek
#' @examples
#'   filename <- wiritttes::find_path("toy_example_1.RDa")
#'   file <- wiritttes::read_file(filename)
#'   pbd_output <- wiritttes::get_pbd_output(file)
#'   testit::assert(ribir::is_pbd_sim_output(pbd_output))
get_pbd_output <- function(file) {

  file$pbd_output
}
