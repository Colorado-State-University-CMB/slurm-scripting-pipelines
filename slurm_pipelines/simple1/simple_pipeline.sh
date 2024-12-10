#!/usr/bin/env bash
network_prefix=$(ip route show default | awk -F'[ .]' '{print $3 "." $4}')
SERVER=$( ( [ "$network_prefix" = 129.82 ] && echo "CSU" ) || ( [ "$network_prefix" = 198.59 ] && echo "CU" ) || echo "unknown" )
if [ "$SERVER" = CU ]
then
    partition_arg="--partition=amilan "
fi

step1=$(sbatch --parsable $partition_arg  sleep10.sh)
step2=$(sbatch --parsable --dependency=afterok:$step1 $partition_arg sleep10.sh )
step3=$(sbatch --parsable --dependency=afterok:$step2 $partition_arg sleep10.sh )


# takes a moment to get going
sleep 1

job_monitor.sh $step1,$step2,$step3

