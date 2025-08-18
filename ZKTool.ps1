if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process Powershell -Verb RunAs {
        Start-Process "$env:ProgramFiles\ZKTool\Setup.exe" -ArgumentList "-Open"
    }
    exit
}

$Global:App = [Hashtable]::Synchronized(@{})

$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

$App.Version = "4.5.9"

if (!((Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion") -eq $App.Version)) {
    Start-Process Powershell -WindowStyle Hidden {
        Start-Process "$env:ProgramFiles\ZKTool\Setup.exe" -ArgumentList "-Update"
    }
    exit
}

$Global:Hash = [Hashtable]::Synchronized(@{})
$Hash.ZKToolPath = "$env:ProgramFiles\ZKTool\"
$Hash.GitHubPath = "https://github.com/Zarckash/ZKTool/raw/main/"
$Hash.Download = New-Object System.Net.WebClient
$Hash.HoverButtonColor = "#33FFFFFF"
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
    $Hash.Status.Text = "Comprobando actualizaciones..."

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
    $App.HoverColor = "#33FFFFFF"
    $App.HoverButtonColor = "#33FFFFFF"

    # Resetting log file
    Get-ChildItem $App.LogFolder -Exclude 'SetupOutput.log' | Remove-Item -Recurse -Force | Out-Null

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
    }

    Copy-Item -Path ($App.ZKToolPath + "\Functions\Test-Sha.ps1") -Destination ($App.FilesPath + "Test-Sha.ps1")
    . ($App.FilesPath + "Test-Sha.ps1")
    & Test-Sha

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

    Update-Splash "Cargando aplicación..."
    $Functions = @('Update-GUI','Switch-Tab','Enable-Buttons')
    $Functions | ForEach-Object {
        . ($App.FunctionsPath + "$_.ps1")
        & $_
    }

    Update-GUI AppVersion Text ("Versión " + $App.Version)

    $App.ZKToolLogoButton.Add_Click({
        $NewRunspace = [RunspaceFactory]::CreateRunspace()
        $NewRunspace.ApartmentState = "STA"
        $NewRunspace.ThreadOptions = "ReuseThread"          
        $NewRunspace.Open()
        $NewRunspace.SessionStateProxy.SetVariable("App", $App)
        $Logic = [PowerShell]::Create().AddScript({
            . ($App.FunctionsPath + "Update-GUI.ps1")
            . ($App.FunctionsPath + "Write-UserOutput.ps1")

            Write-UserOutput "Forzando actualización"

            Remove-Item ($App.ZKToolPath + "Sha.json") -Force | Out-File $App.LogPath -Encoding UTF8 -Append
            $JsonHashTable = @{
                "GlobalSha" = "$LatestSha"
                "Functions" = @{"Sha" = "" }
                "Resources" = @{
                    "Sha"    = ""
                    "Images" = @{
                     "Sha" = ""
                 }
                }
            }

            $JsonHashTable | ConvertTo-Json | Out-File ($App.ZKToolPath + "Sha.json") -Encoding UTF8
            attrib +h ($App.ZKToolPath + "Sha.json")

            Start-Sleep 2
            Start-Process Powershell -WindowStyle Hidden {
                Start-Sleep 2
                Start-Process "$env:ProgramFiles\ZKTool\ZKTool.exe"
            }
            $App.Window.Dispatcher.Invoke("Normal",[action]{$App.Window.Close()})

        })
        $Logic.Runspace = $NewRunspace
        $Logic.BeginInvoke() | Out-Null
    })

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
            . ($App.FunctionsPath + "Write-UserOutput.ps1")

            Update-GUI StartScript Background $App.AccentColor
            Update-GUI StartScript Content EJECUTANDO

            . ($App.FunctionsPath + "Install-App.ps1")
            . ($App.FunctionsPath + "Invoke-Function.ps1")
            . ($App.FunctionsPath + "Functions.ps1")
            . ($App.FunctionsPath + "Import-Configs.ps1")
            . ($App.FunctionsPath + "Export-Import.ps1")

            $App.WingetApps = New-Object System.Collections.Generic.List[System.Object]
            
            $App.SelectedButtons = $App.SelectedButtons | Sort-Object {[regex]::Replace($_, '\d+',{$args[0].Value.Padleft(20)})}
            $App.SelectedButtonsSorted = New-Object System.Collections.Generic.List[System.Object]
            $App.SelectedButtons | ForEach-Object {$App.SelectedButtonsSorted.Add($_)}

            # Apps
            $App.SelectedButtons | Select-String "App[1-9]" | ForEach-Object {
                Update-GUI Apps IsChecked $true
                if ($App.AppsList.$_.Source -in @('Winget','.exe','.appx')) {
                    Install-App -Item $_ -List 'AppsList'
                }
                else {
                    Invoke-Function -Item $_ -List 'AppsList'
                }
            }

            # Check Winget install after Apps tab is finish
            if ($App.WingetApps.Count -gt 0) {
                $getEncoding = [Console]::OutputEncoding
                [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

                $WingetList = winget list -s winget | Select-Object -Skip 4 | ConvertFrom-String -PropertyNames "Name", "Id", "Version", "Available" -Delimiter '\s{2,}'
                $WingetList += winget list -s msstore | Select-Object -Skip 4 | ConvertFrom-String -PropertyNames "Name", "Id", "Version", "Available" -Delimiter '\s{2,}'

                [Console]::OutputEncoding = $getEncoding

                $i = 1
                $App.WingetApps | ForEach-Object {
                    if ($App.WingetApps.Count -eq 1) {
                        Write-UserOutput -Message ("Comprobando instalación de " + $App.AppsList.$_.Name)
                    }
                    else {
                        Write-UserOutput -Message ("Comprobando instalación de " + $App.AppsList.$_.Name) -Progress ("$i de " + $App.WingetApps.Count)
                    }
    
                    if (!($WingetList.Id -contains $App.AppsList.$_.Installer)) {
                        Update-GUI $_ Foreground Red
                    }
                    $i++          
                }
            }

            # Tweaks
            $App.SelectedButtons | Select-String "Tweak[1-9]" | ForEach-Object {
                Update-GUI Tweaks IsChecked $true
                Invoke-Function -Item $_ -List 'TweaksList'
            }

            # Extra
            $App.SelectedButtons | Select-String "Extra[1-9]" | ForEach-Object {
                Update-GUI Extra IsChecked $true
                if ($App.ExtraList.$_.Source -in @('.Winget','.exe','.appx')) {
                    Install-App -Item $_ -List 'ExtraList'
                }
                else {
                    Invoke-Function -Item $_ -List 'ExtraList'
                }
            }

            # Utilities
            $App.SelectedButtons | Select-String "Utility[1-9]" | ForEach-Object {
                Update-GUI Utilities IsChecked $true
                if ($App.UtilitiesList.$_.Source -in @('.Winget','.exe','.appx')) {
                    Install-App -Item $_ -List 'UtilitiesList'
                }
                else {
                    Invoke-Function -Item $_ -List 'UtilitiesList'
                }
            }

            # Configs
            $App.SelectedButtons | Select-String "Config[1-9]" | ForEach-Object {
                Update-GUI Configs IsChecked $true
                Invoke-Function -Item $_ -List 'ConfigsList'
            }

            # Export or Import buttons
            switch ($App.SelectedButtons | Select-String ".*port") {
                'Export' {Update-GUI Configs IsChecked $true ; Export-Import -Export}
                'Import' {Update-GUI Configs IsChecked $true ; Export-Import -Import}
            }

            # User folders
            $App.FoldersToMove = New-Object System.Collections.Generic.List[System.Object]
            $App.FoldersToMove.Add(($App.SelectedButtons | Select-String ".*Folder"))
            $App.SelectedDisk = ($App.SelectedButtons | Select-String "Disk[1-6]")
            if (($App.FoldersToMove.Count -gt 0) -and ($App.SelectedDisk.Count -gt 0)) {
                . ($App.FunctionsPath + "Move-UserFolders.ps1")
                Move-UserFolders
            }

            # Net config
            $App.SelectedIP = ($App.SelectedButtons | Select-String "IP[1-6]")
            $App.SelectedDNS = ($App.SelectedButtons | Select-String "DNS[1-3]")

            if (($App.SelectedIP.Count -gt 0) -or ($App.SelectedDNS.Count -gt 0) -or ($App.CustomIP -gt 0) -or ($App.CustomDNS1 -gt 0)) {
                . ($App.FunctionsPath + "Set-NetConfig.ps1")
                Set-NetConfig
            }

            # Resetting buttons
            function Reset-Buttons {
                $App.SelectedButtonsSorted | ForEach-Object {
                    Update-GUI $_ IsChecked $false
                }
            }

            while ($App.SelectedButtonsSorted.Length -gt 0) {
                Reset-Buttons
            }
     
            $App.SelectedButtons = New-Object System.Collections.Generic.List[System.Object]

            Update-GUI StartScript Content "INICIAR SCRIPT"
            Update-GUI StartScript Background "Transparent"
            Update-GUI OutputBox Text "Script finalizado"
            "Script finalizado" | Out-File ($App.LogFolder +  "UserOutput.log") -Encoding UTF8 -Append
            Focus-Window "ZKTool"
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
            Start-Sleep 2
            Remove-Item -Path "$env:temp\ZKTool\Files\*" -Recurse -Force
        }
    })

    $App.GUILoaded = $true

    while (!$App.GUIClosed) {
        Start-Sleep .1
    }

    $App.Window.ShowDialog()
}) | Out-Null

# Start loading app GUI
$PwShellGUI.Runspace = $GUIRunspace
$PwShellGUI.BeginInvoke() | Out-Null

# Wait until app GUI is loaded
while (!$App.GUILoaded) {
    Start-Sleep .1
}

# Close Splash Screen GUI after app is loaded
$Hash.Window.Dispatcher.Invoke("Normal",[action]{$Hash.Window.Close()})
$PwShell.EndInvoke($Handle) | Out-Null
$App.GUIClosed = $true

Start-Sleep 1
Focus-Window "ZKTool"