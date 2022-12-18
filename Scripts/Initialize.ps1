$ErrorActionPreference = 'SilentlyContinue'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

# Remove Old Path
if (!(Test-Path -Path "$env:ProgramFiles\ZKTool\ZKTool.exe")) {
    Remove-Item -Path $env:windir\System32\ZKTool.exe -Force | Out-Null
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    Remove-Item -Path "HKCR:\Directory\Background\shell\ZKTool" -Recurse -Force | Out-Null
    Remove-Item -Path "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk"
    Remove-MpPreference -ExclusionPath "$env:windir\System32\ZKTool.exe"
}

# Check First Time
Write-Host "Comprobando Si Existe ZKTool.exe..."
if (!(Test-Path -Path "$env:ProgramFiles\ZKTool\ZKTool.exe")) {
    Write-Host "    Creando ZKTool.exe..."
    New-Item $env:ProgramFiles\ZKTool -ItemType Directory | Out-Null
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/ZKTool.exe" -OutFile "$env:ProgramFiles\ZKTool\ZKTool.exe"
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/UninstallZKTool.exe" -OutFile "$env:ProgramFiles\ZKTool\UninstallZKTool.exe"
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/ZKTool.lnk" -OutFile "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk"
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\" -Name "ZKTool" | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "C:\Program Files\ZKTool\ZKTool.exe,0"
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\command\" -Name "(default)" -Value "C:\Program Files\ZKTool\ZKTool.exe"
    Add-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool\ZKTool.exe"
    Add-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool\UninstallZKTool.exe"

    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\" -Name "ZKTool" | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayIcon" -Value "C:\Program Files\ZKTool\ZKTool.exe"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayName" -Value "ZKTool"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "NoModify" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "NoRepair" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "Publisher" -Value "Zarckash"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "UninstallString" -Value "C:\Program Files\ZKTool\UninstallZKTool.exe"
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
Start-Process $env:ProgramFiles\ZKTool\ZKTool.exe
Start-Sleep 2

Exit