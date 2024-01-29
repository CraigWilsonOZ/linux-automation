#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Check if neofetch is installed
if ! command -v neofetch &>/dev/null; then
  echo "neofetch not found. Installing neofetch..."

  # Install neofetch
  apt update update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
  apt install -y neofetch  2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
else
  echo "neofetch is already installed."
fi

# Create the script to autoload neofetch
cat << EOF > /etc/profile.d/00-neofetch.sh
#!/bin/bash

# Display system information using neofetch
neofetch

# Display the MOTD updates
#/etc/update-motd.d/90-updates-available.disabled
#/etc/update-motd.d/98-reboot-required.disabled
#/etc/update-motd.d/98-fsck-at-reboot.disabled

EOF

# Set the correct permissions for the autoload script
chmod +x /etc/profile.d/neofetch.sh

echo "neofetch has been installed and autoloaded for all users."

# Removing the ubuntu default banner
mv /etc/update-motd.d/00-header /etc/update-motd.d/00-header.disabled
mv /etc/update-motd.d/10-help-text /etc/update-motd.d/10-help-text.disabled
mv /etc/update-motd.d/50-landscape-sysinfo /etc/update-motd.d/50-landscape-sysinfo.disabled
mv /etc/update-motd.d/50-motd-news /etc/update-motd.d/50-motd-news.disabled
mv /etc/update-motd.d/90-updates-available /etc/update-motd.d/90-updates-available.disabled
mv /etc/update-motd.d/91-contract-ua-esm-status /etc/update-motd.d/91-contract-ua-esm-status.disabled
mv /etc/update-motd.d/91-release-upgrade /etc/update-motd.d/91-release-upgrade.disabled
mv /etc/update-motd.d/92-unattended-upgrades /etc/update-motd.d/92-unattended-upgrades.disabled
mv /etc/update-motd.d/95-hwe-eol /etc/update-motd.d/95-hwe-eol.disabled
mv /etc/update-motd.d/97-overlayroot /etc/update-motd.d/97-overlayroot.disabled
mv /etc/update-motd.d/98-fsck-at-reboot /etc/update-motd.d/98-fsck-at-reboot.disabled
mv /etc/update-motd.d/98-reboot-required /etc/update-motd.d/98-reboot-required.disabled
mv /etc/update-motd.d/50-motd-news.dpkg-new /etc/update-motd.d/50-motd-news.dpkg-new.disabled
mv /etc/update-motd.d/60-unminimize /etc/update-motd.d/60-unminimize.disabled