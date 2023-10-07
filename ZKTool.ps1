$Global:App = [Hashtable]::Synchronized(@{})

$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

$App.Version = "4.0.4"
try {
    Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" | Out-Null        #
}                                                                                                                                           # Crea DisplayVersion
catch {                                                                                                                                     # en caso de que no exista
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" -Value $App.Version    #
}
finally {
    if (!((Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion") -eq $App.Version)) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" -Value $App.Version
        Start-Process Powershell {
            Invoke-Expression (Invoke-WebRequest -useb 'https://raw.githubusercontent.com/Zarckash/ZKTool/main/Installer.ps1')
        }
        exit
    }
}

# Creating GUI
$GUIRunspace = [RunspaceFactory]::CreateRunspace()
$GUIRunspace.ApartmentState = "STA"
$GUIRunspace.ThreadOptions = "ReuseThread"
$GUIRunspace.Open()
$GUIRunspace.SessionStateProxy.SetVariable("App", $App)


$AppLogic = [PowerShell]::Create().AddScript({
    Add-Type -AssemblyName PresentationFramework
    $ErrorActionPreference = 'SilentlyContinue'
    $ProgressPreference = 'SilentlyContinue'
    $WarningPreference = 'SilentlyContinue'
    $ConfirmPreference = 'None'

    # Declaring synced variables
    $App.Download = New-Object System.Net.WebClient
    $App.GitHubPath = "https://github.com/Zarckash/ZKTool/raw/main/"
    $App.GitHubFilesPath = ($App.GitHubPath + "Files/")
    $App.TempPath = "$env:temp\ZKTool\"
    $App.LogFolder = ($App.TempPath + "Logs\")
    $App.LogPath = ($App.LogFolder + "ZKTool.log")
    $App.ZKToolPath = "$env:ProgramFiles\ZKTool\"
    $App.FilesPath = ($App.TempPath + "Files\")
    $App.ResourcesPath = ($App.ZKToolPath + "Resources\")
    $App.FunctionsPath = ($App.ZKToolPath + "Functions\")
    $App.HoverColor = "#0DFFFFFF"
    $App.HoverButtonColor = "#1AFFFFFF"

    # Updating app accent color  
    . ($App.FunctionsPath + "Set-AccentColor.ps1")
    Set-AccentColor
    
    # Loading WPF
    [xml]$XAML = (Get-Content -Path ($App.ZKToolPath + "WPF\MainWindow.xaml") -Raw) -replace 'x:Name', 'Name'
    $XAML.Window.RemoveAttribute("x:Class")
    $Reader = New-Object System.Xml.XmlNodeReader $XAML
    $App.Window = [Windows.Markup.XamlReader]::Load($Reader)

    # Adding form items to App
    $XAML.SelectNodes("//*[@Name]") | ForEach-Object {
        $App.Add($_.Name,$App.Window.FindName($_.Name))
    }

    # GUI dragging
    $App.AppTitleBar.Add_MouseDown({
        $App.Window.DragMove()
    })

    # Resetting log file
    Remove-Item $App.LogFolder -Recurse -Force | Out-Null

    # Creating folders
    New-Item $App.LogFolder -ItemType Directory -Force | Out-Null
    New-Item $App.FilesPath -ItemType Directory -Force | Out-File $App.LogPath -Encoding UTF8 -Append
    New-Item $App.FunctionsPath -ItemType Directory -Force | Out-File $App.LogPath -Encoding UTF8 -Append
    New-Item $App.ResourcesPath -ItemType Directory -Force | Out-File $App.LogPath -Encoding UTF8 -Append

    $Functions = @('Update-GUI','Switch-Tab','Enable-Buttons')
    $Functions | ForEach-Object {
        . ($App.FunctionsPath + "$_.ps1")
        & $_
    }

    Update-GUI AppVersion Text ("Versión " + $App.Version)

    $App.StartScript.Add_Click({
        if ($this.Content -eq "EJECUTANDO") {
            return
        }

        $NewRunspace = [RunspaceFactory]::CreateRunspace()
        $NewRunspace.ApartmentState = "STA"
        $NewRunspace.ThreadOptions = "ReuseThread"          
        $NewRunspace.Open()
        $NewRunspace.SessionStateProxy.SetVariable("App", $App)
        $Logic = [PowerShell]::Create().AddScript({
            $ErrorActionPreference = 'SilentlyContinue'
            $ProgressPreference = 'SilentlyContinue'
            $WarningPreference = 'SilentlyContinue'
            $ConfirmPreference = 'None'

            . ($App.FunctionsPath + "Update-GUI.ps1")

            Update-GUI StartScript Background $App.AccentColor
            Update-GUI StartScript Content EJECUTANDO

            . ($App.FunctionsPath + "Write-UserOutput.ps1")

            $App.AppsToInstall = New-Object System.Collections.Generic.List[System.Object]
            $App.FunctionsToRun = New-Object System.Collections.Generic.List[System.Object]
            $App.ConfigsToApply = New-Object System.Collections.Generic.List[System.Object]
            $App.FoldersToMove = New-Object System.Collections.Generic.List[System.Object]
            $App.SelectedButtons | ForEach-Object {
                if ($_ -like "App*") {
                    $SourceList = "AppsList"
                }
                else {
                    $SourceList = "ExtraList"
                }

                if (($App.$SourceList.$_.Source -eq "Winget") -or ($App.$SourceList.$_.Source -eq ".exe") -or ($App.$SourceList.$_.Source -eq ".appx")) {
                    $App.AppsToInstall.Add($_)
                }
                elseif ($_ -like "Tweak*") {
                    $App.FunctionsToRun.Add($_)
                }
                elseif (($App.$SourceList.$_.FunctionName).Length -gt 0) {
                    $App.FunctionsToRun.Add($_)
                }
                elseif ($_ -like "Config*") {
                    $App.FunctionsToRun.Add($_)
                }
                elseif (($_ -eq "Export") -or ($_ -eq "Import")) {
                    . ($App.FunctionsPath + "Export-Import.ps1")
                    if ($_ -eq "Export") {
                        & Export-Import -Export
                    }
                    else {
                        & Export-Import -Import
                    }
                }
                elseif ($_ -like "*Folder") {
                    $App.FoldersToMove.Add($_)
                }
                elseif ($_ -like "Disk*") {
                    $App.SelectedDisk = $_
                }
                elseif ($_ -like "IP*") {
                    $App.SelectedIP = $_
                }
                elseif ($_ -like "DNS*") {
                    $App.SelectedDNS = $_
                }
            }
            
            # Calling app installer
            if ($App.AppsToInstall.Count -gt 0) {
                . ($App.FunctionsPath + "Install-App.ps1")
                Install-App
            }

            # Calling function invoker
            if ($App.FunctionsToRun.Count -gt 0) {
                . ($App.FunctionsPath + "Invoke-Function.ps1")
                Invoke-Function
            }

            # Moving selected folders
            if (($App.FoldersToMove.Count -gt 0) -and ($App.SelectedDisk.Count -gt 0)) {
                . ($App.FunctionsPath + "Move-UserFolders.ps1")
                Move-UserFolders
            }

            if (($App.SelectedIP.Count -gt 0) -or ($App.SelectedDNS.Count -gt 0) -or (!($App.CustomIP -eq "")) -or (!($App.CustomDNS1 -eq ""))) {
                . ($App.FunctionsPath + "Set-NetConfig.ps1")
                Set-NetConfig
            }

            # Resetting buttons
            $App.SelectedButtons | ForEach-Object {
                Update-GUI $_ BorderThickness 0
            }
            $App.SelectedButtons.Clear()

            Update-GUI StartScript Content "INICIAR SCRIPT"
            Update-GUI StartScript Background $App.HoverColor
            Update-GUI OutputBox Text "Script finalizado"
            "Script finalizado" | Out-File ($App.LogFolder +  "UserOutput.log") -Encoding UTF8 -Append
        })

        # Catching texboxes values
        if ((!($null -eq $App.IPBoxValue1.Text)) -or (!($null -eq $App.DNSBox1Value1.Text))) {
            . ($App.FunctionsPath + "Get-TextBox.ps1")
            Get-Textbox
        }

        $Logic.Runspace = $NewRunspace
        $Logic.BeginInvoke() | Out-Null
    })

    $App.Window.Add_Closing({
        Start-Process Powershell -WindowStyle Hidden {
            Start-Sleep .5
            Remove-Item -Path "$env:temp\ZKTool\Files" -Recurse -Force
            Get-Process "ZKTool" | Stop-Process
        }
    })

    $App.Window.ShowDialog()
})

$AppLogic.Runspace = $GUIRunspace
$AppLogic.BeginInvoke() | Out-Null



