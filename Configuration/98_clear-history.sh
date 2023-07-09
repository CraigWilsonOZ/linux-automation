#!/bin/bash

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# List all user directories in /home
user_directories=$(ls -d /home/* 2>/dev/null)

# Clear the command history for each user
for user_dir in $user_directories; do
  user=$(basename "$user_dir")
  echo "Clearing command history for user: $user"

  # Clear the command history for the user
  su - "$user" -c "history -c"
  cat /dev/null > "$user_dir/.bash_history" && chown $user:$user "$user_dir/.bash_history"
  cat /dev/null > "$user_dir/.zsh_history" && chown $user:$user "$user_dir/.zsh_history"
  cat /dev/null > "$user_dir/.fish_history" && chown $user:$user "$user_dir/.fish_history"
done

# Clear the command history for root
echo "Clearing command history for root"
history -c
cat /dev/null > /root/.bash_history
cat /dev/null > /root/.zsh_history
cat /dev/null > /root/.fish_history

echo "Command history has been cleared for all users, including root."
