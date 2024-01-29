#!/bin/bash

###################################
# Ubuntu 32bit ARMhf.

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Update and install dependencies
sudo apt-get update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt-get install ca-certificates curl gnupg -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Add Docker’s official GPG key
sudo install -m 0755 -d /etc/apt/keyrings 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker apt repository
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Create Docker Group
GROUP="docker"

# Check if the group already exists
if getent group "$GROUP" > /dev/null 2>&1; then
    echo "Group '$GROUP' already exists."
else
    # Add the group if it doesn't exist
    echo "Adding group '$GROUP'."
    sudo groupadd "$GROUP"
fi

# Add your user to the docker group.
sudo usermod -aG docker $USER

# Docker Test
# sudo docker run hello-world