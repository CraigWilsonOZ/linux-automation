#!/bin/bash

###################################
# Ubuntu 32bit ARMhf.

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Update and install dependencies
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt install ca-certificates curl apt-transport-https lsb-release gnupg 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Add Microsoft official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

# Add Microsoft apt repository
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

# Install Azure CLI
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt install azure-cli 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
