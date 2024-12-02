#!/usr/bin/env bash
echo "<<<<<< Script started at $(date) >>>>>>"
set -e

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

JOBSTEP="STEP 1"
# 1/2 pass/fail chance
[ $((RANDOM % 2)) -eq 0 ] && exit 1

JOBSTEP="STEP 2"
# 1/3 chance of failure
[ $((RANDOM % 3)) -eq 0 ] && exit 1
JOBSTEP="STEP 3"
# 1/4 chance of failure
[ $((RANDOM % 4)) -eq 0 ] && exit 1

JOBSTEP="END"
echo "you made it!"

