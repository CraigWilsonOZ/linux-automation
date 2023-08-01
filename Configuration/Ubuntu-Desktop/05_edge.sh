#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Add Microsoft Edge repository key
wget -q -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# Add Microsoft Edge repository to sources list
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge-dev.list

# Update package lists
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"


# Install Microsoft Edge
sudo apt install microsoft-edge-dev -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Verify installation
microsoft-edge-dev --version

echo "Microsoft Edge installation completed!"
