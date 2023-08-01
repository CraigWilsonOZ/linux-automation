#!/bin/bash

# Ubuntu 22.04 LTS

# Set DEBIAN_FRONTEND to noninteractive
export DEBIAN_FRONTEND=noninteractive

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root or using sudo."
  exit 1
fi

# Setup Microsoft Repo for VS Code
sudo apt install wget gpg -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# Install VS code
sudo apt install apt-transport-https -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt update 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface"
sudo apt install code -y 2>&1 | grep -v "WARNING: apt does not have a stable CLI interface" # or code-insiders 

# List of extensions to install
extensions=(
  # Language and Framework Support
  "dbaeumer.vscode-eslint"                # ESLint
  "esbenp.prettier-vscode"                # Prettier
  "ms-python.python"                      # Python
  "eamodio.gitlens"                       # GitLens
  "ms-vscode.cpptools"                    # C/C++
  "golang.go"                             # Go
  "redhat.java"                           # Java
  "ms-vscode.csharp"                      # C#
  "rust-lang.rust-analyzer"               # Rust
  "visualstudioexptteam.vscodeintellicode" # IntelliCode (AI-assisted IntelliSense)

  # Containerization
  "ms-azuretools.vscode-docker"           # Docker
  "ms-vscode-remote.remote-containers"    # Remote - Containers
  "ms-vscode-remote.remote-ssh-containers" # Remote - SSH: Containers
    
  # Web Development
  
  # Productivity and Utilities
  "ms-vscode-remote.remote-ssh"           # Remote - SSH
  "humao.rest-client"                     # REST Client
  "mechatroner.rainbow-csv"               # Rainbow CSV
  "yzhang.markdown-all-in-one"            # Markdown All in One
  "shardulm94.trailing-spaces"            # Trailing Spaces

  # Testing and Debugging
  
  # Code Snippets

  # Azure Development
  "ms-azuretools.vscode-azureappservice"   # Azure App Service
  "ms-azuretools.vscode-azurefunctions"    # Azure Functions
  "ms-azuretools.vscode-azurestorage"      # Azure Storage
  "ms-azuretools.vscode-azureresourcegroups" # Azure Resource Groups
  "ms-azuretools.vscode-azurevirtualmachines" # Azure Virtual Machines
  "ms-azuretools.vscode-azuredatabases"    # Azure Databases
  "ms-azuretools.vscode-azureterraform"    # Azure Terraform
  "ms-vscode.azurecli"                     # Azure CLI

  # Terraform Development
  "hashicorp.terraform"                   # HashiCorp Terraform
)

# Function to install VS Code extensions
function install_vscode_extensions() {
  sudo_user="$SUDO_USER"
  echo "Running as user: $sudo_user"
  
  for extension in "${extensions[@]}"; do
    echo "Installing $extension..."
    sudo -u "$sudo_user" code --install-extension $extension 
  done
}

# Check if VS Code is installed
if ! [ -x "$(command -v code)" ]; then
  echo "Visual Studio Code is not installed. Please install it and try again."
  exit 1
fi

# Install the extensions
install_vscode_extensions

echo "Visual Studio Code extensions installation completed!"
