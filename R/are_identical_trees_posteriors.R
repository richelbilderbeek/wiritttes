#' Determines if the input is a BEAST2 posterior,
#' as parsed by olli's rBEAST package its function beast2out.read.trees
#' @param p the first posterior
#' @param q the second posterior
#' @return TRUE or FALSE
#' @author Richel Bilderbeek
#' @export
are_identical_trees_posteriors <- function(p, q) {

  if (!tracerer::is_trees_posterior(p)) {
    stop("p must be a BEAST2 posterior")
  }
  if (!tracerer::is_trees_posterior(q)) {
    stop("q must be a BEAST2 posterior")
  }
  if (length(p) != length(q)) {
    return(FALSE)
  }

  for (i in seq(1, length(p))) {
    if (!isTRUE(all.equal(p[[i]], q[[i]]))) {
      return(FALSE)
    }
  }

  TRUE
}
