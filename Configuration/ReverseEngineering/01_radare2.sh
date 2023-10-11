#!/bin/bash

# Script to download and install radare2 on Ubuntu as a standard user.

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Update the system
sudo apt update && sudo apt install -y qttools5-dev qttools5-dev-tools qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5svg5-dev make pkg-config build-essential 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Install radare2 from git repository release

# Directory to store radare2
R2_DOWNLOAD_DIR="$HOME/install/radare2"
mkdir -p "$R2_DOWNLOAD_DIR"

# Download and install radare2
R2_URL="https://github.com/radareorg/radare2/releases/download/5.8.8/radare2_5.8.8_amd64.deb" # This URL might need to be updated for newer versions.
wget "$R2_URL" -O "$R2_DOWNLOAD_DIR/radare2.deb"
sudo dpkg -i "$R2_DOWNLOAD_DIR/radare2.deb"

# Download and install radare2 IDE
R2IDE_DOWNLOAD_DIR="$HOME/install/radare2ide"
mkdir -p "$R2IDE_DOWNLOAD_DIR"

# Download and install radare2 IDE
R2IDE_URL="https://github.com/radareorg/iaito/releases/download/5.8.8/iaito_5.8.8_amd64.deb" # This URL might need to be updated for newer versions.
wget "$R2IDE_URL" -O "$R2IDE_DOWNLOAD_DIR/iaito.deb"
sudo dpkg -i "$R2IDE_DOWNLOAD_DIR/iaito.deb"

# Clean up
rm -rf "$R2_DOWNLOAD_DIR"
rm -rf "$R2IDE_DOWNLOAD_DIR"
