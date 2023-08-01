param (
    [Parameter(Mandatory=$true)][string]$username,
    [Parameter(Mandatory=$true)][string]$remoteHost,
    [Parameter(Mandatory=$true)][string]$port,
    [Parameter(Mandatory=$true)][string]$sourceFolderPath,
    [Parameter(Mandatory=$true)][string]$logFolderPath,
    [Parameter(Mandatory=$true)][string]$targetFolderPath
)

# SSH Key
$sshDir = "$HOME\.ssh"
$keyPath = "$sshDir\id_rsa"

# Check if password was set in environment variable
if ($env:SSH_SUDO_PASSWORD) {
    # Decode base64 password to plain text
    write-Output "Using password from environment variable..."
    $password = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($env:SSH_SUDO_PASSWORD))
}
else {
    # If not, prompt user for password
    write-Output "Password not found in environment variable. Prompting user for password..."
    $securePassword = Read-Host -AsSecureString -Prompt "Enter SSH password for sudo commands: "
    
    # Convert SecureString to plain text
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword)
    $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

    # Clean up
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)

    # Convert password to base64 and store it in environment variable
    $env:SSH_SUDO_PASSWORD = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($password))
}


# Get the list of scripts in the source folder
$scriptFiles = Get-ChildItem -Path $sourceFolderPath -Filter "*.sh"

# Create the target folder on the remote host
Write-Output "Creating target folder on remote host if it doesn't exist..."
ssh -p $port -i $keyPath $username@$remoteHost "mkdir -p $targetFolderPath"

# Copy the scripts to the remote host
Write-Output "Copying scripts to remote host..."
foreach ($scriptFile in $scriptFiles) {
    write-Output "Copying script: ${scriptFile.Name}..."
    $remoteFilePath = "${username}@${remoteHost}:${targetFolderPath}/${scriptFile.Name}"
    scp -P $port -i $keyPath $scriptFile.FullName $remoteFilePath
}

#sort the scripts by name
$sortedScriptFiles = $scriptFiles | Sort-Object Name

# Run the scripts on the remote host
Write-Output "Running scripts on remote host..."
foreach ($scriptFile in $sortedScriptFiles) {
    write-Output "Running script: $($scriptFile.Name)..."
    $remoteScriptPath = "${targetFolderPath}/$($scriptFile.Name)"
    write-Output " script: $remoteScriptPath"
    $logPath = "${targetFolderPath}/$($scriptFile.Name).log"
    write-Output " log: $logPath"
    
    # Set script as executable
    Write-Output "Setting script $($scriptFile.Name) as executable..."
    ssh -p $port -i $keyPath  $username@$remoteHost "chmod +x $remoteScriptPath"
    
    Write-Output "Starting script: $($scriptFile.Name)..."
    ssh -p $port -i $keyPath $username@$remoteHost "echo $password | sudo -S bash $remoteScriptPath > $logPath 2>/dev/null"
    # ssh -p $port -i $keyPath $username@$remoteHost "bash $remoteScriptPath > $logPath"
    Write-Output "Completed script: $($scriptFile.Name)}. Output logged to $logPath"
}

# Copy the log files down to the local machine
Write-Output "Copying log files to local machine..."
foreach ($scriptFile in $sortedScriptFiles) {
    write-Output "Copying log file: $($scriptFile.Name).log..."
    $remoteLogPath = "${username}@${remoteHost}:${targetFolderPath}/$($scriptFile.Name).log"
    write-Output " remote: $remoteLogPath"
    $localLogPath = "${logFolderPath}/$($scriptFile.Name).log"
    write-Output " local: $localLogPath"
    scp -P $port -i "$HOME\.ssh\id_rsa" $remoteLogPath $localLogPath
}

# Remove the target folder and its contents on the remote host
Write-Output "Removing target folder and its contents on remote host..."
ssh -p $port -i "$HOME\.ssh\id_rsa" $username@$remoteHost "echo $password | sudo -S rm -rf $targetFolderPath 2>/dev/null"
Write-Output "Target folder and its contents removed on remote host."

Write-Output "Completed running scripts on remote host."