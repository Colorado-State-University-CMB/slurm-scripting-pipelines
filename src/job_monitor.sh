#!/usr/bin/env bash
DEFAULT_SECONDS_BETWEEN_CMDS=1
PROGNAME=$0
PROGARGS="$@"
# this is to shorten the restart message if this script is in the USER PATH
PROGBASENAME=$(basename $PROGNAME)
if hash $PROGBASENAME 2> /dev/null
then
    PROGNAME=$PROGBASENAME
fi

restart_message() 
{
    echo -e "Type $@ to restart job monitor"
}
#trap "restart_message $0 $@"  SIGINT


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
#sacct_cmd="sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason $J_ARG"
sacct_cmd="SLURM_TIME_FORMAT='%H:%M:%S' sacct -X --format JobID%15,JobName,AllocCPUS%8,State,Elapsed%8,Timelimit%9,Start%8,End%8,Reason%17 $J_ARG"
squeue_cmd="squeue -u $USER $J_ARG"

# shorten for readability, user won't be able to see exactly what was done
W=51 # approximate middle of longer output (from sacct)
display_squeue_cmd="squeue -u $USER $J_ARG"
display_sacct_cmd="sacct -X $J_ARG"
# str lengths
w_display_squeue_cmd=${#display_squeue_cmd}
w_display_sacct_cmd=${#display_sacct_cmd}

# figure out padding
PAD=$(($W + $w_display_squeue_cmd / 2))
display_squeue_cmd=$(printf "% ${PAD}s" "$display_squeue_cmd")      
PAD=$(($W + $w_display_sacct_cmd / 2))
display_sacct_cmd=$(printf "% ${PAD}s" "$display_sacct_cmd") 

if false
then
    # Go at least MIN_ITERATIONS through the loop
    # This is to avoid getting empty data from sacct in the moments
    # that the job is setting up, which this script will detect as "jobs finished"
    MIN_ITERATIONS=2
    i=1
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
            if [ $i -gt $MIN_ITERATIONS ]
            then
                break
            fi
        fi

        sleep $interval
        i=$((i++))
    done
else
    interval_command="echo $PROGNAME $PROGARGS; echo $'\n'\"$display_squeue_cmd\"$'\n'; $squeue_cmd; echo $'\n'\"$display_sacct_cmd\"$'\n'; $sacct_cmd"
    trap "{ clear; $interval_command; echo; restart_message $PROGNAME $PROGARGS; exit 0; }" SIGINT
    watch -t -n $interval "$interval_command; echo $'\n' 'CTRL-C to quit.'"
fi


