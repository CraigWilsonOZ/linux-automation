#!/bin/bash

# List of files to copy and execute
file_list=(
  "file1.sh"
  "file2.sh"
  "file3.sh"
)

# Remote machine details
remote_user="username"
remote_host="remote_host"
remote_directory="/path/to/remote/directory"

# Iterate over the file list
for file_name in "${file_list[@]}"; do
  echo "Copying $file_name to $remote_host..."
  scp "$file_name" "$remote_user@$remote_host:$remote_directory"

  echo "Executing $file_name on $remote_host..."
  ssh "$remote_user@$remote_host" "cd $remote_directory && chmod +x $file_name && ./$file_name"
done
