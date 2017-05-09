#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100G
#SBATCH --job-name=quick_hack
#SBATCH --output=quick_hack.log

# These are the files that did not have an incipient species tree
# 'add_pbd_output.sh' allocated one hour for simulating this tree
# Was the time insufficient?
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_0_944.RDa
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_0_945.RDa
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_0_947.RDa
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_0_951.RDa
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_0_953.RDa
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_0_958.RDa
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_1_968.RDa
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_1_972.RDa
sbatch add_pbd_output.sh /data/p230198/20170509/article_1_3_0_3_1_976.RDa