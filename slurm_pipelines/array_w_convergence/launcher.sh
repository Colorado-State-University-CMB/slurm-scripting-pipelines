#!/usr/bin/env bash
# launcher.sh - submit array job followed by converge script, dependent on array finishing afterok
on_alpine=""
if [ -n "$on_alpine" ]
then
    part_arg="--partition=amilan "
else
    part_arg=""
fi
array_job_id=$(sbatch --parsable --array=1-10 $part_arg array.sbatch)
converge_job_id=$(sbatch --parsable --dependency=afterok:${array_job_id} $part_arg converge.sbatch $array_job_id)
job_monitor.sh $array_job_id,$converge_job_id
