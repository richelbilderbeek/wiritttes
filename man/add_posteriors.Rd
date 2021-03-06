% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_posteriors.R
\name{add_posteriors}
\alias{add_posteriors}
\title{Add BEAST2 posteriors to a file}
\usage{
add_posteriors(filename)
}
\arguments{
\item{filename}{Parameter filename}
}
\value{
the number of posteriors added. Also modifies the parameter file
}
\description{
Add BEAST2 posteriors to a file
}
\examples{
  # Create a parameter file
  filename <- "test-add_posteriors_1.RDa"
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

  # Add an incipient species tree
  add_pbd_output(filename = filename)

  # Add sampled species tree
  add_species_trees(filename = filename)

  # Add alignments
  add_alignments(filename = filename)

  # Add posteriors
  n_posteriors_added <- add_posteriors(filename = filename)

  # Check if it worked
  testit::assert(n_posteriors_added == 2)
  p1 <- get_posterior(file = read_file(filename), sti = 1, ai = 1, pi = 1)
  p2 <- get_posterior(file = read_file(filename), sti = 2, ai = 1, pi = 1)
  testit::assert(tracerer::is_posterior(p1))
  testit::assert(tracerer::is_posterior(p2))

  # Clean up
  file.remove(filename)
}
\author{
Richel Bilderbeek
}
