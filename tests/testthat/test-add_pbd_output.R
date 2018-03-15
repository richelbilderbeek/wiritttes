context("add_pbd_output")

test_that("pbd_output is added", {

  # Create file
  filename <- "test-add_pbd_output.RDa"
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

  # PBD sim output must first be absent
  testthat::expect_false(
    ribir::is_pbd_sim_output(
      wiritttes::get_pbd_output(
        wiritttes::read_file(filename)
      )
    )
  )

  # Add it
  wiritttes::add_pbd_output(filename)

  # PBD sim output must now be present
  testthat::expect_true(
    ribir::is_pbd_sim_output(
      wiritttes::get_pbd_output(
        wiritttes::read_file(filename)
      )
    )
  )

  # Cleanup
  file.remove(filename)
  testthat::expect_false(file.exists(filename))
})

test_that("add_pbd_output: demonstrate PBD::pbd_sim to freeze", {

  if (1 == 2) {
    filename <- "test-add_pbd_output.RDa"

    # If speciation-initiation is zero, and extinction non-zero,
    # it is nearly impossible to create an incipient species tree
    # with two taxa (which is the number of taxa at which it starts)
    save_parameters_to_file(
      rng_seed = 42,
      sirg = 0.0,
      siri = 0.0,
      scr = 0.0,
      erg = 2.0,
      eri = 2.0,
      age = 5,
      mutation_rate = 0.1,
      n_alignments = 1,
      sequence_length = 10,
      nspp = 10,
      n_beast_runs = 1,
      filename = filename
    )

    # Freeze
    add_pbd_output(filename)

    file.remove(filename)
    expect_false(file.exists(filename))
  }
})



test_that("add_pbd_output: abuse", {

  expect_error(
    add_pbd_output(filename = "inval.lid"),
    "invalid filename"
  )

})

test_that("pbd_output is added iff absent", {


  filename <- "test-add_pbd_output_iff_absent.RDa"
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
  expect_true(file.exists(filename))
  expect_false(
    ribir::is_pbd_sim_output(
      wiritttes::get_pbd_output(
        read_file(filename)
      )
    )
  )
  is_added_first <- add_pbd_output_iff_absent(filename)

  expect_true(
    ribir::is_pbd_sim_output(
      wiritttes::get_pbd_output(
        read_file(filename)
      )
    )
  )
  expect_true(is_added_first)

  is_added_second <- add_pbd_output_iff_absent(filename)
  expect_true(
    ribir::is_pbd_sim_output(
      wiritttes::get_pbd_output(read_file(filename))
    )
  )

  expect_false(is_added_second)

  file.remove(filename)
  expect_false(file.exists(filename))

})
