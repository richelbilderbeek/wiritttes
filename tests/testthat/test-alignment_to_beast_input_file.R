context("alignment_to_beast_input_file")

test_that("creates an XML", {

  phylogeny <- ape::rcoal(n = 5)

  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny,
    sequence_length = 10
  )

  beast_xml_input_file <- "test-alignment_to_beast_input_file.xml"
  fasta_filename <- "test-alignment_to_beast_input_file.fasta"

  alignment_to_beast_input_file(
    alignment = alignment,
    nspp = 10,
    rng_seed = 42,
    beast_filename = beast_xml_input_file,
    temp_fasta_filename = fasta_filename
  )
  expect_true(file.exists(beast_xml_input_file))

  # Clean up: remove the temporary files
  file.remove(beast_xml_input_file)
  expect_true(!file.exists(beast_xml_input_file))
})


test_that("alignment_to_beast_input_file: abuse", {

  phylogeny <- ape::rcoal(n = 5)

  alignment <- convert_phylogeny_to_alignment(
    phylogeny = phylogeny,
    sequence_length = 10
  )

  beast_xml_input_file <- "test-alignment_to_beast_input_file.xml"
  fasta_filename <- "test-alignment_to_beast_input_file.fasta"

  expect_error(
    alignment_to_beast_input_file(
      alignment = "not an alignment", # Error
      nspp = 1,
      rng_seed = 42,
      beast_filename = beast_xml_input_file,
      temp_fasta_filename = fasta_filename
    )
  )

  expect_error(
    alignment_to_beast_input_file(
      alignment = alignment,
      nspp = "not numeric", # Error
      rng_seed = 42,
      beast_filename = beast_xml_input_file,
      temp_fasta_filename = fasta_filename
    )
  )

  expect_error(
    alignment_to_beast_input_file(
      alignment = alignment,
      nspp = -314, # Error
      rng_seed = 42,
      beast_filename = beast_xml_input_file,
      temp_fasta_filename = fasta_filename
    )
  )

    expect_error(
    alignment_to_beast_input_file(
      alignment = alignment,
      nspp = 1,
      rng_seed = "not numeric", # Error
      beast_filename = beast_xml_input_file,
      temp_fasta_filename = fasta_filename
    )
  )
  expect_error(
    alignment_to_beast_input_file(
      alignment = alignment,
      nspp = 1,
      rng_seed = 42,
      beast_filename = ape::rcoal(4), # Error
      temp_fasta_filename = fasta_filename
    )
  )
  expect_error(
    alignment_to_beast_input_file(
      alignment = alignment,
      nspp = 1,
      rng_seed = 42,
      beast_filename = beast_xml_input_file,
      temp_fasta_filename = ape::rcoal(4) # Error
    )
  )
  expect_error(
    alignment_to_beast_input_file(
      alignment = alignment,
      nspp = 1,
      rng_seed = 42,
      beast_filename = beast_xml_input_file,
      temp_fasta_filename = fasta_filename
    )
  )
  expect_error(
    alignment_to_beast_input_file(
      alignment = alignment,
      nspp = 1,
      rng_seed = 42,
      beast_filename = beast_xml_input_file,
      temp_fasta_filename = fasta_filename
    )
  )
  expect_error(
    alignment_to_beast_input_file(
      alignment = alignment,
      nspp = 1,
      rng_seed = 42,
      beast_filename = beast_xml_input_file,
      temp_fasta_filename = fasta_filename
    )
  )

})
