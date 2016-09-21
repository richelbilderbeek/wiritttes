#' Add BEAST2 posteriors to a file
#' @param filename Parameter filename
#' @return the number of posteriors added. Also modifies the parameter file
#' @examples
#'   # Create a parameter file
#'   filename <- "test-add_posteriors_1.RDa"
#'   save_parameters_to_file(
#'     rng_seed = 42,
#'     sirg = 0.5,
#'     siri = 0.5,
#'     scr = 0.5,
#'     erg = 0.5,
#'     eri = 0.5,
#'     age = 5,
#'     mutation_rate = 0.1,
#'     n_alignments = 1,
#'     sequence_length = 10,
#'     nspp = 10,
#'     n_beast_runs = 1,
#'     filename = filename
#'   )
#'
#'   # Add an incipient species tree
#'   add_pbd_output(filename = filename)
#'
#'   # Add sampled species tree
#'   add_species_trees(filename = filename)
#'
#'   # Add alignments
#'   add_alignments(filename = filename)
#'
#'   # Add posteriors
#'   n_posteriors_added <- add_posteriors(filename = filename)
#'
#'   # Check if it worked
#'   testit::assert(n_posteriors_added == 2)
#'   p1 <- get_posterior(file = read_file(filename), sti = 1, ai = 1, pi = 1)
#'   p2 <- get_posterior(file = read_file(filename), sti = 2, ai = 1, pi = 1)
#'   testit::assert(RBeast::is_posterior(p1))
#'   testit::assert(RBeast::is_posterior(p2))
#'
#'   # Clean up
#'   file.remove(filename)
#' @export
#' @author Richel Bilderbeek
add_posteriors <- function(filename) {

  if (!is_valid_file(filename)) {
    stop("invalid filename")
  }
  file <- wiritttes::read_file(filename)
  if (!all(has_alignments(file) == TRUE)) {
    stop("alignments absent")
  }

  parameters <- file$parameters
  rng_seed <- as.numeric(parameters$rng_seed[2])
  nspp <- as.numeric(parameters$nspp[2])
  n_alignments <- as.numeric(parameters$n_alignments[2])
  n_beast_runs <- as.numeric(parameters$n_beast_runs[2])

  n_posteriors_added <- 0

  for (sti in 1:2) {
    for (ai in 1:n_alignments) {
      alignment <- get_alignment(
        file = file,
        sti = sti,
        ai = ai
      )
      testit::assert(ribir::is_alignment(alignment))
      for (pi in 1:n_beast_runs) {
        posterior <- NA
        testit::assert(!RBeast::is_trees_posterior(posterior))
        tryCatch(
          posterior <- get_posterior(
            file = file,
            sti = sti,
            ai = ai,
            pi = pi
          ),
          error = function(msg) {} # nolint
        )
        if (RBeast::is_posterior(posterior)) {
          next
        }
        i <- p2i(sti = sti, ai = ai, pi = pi, nstpist = 2, napst = n_alignments, nppa = n_beast_runs) # nolint
        new_seed <- rng_seed + i
        set.seed(new_seed)
        basefilename <- paste0(
          tools::file_path_sans_ext(filename), "_",
          sti, "_", ai, "_", pi
        )
        posterior <- alignment_to_beast_posterior(
          alignment = alignment,
          base_filename = basefilename,
          nspp = nspp,
          rng_seed = new_seed
        )
        testit::assert(RBeast::is_posterior(posterior))

        file <- set_posterior(
          file = file, sti = sti, ai = ai, pi = pi,
          posterior = posterior
        )
        saveRDS(object = file, file = filename)
        testit::assert(
          are_identical_posteriors(
            get_posterior(file = file,
              sti = sti, ai = ai, pi = pi
            ),
            posterior
          )
        )
        n_posteriors_added <- n_posteriors_added + 1
      }
    }
  }
  n_posteriors_added
}
