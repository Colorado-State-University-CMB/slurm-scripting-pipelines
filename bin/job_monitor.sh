#!/usr/bin/env bash
DEFAULT_SECONDS_BETWEEN_CMDS=4

# makes the restart message more concise by not including the full path to this script, if it is already in $PATH
this_script=$(basename $0)
hash $this_script || this_script=$0

if [ $# -eq 0 ]
then
    echo "USAGE:"
    echo "	$0 all"
    echo "	$0 jobid1,jobid2"
    echo "optional second parameter: interval between commands"
    echo "	$0 all 5"
    echo "	$0 jobid1,jobid2 10"
    exit 1
fi

# handle args
JOB_IDS=$1
interval=${2:-$DEFAULT_SECONDS_BETWEEN_CMDS} 

if [ "$JOB_IDS" = "all" ]
then
    J_ARG=""
else
    J_ARG="-j $JOB_IDS"
fi

# SLURM commands to check jobs
sacct_cmd="sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason $J_ARG"
squeue_cmd="squeue -u $USER $J_ARG"

while true
do
    echo $sacct_cmd
    eval $sacct_cmd
    echo
    echo $squeue_cmd
    eval $squeue_cmd
    echo
    echo


    # if jobs are finished, break loop
    if sacct -X --format State $J_ARG -P | grep -qE "RUNNING|PENDING"
    then
        echo "Hit CTRL-C to quit monitoring jobs {$JOB_IDS}. Run \`$this_script $@\` to restart job monitor."
    else
        echo "No jobs are running or pending... done."
        break
    fi

    sleep $interval
done
