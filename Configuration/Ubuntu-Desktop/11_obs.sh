#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Add the OBS Studio PPA
sudo add-apt-repository -y ppa:obsproject/obs-studio

# Update the package index
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Install OBS Studio
sudo apt install obs-studio -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Install missing dependencies if any
sudo apt install -f -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

echo "OBS Studio installation completed!"

