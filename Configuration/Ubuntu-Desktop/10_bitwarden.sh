#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Set the initial URL
initial_url="https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb"

# Use wget to follow the redirect and capture the final URL
final_url=$(wget --max-redirect=0 -S "$initial_url" 2>&1 | grep -i 'Location' | awk '{print $2}')

# Print the final URL
echo "Downloading from URL: $final_url"

# Extract the filename using basename
Filename=$(basename "$final_url")

# Add Bitwarden repository and key
wget $final_url
sudo dpkg -i $Filename

# Install Bitwarden
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt install bitwarden -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Install missing dependencies if any
sudo apt install -f -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Clean up downloaded package
rm $Filename

echo "Bitwarden installation completed!"
