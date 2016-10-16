devtools::install_github("richelbilderbeek/wiritttea")
rda_files <- list.files("~/GitHubs/wiritttes/scripts", pattern = "\\.RDa", full.names = TRUE)
print(rda_files)
wiritttea::collect_files_nltt_stats(rda_files)