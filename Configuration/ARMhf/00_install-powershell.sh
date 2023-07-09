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

###################################
# Prerequisites

# Update package lists
sudo apt update

# Install dependencies
sudo apt install libunwind8 -y

# workaround for raspberry pi 4, download from https://packages.debian.org/bullseye/libssl1.1
mkdir ~/downloads
cd ~/downloads
wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.1n-0+deb11u5_armhf.deb
sudo dpkg -i libssl1.1_1.1.1n-0+deb11u5_armhf.deb
rm ~/downloads/libssl1.1_1.1.1n-0+deb11u5_armhf.deb


###################################
# Download and extract PowerShell
cd ~/downloads
# Grab the latest tar.gz
wget https://github.com/PowerShell/PowerShell/releases/download/v7.3.5/powershell-7.3.5-linux-arm32.tar.gz

# Make folder to put powershell
sudo mkdir /opt/powershell

# Unpack the tar.gz file
sudo tar -xvf ./powershell-7.3.5-linux-arm32.tar.gz -C /opt/powershell

# Remo the tar.gz file
rm ~/downloads/powershell-7.3.5-linux-arm32.tar.gz

# Start PowerShell from bash with sudo to create a symbolic link
# sudo /opt/powershell/pwsh -command 'New-Item -ItemType SymbolicLink -Path "/usr/bin/pwsh" -Target "$PSHOME/pwsh" -Force'

# alternatively you can run following to create a symbolic link
sudo ln -s /opt/powershell/pwsh /usr/bin/pwsh

# Now to start PowerShell you can just run "pwsh"

# Start PowerShell
#~/powershell/pwsh