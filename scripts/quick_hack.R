devtools::install_github("richelbilderbeek/wiritttea")
rda_files <- list.files("~/GitHubs/wiritttes/script", pattern = "\\.RDa", full.names = TRUE)
wiritttea::collect_files_nltt_stats(rda_files)