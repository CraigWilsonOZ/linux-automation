#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Update system
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface" && \
    sudo apt upgrade -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface" && \
    sudo apt autoremove -y  2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"