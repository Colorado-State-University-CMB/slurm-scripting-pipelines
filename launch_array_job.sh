#!/usr/bin/env bash
# usage: bash launch_array_job.sh scriptname.sh arg1 arg2 ...
jobscript=$1
shift
args=$@
nargs=$#

# array over command line args
sbatch --array=1-$nargs $jobscript $args
# jobscript will make use of $SLURM_ARRAY_JOB_ID to choose which command line arg to use
