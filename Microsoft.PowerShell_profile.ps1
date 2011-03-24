Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

. .\Do-Touch.ps1
. .\Elevate-Process.ps1
. .\Aliases.ps1
. .\PromptConfig.ps1

Pop-Location
