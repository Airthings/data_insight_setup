# Function to uninstall a package using winget
function Uninstall-Package {
    param (
        [string]$packageName
    )

    try {
        # Check if the package is installed
        $packageInstalled = winget list | Select-String -Pattern $packageName
        if ($packageInstalled) {
            Write-Host "Uninstalling $packageName..."
            winget uninstall --id $packageName --silent --accept-package-agreements --accept-source-agreements
        } else {
            Write-Host "$packageName is not installed."
        }
    } catch {
        Write-Host "An error occurred while uninstalling $packageName: $_"
    }
}

# Uninstall poetry using pipx
try {
    pipx uninstall poetry
} catch {
    Write-Host "An error occurred while uninstalling poetry: $_"
}

# Uninstall pipx using Scoop
try {
    scoop uninstall pipx
} catch {
    Write-Host "An error occurred while uninstalling pipx: $_"
}

# Remove Scoop from the path
try {
    $scoopPath = "$($env:USERPROFILE)\scoop\shims"
    [System.Environment]::SetEnvironmentVariable('PATH', $env:PATH -replace ";$scoopPath", '', [System.EnvironmentVariableTarget]::Machine)
    $env:PATH = $env:PATH -replace ";$scoopPath", ''
} catch {
    Write-Host "An error occurred while removing Scoop from the PATH: $_"
}

# Uninstall Scoop (deletes scoop directory)
try {
    Remove-Item -Recurse -Force "$($env:USERPROFILE)\scoop"
} catch {
    Write-Host "An error occurred while uninstalling Scoop: $_"
}

# Uninstall pyenv specific version of Python
try {
    pyenv uninstall 3.9.7
} catch {
    Write-Host "An error occurred while uninstalling Python 3.9.7 with pyenv: $_"
}

# Reset pyenv global to system
try {
    pyenv global system
} catch {
    Write-Host "An error occurred while resetting pyenv global: $_"
}

# Remove pyenv from environment variables
try {
    $env:PYENV = "$($env:USERPROFILE)\.pyenv"
    $env:PATH = $env:PATH -replace "$env:PYENV\pyenv-win\bin;", ''
    $env:PATH = $env:PATH -replace "$env:PYENV\pyenv-win\shims;", ''
    [System.Environment]::SetEnvironmentVariable('PATH', $env:PATH, [System.EnvironmentVariableTarget]::Process)
} catch {
    Write-Host "An error occurred while removing pyenv from environment variables: $_"
}

# Uninstall pyenv
Uninstall-Package -packageName "pyenv.pyenv"

# Uninstall AWS CLI
Uninstall-Package -packageName "Amazon.AWSCLI"

# Uninstall Git
Uninstall-Package -packageName "Git.Git"

# Uninstall Chocolatey
try {
    choco uninstall -y chocolatey
} catch {
    Write-Host "An error occurred while uninstalling Chocolatey: $_"
}

# Remove Chocolatey environment variables
try {
    $chocoPath = "$($env:SystemDrive)\ProgramData\chocolatey\bin"
    $env:PATH = $env:PATH -replace ";$chocoPath", ''
    [System.Environment]::SetEnvironmentVariable('PATH', $env:PATH, [System.EnvironmentVariableTarget]::Process)
    [System.Environment]::SetEnvironmentVariable('PATH', $env:PATH, [System.EnvironmentVariableTarget]::Machine)
} catch {
    Write-Host "An error occurred while removing Chocolatey from the PATH: $_"
}

Write-Host "All specified packages have been uninstalled and environment variables reset."

