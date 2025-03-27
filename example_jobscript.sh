#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition GPU # Name of the partition of the compute node
#SBATCH --gres=gpu:A40:1 # The resources you want for your job
#SBATCH --array=0-5%3 # If you want to submit an array job
#SBATCH --output="slurm_logs/log_data_%A_%a.out" # stdout file
#SBATCH --error="slurm_logs/log_data_%A_%a.err" # stderr file

source /usr/local/anaconda3/etc/profile.d/conda.sh

index=$SLURM_ARRAY_TASK_ID

cd $PROJECT_PATH

srun $YOUR_SCRIPT
