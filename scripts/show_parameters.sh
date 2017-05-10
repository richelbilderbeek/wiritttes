#!/bin/bash
#SBATCH --time=0:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --job-name=show_parameters
#SBATCH --output=show_parameters_%j.log
module load R/3.3.1-foss-2016a
time Rscript -e "print(read_file(\"$1\")$parameters"
