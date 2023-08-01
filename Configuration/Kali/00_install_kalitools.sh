#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# List of top 15 Kali Linux command-line tools
tools=(
  nmap
  metasploit-framework
  burpsuite
  sqlmap
  aircrack-ng
  john
  hydra
  hashcat
  nikto
  dirb
  wpscan
  gobuster
  enum4linux
  seclists
  exploitdb
)

# Add Kali Linux repositories to APT
echo "Adding Kali Linux repositories to APT..."
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list.d/kali.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ED444FF07D8D0BF6 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ED444FF07D8D0BF6
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Install Kali Linux tools
echo "Installing Kali Linux tools..."
sudo apt install "${tools[@]}" -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

# Remove Kali Linux repositories from APT
echo "Removing Kali Linux repositories from APT..."
sudo rm /etc/apt/sources.list.d/kali.list
sudo apt-key del ED444FF07D8D0BF6

touch ~/.hushlogin

sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"

echo "Installation complete!"
