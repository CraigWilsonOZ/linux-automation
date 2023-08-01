#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Add Google Chrome repository key
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Add Google Chrome repository to sources list
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Update package lists
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Install Google Chrome
sudo apt install google-chrome-stable -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Verify installation
google-chrome --version

echo "Google Chrome installation completed!"
