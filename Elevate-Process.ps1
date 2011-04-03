function Elevate-Process {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.Verb = "runas"

    # No arguments - launch PowerShell in the current location
    if ($args.Length -eq 0) {
      $psi.FileName = 'powershell'
      $psi.Arguments = "-NoExit -Command &{Set-Location '" + (Get-Location).Path + "'}"
    }
    # Argument is a folder - launch powershell on that folder
    elseif (($args.Length -eq 1) -and (Test-Path $args[0] -pathType Container)) {
      $psi.FileName = 'powershell'
      $psi.Arguments = "-NoExit -Command &{set-location '" + (Resolve-Path $args[0]) + "'}"
    }
    else {
      $file, [string]$arguments = $args
      $psi.FileName = $file
      $psi.Arguments = $arguments
    }

    [System.Diagnostics.Process]::Start($psi) | out-null
}
