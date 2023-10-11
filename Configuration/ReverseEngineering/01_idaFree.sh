#!/bin/bash

# Script to download and install IDA Free on Ubuntu as a standard user.

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Update the system
# sudo apt update && sudo apt install -y wget unzip default-jre 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Directory to store IDA Free
IDA_DOWNLOAD_DIR="$HOME/install/idafree"
IDA_INSTALL_DIR="$HOME/tools/idafree/ida-8.3"
mkdir -p "$IDA_DOWNLOADDIR"
mkdir -p "IDA_INSTALL_DIR"

# Download and install IDA Free
IDA_DOWNLOAD="https://out7.hex-rays.com/files/idafree83_linux.run" # This URL might need to be updated for newer versions, https://hex-rays.com/ida-free/#download.
wget "$IDA_DOWNLOAD" -O "$IDA_DOWNLOAD_DIR/idafree.run"
chmod +x "$IDA_DOWNLOAD_DIR/idafree.run"

# Install IDA Free
"$IDA_DOWNLOAD_DIR/idafree.run" --prefix "$IDA_INSTALL_DIR" --mode unattended

# Clean up
rm -rf "$IDA_DOWNLOAD_DIR"