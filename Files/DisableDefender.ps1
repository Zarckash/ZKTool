$ErrorActionPreference = 'SilentlyContinue'
$Host.UI.RawUI.WindowTitle = 'Windows Defender Disabler'

function Write-TypeHost ([string]$s = '',[string]$TextColor = 'DarkCyan') {
    $s -split '' | ForEach-Object {
        Write-Host $_ -NoNewline -ForegroundColor $TextColor
        Start-Sleep -Milliseconds 15
    }
    Start-Sleep -Milliseconds 15
    Write-Host `n
}

$TempPath = "$env:temp\ZKTool\Files"

#Disable Real Time Protection using virtual keyboard
Write-TypeHost "Desactivando Proteccion En Tiempo Real..."

Start-Process "explorer" -ArgumentList "windowsdefender://threat" 
Start-Sleep 3

$wshell = New-Object -ComObject wscript.shell

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Keyboard
{
    [DllImport("user32.dll")]
    public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, uint dwExtraInfo);
}
"@

$wshell.SendKeys("{TAB}")
Start-Sleep .65
$wshell.SendKeys("{TAB}")
Start-Sleep .65
$wshell.SendKeys("{TAB}")
Start-Sleep .65
$wshell.SendKeys("{TAB}")
Start-Sleep .65
$wshell.SendKeys(" ")
Start-Sleep .65
$wshell.SendKeys(" ")

Start-Sleep .75

Stop-Process -Name "SecHealthUI"

# Downloading files
$Url = "https://github.com/Zarckash/ZKTool/raw/main/Files/.exe/NSudoLG.exe"
(New-Object System.Net.WebClient).DownloadFile($Url,"$TempPath\NSudoLG.exe")

# Create .bat file
'@echo off

Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WdBoot" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d "4" /f' | Out-File "$TempPath\DisableDefender.bat"

# Add Defender exclusions to all drives
Write-TypeHost "Añadiendo Exclusiones De Todo A Windows Defender..."
$ActiveDrives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty "Root" | Where-Object {$_.Length -eq 3}
$ActiveDrives | ForEach-Object {
    Add-MpPreference -ExclusionPath "$_"
    Add-MpPreference -ExclusionProcess "$_*"
}

# Disable Windows Defender through Set-MpPreference
Write-TypeHost "Desactivando Windows Defender Con Powershell Cmdlet..."
Set-MpPreference -DisableArchiveScanning 1
Set-MpPreference -DisableBehaviorMonitoring 1
Set-MpPreference -DisableIntrusionPreventionSystem 1
Set-MpPreference -DisableIOAVProtection 1
Set-MpPreference -DisableRemovableDriveScanning 1
Set-MpPreference -DisableBlockAtFirstSeen 1
Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan 1
Set-MpPreference -DisableScanningNetworkFiles 1
Set-MpPreference -DisableScriptScanning 1
Set-MpPreference -DisableRealtimeMonitoring 1
Set-MpPreference -LowThreatDefaultAction Allow
Set-MpPreference -ModerateThreatDefaultAction Allow
Set-MpPreference -HighThreatDefaultAction Allow

# Disable Windows Defender through Group Policy
Write-TypeHost "Desactivando Windows Defender Con Política De Grupo..." 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0 -Force
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "Real-Time Protection" | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Type DWord -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SecurityHealthService" -Name "Start" -Type DWord -Value 4 -Force

Get-ScheduledTask -TaskName "Windows Defender Cache Maintenance" | Disable-ScheduledTask | Out-Null
Get-ScheduledTask -TaskName "Windows Defender Cleanup" | Disable-ScheduledTask | Out-Null
Get-ScheduledTask -TaskName "Windows Defender Scheduled Scan" | Disable-ScheduledTask | Out-Null
Get-ScheduledTask -TaskName "Windows Defender Verification" | Disable-ScheduledTask | Out-Null

gpupdate /force | Out-Null

# Running .bat file with Power Run
Write-TypeHost "Desactivando Servicios..."
$BatPath = "$TempPath\DisableDefender.bat"
$ArgumentList = "-U:T -P:E -M:S " + "`"$BatPath`"" 
Start-Process "$TempPath\NSudoLG.exe" -ArgumentList $ArgumentList -Wait

Write-TypeHost '- - - WINDOWS DEFENDER DESACTIVADO - - -'
Start-Sleep 2