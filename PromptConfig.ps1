Import-Module posh-git
Import-Module posh-svn

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

Enable-GitColors
