#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Current file at time of creation, check ExpressVPN website for latest version
Filename="expressvpn_3.51.8.0-1_amd64.deb"

# Add ExpressVPN repository and key
wget https://www.expressvpn.works/clients/linux/$Filename
sudo dpkg -i $Filename

# Install ExpressVPN
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt install expressvpn -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Authenticate ExpressVPN
# echo "Please enter your ExpressVPN activation code:"
# read activation_code
# sudo expressvpn activate "$activation_code"

# Install missing dependencies if any
sudo apt install -f -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Clean up downloaded package
rm $Filename

echo "ExpressVPN installation completed!"
