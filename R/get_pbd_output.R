#' Get the PBD simulation output
#' @param file A loaded parameter file
#' @return the PBD simulation output
#' @export
#' @author Richel Bilderbeek
get_pbd_output <- function(file) {

  # file <- wiritttes::read_file(filename)
  file$pbd_output
}
