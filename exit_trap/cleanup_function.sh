#!/usr/bin/env bash
echo "<<<<<< Script started at $(date) >>>>>>"
set -e # exit on error
JOBSTEP=SETUP

# error handling
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

sleep 1
# BEGIN WORKFLOW
JOBSTEP=STEP1
# do something
JOBSTEP=STEP2
[ 1 -lt 4 ] # delete a number to trigger a syntax error

JOBSTEP=STEP3
exit 1 # uncomment to exit in controlled manner

JOBSTEP=STEP4
# stop prematurely but without error, perhaps debugging
#exit 0

JOBSTEP=END

