#!/bin/bash

#SBATCH --output=vscode_tunnel_job.out
#SBATCH --job-name="code"
#SBATCH --partition=CPU # partition of the compute node
##SBATCH --gres=gpu # Double # to comment things out here in the shebang block
##SBATCH --gpus-per-node=1 
##SBATCH --time 0-1  # Walltime for the job

set -e

source /usr/local/anaconda3/etc/profile.d/conda.sh

CLI_PATH="${HOME}/.local/vscode_cli"

# Install the VS Code CLI command if it doesn't exist
if [[ ! -e ${CLI_PATH}/code ]]; then
    echo "Downloading and installing the VS Code CLI command"
    mkdir -p "${HOME}/.local/vscode_cli"
    pushd "${HOME}/.local/vscode_cli"
    # Process from: https://code.visualstudio.com/docs/remote/tunnels#_using-the-code-cli
    curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
    # unpack the code binary file
    tar -xf vscode_cli.tar.gz
    # clean-up
    rm vscode_cli.tar.gz
    popd
fi

# run the code tunnel command and accept the licence
${CLI_PATH}/code tunnel --accept-server-license-terms
