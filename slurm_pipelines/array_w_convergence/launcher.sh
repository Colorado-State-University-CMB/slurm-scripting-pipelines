#!/usr/bin/env bash

array_job_id=$(sbatch --parsable --array=1-5 array.sbatch)
converge_job_id=$(sbatch --parsable --dependency=afterok:${array_job_id} converge.sbatch $array_job_id)
job_monitor.sh $array_job_id,$converge_job_id
