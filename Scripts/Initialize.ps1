$ErrorActionPreference = 'SilentlyContinue'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

# Check First Time
Write-Host "Comprobando Si Existe ZKTool.exe..."
if (!(Test-Path -Path "$env:windir\System32\ZKTool.exe")) {
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/ZKTool.exe" -OutFile "$env:windir\System32\ZKTool.exe"
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/ZKTool.lnk" -OutFile "C:\Users\Public\Desktop\ZKTool.lnk"
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\" -Name "ZKTool" | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "ZKTool.exe,0"
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\command\" -Name "(default)" -Value "ZKTool.exe"
    Write-Host "    Creando ZKTool.exe..."
}

# Check Winget
Write-Host "`r`nComprobando Winget..."
if (!((Get-ComputerInfo | Select-Object -ExpandProperty OsBuildNumber) -lt 22000)) {
    if (!(Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe)) {
        Write-Host "    Instalando Winget..."
        Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
        $nid = (Get-Process AppInstaller).Id
        Wait-Process -Id $nid
    }
}

# Check GUI Fonts
Write-Host "`r`nComprobando Fuentes Necesarias..."
if (!(Test-Path -Path $env:userprofile\AppData\Local\Microsoft\Windows\Fonts\UbuntuMono*)) {
    Write-Host "    Instalando Fuentes Necesarias..."
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Zarckash/ZKTool/main/Configs/FontUbuntuMono.zip" -OutFile $env:userprofile\AppData\Local\Temp\FontUbuntuMono.zip
    Expand-Archive $env:userprofile\AppData\Local\Temp\FontUbuntuMono.zip $env:userprofile\AppData\Local\Temp\FontUbuntuMono -Force
    Start-Process $env:userprofile\AppData\Local\Temp\FontUbuntuMono\Install.exe
    Wait-Process -Name "Install"
}

Write-Host "`r`n        ###################" -ForegroundColor Green
Write-Host "        #####  READY  #####" -ForegroundColor Green
Write-Host "        ###################" -ForegroundColor Green
Start-Process $env:windir\System32\ZKTool.exe
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "ElevatedPowershell" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SetClipboard" -ErrorAction SilentlyContinue

Start-Sleep 2

Exit