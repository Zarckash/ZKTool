$ErrorActionPreference = 'SilentlyContinue'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

# Check First Time
Write-Host "Comprobando Si Existe ZKTool.exe..."
if (!(Test-Path -Path "$env:windir\System32\ZKTool.exe")) {
    Write-Host "    Creando ZKTool.exe..."
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/ZKTool.exe" -OutFile "$env:windir\System32\ZKTool.exe"
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/ZKTool.lnk" -OutFile "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk"
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\" -Name "ZKTool" | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "ZKTool.exe,0"
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\command\" -Name "(default)" -Value "ZKTool.exe"
    Add-MpPreference -ExclusionPath "$env:windir\System32\ZKTool.exe"
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

Write-Host "`r`n        ###################" -ForegroundColor Green
Write-Host "        #####  READY  #####" -ForegroundColor Green
Write-Host "        ###################" -ForegroundColor Green
Start-Process $env:windir\System32\ZKTool.exe
Start-Sleep 2

Exit