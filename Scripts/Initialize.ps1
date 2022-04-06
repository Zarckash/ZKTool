$ErrorActionPreference = 'SilentlyContinue'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

if (!(Test-Path -Path "HKCR:\HKEY_CLASSES_ROOT\Directory\Background\shell\ZKTool\command\")) {
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Scripts/ZKTool.exe" -OutFile "$env:windir\System32\ZKTool.exe" | Out-Null
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    New-Item -Path "HKCR:\HKEY_CLASSES_ROOT\Directory\Background\shell\" -Name "ZKTool" | Out-Null
    New-Item -Path "HKCR:\HKEY_CLASSES_ROOT\Directory\Background\shell\ZKTool\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\HKEY_CLASSES_ROOT\Directory\Background\shell\ZKTool\command\" -Name "(default)" -Value "ZKTool.exe"
}

if (!(Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe)) {
    Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
}  

if (!(Test-Path -Path $env:userprofile\AppData\Local\Microsoft\Windows\Fonts\UbuntuMono*)) {
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Zarckash/ZKTool/main/Configs/FontUbuntuMono.zip" -OutFile $env:userprofile\AppData\Local\Temp\ZKTool\Configs\FontUbuntuMono.zip
    Expand-Archive $env:userprofile\AppData\Local\Temp\ZKTool\Configs\FontUbuntuMono.zip $env:userprofile\AppData\Local\Temp\ZKTool\Configs\FontUbuntuMono -Force
    Start-Process $env:userprofile\AppData\Local\Temp\ZKTool\Configs\UbuntuMonoFont\Install.exe
    Start-Sleep 10
}

Start-Process $env:windir\System32\ZKTool.exe
Taskkill /PID $PID -F