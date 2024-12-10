#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:01:00
#SBATCH --job-name=array
#SBATCH --partition=short-cpu
#SBATCH --output=/dev/null
datetime=$(date +"%Y-%m-%d_%H:%M:%S")
echo "[$datetime] $SLURM_JOB_NAME $@" # log the command line
echo "SLURM_JOBID=$SLURM_JOBID"
echo "SLURM_ARRAY_JOB_ID=$SLURM_ARRAY_JOB_ID"
echo "SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID"

mkdir -pv $SLURM_ARRAY_JOB_ID
touch $SLURM_ARRAY_JOB_ID/${SLURM_ARRAY_TASK_ID}.txt
#sleeptime=$((RANDOM % 19 + 1))
sleeptime=$(($RANDOM % 11 + 10)) # between 10 and 20 seconds
sleep $sleeptime
echo "$SLURM_ARRAY_JOB_ID process $SLURM_ARRAY_TASK_ID slept $sleeptime" >> $SLURM_ARRAY_JOB_ID/${SLURM_ARRAY_TASK_ID}.txt
