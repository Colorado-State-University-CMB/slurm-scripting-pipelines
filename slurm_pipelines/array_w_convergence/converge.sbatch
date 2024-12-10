#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:01:00
#SBATCH --job-name=converge
#SBATCH --partition=short-cpu
#SBATCH --output=%x.%j.log # gives jobname.ID.log
# converge.sbatch - after array jobs are finished, concat their contents
dir_to_list=$1
cat $dir_to_list/*
