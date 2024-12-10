#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:01:00
#SBATCH --job-name=converge
#SBATCH --partition=short-cpu
#SBATCH --output=%x.%j.log # gives jobname.ID.log
# Available partitions
# day-long-cpu
# day-long-gpu
# day-long-highmem
# exp-gpu
# short-cpu*
# short-gpu
# short-highmem
# week-long-cpu
# week-long-gpu
# week-long-highmem

dir_to_list=$1
ls -l $dir_to_list
cat $dir_to_list/*
