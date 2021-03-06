#!/bin/bash
#SBATCH --time=0:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=run_0
#SBATCH --output=run_0.log

##########################
echo "Clean up"
##########################
rm *.txt
rm *.log
rm *.RDa
rm *.csv
rm *.pdf
rm *.md
rm *.csv

##########################
echo "Update other packages"
##########################

jobid=`sbatch install_r_packages.sh | cut -d ' ' -f 4`
echo "jobid: "$jobid


##########################
echo "Update this package"
##########################

cmd="sbatch --dependency=afterok:$jobid install_this_r_package.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
echo "Create parameter files"
##########################


# Trivial test runs
#cmd="sbatch --dependency=afterok:$jobid create_test_parameter_files.sh"
# 1% of MCMC run
#cmd="sbatch --dependency=afterok:$jobid create_parameter_files_timings.sh"
# Full run
cmd="sbatch --dependency=afterok:$jobid create_parameter_files_article.sh"

echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid

##########################
echo "Add pbd_sim_output"
echo "This is a parallel job,"
echo "which is started in run_1.sh"
##########################

cmd="sbatch --dependency=afterany:$jobid run_1.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid
