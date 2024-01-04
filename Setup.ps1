$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

$Global:Setup = [Hashtable]::Synchronized(@{})

$Runspace = [RunspaceFactory]::CreateRunspace()
$Runspace.ApartmentState = "STA"
$Runspace.ThreadOptions = "ReuseThread"
$Runspace.Open()
$Runspace.SessionStateProxy.SetVariable("Setup", $Setup)
$PwShell = [PowerShell]::Create() 

$PwShell.AddScript({
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName System.Windows.Forms
    $ErrorActionPreference = 'SilentlyContinue'
    $ProgressPreference = 'SilentlyContinue'
    $WarningPreference = 'SilentlyContinue'
    $ConfirmPreference = 'None'

    $Setup.Download = New-Object System.Net.WebClient
    $Setup.GitHubPath = "https://github.com/Zarckash/ZKTool/raw/main/"
    $Setup.GitHubFilesPath = ($Setup.GitHubPath + "Files/")
    $Setup.TempPath = "$env:temp\ZKTool\"
    $Setup.ZKToolPath = "$env:ProgramFiles\ZKTool\"
    $Setup.FilesPath = ($Setup.TempPath + "Files\")
    $Setup.HoverButtonColor = "#1AFFFFFF"

    New-Item $Setup.FilesPath -ItemType Directory -Force | Out-Null
    if (!(Test-Path ($Setup.ZKToolPath + "WPF\"))) {
        $Setup.Download.DownloadFile(($Setup.GitHubPath + "Resources/ZKTool.zip"),($Setup.FilesPath + "ZKTool.zip"))
        Expand-Archive -Path ($Setup.FilesPath + "ZKTool.zip") -DestinationPath $Setup.ZKToolPath -Force
        Move-Item -Path ($Setup.ZKToolPath + "ZKTool.lnk") -Destination "$env:appdata\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk" -Force
    }

    # Loading WPF
    [xml]$XAML = (Get-Content -Path "H:\GitHub\ZKTool\WPF\SetupScreen.xaml" -Raw) -replace 'x:Name', 'Name'
    $XAML.Window.RemoveAttribute("x:Class")
    $Reader = New-Object System.Xml.XmlNodeReader $XAML
    $Setup.Window = [Windows.Markup.XamlReader]::Load($Reader)

    # Adding form items to Setup
    $XAML.SelectNodes("//*[@Name]") | ForEach-Object {
        $Setup.Add($_.Name,$Setup.Window.FindName($_.Name))
    }

    . ($Setup.ZKToolPath + "Functions\SetupLogic.ps1")

    if (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool") {
        Update-Status "Actualizando ZKTool App..."
    } else {
        Update-Status "Instalando ZKTool App..."
    }

    $Setup.Window.ShowDialog()

}) | Out-Null

function Open-SplashScreen {
    $PwShell.Runspace = $Runspace
    $Script:Handle = $PwShell.BeginInvoke()
}

function Close-SplashScreen {
    $Setup.Window.Dispatcher.Invoke("Normal",[action]{$Setup.Window.Close()})
    $PwShell.EndInvoke($Handle) | Out-Null
}

Open-SplashScreen

. ($Setup.ZKToolPath + "Functions\SetupLogic.ps1")

if (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool") {
    # Update ZKTool
    Update-Status "Actualizando ZKTool App..."

    Start-Sleep 1

    $Setup.Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip", "$env:temp\ZKTool\Files\ZKTool.zip")
    Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool" -Force
    Move-Item -Path "$env:ProgramFiles\ZKTool\ZKTool.lnk" -Destination "$env:appdata\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk" -Force

    if ((!(Test-Path "C:\Windows\Fonts\Hasklig*")) -or (!(Test-Path "C:\Windows\Fonts\BMWTypeNext*"))) {
        Install-Font
    }

    #Reset-IconCache
}
else {
    # Install ZKTool
    Update-Status "Instalando ZKTool App..."

    $Setup.Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip", "$env:temp\ZKTool\Files\ZKTool.zip")
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
    $WingetApiUrl = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
    $WingetDownloadUrl = $(Invoke-RestMethod -UseBasicParsing $WingetApiUrl).assets.browser_download_url | Where-Object {$_.EndsWith(".msixbundle")} 
    $Download.DownloadFile($WingetDownloadUrl, "$env:temp\ZKTool\Files\Winget.msixbundle")
    Add-AppxPackage "$env:temp\ZKTool\Files\Winget.msixbundle"
}

Start-Process "$env:ProgramFiles\ZKTool\ZKTool.exe"

Close-SplashScreen