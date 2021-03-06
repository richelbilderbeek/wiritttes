% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_parameters.R
\name{extract_sequence_length}
\alias{extract_sequence_length}
\title{Extract the DNA aligment sequence length parameter value from a file}
\usage{
extract_sequence_length(file)
}
\arguments{
\item{file}{A loaded parameter file}
}
\value{
the sequence length
}
\description{
Extract the DNA aligment sequence length parameter value from a file
}
\examples{
  file <- read_file(find_path("toy_example_1.RDa"))
  sequence_length <- extract_sequence_length(file)
  testit::assert(sequence_length == 1000)
}
\author{
Richel Bilderbeek
}
