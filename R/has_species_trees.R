#' Sees if a the sampled species tree are present in the file
#' @param file File, as read by wiritttes::read_file
#' @return TRUE if the sampled species trees are present
#' @examples
#'  # Create a parameter file
#'   filename <- "has_species_trees"
#'   save_parameters_to_file(
#'     rng_seed = 42,
#'     sirg = 0.5,
#'     siri = 0.5,
#'     scr = 0.5,
#'     erg = 0.5,
#'     eri = 0.5,
#'     age = 5,
#'     mutation_rate = 0.1,
#'     n_alignments = 1,
#'     sequence_length = 2,
#'     nspp = 10,
#'     n_beast_runs = 1,
#'     filename = filename
#'   )
#'
#'   # Simulate an incipient species tree
#'   add_pbd_output(filename)
#'
#'   # No species tree added yet
#'   testit::assert(!has_species_trees(read_file(filename)))
#'
#'   # Add the species trees
#'   add_species_trees(filename = filename)
#'
#'   # Now species tree is added
#'   testit::assert(has_species_trees(read_file(filename)))
#'
#' @export
#' @author Richel Bilderbeek
has_species_trees <- function(file) {
  tryCatch({
      wiritttes::get_species_tree_youngest(file)
      wiritttes::get_species_tree_oldest(file)
      return(TRUE)
    },
    error = function(cond) {} # nolint
  )
  return(FALSE)
}
