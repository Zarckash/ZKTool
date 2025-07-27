$App.NavItemsList = @('Apps','Tweaks','Extra','Utilities','Configs','UserFolders','NetConfig','Personalization')
$App.DisksList = @('Disk1','Disk2','Disk3','Disk4','Disk5','Disk6')

if ($App.AppsBorder.Opacity -eq 1) {
    $App.Apps.Add_Unchecked({
        Update-GUI AppsBorder Opacity 0
    })
}

$App.NavItemsList | ForEach-Object {
    $App.$_.Add_Checked({
        # Reset other buttons
        $App.NavItemsList | ForEach-Object {
            if ($_ -notlike $this.Name) {
                Update-GUI $_ IsChecked $false
                Update-GUI $_ IsEnabled $true
                Update-GUI ($_ + "ContentGrid") Visibility Hidden
            }
        }

        # Load page content
        if ($App.($this.Name + "Loaded") -ne $true) {
            $App.($this.Name + "Loaded") = $true
            & ("Load" + $this.Name )
        }

        # Block current button and show page
        Update-GUI $this.Name IsEnabled $false
        Update-GUI ($this.Name + "ContentGrid") Visibility Visible
    })
}

function LoadUserFolders {
    if ($App.Disk1.Visibility -ne "Visible") {
        $NewRunspace = [RunspaceFactory]::CreateRunspace()
        $NewRunspace.ApartmentState = "STA"
        $NewRunspace.ThreadOptions = "ReuseThread"          
        $NewRunspace.Open()
        $NewRunspace.SessionStateProxy.SetVariable("App", $App)
        $Logic = [PowerShell]::Create().AddScript({
            . ($App.FunctionsPath + "Update-GUI.ps1")
            $GetDisk = Get-Volume | Where-Object {(($_.DriveType -eq "Fixed") -and ($_.DriveLetter -like "?") -and ($_.FileSystemLabel -notlike ""))} | Select-Object DriveLetter,FileSystemLabel | Sort-Object -Property DriveLetter
            1..$GetDisk.Count | ForEach-Object {
                $App.("Disk$_" + "Label") = $GetDisk[$_ - 1].DriveLetter
                Update-GUI ("Disk$_" + "Text") Text ($GetDisk[$_ - 1].FileSystemLabel + " (" + $GetDisk[$_ - 1].DriveLetter + ":)")
                Update-GUI ("Disk$_") Visibility Visible
            }
        })
        $Logic.Runspace = $NewRunspace
        $Logic.BeginInvoke() | Out-Null
    }
}

function LoadNetConfig {
    if ($App.CurrentDNS1 -ne "Visible") {
        $NewRunspace = [RunspaceFactory]::CreateRunspace()
        $NewRunspace.ApartmentState = "STA"
        $NewRunspace.ThreadOptions = "ReuseThread"          
        $NewRunspace.Open()
        $NewRunspace.SessionStateProxy.SetVariable("App", $App)
        $Logic = [PowerShell]::Create().AddScript({
            . ($App.FunctionsPath + "Update-GUI.ps1")
            $Gateway = Get-NetIPConfiguration -InterfaceAlias Ethernet | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop
            $GetIP = Get-NetIPConfiguration -InterfaceAlias Ethernet | Select-Object -ExpandProperty IPv4Address | Select-Object -ExpandProperty IPv4Address
            $GetDNS = Get-DnsClientServerAddress -InterfaceAlias Ethernet -AddressFamily IPv4  | Select-Object -ExpandProperty ServerAddresses
            Update-GUI CurrentIPValue Content $GetIP
            if (!($GetDNS -eq $Gateway)) {
                Update-GUI CurrentDNS1 Visibility Visible
                Update-GUI CurrentDNS1Value Content $GetDNS[0]
                Update-GUI CurrentDNS2 Visibility Visible
                Update-GUI CurrentDNS2Value Content $GetDNS[1]
            }
        })
        $Logic.Runspace = $NewRunspace
        $Logic.BeginInvoke() | Out-Null
    }
}

function LoadPersonalization {
    $App.PersonalizationLoaded = $false

    Update-GUI OutputContentGrid Visibility Hidden

    if ($App.PersonalizationLogicLoaded -ne $true) {
        . ($App.FunctionsPath + "Set-Personalization.ps1")
    }
    
    if ($App.ModuleChecked -ne $true) {
        $NewRunspace = [RunspaceFactory]::CreateRunspace()
        $NewRunspace.ApartmentState = "STA"
        $NewRunspace.ThreadOptions = "ReuseThread"          
        $NewRunspace.Open()
        $NewRunspace.SessionStateProxy.SetVariable("App", $App)
        $Logic = [PowerShell]::Create().AddScript({
                . ($App.FunctionsPath + "Update-GUI.ps1")

                if (!(Get-InstalledModule -Name PowerShellGet) -or !(Get-InstalledModule -Name FP.SetWallpaper)) {
                    "Installing modules not found" | Out-File $App.LogPath -Encoding UTF8 -Append
                    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-File $App.LogPath -Encoding UTF8 -Append

                    [Net.ServicePointManager]::SecurityProtocol =
                    [Net.ServicePointManager]::SecurityProtocol -bor
                    [Net.SecurityProtocolType]::Tls12

                    Install-Module PowerShellGet -AllowClobber -Force
                    Remove-Module -Name PowerShellGet
                    Import-Module -Name PowerShellGet

                    Install-Module -Name FP.SetWallpaper -AcceptLicense -Force 
                }
    
                Import-Module -Name FP.SetWallpaper

                if ((Get-Monitor).Count -gt 1) {
                    Update-GUI WallpaperBox2 Visibility Visible
                }

                if (!(Test-Path ($App.ZKToolPath + "Media"))) {
                    New-Item ($App.ZKToolPath + "Media") -ItemType Directory -Force | Out-Null
                }

                $App.Download.DownloadFile(($App.GitHubFilesPath + ".exe/AccentColorizer.exe"), ($App.FilesPath + "AccentColorizer.exe"))
                Update-GUI ApplyTheme IsEnabled $true
                Update-GUI ApplyTheme Opacity "1"

                $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Wallpapers.zip"), ($App.FilesPath + "Wallpapers.zip"))
                Expand-Archive -Path ($App.FilesPath + "Wallpapers.zip") -DestinationPath ($App.FilesPath + "Wallpapers") -Force
                Update-GUI PresetsPanel Visibility Visible

                $App.ModuleChecked = $true
            })
        $Logic.Runspace = $NewRunspace
        $Logic.BeginInvoke() | Out-Null
    }
}

$App.Personalization.Add_Unchecked({
    Update-GUI OutputContentGrid Visibility Visible
})