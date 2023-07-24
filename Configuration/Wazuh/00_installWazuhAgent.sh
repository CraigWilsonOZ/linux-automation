#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the management IP is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <wazuh_manager_ip>"
  exit 1
fi

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Get the Wazuh manager IP from the first argument
WAZUH_MANAGER="$1"

# update system repositories
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list

# Update the package lists
sudo apt update | grep -v "WARNING: apt does not have a stable CLI interface"

# Install the Wazuh agent
apt install wazuh-agent | grep -v "WARNING: apt does not have a stable CLI interface"

# Configure the Wazuh agent to connect to the Wazuh manager
sudo sed -i "s/MANAGER_IP/$WAZUH_MANAGER/" /var/ossec/etc/ossec.conf

# Start the Wazuh agent
sudo systemctl start wazuh-agent

# Enable the Wazuh agent to start on boot
sudo systemctl enable wazuh-agent

# Start the Wazuh agent
sudo systemctl start wazuh-agent

# Check the Wazuh agent status
sudo systemctl status wazuh-agent
