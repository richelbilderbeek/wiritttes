#' Run the full simulation pipeline on the test parameters
#' @param filenames the name of the four files created
#' @return Nothing. It creates the four files
#' @export
#' @author Richel Bilderbeek
do_test_simulations <- function(
  filenames = paste0("toy_example_", seq(1, 4), ".RDa")
) {
  if (length(filenames) != 4) {
    stop(
      "must have exactly four filenames"
    )
  }
  wiritttes::create_test_parameter_files(
    filenames = filenames
  )
  for (filename in filenames) {
    wiritttes::add_pbd_output(filename = filename)
    wiritttes::add_species_trees(filename = filename)
    wiritttes::add_alignments(filename = filename)
    wiritttes::add_posteriors(filename = filename)
  }
}
