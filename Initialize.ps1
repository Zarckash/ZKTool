$ErrorActionPreference = 'SilentlyContinue'

# Run Script As Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process Powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Set-ExecutionPolicy Bypass

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

function Write-TypeHost ([string]$s = '', [string]$TextColor = 'DarkCyan') {
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

    # Rebuild Icon Cache
    ie4uinit.exe -show
    taskkill /f /im explorer.exe | Out-Null
    Remove-Item -Path "$env:localappdata\IconCache.db" -Force
    Remove-Item -Path "$env:localappdata\Microsoft\Windows\Explorer\iconcache*" -Force
    explorer.exe

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "C:\Program Files\ZKTool\ZKTool.exe,0" -Force
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

    # Check Winget
    Write-TypeHost "`r`nComprobando Winget..."
    if (!(Test-Path "$env:userprofile\AppData\Local\Microsoft\WindowsApps\winget.exe")) {
        Write-TypeHost "`r`n    Instalando Winget..."
        Start-Process "ms-appinstaller:?source=https://aka.ms/getwinget" -Wait
    }
}

Write-Host "`r`n- - - - - - - - - - - - -" -ForegroundColor Green
Write-Host "- - - - R E A D Y - - - -" -ForegroundColor Green
Write-Host "- - - - - - - - - - - - -" -ForegroundColor Green

$GetDays = (New-TimeSpan -Start (Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "LastOptimizationDate") -End (Get-Date -Format "dd-MM-yyyy")).Days
if ($GetDays -gt 29) {
    Start-Process $env:ProgramFiles\ZKTool\ZKTool.exe -ArgumentList "-Optimize"
}
else {
    Start-Process $env:ProgramFiles\ZKTool\ZKTool.exe
}

exit