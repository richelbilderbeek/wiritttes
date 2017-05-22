#!/bin/bash
#SBATCH --time=0:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=create_parameter_files_article
#SBATCH --output=create_parameter_files_article.log
module load R/3.3.1-foss-2016a
time Rscript -e 'library(wiritttes); create_parameter_files_article()'
