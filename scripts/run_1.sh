#!/bin/bash
######################
echo "Add pbd_sim_output"
######################
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=run_1
#SBATCH --output=run_1.log
jobids=()
for filename in `ls *.RDa`
do
  cmd="sbatch add_pbd_output.sh $filename"
  echo "cmd: "$cmd
  jobids+=(`$cmd | cut -d ' ' -f 4`)
done

jobid=$(printf ":%s" "${jobids[@]}")
jobid=${jobid:1}
echo "jobid: "$jobid

##########################
echo "Add species trees"
echo "This is a parallel job,"
echo "which is started in run_2.sh"
##########################
cmd="sbatch --dependency=afterany:$jobid run_2.sh"
echo "cmd: "$cmd
jobid=`$cmd | cut -d ' ' -f 4`
echo "jobid: "$jobid
