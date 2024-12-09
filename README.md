# Scripting and pipeline development in a SLURM environment (HPC).
This repo has tools, demonstrations and explanatory examples.

## Organization
The contents accompany the PDF presentation Pipelines_and_slurm.pdf

#### array_job_scripts
Array launchers and convergence step pipeline wrapper script.

#### bin
Contains job_monitor.sh which will be installed with INSTALL.sh
# Scripting

I find that scripting leads naturally from working things out on the command line and realizing you'd rather automate a task and/or create a tool that you can reuse. In fact, BASH scripts are simply commands in a file that you could execute at the prompt one at a time, but are easier to run as a cohesive unit.

With that in mind, the steps to scripting that I encounter are as follows:

- Experiment/learn what commands you need
- Put commands in a file- this is your script:  Start simple. Build up.
- Refinement: Test it out, make it generalizable with special variables such as `$@` (command line input)
- Error checking: Account for possible pitfalls. Improve output.

Example slurm pipeline:

Say you have 3 steps to your code that are written in 3 separate scripts.
* step1_script.sh
* step2_script.sh
* step3_script.sh

You could combine the separate scripts into a single, large script, or you could use SLURM's dependency feature to make a simple pipeline. All you have to do is add arguments to `sbatch`.

```bash
step1_jobid=$(sbatch --parsable step1_script.sh)
step2_jobid=$(sbatch --parsable --dependency=afterok:${step1_jobid} step2_script.sh)
step3_jobid=$(sbatch --parsable --dependency=afterok:${step2_jobid} step3_script.sh)
```
Notice the use of the `$( ... )` construct to capture command output. When `sbatch` is run with the `--parsable` flag, it only returns the job ID which can be saved to a variable. That variable is referenced using the `--dependency=afterok`
