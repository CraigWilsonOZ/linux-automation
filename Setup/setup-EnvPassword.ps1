param (
    [Parameter(Mandatory=$true)][Security.SecureString]$password
)

# Convert SecureString to plain text
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
$PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# Convert password to base64
$base64Password = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($PlainPassword))
$env:SSH_SUDO_PASSWORD = $base64Password

# Clean up
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
