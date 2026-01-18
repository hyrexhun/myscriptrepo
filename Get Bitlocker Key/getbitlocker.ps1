Set-ExecutionPolicy Bypass -Scope Process -Force

$LogLocate= "\\save\file\location\$env:COMPUTERNAME.txt"

New-Item -Path "$LogLocate"
$BitlockerVolumers = Get-BitLockerVolume
$BitlockerVolumers |
ForEach-Object {
    $MountPoint = $_.MountPoint
    $MountPoint,$BitlockerVolumers.KeyProtector > $LogLocate
} 