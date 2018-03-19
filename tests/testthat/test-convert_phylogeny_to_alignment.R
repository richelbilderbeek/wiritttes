context("convert_phylogeny_to_alignment")

test_that("convert_phylogeny_to_alignment: basic", {

  testthat::expect_silent(
    wiritttes::convert_phylogeny_to_alignment(
      phylogeny = ape::rcoal(n_taxa),
      sequence_length = 10,
      mutation_rate = 1
    )
  )
})
