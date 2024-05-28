#!/bin/bash

# Refresh sudo timestamp
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Check if Homebrew was installed successfully
if [ $? -eq 0 ]; then
    echo "Homebrew installed successfully."

    # Install Git using Homebrew
    brew install git

    # Check if Git was installed successfully
    if [ $? -eq 0 ]; then
        echo "Git installed successfully."
    else
        echo "Failed to install Git."
        exit 1
    fi

    # Install Leapp using Homebrew
    brew install leapp

    # Check if Leapp was installed successfully
    if [ $? -eq 0 ]; then
        echo "Leapp installed successfully."
    else
        echo "Failed to install Leapp."
        exit 1
    fi

    # Install AWS CLI using Homebrew
    brew install awscli

    # Check if AWS CLI was installed successfully
    if [ $? -eq 0 ]; then
        echo "AWS CLI installed successfully."
    else
        echo "Failed to install AWS CLI."
        exit 1
    fi

    # Install pyenv using Homebrew
    brew install pyenv

    # Check if pyenv was installed successfully
    if [ $? -eq 0 ]; then
        echo "pyenv installed successfully."
    else
        echo "Failed to install pyenv."
        exit 1
    fi

    # Install pipx using Homebrew
    brew install pipx

    # Check if pipx was installed successfully
    if [ $? -eq 0 ]; then
        echo "pipx installed successfully."
    else
        echo "Failed to install pipx."
        exit 1
    fi

    # Ensure pipx path
    pipx ensurepath
    sudo pipx ensurepath --global

    # Install poetry using pipx
    pipx install poetry

    # Check if poetry was installed successfully
    if [ $? -eq 0 ]; then
        echo "poetry installed successfully."
    else
        echo "Failed to install poetry."
        exit 1
    fi

else
    echo "Failed to install Homebrew."
fi

