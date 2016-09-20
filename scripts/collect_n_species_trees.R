library(wiritttes)
folder <- "/home/p230198/GitHubs/wiritttes/scripts"
fns <- paste(
  folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
)
df <- wiritttes::collect_files_n_species_trees(fns, verbose = TRUE)

write.csv(
  x = df,
  file = "../inst/extdata/collected_n_species_trees.csv",
  row.names = TRUE
)

warnings()
