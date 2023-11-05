$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

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
        Start-Sleep -Milliseconds 10
    }
    Start-Sleep -Milliseconds 10
    Write-Host ''
}

$Download = (New-Object System.Net.WebClient)
New-Item $env:temp\ZKTool\Files\ -ItemType Directory -Force | Out-Null

function Install-Font {
    Write-TypeHost "`r`nInstalando Fuente..."
    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/Fonts.zip", "$env:temp\ZKTool\Files\Fonts.zip")
    Expand-Archive -Path "$env:temp\ZKTool\Files\Fonts.zip" -DestinationPath "$env:temp\ZKTool\Files\Fonts" -Force

    $ExistingFonts = Get-ChildItem -Path "C:\Windows\Fonts" | ForEach-Object { $_.Name }
    $CSharpCode = @'
using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Runtime.InteropServices;

namespace FontResource
{
    public class AddRemoveFonts
    {
        [DllImport("gdi32.dll")]
        static extern int AddFontResource(string lpFilename);

        public static int AddFont(string fontFilePath) {
            try 
            {
                return AddFontResource(fontFilePath);
            }
            catch
            {
                return 0;
            }
        }
    }
}
'@

    Add-Type $CSharpCode

    $FontFileTypes = @{}
    $FontFileTypes.Add(".ttf", " (TrueType)")
    $FontFileTypes.Add(".otf", " (OpenType)")
    $FontRegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

    Get-ChildItem "$env:temp\ZKTool\Files\Fonts" | ForEach-Object {
        $Path = Join-Path "C:\Windows\Fonts" $_.Name
        if (!($ExistingFonts.Contains($_.Name))) {

            Copy-Item -Path $_.FullName -Destination $Path
    
            $FileDir = split-path $Path
            $FileName = split-path $Path -leaf
            $FileExt = (Get-Item $Path).extension
            $FileBaseName = $FileName -replace ($FileExt , "")
                
            $Shell = new-object -com Shell.application
            $MyFolder = $Shell.Namespace($FileDir)
            $FileObj = $MyFolder.Items().Item($FileName)
            $FontName = $MyFolder.GetDetailsOf($FileObj, 21)
                
            if ($FontName -eq "") { $FontName = $FileBaseName }
                
            [FontResource.AddRemoveFonts]::AddFont($Path) | Out-Null
            Set-ItemProperty -Path "$($FontRegistryPath)" -Name "$($FontName)$($FontFileTypes.Item($FileExt))" -Value "$($FileName)"
        }
    }
}

function Reset-IconCache {
        ie4uinit.exe -show
        taskkill /f /im explorer.exe | Out-Null
        Remove-Item -Path "$env:localappdata\IconCache.db" -Force
        Remove-Item -Path "$env:localappdata\Microsoft\Windows\Explorer\iconcache*" -Force
        explorer.exe
    
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "C:\Program Files\ZKTool\ZKTool.exe,0" -Force
}

if (Test-Path "$env:ProgramFiles\ZKTool\ZKTool.exe") {
    # Update ZKTool
    $host.UI.RawUI.WindowTitle = "ZKTool Updater"
    Write-TypeHost "Actualizando ZKTool App..."
    Start-Sleep 1

    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip", "$env:temp\ZKTool\Files\ZKTool.zip")
    Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool" -Force
    Move-Item -Path "$env:ProgramFiles\ZKTool\ZKTool.lnk" -Destination "$env:appdata\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk" -Force

    if ((!(Test-Path "C:\Windows\Fonts\Hasklig*")) -or (!(Test-Path "C:\Windows\Fonts\BMWTypeNext*"))) {
        Install-Font
    }

    #Reset-IconCache
}
else {
    # Install ZKTool
    $host.UI.RawUI.WindowTitle = "ZKTool Installer"
    Write-TypeHost "Instalando ZKTool App..."

    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip", "$env:temp\ZKTool\Files\ZKTool.zip")
    Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool" -Force
    Move-Item -Path "$env:ProgramFiles\ZKTool\ZKTool.lnk" -Destination "$env:appdata\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk" -Force

    New-Item $env:ProgramFiles\ZKTool\sha | Out-Null
    attrib +h $env:ProgramFiles\ZKTool\sha

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
    Install-Font

    # Update Winget
    Write-TypeHost "`r`nActualizando Winget..."
    $Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Files/.appx/Winget.appx", "$env:temp\ZKTool\Files\Winget.appx")
    Add-AppPackage "$env:temp\ZKTool\Files\Winget.appx"
}

Write-Host "- - - - R E A D Y - - - -" -ForegroundColor Green

Start-Process "$env:ProgramFiles\ZKTool\ZKTool.exe"
Start-Sleep 1

exit