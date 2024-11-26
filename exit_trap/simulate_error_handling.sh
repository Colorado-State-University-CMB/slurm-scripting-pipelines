#!/usr/bin/env bash
# Simulate error handling behavior based on a random choice within these possibilities:
# The random number determines the following outcomes:
outcomes=( "syntax error" "controlled error" "early success" "full success")
outcome=${outcomes[$((RANDOM % ${#outcomes[*]}))]} # sorry for ugly syntax
echo "Simulating outcome: $outcome"
#
# Establish error function and trap
set -e # exit on error
davidsExitFunc()
{
    exitcode=$1
    if [ -z "$exitcode" ] || [ $exitcode -eq 0 ] # wasn't provided or is 0
    then
        echo "<<<<<< Script reached $JOBSTEP successfully at $(date) >>>>>>"
    else
        echo "<<<<<< Script failed at $JOBSTEP with exit code $exitcode at $(date) >>>>>>"
    fi
    
}
trap 'davidsExitFunc $?' EXIT

# BEGIN WORKFLOW
# We are just going to read which outcome was randomly selected
# and cause the given outcome to trigger the EXIT
echo "<<<<<< Script started at $(date) >>>>>>"

JOBSTEP="SYNTAX ERROR"
if [ "$outcome" == "syntax error" ]
then
    [ 1 -lt ] # missing second operand
fi

JOBSTEP="CONTROLLED ERROR"
if [ "$outcome" == "controlled error" ]
then
    exit 1
fi

JOBSTEP="EARLY SUCCESS"
if [ "$outcome" == "early success" ]
then
    exit 0
fi

JOBSTEP=END

echo "got to end!!!"
