#' Checks if a file is a valid parameter file
#' @param filename the name of the file to be checked
#' @return TRUE or FALSE
#' @examples
#'   testit::assert(is_valid_file(find_path("toy_example_1.RDa")))
#' @author Richel Bilderbeek
#' @export
is_valid_file <- function(
  filename
) {

  if (!file.exists(filename)) {
    return(FALSE)
  }
  file <- NULL
  tryCatch(
    file <- wiritttes::read_file(filename),
    error = function(msg) {} # nolint
  )
  if (is.null(file)) return(FALSE)
  if (mode(file) != "list") {
    return(FALSE)
  }
  if (is.null(file$parameters)) {
    return(FALSE)
  }
  if (is.null(file$pbd_output)) {
    return(FALSE)
  }
  if (is.null(file$species_trees)) {
    return(FALSE)
  }
  if (is.null(file$alignments)) {
    return(FALSE)
  }
  if (is.null(file$posteriors)) {
    return(FALSE)
  }

  # First try if parameters can be read
  success <- NA
  tryCatch(
    success <- extract_erg(file),
    error = function(msg) {} # nolint
  )
  if (is.na(success)) return (FALSE)
  tryCatch(
    success <- extract_eri(file),
    error = function(msg) {} # nolint
  )
  if (is.na(success)) return (FALSE)
  tryCatch(
    success <- extract_scr(file),
    error = function(msg) {} # nolint
  )
  if (is.na(success)) return (FALSE)
  tryCatch(
    success <- extract_sirg(file),
    error = function(msg) {} # nolint
  )
  if (is.na(success)) return (FALSE)
  tryCatch(
    success <- extract_siri(file),
    error = function(msg) {} # nolint
  )
  if (is.na(success)) return (FALSE)

  return(
    wiritttes::file_has_valid_parameters(
      file = file
    )
  )
}
