$ErrorActionPreference = 'SilentlyContinue'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

Set-ExecutionPolicy RemoteSigned

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

function TypeWriteHost ([string]$s = '',[string]$TextColor = 'Cyan') {
    $s -split '' | ForEach-Object {
        Write-Host $_ -NoNewline -ForegroundColor $TextColor
        Start-Sleep -Milliseconds 20
    }
    Start-Sleep -Milliseconds 20
    Write-Host ''
}

# Install ZKTool
TypeWriteHost "Instalando ZKTool App..."
New-Item $env:temp\ZKTool\Resources\ -ItemType Directory | Out-Null
Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip" -OutFile "$env:temp\ZKTool\Resources\ZKTool.zip"
Expand-Archive -Path "$env:temp\ZKTool\Resources\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool"
Move-Item -Path "$env:ProgramFiles\ZKTool\ZKTool.lnk" -Destination "$env:appdata\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk" -Force
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
New-Item -Path "HKCR:\Directory\Background\shell\" -Name "ZKTool" | Out-Null
New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "command" | Out-Null
Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "C:\Program Files\ZKTool\ZKTool.exe,0"
Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\command\" -Name "(default)" -Value "C:\Program Files\ZKTool\ZKTool.exe"
Add-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool"

New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\" -Name "ZKTool" | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayIcon" -Value "C:\Program Files\ZKTool\ZKTool.exe"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayName" -Value "ZKTool"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "NoModify" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "NoRepair" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "Publisher" -Value "Zarckash"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "UninstallString" -Value "C:\Program Files\ZKTool\UninstallZKTool.exe"

# Create Monthly Scheduled Task
TypeWriteHost "`r`nCreando Tarea Programada..."
$Action = New-ScheduledTaskAction -Execute "$env:ProgramFiles\ZKTool\ZKTool.exe" -Argument "-Optimize"
$Trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 4 -DaysOfWeek Monday -At 10am
Register-ScheduledTask -TaskName "ZKToolUpdater" -Action $Action -Trigger $Trigger | Out-Null

# Check Winget
TypeWriteHost "`r`nComprobando Winget..."
if (!(((Get-ComputerInfo | Select-Object -ExpandProperty OsName).Substring(10,10)) -eq "Windows 11")) {
    TypeWriteHost "`r`n    Instalando Winget..."
    Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget"
    $WaitFor = (Get-Process AppInstaller).Id
    Wait-Process -Id $WaitFor
}

Write-Host "`r`n`r`n        ###################" -ForegroundColor Green
Write-Host "        #####  READY  #####" -ForegroundColor Green
Write-Host "        ###################" -ForegroundColor Green
Start-Process $env:ProgramFiles\ZKTool\ZKTool.exe
Start-Sleep 1

Exit