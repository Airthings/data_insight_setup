#!/bin/bash

# Refresh sudo timestamp
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Function to check if a package is installed and uninstall it using Homebrew
function uninstall_package {
    package_name=$1
    if brew list --formula | grep -q "^${package_name}\$"; then
        echo "Uninstalling ${package_name}..."
        brew uninstall ${package_name}
        if [ $? -eq 0 ]; then
            echo "${package_name} uninstalled successfully."
        else
            echo "Failed to uninstall ${package_name}."
        fi
    else
        echo "${package_name} is not installed."
    fi
}

# Uninstall poetry using pipx
if command -v pipx &> /dev/null; then
    echo "Uninstalling poetry..."
    pipx uninstall poetry
    if [ $? -eq 0 ]; then
        echo "poetry uninstalled successfully."
    else
        echo "Failed to uninstall poetry."
    fi
else
    echo "pipx is not installed, skipping poetry uninstallation."
fi

# Uninstall pipx
uninstall_package "pipx"

# Uninstall pyenv
uninstall_package "pyenv"

# Uninstall AWS CLI
uninstall_package "awscli"

# Uninstall Leapp
uninstall_package "leapp"

# Uninstall Git
uninstall_package "git"

# Uninstall Homebrew
if command -v brew &> /dev/null; then
    echo "Uninstalling Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    if [ $? -eq 0 ]; then
        echo "Homebrew uninstalled successfully."
    else
        echo "Failed to uninstall Homebrew."
    fi
else
    echo "Homebrew is not installed."
fi

