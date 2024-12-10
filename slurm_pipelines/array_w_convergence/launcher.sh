#!/usr/bin/env bash
# launcher.sh - submit array job followed by converge script, dependent on array finishing afterok
network_prefix=$(ip route show default | awk -F'[ .]' '{print $3 "." $4}')
SERVER=$( ( [ "$network_prefix" = 129.82 ] && echo "CSU" ) || ( [ "$network_prefix" = 198.59 ] && echo "CU" ) || echo "unknown" )
if [ "$SERVER" = CU ]
then
    partition_arg="--partition=amilan "
fi
array_job_id=$(sbatch --parsable --array=1-10 $partition_arg array.sbatch)
converge_job_id=$(sbatch --parsable --dependency=afterok:${array_job_id} $partition_arg converge.sbatch $array_job_id)
job_monitor.sh $array_job_id,$converge_job_id
