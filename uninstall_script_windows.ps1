# Function to uninstall a package using winget
function Uninstall-Package {
    param (
        [string]$packageName
    )

    # Check if the package is installed
    $packageInstalled = winget list | Select-String -Pattern $packageName
    if ($packageInstalled) {
        Write-Host "Uninstalling $packageName..."
        winget uninstall --id $packageName --silent --accept-package-agreements --accept-source-agreements
    } else {
        Write-Host "$packageName is not installed."
    }
}

# Uninstall poetry using pipx
pipx uninstall poetry

# Uninstall pipx using Scoop
scoop uninstall pipx

# Remove Scoop from the path
$scoopPath = "$($env:USERPROFILE)\scoop\shims"
[System.Environment]::SetEnvironmentVariable('PATH', $env:PATH -replace ";$scoopPath", '', [System.EnvironmentVariableTarget]::Machine)
$env:PATH = $env:PATH -replace ";$scoopPath", ''

# Uninstall Scoop (deletes scoop directory)
Remove-Item -Recurse -Force "$($env:USERPROFILE)\scoop"

# Uninstall pyenv specific version of Python
pyenv uninstall 3.9.7

# Reset pyenv global to system
pyenv global system

# Remove pyenv from environment variables
$env:PYENV = "$($env:USERPROFILE)\.pyenv"
$env:PATH = $env:PATH -replace "$env:PYENV\pyenv-win\bin;", ''
$env:PATH = $env:PATH -replace "$env:PYENV\pyenv-win\shims;", ''
[System.Environment]::SetEnvironmentVariable('PATH', $env:PATH, [System.EnvironmentVariableTarget]::Process)

# Uninstall pyenv
Uninstall-Package -packageName "pyenv.pyenv"

# Uninstall AWS CLI
Uninstall-Package -packageName "Amazon.AWSCLI"

# Uninstall Git
Uninstall-Package -packageName "Git.Git"

# Uninstall Chocolatey
choco uninstall -y chocolatey

# Remove Chocolatey environment variables
$chocoPath = "$($env:SystemDrive)\ProgramData\chocolatey\bin"
$env:PATH = $env:PATH -replace ";$chocoPath", ''
[System.Environment]::SetEnvironmentVariable('PATH', $env:PATH, [System.EnvironmentVariableTarget]::Process)
[System.Environment]::SetEnvironmentVariable('PATH', $env:PATH, [System.EnvironmentVariableTarget]::Machine)

Write-Host "All specified packages have been uninstalled and environment variables reset."

