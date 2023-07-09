#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

OPENSSL_CONFIG="/etc/ssl/openssl.cnf"

# Create a backup of the original OpenSSL configuration file
cp "$OPENSSL_CONFIG" "$OPENSSL_CONFIG.bak"

# Update the OpenSSL configuration file
sed -i '/^\[system_default_sect\]$/a MinProtocol = TLSv1.2' "$OPENSSL_CONFIG"
sed -i '/^\[system_default_sect\]$/a CipherString = DEFAULT@SECLEVEL=2' "$OPENSSL_CONFIG"

echo "OpenSSL configuration has been updated."

# Restart any services using OpenSSL (e.g., Apache, Nginx) for changes to take effect
echo "Restarting services using OpenSSL..."
service apache2 restart
service nginx restart

echo "Services using OpenSSL have been restarted."
