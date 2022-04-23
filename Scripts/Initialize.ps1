$ErrorActionPreference = 'SilentlyContinue'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null

if (!(Test-Path -Path "HKCR:\Directory\Background\shell\ZKTool\command\")) {
    Add-MpPreference -ExclusionPath "$env:windir\System32\ZKTool.exe"
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Scripts/ZKTool.exe" -OutFile "$env:windir\System32\ZKTool.exe" | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\" -Name "ZKTool" | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "ZKTool.exe,0"
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\command\" -Name "(default)" -Value "ZKTool.exe"
}

if (!(Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe)) {
    Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
	$nid = (Get-Process AppInstaller).Id
	Wait-Process -Id $nid
}  

if (!(Test-Path -Path $env:userprofile\AppData\Local\Microsoft\Windows\Fonts\UbuntuMono*)) {
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Zarckash/ZKTool/main/Configs/FontUbuntuMono.zip" -OutFile $env:userprofile\AppData\Local\Temp\FontUbuntuMono.zip
    Expand-Archive $env:userprofile\AppData\Local\Temp\FontUbuntuMono.zip $env:userprofile\AppData\Local\Temp\FontUbuntuMono -Force
    Start-Process $env:userprofile\AppData\Local\Temp\FontUbuntuMono\Install.exe
    Start-Sleep 10
}

Start-Process $env:windir\System32\ZKTool.exe
Taskkill /PID $PID -F
