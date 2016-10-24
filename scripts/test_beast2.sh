#!/bin/bash
#SBATCH --time=0:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=test_beast2
#SBATCH --output=test_beast2.log
echo "Loading modules"
module load R/3.3.1-foss-2016a
echo "Starting script"
time Rscript test_beast2.R
