% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_species_trees.R
\name{add_species_trees}
\alias{add_species_trees}
\title{Add two reconstructed species trees to a file that already has an incipient
  species tree. These two species trees are sampled from the incipient
  species tree. One sampling method selects the youngest subspecies to
  represent each good species. The other tree has the oldest subspecies
  selected to represent the good species. These two tree may differ.}
\usage{
add_species_trees(filename)
}
\arguments{
\item{filename}{Parameter filename}
}
\value{
Nothing, modifies the parameter file
}
\description{
Add two reconstructed species trees to a file that already has an incipient
  species tree. These two species trees are sampled from the incipient
  species tree. One sampling method selects the youngest subspecies to
  represent each good species. The other tree has the oldest subspecies
  selected to represent the good species. These two tree may differ.
}
\examples{
 # Create a parameter file
  filename <- "add_species_trees_example.RDa"
  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename
  )

  # Simulate an incipient species tree
  add_pbd_output(filename)

  # No species tree added yet
  testit::assert(!has_species_trees(read_file(filename)))

  # Add the species trees
  add_species_trees(filename = filename)

  # Now species tree is added
  testit::assert(has_species_trees(read_file(filename)))

}
\author{
Richel Bilderbeek
}
