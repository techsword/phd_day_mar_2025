# Department of Cognitive Science and Artificial Intelligence PhD Day March 2025

## [SLURM](https://slurm.schedmd.com/documentation.html)

```bash
#!/bin/bash
#SBATCH --job-name=example_job    # Job name
#SBATCH --nodes=1                 # Number of nodes
#SBATCH --ntasks=1                # Number of tasks
#SBATCH --cpus-per-task=4         # Number of CPU cores per task
#SBATCH --mem=8G                  # Memory per node
#SBATCH --time=01:00:00           # Time limit hrs:min:sec
#SBATCH --output=example_%j.log   # Standard output and error log (%j expands to jobid)
#SBATCH --mail-type=BEGIN,END,FAIL # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=email@example.com  # Where to send mail

# Load any required modules if you're on a cluster with configured modules environment
# module load python/3.9

# Activate virtual environment (if using one)
source /path/to/venv/bin/activate

# Run your script
python /path/to/your/script.py

echo "Job completed at $(date)"
```

## [uv](https://docs.astral.sh/uv/)

`uv` is a Python package installer and resolver written in Rust. It's designed to be a faster, more reliable alternative to tools like `pip` and `conda`. Key features include:

- Ultra-fast package installation (up to 10-100x faster than pip)
- Drop-in replacement for pip commands
- Compatible with existing Python workflows
- Robust dependency resolution
- Supports virtual environments and isolated installations

### Installation

```bash
# Install uv on your own computer
curl -LsSf https://astral.sh/uv/install.sh | sh

# Or with pip on our cluster
pip install uv
```

### Basic Usage

```bash
# Create a virtual environment at the current working directory
uv venv

# Install packages
uv pip install numpy pandas 

# Install from requirements.txt
uv pip install -r requirements.txt

```


## [submitit](https://github.com/facebookincubator/submitit)

`submitit` is a lightweight Python package developed by Facebook Research that makes it easy to submit jobs to a SLURM cluster. It provides a simple Python interface to schedule, monitor, and retrieve results from SLURM jobs.

### Key features

- Simple Python function execution on SLURM
- Automatic job serialization and result retrieval
- Support for array jobs and job dependencies
- Easy checkpointing functionality
- Compatible with most Python workflows

### Installation

```bash
pip install submitit

# Or if you have uv installed already:
uv pip install submitit
```

### Basic Usage

```python
import submitit

# Define the function to run on the cluster
def train_model(learning_rate, epochs):
    # Your training code here
    return {"accuracy": 0.95}

# Setup the executor
executor = submitit.SlurmExecutor(folder="logs")
executor.update_parameters(
    time=60,               # 1 hour in minutes
    mem_gb=8,              # 8 GB RAM
    cpus_per_task=4,       # 4 CPU cores
    name="train_job",      # Job name
    slurm_partition="gpu"  # Partition name
)

# Submit the job
job = executor.submit(train_model, 0.01, 100)
print(f"Submitted job ID: {job.job_id}")

# Wait for completion and get results
result = job.result()
print(f"Job completed with accuracy: {result['accuracy']}")
```
