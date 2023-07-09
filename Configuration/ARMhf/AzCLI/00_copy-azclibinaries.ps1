param (
    [Parameter(Mandatory=$true)][string]$username,
    [Parameter(Mandatory=$true)][string]$remoteHost,
    [Parameter(Mandatory=$true)][string]$port
)

$sourceDir = ".\binaries\"
$filetocopy = "azure_cli-2.50.0-py3-none-any.whl"
$remoteDir = "~/staging/"

# Create the target folder on the remote host
Write-Output "Creating remote directory..."
ssh -p $port $username@$remoteHost "mkdir $remoteDir"

# Copy the file to the remote host
Write-Output "Copying file to remote host..."
# Note: You will need to manually enter the password for this step
scp -P $port $sourceDir$filetocopy  "${username}@${remoteHost}:${remoteDir}"
