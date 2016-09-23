#' Read multiple parameter (.RDa) files
#' @param filenames names of the parameter (.RDa) file
#' @return the file as R data
#' @export
#' @examples
#'   files <- read_files(find_paths(c("toy_example_1.RDa", "toy_example_2.RDa")))
#'   testit::assert(extract_sirg(files[[1]]) > 0.0)
#'   testit::assert(extract_siri(files[[2]]) > 0.0)
#' @author Richel Bilderbeek
read_files <- function(filenames) {
  if (length(filenames) < 1) {
    stop("must supply at least one filename")
  }
  files <- as.list(rep(NA, length(filenames)))
  for (i in seq_along(filenames)) {
    tryCatch(
      files[[i]] <- read_file(filenames[i]),
      error = function(msg) {} # nolint
    )
  }
  return(files)
}
