#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

BANNER_FILE="/etc/ssh/banner"
SSH_CONFIG="/etc/ssh/sshd_config"

# Create the SSH banner file
cat << EOF > "$BANNER_FILE"
*******************************************************************************
**                     NOTICE TO USERS OF THIS SYSTEM                        **
**                                                                           **
** This computer system is for authorized use only.                          **
**                                                                           **
** Users (authorized or unauthorized) have no explicit or implicit           **
** expectation of privacy. Any or all uses of this system and all files on   **
** this system may be intercepted, monitored, recorded, copied, audited,     **
** inspected, and disclosed to authorized site, and law enforcement          **
** personnel, as well as authorized officials of other agencies, both        **
** domestic and foreign.                                                     **
**                                                                           **
** By using this system, the user consents to such interception, monitoring, **
** recording, copying, auditing, inspection, and disclosure at the           **
** discretion of authorized site or personnel.                               **
**                                                                           **
** Unauthorized or improper use of this system may result in disciplinary    **
** action, as well as civil and criminal penalties.                          **
**                                                                           **
** By continuing to use this system, you indicate your awareness of and      **
** consent to these terms and conditions of use.                             **
*******************************************************************************
EOF

# Add or update the Banner configuration in SSH config
if grep -q "Banner $BANNER_FILE" "$SSH_CONFIG"; then
  echo "Banner configuration already exists. Skipping..."
else
  echo "Banner $BANNER_FILE" >> "$SSH_CONFIG"
fi

# Restart the SSH service
service ssh restart

echo "SSH banner with a detailed legal disclaimer has been added successfully."
