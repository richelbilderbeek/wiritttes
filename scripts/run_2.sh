#!/bin/bash

##########################
# Add species trees
##########################

#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=run_2
#SBATCH --output=run_2.log
jobids=()
for filename in `ls *.RDa`
do
  cmd="sbatch add_species_trees.sh $filename"
  echo "cmd: "$cmd
  jobids+=(`$cmd | cut -d ' ' -f 4`)
done

jobid=$(printf ":%s" "${jobids[@]}")
jobid=${jobid:1}
echo "jobid: "$jobid

##########################
# Add alignments
# This is a parallel job, 
# which is started in run_3.sh
##########################

cmd="sbatch --dependency=afterany:$jobid run_3.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid
