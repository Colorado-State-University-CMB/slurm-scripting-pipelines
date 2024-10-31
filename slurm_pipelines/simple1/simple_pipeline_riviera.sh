#!/usr/bin/env bash

step1=$(sbatch --parsable sleep10_riviera.sh)
step2=$(sbatch --parsable --dependency=afterok:$step1 sleep10_riviera.sh )
step3=$(sbatch --parsable --dependency=afterok:$step2 sleep10_riviera.sh )


# takes a moment to get going
sleep 1

job_monitor.sh $step1,$step2,$step3

