#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Download discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"

# Install discord using dpkg
sudo dpkg -i -y discord.deb

# fix dependencies
sudo apt install -f -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Remove the downloaded .deb file
rm discord.deb

# Verify installation
discord --version
