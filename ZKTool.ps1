$Global:App = [Hashtable]::Synchronized(@{})

$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

$App.Version = "4.2.9"

if (!((Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion") -eq $App.Version)) {
    if (!(Test-Path "$env:ProgramFiles\ZKTool\Setup.exe")) {
        Start-Process Powershell -WindowStyle Hidden{
            Invoke-Expression (Invoke-WebRequest -useb 'https://raw.githubusercontent.com/Zarckash/ZKTool/main/Installer.ps1')
        }
    } else {
        Start-Process Powershell -WindowStyle Hidden{
            Start-Process "$env:ProgramFiles\ZKTool\Setup.exe" -ArgumentList "-Update"
        }
    }
    exit
}

$Global:Hash = [Hashtable]::Synchronized(@{})
$Hash.ZKToolPath = "$env:ProgramFiles\ZKTool\"
$Hash.GitHubPath = "https://github.com/Zarckash/ZKTool/raw/main/"
$Hash.Download = New-Object System.Net.WebClient
$Hash.HoverButtonColor = "#1AFFFFFF"
$Hash.XamlPath = ($Hash.ZKToolPath + "\WPF\SetupWindow.xaml")

$Runspace = [RunspaceFactory]::CreateRunspace()
$Runspace.ApartmentState = "STA"
$Runspace.ThreadOptions = "ReuseThread"
$Runspace.Open()
$Runspace.SessionStateProxy.SetVariable("Hash", $Hash)
$PwShell = [PowerShell]::Create()

$PwShell.AddScript({
    $ErrorActionPreference = 'SilentlyContinue'
    $ProgressPreference = 'SilentlyContinue'
    $WarningPreference = 'SilentlyContinue'
    $ConfirmPreference = 'None'

    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName System.Windows.Forms

    [xml]$XAML = (Get-Content -Path $Hash.XamlPath -Raw) -replace 'x:Name', 'Name'
    $XAML.Window.RemoveAttribute("x:Class")
    $Reader = New-Object System.Xml.XmlNodeReader $XAML
    $Hash.Window = [Windows.Markup.XamlReader]::Load($Reader)

    $XAML.SelectNodes("//*[@Name]") | ForEach-Object {
        $Hash.Add($_.Name,$Hash.Window.FindName($_.Name))
    }

    $Hash.SetupTitleBar.Add_MouseDown({
        $Hash.Window.DragMove()
    })
    
    $InteractionButtons = @('Minimize','Close')
    
    $InteractionButtons | ForEach-Object {
        if ($_ -ne "Close") {
            $Hash.$_.Add_MouseEnter({
                $this.Background = $Hash.HoverButtonColor
            })
        }
        else {
            $Hash.$_.Add_MouseEnter({
                $this.Background = "#CC0000"
            })
        }
    
        $Hash.$_.Add_MouseLeave({
            $this.Background = "Transparent"
        })
    
    }
    
    $Hash.Minimize.Add_Click({
        $Hash.Window.WindowState = "Minimized"
    })
    
    $Hash.Close.Add_Click({
        $Hash.Window.Close()
    })

    $Hash.Title.Text = "ZKTool"
    $Hash.Status.Text = "Cargando..."

    $Hash.Window.ShowDialog()
}) | Out-Null

$PwShell.Runspace = $Runspace
$PwShell.BeginInvoke() | Out-Null

# Creating GUI
$GUIRunspace = [RunspaceFactory]::CreateRunspace()
$GUIRunspace.ApartmentState = "STA"
$GUIRunspace.ThreadOptions = "ReuseThread"
$GUIRunspace.Open()
$GUIRunspace.SessionStateProxy.SetVariable("App", $App)
$GUIRunspace.SessionStateProxy.SetVariable("Hash", $Hash)
$PwShellGUI = [PowerShell]::Create()

$PwShellGUI.AddScript({
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName System.Windows.Forms
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

    # Resetting log file
    Remove-Item $App.LogFolder -Recurse -Force | Out-Null

    # Creating folders
    New-Item $App.LogFolder -ItemType Directory -Force | Out-Null
    New-Item $App.FilesPath -ItemType Directory -Force | Out-File $App.LogPath -Encoding UTF8 -Append
    New-Item $App.FunctionsPath -ItemType Directory -Force | Out-File $App.LogPath -Encoding UTF8 -Append
    New-Item $App.ResourcesPath -ItemType Directory -Force | Out-File $App.LogPath -Encoding UTF8 -Append

    function Update-Splash {
        Param (
            $Value
        )
        $Hash.Status.Dispatcher.Invoke([action]{$Hash.Status.Text = $Value},"Normal")
        $Value | Out-File ($App.LogFolder +  "SplashOutput.log") -Encoding UTF8 -Append
        Start-Sleep .3
    }

    . ($App.ZKToolPath + "\Functions\Test-Sha.ps1")
    & Test-Sha

    # Updating app accent color
    Update-Splash "Cambiando colores..."
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

    Update-Splash "Cargando aplicación..."
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
                elseif ($_ -like "Extra*") {
                    $SourceList = "ExtraList"
                }
                else {
                    $SourceList = "UtilitiesList"
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
                    $App.Download.DownloadFile(($App.GitHubPath + "Functions/Export-Import.ps1"), ($App.FunctionsPath + "Export-Import.ps1"))
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

            if (($App.SelectedIP.Count -gt 0) -or ($App.SelectedDNS.Count -gt 0) -or ($App.CustomIP -gt 0) -or ($App.CustomDNS1 -gt 0)) {
                . ($App.FunctionsPath + "Set-NetConfig.ps1")
                Set-NetConfig
            }

            # Resetting buttons
            function Reset-Buttons {
                $App.SelectedButtons | ForEach-Object {
                    Update-GUI $_ IsChecked $false
                }
                if ($App.SelectedButtons.Length -gt 0) {
                    & Reset-Buttons
                }
            }
            & Reset-Buttons

            # Checking Restart
            if ($App.RequireRestart) {
                Write-UserOutput "Reinicio necesario"
                $MessageBox = [System.Windows.Forms.MessageBox]::Show("El equipo requiere reiniciarse para aplicar los cambios`r`nReiniciar equipo ahora?", "Reiniciar equipo", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information)
                if ($MessageBox -ne [System.Windows.Forms.DialogResult]::No) {
                    Write-UserOutput "Reiniciando pc en 5 segundos"
                    Start-Sleep 1
                    4..1 | ForEach-Object {
                        Update-GUI OutputBox Text "Reiniciando pc en $_ segundos..."
                        Start-Sleep 1
                    }
                    Start-Process Powershell -WindowStyle Hidden {
                        Start-Sleep 1
                        Get-Process "ZKTool" | Stop-Process
                        Remove-Item -Path "$env:temp\ZKTool\Files" -Recurse -Force
                        Restart-Computer
                    }
                }
            }

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
            Get-Process "ZKTool" | Stop-Process
            Remove-Item -Path "$env:temp\ZKTool\Files" -Recurse -Force
        }
    })

    Start-Sleep 1
    $App.GUILoaded = $true
    Start-Sleep 1

    $App.Window.ShowDialog()
}) | Out-Null

# Start loading app GUI
$PwShellGUI.Runspace = $GUIRunspace
$PwShellGUI.BeginInvoke() | Out-Null

# Wait until app GUI is loaded
while (!$App.GUILoaded) {
    Start-Sleep .3
}

# Close Splash Screen GUI after app is loaded
$Hash.Window.Dispatcher.Invoke("Normal",[action]{$Hash.Window.Close()})
$PwShell.EndInvoke($Handle) | Out-Null