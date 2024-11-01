## Example using simple_pipeline.sh on Riviera

Using the tools in this repository, you can launch the simple pipeline that has three steps: the sleep10 script runs three times in succession, each waiting for the last to finish using the `--dependency` argument to specify the previous jobs.

```bash
(base) [dking@login001 ~/dev/slurm-scripting-pipelines/slurm_pipelines/simple1]$ bash simple_pipeline_riviera.sh 
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736        allocation          0    PENDING   00:00:01            2024-10-31T15:23:14             Unknown                   None 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             25737 short-cpu sleep_10    dking PD       0:00      1 (Dependency)
             25738 short-cpu sleep_10    dking PD       0:00      1 (Dependency)
             25736 short-cpu sleep_10    dking  R       0:01      1 node001

Hit CTRL-C to quit monitoring jobs {25736,25737,25738}. Run `job_monitor.sh 25736,25737,25738` to restart job monitor.
```

```base
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736          sleep_10          1    RUNNING   00:00:05   00:01:00 2024-10-31T15:23:14             Unknown                   None 
25737          sleep_10          0    PENDING   00:00:00   00:01:00             Unknown             Unknown             Dependency 
25738          sleep_10          0    PENDING   00:00:00   00:01:00             Unknown             Unknown             Dependency 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             25737 short-cpu sleep_10    dking PD       0:00      1 (Dependency)
             25738 short-cpu sleep_10    dking PD       0:00      1 (Dependency)
             25736 short-cpu sleep_10    dking  R       0:05      1 node001


Hit CTRL-C to quit monitoring jobs {25736,25737,25738}. Run `job_monitor.sh 25736,25737,25738` to restart job monitor.
```

```base
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736          sleep_10          1    RUNNING   00:00:09   00:01:00 2024-10-31T15:23:14             Unknown                   None 
25737          sleep_10          0    PENDING   00:00:00   00:01:00             Unknown             Unknown             Dependency 
25738          sleep_10          0    PENDING   00:00:00   00:01:00             Unknown             Unknown             Dependency 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             25737 short-cpu sleep_10    dking PD       0:00      1 (Dependency)
             25738 short-cpu sleep_10    dking PD       0:00      1 (Dependency)
             25736 short-cpu sleep_10    dking  R       0:09      1 node001


Hit CTRL-C to quit monitoring jobs {25736,25737,25738}. Run `job_monitor.sh 25736,25737,25738` to restart job monitor.
```

```bash
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:14 2024-10-31T15:23:24                   None 
25737          sleep_10          1    RUNNING   00:00:04   00:01:00 2024-10-31T15:23:24             Unknown             Dependency 
25738          sleep_10          0    PENDING   00:00:00   00:01:00             Unknown             Unknown             Dependency 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             25738 short-cpu sleep_10    dking PD       0:00      1 (Dependency)
             25737 short-cpu sleep_10    dking  R       0:04      1 node001


Hit CTRL-C to quit monitoring jobs {25736,25737,25738}. Run `job_monitor.sh 25736,25737,25738` to restart job monitor.
```

```bash
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:14 2024-10-31T15:23:24                   None 
25737          sleep_10          1    RUNNING   00:00:08   00:01:00 2024-10-31T15:23:24             Unknown             Dependency 
25738          sleep_10          0    PENDING   00:00:00   00:01:00             Unknown             Unknown             Dependency 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             25738 short-cpu sleep_10    dking PD       0:00      1 (Dependency)
             25737 short-cpu sleep_10    dking  R       0:08      1 node001


Hit CTRL-C to quit monitoring jobs {25736,25737,25738}. Run `job_monitor.sh 25736,25737,25738` to restart job monitor.
```

```bash
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:14 2024-10-31T15:23:24                   None 
25737          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:24 2024-10-31T15:23:34             Dependency 
25738          sleep_10          0    PENDING   00:00:00   00:01:00             Unknown             Unknown             Dependency 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             25738 short-cpu sleep_10    dking  R       0:02      1 node001


Hit CTRL-C to quit monitoring jobs {25736,25737,25738}. Run `job_monitor.sh 25736,25737,25738` to restart job monitor.
```

```bash
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:14 2024-10-31T15:23:24                   None 
25737          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:24 2024-10-31T15:23:34             Dependency 
25738          sleep_10          1    RUNNING   00:00:06   00:01:00 2024-10-31T15:23:34             Unknown             Dependency 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             25738 short-cpu sleep_10    dking  R       0:06      1 node001


Hit CTRL-C to quit monitoring jobs {25736,25737,25738}. Run `job_monitor.sh 25736,25737,25738` to restart job monitor.
```

```bash
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:14 2024-10-31T15:23:24                   None 
25737          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:24 2024-10-31T15:23:34             Dependency 
25738          sleep_10          1    RUNNING   00:00:10   00:01:00 2024-10-31T15:23:34             Unknown             Dependency 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             25738 short-cpu sleep_10    dking  R       0:10      1 node001


Hit CTRL-C to quit monitoring jobs {25736,25737,25738}. Run `job_monitor.sh 25736,25737,25738` to restart job monitor.
```

```bash
sacct -X --format JobID,JobName,AllocCPUS,State,Elapsed,TimeLimit,Start,End,Reason -j 25736,25737,25738
JobID           JobName  AllocCPUS      State    Elapsed  Timelimit               Start                 End                 Reason 
------------ ---------- ---------- ---------- ---------- ---------- ------------------- ------------------- ---------------------- 
25736          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:14 2024-10-31T15:23:24                   None 
25737          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:24 2024-10-31T15:23:34             Dependency 
25738          sleep_10          1  COMPLETED   00:00:10   00:01:00 2024-10-31T15:23:34 2024-10-31T15:23:44             Dependency 

squeue -u dking -j 25736,25737,25738
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)


No jobs are running or pending... done.
```
