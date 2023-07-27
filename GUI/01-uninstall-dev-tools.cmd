@echo off

echo This script will uninstall the following software packages:
echo - Winget
echo - Chocolatey
echo - Visual Studio Code
echo - Python
echo - Node.js
echo.
set /p confirm=Do you want to proceed? (y/n)

if /i "%confirm%" neq "y" (
    echo Uninstall aborted.
    pause
    exit
)

PowerShell.exe -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"

echo Uninstalling Winget...
PowerShell.exe -Command "Get-AppxPackage Microsoft.DesktopAppInstaller | Remove-AppxPackage"

echo Uninstalling Chocolatey...
PowerShell.exe -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); choco uninstall chocolatey -y"

echo Uninstalling Visual Studio Code...
PowerShell.exe -Command "Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall' | ForEach-Object { if($_.GetValue('DisplayName') -eq 'Visual Studio Code') { $_.GetValue('UninstallString') } } | ForEach-Object { & $_ /S }"

echo Uninstalling Python...
PowerShell.exe -Command "Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like '*Python*' } | ForEach-Object { $_.Uninstall() }"

echo Uninstalling Node.js...
PowerShell.exe -Command "Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like '*Node.js*' } | ForEach-Object { $_.Uninstall() }"

echo Uninstall complete.
pause