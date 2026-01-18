#This script is example for how to install chocolatey programs and check if installed
#Ez a szkript példa arra, hogyan telepítheted a Chocolatey programokat és ellenőrizheted, hogy telepítve vannak-e

$ComputerName = $env:COMPUTERNAME
$ComputerCheck = "\\server\path\to\install\$ComputerName"

echo "Fut." >> "\\server\path\to\install\log\$ComputerName"

if (-Not [System.IO.File]::Exists($ComputerCheck)) {

    Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    $OSarchitecture = (Get-WmiObject win32_operatingsystem).osarchitecture

    $RustDeskInstall = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*RustDesk*"}

    if (-Not $RustDeskInstall) {
	    choco install rustdesk -y --ignore-checksum
    }

    if ($OSarchitecture -eq "64*") {
	    $SumatraPDFInstall = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Sumatra*"}
    } else {
	    $SumatraPDFInstall = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Sumatra*"}
    }

    if (-Not $SumatraPDFInstall) {
	    choco install sumatrapdf --params="/NoUpdates /DesktopIcon"
    }

    $FirefoxInstall = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Mozilla Firefox*"}

    if (-Not $FirefoxInstall) {
	    choco install firefoxesr -y --params="/l:hu"
    }

    $ThunderbirdInstall = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Mozilla Thunderbird*"}

    if (-Not $ThunderbirdInstall) {

	    choco install thunderbird -y --params="/l:hu"
    }

    if ($OSarchitecture -eq "64*") {
	    $ChromeInstall = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Chrome*"}
    } else {
	    $ChromeInstall = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Chrome*"}
    }

    if (-Not $ChromeInstall) {
	    choco install googlechrome -y
    }

    $7zipInstall = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*7-Zip*"}

    if (-Not $7zipInstall) {
	    choco install 7zip -y
    }

    echo "True" >> "\\path\to\install\$ComputerName"
}
