#! This module could not be loaded in `enhanced-lazy.ps1`!
#! Therefore it cannot be in `dyn.lazy.ps1`.

function New-CacheFile {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, HelpMessage = "Cache file name.")]
    [ValidateNotNullOrEmpty()]
    [string]$FileName,

    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory = $true, HelpMessage = "Create cache command.")]
    [string]$CreateCacheCmd,

    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory = $true, HelpMessage = "Target cache directory.")]
    [string]$TargetDir
  )

  $FullPath = Join-Path $TargetDir "$FileName.ps1"

  if (!(Test-Path $FullPath)) {
    New-Item $TargetDir -ItemType Directory -ErrorAction SilentlyContinue
  }
  $CreateCacheCmd | Invoke-Expression > $FullPath
}

$local:hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
$local:CachePwsh = "$HOME/.cache/pwsh/"
New-CacheFile -CreateCacheCmd "`$(zoxide init --cmd z --hook $hook powershell).Replace('function ', 'function script:')" `
  -FileName zoxide -TargetDir "$CachePwsh/hooks"

if (Test-Path "$CachePwsh/hooks/zoxide.ps1") {
  . "$CachePwsh/hooks/zoxide.ps1"
}
