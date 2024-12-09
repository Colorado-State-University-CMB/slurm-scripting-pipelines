#!/usr/bin/env bash
#SBATCH
#SBATCH
#SBATCH

args=($@)
arg=${args[$(($SLURM_ARRAY_JOB_ID + 1))]}

# run your command on arg
cmd $arg
