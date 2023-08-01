#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Current file at time of creation, check https://obsidian.md/download website for latest version
Filename="obsidian_1.3.7_amd64.deb"

# Add Obsidian repository and key
wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.3.7/obsidian_1.3.7_amd64.deb"
sudo dpkg -i $Filename

# Install Obsidian
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt install obsidian -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Install missing dependencies if any
sudo apt install -f -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Clean up downloaded package
rm $Filename

echo "Obsidian installation completed!"
