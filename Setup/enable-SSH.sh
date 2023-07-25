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

# install openssh server
sudo apt install openssh-server -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# enable SSH service
sudo systemctl enable ssh

# start SSH service
sudo systemctl start ssh

# check SSH service status
sudo systemctl status ssh

