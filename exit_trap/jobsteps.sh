#!/usr/bin/env bash
set -e
JOBSTEP=START
echo "Script started at $(date)"

trap 'echo "(exit $?) Script reached $JOBSTEP at $(date) "' EXIT

JOBSTEP=STEP1
JOBSTEP=STEP2
[ 1 -lt  4 ] # remove a number to trigger the program to crash (set -e above)
JOBSTEP=STEP3
[ 1 -lt  5 ] # remove a number to trigger the program to crash (set -e above)
JOBSTEP=STEP4
JOBSTEP=END

