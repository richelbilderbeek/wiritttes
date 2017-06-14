#' Checks if files are valid parameter files
#' @param filenames the names of the file to be checked
#' @return TRUE or FALSE
#' @examples
#'   testit::assert(
#'     are_valid_files(
#'       c(
#'         find_path("toy_example_1.RDa"),
#'         find_path("toy_example_2.RDa")
#'        )
#'      )
#'    )
#' @author Richel Bilderbeek
#' @export
are_valid_files <- function(
  filenames
) {
  v <- rep(FALSE, length(filenames))
  for (i in seq_along(filenames)) {
    tryCatch({
      v[i] <- wiritttes::is_valid_file(filenames[i])
    }, error = function() {} # nolint
    )
  }
  v
}
