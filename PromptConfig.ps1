Import-Module .\posh-git\posh-git
Import-Module .\posh-svn\posh-svn

function prompt {
    $path = ""
    $pathbits = ([string]$pwd).split("\", [System.StringSplitOptions]::RemoveEmptyEntries)

    if($pathbits.length -eq 1) {
        $path = $pathbits[0] + "\"
    } else {
        $path = $pathbits[$pathbits.length - 1]
    }
    
    $host.UI.RawUi.WindowTitle = $path

    Write-Host($path) -nonewline -foregroundcolor Yellow    

    $Global:GitStatus = Get-GitStatus
    Write-GitStatus $GitStatus

    $Global:SvnStatus = Get-SvnStatus
    Write-SvnStatus $SvnStatus

    Write-Host(' >') -nonewline -foregroundcolor Yellow

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
        'svn (.*)' { SvnTabExpansion $lastBlock }
        default { & $teBackup $line $lastWord }
    }
}
