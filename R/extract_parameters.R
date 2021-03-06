#' Extract the parameters from a file created by wiritttes::read_file
#' @param file A loaded parameter file
#' @return the value of the ERG parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   parameters <- extract_parameters(file)
#'   testit::assert(nrow(parameters) > 1)
#'   testit::assert(ncol(parameters) > 1)
#' @author Richel Bilderbeek
extract_parameters <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }
  file$parameters
}


#' Extract the ERG ('Extinction Rate of a Good species')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the ERG parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   erg <- extract_erg(file)
#'   testit::assert(erg >= 0.0)
#' @author Richel Bilderbeek
extract_erg <- function(file) {

  parameters <- wiritttes::extract_parameters(file)

  erg <- NA
  if ("erg" %in% names(parameters)) {
    erg <- as.numeric(parameters$erg[2])
  }
  if (is.na(erg)) {
    stop("parameter 'erg' absent")
  }
  return(erg)
}

#' Extract the ERI ('Extinction Rate of an Incipient species')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the ERI parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   eri <- extract_eri(file)
#'   testit::assert(eri >= 0.0)
#' @author Richel Bilderbeek
extract_eri <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  eri <- NA
  if ("eri" %in% names(file$parameters)) {
    eri <- as.numeric(file$parameters$eri[2])
  }
  if (is.na(eri)) {
    stop("parameter 'eri' absent")
  }
  return(eri)
}


#' Extract the SCR ('Speciation Completion Rate')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the SCR parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   scr <- extract_scr(file)
#'   testit::assert(scr >= 0.0)
#' @author Richel Bilderbeek
extract_scr <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  scr <- NA
  if ("scr" %in% names(file$parameters)) {
    scr <- as.numeric(file$parameters$scr[2])
  }
  if (is.na(scr)) {
    stop("parameter 'scr' absent")
  }
  return(scr)
}


#' Extract the SIRG ('Speciation Initial Rate of a Good species')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the SIRG parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   sirg <- extract_sirg(file)
#'   testit::assert(sirg >= 0.0)
#' @author Richel Bilderbeek
extract_sirg <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  sirg <- NA
  if ("sirg" %in% names(file$parameters)) {
    sirg <- as.numeric(file$parameters$sirg[2])
  }
  if (is.na(sirg)) {
    stop("parameter 'sirg' absent")
  }
  return(sirg)
}

#' Extract the SIRI ('Speciation Initial Rate of an Incipient species')
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the value of the SIRI parameter
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   siri <- extract_siri(file)
#'   testit::assert(siri >= 0.0)
#' @author Richel Bilderbeek
extract_siri <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  siri <- NA
  if ("siri" %in% names(file$parameters)) {
    siri <- as.numeric(file$parameters$siri[2])
  }
  if (is.na(siri)) {
    stop("parameter 'siri' absent")
  }
  return(siri)
}

#' Extract the number of alignments per species tree
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the number of alignments per species tree
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   napst <- extract_napst(file)
#'   testit::assert(napst == 1)
#' @author Richel Bilderbeek
extract_napst <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  n_alignments <- NA
  if ("n_alignments" %in% names(file$parameters)) {
    n_alignments <- as.numeric(file$parameters$n_alignments[2])
  }
  if (is.na(n_alignments)) {
    stop("parameter 'n_alignments' absent")
  }
  return(n_alignments)
}

#' Extract the number of posteriors per alignment
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the number of posteriors per alignment
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   nppa <- extract_nppa(file)
#'   testit::assert(nppa == 1)
#' @author Richel Bilderbeek
extract_nppa <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  nppa <- NA
  if ("n_beast_runs" %in% names(file$parameters)) {
    nppa <- as.numeric(file$parameters$n_beast_runs[2])
  }
  if (is.na(nppa)) {
    stop("parameter 'n_beast_runs' absent")
  }
  return(nppa)
}

