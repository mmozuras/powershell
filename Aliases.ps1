function .. {Set-Location .. }
function ... {Set-Location ../.. }
function .... {Set-Location ../../.. }
function ..... {Set-Location ../../../.. }

Set-Alias touch Do-Touch
Set-Alias sudo Elevate-Process

Remove-Item alias:cd
$changeDirectory = %{'{0}\{1}' -f (Split-Path $profile),"Change-Directory.ps1"}
Set-Alias cd $changeDirectory 
