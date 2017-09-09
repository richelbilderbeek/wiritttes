#' Extract a BEAST2 posterior tree from a file
#' @param file A loaded parameter file
#' @param sti the species tree index, a value from 1 to and including 2
#' @param ai the alignment index,
#'   the ai-th alignment of that species tree,
#'   a value from 1 to and including
#'   the number of alignments per species tree
#' @param pi the posterior index,
#'   the pi-th posterior of that alignment,
#'   a value from 1 to and including
#'   the number of posteriors per alignment
#' @param si the posterior state index,
#'   the si-th state in the posterior,
#'   a value from 1 to and including
#'   the number of posterior states per posterior
#' @return the posterior
#' @export
#' @examples
#'   # Read a file with one or more posteriors
#'   file <- read_file(find_path("toy_example_1.RDa"))
#'   # Pick the indices of the posterior to extract
#'   sti  <- 1 # Species tree index
#'   ai   <- 1 # Alignment index
#'   pi   <- 1 # Posterior index
#'   si   <- 1 # Posterior state index
#'   # Extract the posterior
#'   tree <- get_posterior_tree(file = file, sti = sti, ai = 1, pi = 1, si = 1)
#'   # Check that it is indeed a phylogeny
#'   testit::assert(ribir::is_phylogeny(tree))
#' @author Richel Bilderbeek
get_posterior_tree <- function(
  file,
  sti,
  ai,
  pi,
  si
) {
  if (sti < 1) {
    stop("sti must be at least 1")
  }
  if (sti > 2) {
    stop("sti must at most be 2")
  }
  if (ai < 1) {
    stop("ai must be at least 1")
  }
  napst <- wiritttes::extract_napst(file = file)
  if (ai > napst) {
    stop("ai must at most be napst")
  }
  if (pi < 1) {
    stop("pi must be at least 1")
  }
  nppa <- wiritttes::extract_nppa(file = file)
  if (pi > nppa) {
    stop("pi must at most be nppa")
  }
  if (si < 1) {
    stop("si must be at least 1")
  }
  nspp <- wiritttes::extract_nspp(file = file)
  if (si > nspp) {
    stop("si must at most be nspp")
  }

  phylogeny <- get_posterior(file = file, sti = sti, ai = ai, pi = pi)$trees[[si]]
  phylogeny
}
