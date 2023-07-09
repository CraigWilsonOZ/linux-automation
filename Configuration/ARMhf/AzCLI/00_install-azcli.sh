#!/bin/bash

###################################
# Ubuntu 32bit ARMhf.

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if rust is installed
echo "Checking if Rust is installed..."
if command -v rustc >/dev/null 2>&1; then
    echo "Rust is installed."
else
    echo "Rust is not installed."
    echo "Please run the install Rust."
    exit 1
fi

sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt install python3-pip python3-venv python3-dev gcc libffi-dev libssl-dev pkg-config -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Define the path to your Python virtual environment
virtual_env_path="./.azcli_venv"
install_source_path="./staging"
cd 

# Create Python Environment to host Azure CLI
python3 -m venv ${virtual_env_path}
# Activate Python Environment
source ${virtual_env_path}/bin/activate
# Install Azure CLI dev tools
pip install ${install_source_path}/azure_cli-2.50.0-py3-none-any.whl
# pip install ${install_source_path}/azure_cli_core-2.50.0-py3-none-any.whl
# pip install ${install_source_path}/azure_cli_telemetry-1.0.8-py3-none-any.whl 

# Remove any existing alias for azurecli
sed -i '/^alias azurecli/d' ~/.bashrc

# Add the new alias for azurecli
echo "alias azurecli='source ${virtual_env_path}/bin/activate && az'" >> ~/.bashrc

# Reload the Bash configuration
source ~/.bashrc

# run azurecli to start the Azure CLI