function Do-Touch {
  param ( [string]$filename = $null );
  
  if ($filename) {
    $file = @(Get-ChildItem -Path $filename -ErrorAction SilentlyContinue)[0]

    if (!$file) {
      Set-Content -Path $filename -value $null;
      $file = @(Get-ChildItem -Path $filename)[0];
    }
    
    [datetime]$now = ([DateTime]::Now) 
    [DateTime]$UTCNow = $now.ToUniversalTime();

    $file.LastAccessTime = $now
    $file.LastAccessTimeUtc = $UTCNow
    $file.LastWriteTime = $now
    $file.LastWriteTimeUtc = $UTCNow
    $file | select Name, *time*
  }
}

Do-Touch -filespec $filename;
