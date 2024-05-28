# Set execution policy to bypass for thi
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

# Install pipx using pip
python -m pip install --user pipx

# Ensure pipx path is added to shell
$env:Path += ";$([System.Environment]::GetFolderPath('LocalApplicationData'))\Programs\Python\Python39\Scripts"
pipx ensurepath

# Install poetry using pipx
pipx install poetry
