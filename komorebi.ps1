$YasbPath = "$Env:USERPROFILE/Documents/Projects/yasb-py"

Write-Output "Killing processes"
taskkill /IM komorebi.exe /F

Set-Location -Path $PSScriptRoot
$PidFile = "$PSScriptRoot/yasb_pid.txt"

if (Test-Path $PidFile) {
    $YasbPids = Get-Content -Path $PidFile -Raw

    foreach ($line in $YasbPids) {
        if (-not $line -or $line -ne "") {
            taskkill /F /PID $line
        }
    }

    Remove-Item $PidFile
}

Write-Output "Starting processes"
komorebic start -c $Env:USERPROFILE/.config/komorebi.json
Start-Process -WindowStyle hidden -FilePath python -ArgumentList $YasbPath/src/main.py