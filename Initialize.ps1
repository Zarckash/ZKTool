$ErrorActionPreference = 'SilentlyContinue'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process Powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

Set-ExecutionPolicy RemoteSigned

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

function Write-TypeHost ([string]$s = '', [string]$TextColor = 'Cyan') {
    $s -split '' | ForEach-Object {
        Write-Host $_ -NoNewline -ForegroundColor $TextColor
        Start-Sleep -Milliseconds 15
    }
    Start-Sleep -Milliseconds 15
    Write-Host ''
}

if (Test-Path "$env:ProgramFiles\ZKTool\ZKTool.exe") { # Update ZKTool
    $host.UI.RawUI.WindowTitle = "ZKTool Updater"
    Write-TypeHost "Actualizando ZKTool App..."
    Start-Sleep 1
    New-Item $env:temp\ZKTool\Resources\ -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip" -OutFile "$env:temp\ZKTool\Resources\ZKTool.zip"
    Expand-Archive -Path "$env:temp\ZKTool\Resources\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool" -Force
    Move-Item -Path "$env:ProgramFiles\ZKTool\ZKTool.lnk" -Destination "$env:appdata\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk" -Force
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\" -Name "ZKTool" | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "C:\Program Files\ZKTool\ZKTool.exe,0"
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\command\" -Name "(default)" -Value "C:\Program Files\ZKTool\ZKTool.exe"
}
else { # Install ZKTool
    $host.UI.RawUI.WindowTitle = "ZKTool Installer"
    Write-TypeHost "Instalando ZKTool App..."
    New-Item $env:temp\ZKTool\Resources\ -ItemType Directory -Force | Out-Null
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip" -OutFile "$env:temp\ZKTool\Resources\ZKTool.zip"
    Expand-Archive -Path "$env:temp\ZKTool\Resources\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool" -Force
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

    # Install Font
    Write-TypeHost "`r`nInstalando Fuente..."
    Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Resources/HaskligFont.zip" -OutFile "$env:temp\ZKTool\Resources\HaskligFont.zip"
    Expand-Archive -Path "$env:temp\ZKTool\Resources\HaskligFont.zip" -DestinationPath "$env:temp\ZKTool\Resources\HaskligFont" -Force
    Get-ChildItem -Path "$env:temp\ZKTool\Resources\HaskligFont" | ForEach-Object {
        $FontName = $_.Name.Replace('-', ' ').Replace('It', ' Italic').Replace('  ', ' ').Replace('.ttf', ' (True Type)')
        $FontPath = "$env:localappdata\Microsoft\Windows\Fonts\" + $_.Name
        Copy-Item -Path $_.FullName -Destination $FontPath -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $FontName -Value $FontPath
    }

    # Create Monthly Scheduled Task
    Write-TypeHost "`r`nCreando Tarea Programada..."
    $Action = New-ScheduledTaskAction -Execute "$env:ProgramFiles\ZKTool\ZKTool.exe" -Argument "-Optimize"
    $Trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 4 -DaysOfWeek Monday -At 10am
    Register-ScheduledTask -TaskName "ZKToolOptimizer" -Action $Action -Trigger $Trigger | Out-Null

    # Check Winget
    Write-TypeHost "`r`nComprobando Winget..."
    if (!(((Get-ComputerInfo | Select-Object -ExpandProperty OsName).Substring(10, 10)) -eq "Windows 11")) {
        Write-TypeHost "`r`n    Instalando Winget..."
        Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget" -Wait
    }
}

Write-Host "`r`n`r`n        ###################" -ForegroundColor Green
Write-Host "        #####  READY  #####" -ForegroundColor Green
Write-Host "        ###################" -ForegroundColor Green
Start-Process $env:ProgramFiles\ZKTool\ZKTool.exe -Wait

Exit