#' Extract the number of states per posterior
#'   parameter value from a file
#' @param file A loaded parameter file
#' @return the number of posteriors per alignment
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   nspp <- extract_nspp(file)
#'   testit::assert(nspp == 10)
#' @author Richel Bilderbeek
extract_nspp <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }

  nspp <- NA
  if ("nspp" %in% names(file$parameters)) {
    nspp <- as.numeric(file$parameters$nspp[2])
  } else {
    # Backwards compatibility
    if ("mcmc_chainlength" %in% names(file$parameters)) {
      nspp <- as.numeric(file$parameters$mcmc_chainlength[2]) / 1000
    }
  }
  if (is.na(nspp)) {
    stop("parameter 'nspp' absent")
  }
  return(nspp)
}


#' Extract the mutation rate parameter value from a file
#' @param file A loaded parameter file
#' @return the mutation rate
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   mutation_rate <- extract_mutation_rate(file)
#'   testit::assert(mutation_rate == 0.01)
#' @author Richel Bilderbeek
extract_mutation_rate <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }
  mutation_rate <- NA
  if ("mutation_rate" %in% names(file$parameters)) {
    mutation_rate <- as.numeric(file$parameters$mutation_rate[2])
  }
  if (is.na(mutation_rate)) {
    stop("parameter 'mutation_rate' absent")
  }
  mutation_rate
}

#' Extract the RNG seed parameter value from a file
#' @param file A loaded parameter file
#' @return the RNG seed rate
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   rng_seed <- extract_seed(file)
#'   testit::assert(rng_seed == 1)
#' @author Richel Bilderbeek
extract_seed <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }
  rng_seed <- NA
  if ("rng_seed" %in% names(file$parameters)) {
    rng_seed <- as.numeric(file$parameters$rng_seed[2])
  }
  if (is.na(rng_seed)) {
    stop("parameter 'rng_seed' absent")
  }
  rng_seed
}

#' Extract the DNA aligment sequence length parameter value from a file
#' @param file A loaded parameter file
#' @return the sequence length
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   sequence_length <- extract_sequence_length(file)
#'   testit::assert(sequence_length == 1000)
#' @author Richel Bilderbeek
extract_sequence_length <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }
  sequence_length <- NA
  if ("sequence_length" %in% names(file$parameters)) {
    sequence_length <- as.numeric(file$parameters$sequence_length[2])
  }
  if (is.na(sequence_length)) {
    stop("parameter 'sequence_length' absent")
  }
  sequence_length
}





#' Extract if the crown age is fixed from a file
#' @param file A loaded parameter file
#' @return a boolean indicating if the crown age is fixed
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   fixed_crown_age <- extract_fixed_crown_age(file)
#'   testit::assert(fixed_crown_age == FALSE)
#' @author Richel Bilderbeek
extract_fixed_crown_age <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }
  fixed_crown_age <- NA
  if ("fixed_crown_age" %in% names(file$parameters)) {
    fixed_crown_age <- as.logical(file$parameters$fixed_crown_age[2])
  }
  if (is.na(fixed_crown_age)) {
    return(FALSE)
  }
  TRUE
}

#' Extract the crown age from a file
#' @param file A loaded parameter file
#' @return a floating point value for the crown age in time units
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   age <- extract_age(file)
#'   testit::assert(age == 5)
#' @author Richel Bilderbeek
#' @note  extract_crown_age does exactly the same
extract_age <- function(file) {

  wiritttes::extract_crown_age(file)
}

#' Extract the crown age from a file
#' @param file A loaded parameter file
#' @return a floating point value for the crown age in time units
#' @export
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   age <- extract_crown_age(file)
#'   testit::assert(age == 5)
#' @author Richel Bilderbeek
#' @note  extract_age does exactly the same
extract_crown_age <- function(file) {

  if (is.null(names(file$parameters))) {
    stop("file$parameters not found")
  }
  age <- NA
  if ("age" %in% names(file$parameters)) {
    age <- as.numeric(file$parameters$age[2])
  }
  if (is.na(age)) {
    stop("parameter 'age' absent")
  }
  age
}
