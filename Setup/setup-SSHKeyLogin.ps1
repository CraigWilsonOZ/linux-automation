param (
    [Parameter(Mandatory=$true)][string]$username,
    [Parameter(Mandatory=$true)][string]$remoteHost,
    [Parameter(Mandatory=$true)][string]$port
)

$sshDir = "$HOME\.ssh"
$keyPath = "$sshDir\id_rsa"

# Ensure SSH directory exists
Write-Output "Checking if SSH directory exists locally..."
if (-not (Test-Path $sshDir)) {
    Write-Output "SSH directory not found. Creating SSH directory..."
    New-Item -Path $sshDir -ItemType Directory -Force
} else {
    Write-Output "SSH directory found."
}

# Generate SSH key pair if not already exist
Write-Output "Checking if SSH key pair exists..."
if (-not (Test-Path $keyPath)) {
    Write-Output "SSH key pair not found. Generating SSH key pair..."
    ssh-keygen -t rsa -b 4096 -f $keyPath -N "" # No passphrase
    Write-Output "SSH key pair generated."
} else {
    Write-Output "SSH key pair found."
}

# Copy public key to remote host using password authentication
Write-Output "Copying public key to remote host..."
# Note: You will need to manually enter the password for this step
ssh -p $port ${username}@${remoteHost} "mkdir -p ~/.ssh"
scp -P $port "${keyPath}.pub" "${username}@${remoteHost}:~/.ssh/id_rsa.pub"
Write-Output "Public key copied to remote host."

# Connect to remote host, create .ssh directory if it doesn't exist, set correct permissions and append public key to authorized_keys using password authentication
Write-Output "Appending public key to authorized_keys on remote host..."
# Note: You will need to manually enter the password for this step
ssh -p $port ${username}@${remoteHost} "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
Write-Output "Public key appended to authorized_keys on remote host."
