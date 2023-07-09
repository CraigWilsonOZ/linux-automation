#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# download rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup.sh
# set permissions to execute
chmod +x rustup.sh
# run rustup to install rust
./rustup.sh --profile default -y

# remove rustup.sh
rm rustup.sh

# Directory path to add to PATH
directory_path="$HOME/.cargo/"

# Check if the directory already exists in PATH
if [[ ":$PATH:" == *":$directory_path:"* ]]; then
  echo "Directory already exists in PATH."
else
  # Add the directory to PATH
  echo "Adding directory to PATH..."
  echo "export PATH=\$PATH:$directory_path" >> ~/.bashrc
  source ~/.bashrc
  echo "Directory added to PATH."
fi