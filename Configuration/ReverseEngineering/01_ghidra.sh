#!/bin/bash

# Script to download and install Ghidra on Ubuntu as a standard user.

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Update the system
sudo apt update && sudo apt install -y wget unzip default-jre 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Directory to store Ghidra
GHIDRA_DIR="$HOME/tools/ghidra"
mkdir -p "$GHIDRA_DIR"

# Download and install Ghidra
GHIDRA_URL="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.3.2_build/ghidra_10.3.2_PUBLIC_20230711.zip" # This URL might need to be updated for newer versions.
wget "$GHIDRA_URL" -O "$GHIDRA_DIR/ghidra.zip"
unzip "$GHIDRA_DIR/ghidra.zip" -d "$GHIDRA_DIR"
rm "$GHIDRA_DIR/ghidra.zip"

# Set JAVA_HOME if not set
JAVA_PATH=$(update-java-alternatives --list | awk '{print $3}' | head -1)

if ! grep -q "export JAVA_HOME=$JAVA_PATH" ~/.bashrc; then
    echo "export JAVA_HOME=$JAVA_PATH" >> ~/.bashrc
    echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
fi

source ~/.bashrc

# Create a desktop shortcut
cat <<EOF > ~/Desktop/ghidra.desktop
[Desktop Entry]
Name=Ghidra
Exec=$GHIDRA_DIR/ghidraRun
Icon=$GHIDRA_DIR/docs/images/GHIDRA.png
Terminal=false
Type=Application
Categories=Utility;Development;
EOF

chmod +x ~/Desktop/ghidra.desktop
