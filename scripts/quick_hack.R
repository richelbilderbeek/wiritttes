devtools::install_github("richelbilderbeek/wiritttea")
rda_files <- list.files("~/GitHubs/wiritttes/scripts", pattern = "\\.RDa", full.names = TRUE)
print(rda_files)
df <- wiritttea::collect_files_nltt_stats(rda_files)

utils::write.csv(
  x = df,
  file = "collect_files_nltt_stats.csv",
  row.names = TRUE
)

warnings()
