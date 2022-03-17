param (
  [switch]$Light
)

Write-Host "Installing Windows development environment..." -ForegroundColor Green

if (!(Get-Command scoop)) {
  # Install scoop(https://scoop.sh/)
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}

scoop install 7zip git --global # for auto `git clone`
# For sudo, say, gitignore, etc commands. (https://github.com/lukesampson/psutils)
scoop install psutils

function Invoke-RemoteScript($url) {
  $script = (New-Object Net.WebClient).DownloadString($url)
  sudo Invoke-Expression("&{$script} $args")
}

Invoke-RemoteScript "https://raw.githubusercontent.com/SARDONYX-sard/dotfiles/main/windows/install-app.ps1"

Set-Location $HOME
if (!(Test-Path $HOME/dotfiles)) {
  git clone https://github.com/SARDONYX-sard/dotfiles $HOME/dotfiles
}

# --------------------------------------------------------------------------------------------------
# Require:
# --------------------------------------------------------------------------------------------------
#! Module loading must be done before symlink, otherwise symlink settings will not be reflected.
# Install modules
if ($Light) {
  # In lightweight mode, do not include development language or msys2.
  Invoke-Expression "$HOME/dotfiles/windows/bin/all-installer.ps1 -Light"
}
else {
  Invoke-Expression "$HOME/dotfiles/windows/bin/all-installer.ps1"
}

# Git settings
Invoke-Expression "$HOME/dotfiles/windows/setup/git-setting.ps1"



# Connect each file (or directory) to dotfiles with a symbolic link.
Invoke-Expression "$HOME/dotfiles/windows/setup/symlink.ps1"

if (! $Light) {
  winget import "$HOME/dotfiles/windows/data/winget-app-list.json"
}
