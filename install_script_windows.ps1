# Save this script to a file, for example, install_tools.ps1

# Function to install a package using Chocolatey
function Install-Package {
    param (
        [string]$packageName
    )

    # Check if Chocolatey is installed
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is not installed. Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

    # Check if the package is already installed
    $packageInstalled = choco list --local-only | Select-String -Pattern $packageName
    if ($packageInstalled) {
        Write-Host "$packageName is already installed."
    } else {
        # Install the package
        Write-Host "Installing $packageName..."
        choco install $packageName -y
    }
}

# Set execution policy to bypass for this process
Set-ExecutionPolicy Bypass -Scope Process -Force

# Ensure TLS 1.2 is used for the download
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

# Install Git
Install-Package -packageName "git"

# Install AWS CLI
Install-Package -packageName "awscli"

# Install pyenv-win
Install-Package -packageName "pyenv-win"

# Initialize pyenv
$env:PYENV = "$($env:USERPROFILE)\.pyenv"
$env:PATH = "$env:PYENV\pyenv-win\bin;$env:PYENV\pyenv-win\shims;$env:PATH"

# Refresh the environment variables to ensure pyenv is in the path
[System.Environment]::SetEnvironmentVariable('PATH', $env:PATH, [System.EnvironmentVariableTarget]::Process)

# Install a specific version of Python using pyenv
pyenv install 3.9.7
pyenv global 3.9.7

# Update pip to the latest version
python -m pip install --upgrade pip

# Install Scoop as an administrator
iex "& {$(irm get.scoop.sh)} -RunAsAdmin"

# Ensure Scoop is in the path
$scoopPath = "$($env:USERPROFILE)\scoop\shims"
[System.Environment]::SetEnvironmentVariable('PATH', $env:PATH + ";$scoopPath", [System.EnvironmentVariableTarget]::Machine)
$env:PATH += ";$scoopPath"

# Install pipx using Scoop
scoop install pipx

# Ensure pipx path is added to shell
pipx ensurepath

# Install poetry using pipx
pipx install poetry

