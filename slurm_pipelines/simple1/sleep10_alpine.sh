#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:01:00
#SBATCH --job-name=sleep_10
#SBATCH --partition=amilan
#SBATCH --output=%x.%j.log # gives jobname.ID.log
echo "This is $SLURM_JOB_NAME with job ID $SLURM_JOB_ID"
sleep 10

