#' Creates the parameter files in the article
#' Now every parameter setting has its own seed
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_parameter_files_article <- function() {
  filenames <- NULL
  b_index <- 0
  seed <- 100
  for (b in c(0.2, 0.4)) {
    lambda_index <- 0
    for (lambda in c(0.1, 0.3, 1.0, 1000000)) {
      mu_index <- 0
      for (mu in c(0.0, 0.1, 0.2)) {
        if (mu > b) next
        r_index <- 0
        for (r in c(0.05)) {
          l_index <- 0
          for (l in c(1000, 10000)) {
            for (replicate in seq(1, 20)) {
              filename <- paste0(
                "article_",
                b_index, "_",
                lambda_index, "_",
                mu_index, "_",
                r_index, "_",
                l_index, "_",
                seed, ".RDa"
              )
              filenames <- c(filenames, filename)
              save_parameters_to_file(
                rng_seed = seed,
                sirg = b,
                siri = b,
                scr = lambda,
                erg = mu,
                eri = mu,
                age = 15,
                mutation_rate = r,
                n_alignments = 2,
                sequence_length = l,
                nspp = 1000,
                n_beast_runs = 2,
                filename = filename,
                fixed_crown_age = TRUE
              )
              # Every simulation has its unique seed
              seed <- seed + 1
            } # l
            l_index <- l_index + 1
          } # l
          r_index <- r_index + 1
        } # r
        mu_index <- mu_index + 1
      } # mu
      lambda_index <- lambda_index + 1
    } # lambda
    b_index <- b_index + 1
  } # b
  filenames
}
