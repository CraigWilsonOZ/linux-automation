#!/bin/bash

# Script to download and install Binary Ninja Free on Ubuntu as a standard user.

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Update the system
# sudo apt update && sudo apt install -y wget unzip default-jre 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Directory to store Binary Ninja
BN_DOWNLOAD_DIR="$HOME/install/binaryninja"
BN_INSTALL_DIR="$HOME/tools"
mkdir -p "$BN_DOWNLOAD_DIR"
mkdir -p "$BN_INSTALL_DIR"

# Download and install Binary Ninja
BN_DOWNLOAD="https://cdn.binary.ninja/installers/BinaryNinja-demo.zip" # This URL might need to be updated for newer versions, https://binary.ninja/demo/.
wget "$BN_DOWNLOAD" -O "$BN_DOWNLOAD_DIR/BinaryNinja.zip"
unzip "$BN_DOWNLOAD_DIR/BinaryNinja.zip" -d "$BN_INSTALL_DIR"

# Clean up
rm -rf "$BN_DOWNLOAD_DIR"

