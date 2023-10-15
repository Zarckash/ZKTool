$App.NavItemsList = @('Apps','Tweaks','Extra','Configs','UserFolders','NetConfig','Personalization')
$App.DisksList = @('Disk1','Disk2','Disk3','Disk4','Disk5','Disk6')



@('Apps','Tweaks','Extra','Configs') | ForEach-Object {
    $App.$_.Add_Checked({
        $App.NavItemsList | ForEach-Object {
            Update-GUI $_ IsChecked $false
            Update-GUI ($_ + "ContentGrid") Visibility Collapsed
        }
        Update-GUI $this.Name IsChecked $true
        Update-GUI ($this.Name + "ContentGrid") Visibility Visible
    })
}

$App.Extra.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible
})

$App.Configs.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible
})

$App.UserFolders.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible

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
})

$App.NetConfig.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible

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
})

$App.Personalization.Add_Checked({
    Update-GUI OutputContentGrid Visibility Hidden
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible

    if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme") -eq 0) {
        Update-GUI DarkTheme IsChecked $true
    }
})

$App.Personalization.Add_Unchecked({
    Update-GUI OutputContentGrid Visibility Visible
})