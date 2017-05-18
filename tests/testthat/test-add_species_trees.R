context("add_species_trees")

test_that("add_species_trees: use", {
  filename <- "test-add_species_trees.RDa"
  wiritttes::save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename
  )
  wiritttes::add_pbd_output(filename)

  # Must not have a species tree yet
  testthat::expect_true(!wiritttes::has_species_trees(wiritttes::read_file(filename)))

  # Add the species trees
  wiritttes::add_species_trees(filename = filename)

  # Must now have a species tree
  testthat::expect_true(wiritttes::has_species_trees(wiritttes::read_file(filename)))

  # Cleanup
  file.remove(filename)
  expect_false(file.exists(filename))
})


test_that("add_species_trees: abuse", {

  expect_error(
    add_species_trees(filename = "inva.lid"),
    "invalid file"
  )

  filename <- "test-add_species_trees.RDa"
  save_parameters_to_file(
    rng_seed = 42,
    sirg = 0.5,
    siri = 0.5,
    scr = 0.5,
    erg = 0.5,
    eri = 0.5,
    age = 5,
    mutation_rate = 0.1,
    n_alignments = 1,
    sequence_length = 10,
    nspp = 10,
    n_beast_runs = 1,
    filename = filename
  )
  expect_error(
    add_species_trees(filename = filename),
    paste0("file '", filename, "' needs a pbd_output")
  )
  file.remove(filename)
})


test_that("species trees must be reconstructed", {
  filename <- "test-add_species_trees.RDa"
  wiritttes::save_parameters_to_file(
    rng_seed = 860,
    sirg = 0.5,
    siri = 0.5,
    scr = 1,
    erg = 0.1,
    eri = 0.1,
    age = 15,
    mutation_rate = 0.5,
    n_alignments = 2,
    sequence_length = 1000,
    nspp = 1000,
    n_beast_runs = 2,
    filename = filename
  )
  wiritttes::add_pbd_output(filename)
  wiritttes::add_species_trees(filename = filename)

  # Both species trees must be reconstructed species trees
  stree_oldest <- wiritttes::get_species_tree_oldest(
    wiritttes::read_file(filename))
  stree_youngest <- wiritttes::get_species_tree_youngest(
    wiritttes::read_file(filename))
  ape::plot.phylo(stree_oldest)

  if (1 == 2) {
    p1 <- geiger::sim.bdtree(b=0.2, d=0.1, stop="time", seed=1, t=30)
    ape::plot.phylo(p1)
    geiger::is.extinct(p1)
    p2 <- geiger::drop.extinct(p1)
    geiger::is.extinct(p2)
  }

  testthat::expect_null(geiger::is.extinct(stree_oldest))
  testthat::expect_null(geiger::is.extinct(stree_youngest))

  # Cleanup
  file.remove(filename)
  expect_false(file.exists(filename))
})
