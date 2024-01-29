#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# update system repositories
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# install base tools
sudo apt install htop cmatrix curl wget tmux vim nano open-vm-tools -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# install development tools
sudo apt install build-essential git -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# install connectivity
sudo apt install openvpn -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
