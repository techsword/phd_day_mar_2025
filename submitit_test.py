import submitit 
import numpy as np

def my_function(x):
    return x**2


executor = submitit.AutoExecutor(folder='submitit_jobs')
executor.update_parameters(timeout_min=1, slurm_partition='CPU')
job = executor.submit(my_function, 2)

print(job.job_id)
