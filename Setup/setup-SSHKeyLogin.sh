#!/bin/bash

# Parameters
username=$1
remoteHost=$2
port=$3

# Check parameters
if [ -z "$username" ] || [ -z "$remoteHost" ] || [ -z "$port" ]; then
    echo "Usage: $0 <username> <remote_host> <port>"
    exit 1
fi

sshDir="$HOME/.ssh"
keyPath="$sshDir/id_rsa"

# Ensure SSH directory exists
echo "Checking if SSH directory exists locally..."
mkdir -p $sshDir

# Generate SSH key pair if not already exist
if [ ! -f "$keyPath" ]; then
    echo "SSH key pair not found. Generating SSH key pair..."
    ssh-keygen -t rsa -b 2048 -f $keyPath -N "" # No passphrase
    echo "SSH key pair generated."
fi

# Copy public key to remote host using ssh-copy-id
echo "Copying public key to remote host..."
ssh-copy-id -p $port -i "$keyPath.pub" "$username@$remoteHost"
echo "Public key copied to remote host."

# After running this script, you should be able to connect to the remote host without a password using the private key.
