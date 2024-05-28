# Set execution policy to bypass for this process
Set-ExecutionPolicy Bypass -Scope Process -Force

# Ensure TLS 1.2 is used for the download
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

# Download and execute the Chocolatey installation script
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Git
choco install git -y

# Install AWS CLI
choco install awscli -y

# Install pyenv
choco install pyenv-win -y

# Install pipx using Chocolatey
choco install pipx -y

# Ensure pipx path is added to shell
pipx ensurepath

# Install poetry using pipx
pipx install poetry
