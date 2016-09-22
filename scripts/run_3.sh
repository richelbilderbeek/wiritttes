#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=run_3
#SBATCH --output=run_3.log

##########################
# Add alignments
##########################

jobids=()
for filename in `ls *.RDa`
do
  cmd="sbatch add_alignments.sh $filename"
  echo "cmd: "$cmd
  jobids+=(`$cmd | cut -d ' ' -f 4`)
done

jobid=$(printf ":%s" "${jobids[@]}")
jobid=${jobid:1}
echo "jobid: "$jobid

##########################
# Add posteriors
# This is a parallel job, 
# which is started in run_4.sh
##########################

cmd="sbatch --dependency=afterany:$jobid run_4.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid
