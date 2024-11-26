#!/usr/bin/env bash
echo "Job started at $(date)"

trap 'echo "Job finished at $(date)"' EXIT

sleep 5
