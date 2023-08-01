#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Update the list of packages
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
# Install pre-requisite packages.
sudo apt install -y wget apt-transport-https software-properties-common 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
# Download the Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Delete the the Microsoft repository GPG keys file
rm packages-microsoft-prod.deb
# Update the list of packages after we added packages.microsoft.com
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
# Install PowerShell
sudo apt install -y powershell 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
# Start PowerShell
pwsh