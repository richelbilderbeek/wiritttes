#' Determines if the input is a wiritttes posterior,
#' @param p the first wiritttes posterior
#' @param q the second wiritttes posterior
#' @return TRUE or FALSE
#' @examples
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   posterior_1 <- get_posterior(file = file, sti = 1, ai = 1, pi = 1)
#'   posterior_2 <- get_posterior(file = file, sti = 2, ai = 1, pi = 1)
#'   testit::assert( are_identical_posteriors(posterior_1, posterior_1))
#'   testit::assert(!are_identical_posteriors(posterior_1, posterior_2))
#'   testit::assert(!are_identical_posteriors(posterior_2, posterior_1))
#'   testit::assert( are_identical_posteriors(posterior_2, posterior_2))
#' @author Richel J.C. Bilderbeek
#' @export
are_identical_posteriors <- function(p, q) {

  if (!tracerer::is_posterior(p)) {
    stop(
      "p must be a posterior"
    )
  }
  if (!tracerer::is_posterior(q)) {
    stop(
      "q must be a posterior"
    )
  }
  if (!are_identical_trees_posteriors(p$trees, q$trees)) {
    return(FALSE)
  }

  TRUE
}
