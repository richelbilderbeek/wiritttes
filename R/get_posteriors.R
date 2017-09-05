#' Extract the BEAST2 posterior phyogenies
#'   from a file
#' @param file A loaded parameter file
#' @return all posteriors
#' @examples
#'   filename <- wiritttes::find_path("toy_example_1.RDa")
#'   file <- wiritttes::read_file(filename)
#'   posteriors <- wiritttes::get_posteriors(file)
#'   testit::assert(length(posteriors) == 2)
#'   testit::assert("trees" %in% names(posteriors[[1]][[1]]))
#'   testit::assert("estimates" %in% names(posteriors[[1]][[1]]))
#'   testit::assert("likelihood" %in% names(posteriors[[1]][[1]]$estimates))
#' @export
#' @author Richel Bilderbeek
get_posteriors <- function(file) {
  return(file$posteriors)
}
