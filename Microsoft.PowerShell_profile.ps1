Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

Import-Module .\posh-git\posh-git
. .\Aliases.ps1

function prompt {
    $path = ""
    $pathbits = ([string]$pwd).split("\", [System.StringSplitOptions]::RemoveEmptyEntries)

    if($pathbits.length -eq 1) {
        $path = $pathbits[0] + "\"
    } else {
        $path = $pathbits[$pathbits.length - 1]
    }
    
    $host.UI.RawUi.WindowTitle = $path
    $host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($path) -nonewline -foregroundcolor DarkYellow    

    $Global:GitStatus = Get-GitStatus
    Write-GitStatus $GitStatus

    Write-Host(' >') -nonewline -foregroundcolor DarkYellow

    return " "
}

$teBackup = 'posh-git_DefaultTabExpansion'
if(!(Test-Path Function:\$teBackup)) {
    Rename-Item Function:\TabExpansion $teBackup
}

# Set up tab expansion and include git expansion
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1]
    
    switch -regex ($lastBlock) {
        'git (.*)' { GitTabExpansion $lastBlock }
        default { & $teBackup $line $lastWord }
    }
}

Enable-GitColors

Pop-Location