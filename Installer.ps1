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

$Download = (New-Object System.Net.WebClient)
New-Item $env:temp\ZKTool\Files\ -ItemType Directory -Force | Out-Null
New-Item $env:ProgramFiles\ZKTool\Functions\ -ItemType Directory -Force | Out-Null
New-Item $env:ProgramFiles\ZKTool\Resources\Images -ItemType Directory -Force | Out-Null
New-Item $env:ProgramFiles\ZKTool\WPF -ItemType Directory -Force | Out-Null

$Functions = @('Enable-Buttons.ps1','Export-Import.ps1','Functions.ps1','Import-Configs.ps1','Install-App.ps1','Invoke-Function.ps1','Move-UserFolders.ps1','Set-AccentColor.ps1','Switch-Tab.ps1','Update-GUI.ps1','Write-UserOutput.ps1')
$Functions | ForEach-Object {
    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Functions/$_", "$env:ProgramFiles\ZKTool\Functions\$_")
}

$Jsons = @("Apps.json","Tweaks.json","Extra.json","Configs.json")
$Jsons | ForEach-Object {
    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/$_", "$env:ProgramFiles\ZKTool\Resources\$_")
}

$Images = $Download.DownloadString("https://github.com/Zarckash/ZKTool/raw/main/Resources/Configs.json")  | ConvertFrom-Json
$Images.psobject.properties.name | ForEach-Object {
    $ImagePath = $Images.$_.Image
    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/Images/$ImagePath","$env:ProgramFiles\ZKTool\Resources\Images\$ImagePath")
}

$Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/WPF/WPF.zip", "$env:temp\ZKTool\Files\WPF.zip")
Expand-Archive -Path "$env:temp\ZKTool\Files\WPF.zip" -DestinationPath "$env:ProgramFiles\ZKTool\WPF" -Force

if (Test-Path "$env:ProgramFiles\ZKTool\ZKTool.exe") { # Update ZKTool
    $host.UI.RawUI.WindowTitle = "ZKTool Updater"
    Write-TypeHost "Actualizando ZKTool App..."
    Start-Sleep 1

    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip", "$env:temp\ZKTool\Files\ZKTool.zip")
    Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool" -Force
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

    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip", "$env:temp\ZKTool\Files\ZKTool.zip")
    Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool" -Force
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
    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/HaskligFont.zip", "$env:temp\ZKTool\Files\HaskligFont.zip")
    Expand-Archive -Path "$env:temp\ZKTool\Files\HaskligFont.zip" -DestinationPath "$env:temp\ZKTool\Files\HaskligFont" -Force
    Get-ChildItem -Path "$env:temp\ZKTool\Files\HaskligFont" | ForEach-Object {
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

exit