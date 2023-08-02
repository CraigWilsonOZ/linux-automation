# SSH Key Automation for Remote Hosts

This script automates the process of generating an RSA key pair for SSH on the local machine, and then copying the public key to a specified remote host. This allows for password-less SSH access to the remote host using the generated key pair.

## Prerequisites

- PowerShell (script is written in PowerShell)
- SSH client installed on the local machine

## Enabling SSH on the Linux host

To enable SSH on the linux host, follow the steps in the script "enable-ssh.sh". This script will install OpenSSH and enable the service.

## Parameters

- `username`: The username for the remote host. This is a mandatory parameter.
- `remoteHost`: The hostname or IP address of the remote machine. This is a mandatory parameter.
- `port`: The SSH port number of the remote machine. This is a mandatory parameter.

## How to Use

1. Navigate to the directory where the script is located.
2. Run the script in PowerShell, making sure to provide the mandatory parameters:

```powershell

   .\script_name.ps1 -username <USERNAME> -remoteHost <REMOTE_HOST> -port <SSH_PORT>

```

## Setting up and Environment Variable

An environment variable is used on the automation script to allow passing a password over the SSH connection for sudo command. The method used to store the password using Base64 encode(not encrypted) string. The script "set-EnvPassword.ps1" will create the environment variable for you. This has been include but should be replace with a more secure method. It has been included here so the script can be run in your local environment. Running this process in a pipeline, the password can be stored in a vault solution then exported to the variable while running.
