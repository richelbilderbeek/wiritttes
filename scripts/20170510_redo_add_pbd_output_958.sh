#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=100G
#SBATCH --job-name=redo_add_pbd_output_958
#SBATCH --output=redo_add_pbd_output_958.log

# These are the files that did not have an incipient species tree
# 'add_pbd_output.sh' allocated one hour for simulating this tree
# Was the time insufficient?
show_parameters.sh /data/p230198/20170509/article_1_3_0_3_0_958.RDa
add_pbd_output.sh  /data/p230198/20170509/article_1_3_0_3_0_958.RDa
show_parameters.sh /data/p230198/20170509/article_1_3_0_3_1_972.RDa
add_pbd_output.sh  /data/p230198/20170509/article_1_3_0_3_1_972.RDa
show_parameters.sh /data/p230198/20170509/article_1_3_0_3_1_976.RDa
add_pbd_output.sh  /data/p230198/20170509/article_1_3_0_3_1_976.RDa
