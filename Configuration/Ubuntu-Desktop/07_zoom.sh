#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Download Zoom package for 64-bit systems
wget https://zoom.us/client/latest/zoom_amd64.deb

# Install dependencies
sudo apt install libglib2.0-0 \
                  libxcb-shape0 libxcb-shm0 libxcb-xfixes0 \
                  libxcb-randr0 libxcb-image0 libfontconfig1 \
                  libgl1-mesa-glx libxi6 libsm6 libxrender1 \
                  libpulse0 libxcomposite1 libxslt1.1 \
                  libsqlite3-0 libxcb-keysyms1 libxcb-xtest0 \
                  ibus -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Install Zoom using dpkg
sudo dpkg -i zoom_amd64.deb

# Install missing dependencies if any
sudo apt install -f -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Clean up downloaded package
rm zoom_amd64.deb

echo "Zoom installation completed!"
