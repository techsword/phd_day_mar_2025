import submitit
import numpy as np


def my_function(x):
    return x**2


executor = submitit.AutoExecutor(folder="submitit_jobs")
executor.update_parameters(
    timeout_min=1, 
    slurm_partition="CPU", 
    name="test-cpu",
)
job = executor.submit(my_function, 2)

cpu_jobid = job.job_id


# GPU execution
executor = submitit.AutoExecutor(folder="submitit_jobs")
executor.update_parameters(
    timeout_min=1,
    slurm_partition="GPU",
    name="test-gpu",
)

job = executor.submit(my_function, 2)
gpu_jobid = job.job_id


print(f"CPU job id: {cpu_jobid}")
print(f"GPU job id: {gpu_jobid}")

# Use command line to check the past two jobs
# $ sacct -j gpu_jobid
