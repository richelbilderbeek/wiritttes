#' Extract an species_tree from an index from a file
#' @param file A loaded parameter file
#' @param sti the index of the species_tree
#' @return the species_tree
#' @export
#' @author Richel Bilderbeek
get_species_tree_by_index <- function(file, sti) {
  if (sti < 1) {
    stop("index must be at least 1")
  }
  if (sti > length(file$species_trees)) {
    stop("index must be less than number of species_trees") # nolint
  }

  species_tree <- file$species_trees[[sti]][[1]]

  if (class(species_tree) != "phylo") {
    # The species_tree may not be added yet
    stop(
      "species_tree absent at index ",
      sti
    )
  }
  species_tree
}

#' Get the species tree with youngest subspecies representing each good species
#' @param file A loaded parameter file
#' @return the species_tree
#' @export
#' @author Richel Bilderbeek
get_species_tree_youngest <- function(file) {

  return(wiritttes::get_species_tree_by_index(file, sti = 1))
}

#' Get the species tree with oldest subspecies representing each good species
#' @param file A loaded parameter file
#' @return the species_tree
#' @export
#' @author Richel Bilderbeek
get_species_tree_oldest <- function(file) {

  return(wiritttes::get_species_tree_by_index(file, sti = 2))
}
