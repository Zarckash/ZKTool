$App.AppsList = Get-Content ($App.ResourcesPath + "Apps.json") -Raw | ConvertFrom-Json
$App.TweaksList = Get-Content ($App.ResourcesPath + "Tweaks.json") -Raw | ConvertFrom-Json
$App.ExtraList = Get-Content ($App.ResourcesPath + "Extra.json") -Raw | ConvertFrom-Json
$App.UtilitiesList = Get-Content ($App.ResourcesPath + "Utilities.json") -Raw | ConvertFrom-Json
$App.ConfigsList = Get-Content ($App.ResourcesPath + "Configs.json") -Raw | ConvertFrom-Json
$UserFolders = @("DesktopFolder","DownloadsFolder","DocumentsFolder","PicturesFolder","VideosFolder","MusicFolder")
$App.IPList = @("IP1","IP2","IP3","IP4","IP5","IP6")
$DNSList = @("DNS1","DNS2","DNS3")

$InteractionButtons = @('Minimize','Maximize','Close')


$InteractionButtons | ForEach-Object {
    if ($_ -ne "Close") {
        $App.$_.Add_MouseEnter({
            $this.Background = $App.HoverButtonColor
        })
    }
    else {
        $App.$_.Add_MouseEnter({
            $this.Background = "#CC0000"
        })
    }

    $App.$_.Add_MouseLeave({
        $this.Background = "Transparent"
    })

}

$App.Minimize.Add_Click({
    $App.Window.WindowState = "Minimized"
})

$App.Maximize.Add_Click({
    if ($App.Window.WindowState -eq "Normal") {
        $App.Window.WindowState = "Maximized"
    }
    else {
        $App.Window.WindowState = "Normal"
    }
    Update-GUI Wallpaper1Box Height ($App.Wallpaper1Box.ActualWidth / 1.77)
    Update-GUI Wallpaper2Box Height ($App.Wallpaper2Box.ActualWidth / 1.77)
})

$App.Close.Add_Click({
    $App.Window.Close()
})


$App.SelectedButtons = New-Object System.Collections.Generic.List[System.Object]

$App.AppsList.psobject.properties.name + $App.TweaksList.psobject.properties.name + $App.ExtraList.psobject.properties.name + $App.UtilitiesList.psobject.properties.name + $App.ConfigsList.psobject.properties.name + $UserFolders | ForEach-Object {

    if ($_ -like "App*") {
        $SourceList = "AppsList"
    }
    elseif ($_ -like "Tweak*") {
        $SourceList = "TweaksList"
    }
    elseif ($_ -like "Extra*") {
        $SourceList = "ExtraList"
    }
    elseif ($_ -like "Utility*") {
        $SourceList = "UtilitiesList"
    }
    elseif ($_ -like "Config*") {
        $SourceList = "ConfigsList"
    }

    if ($_ -like "Config*") {
        Update-GUI ($_ + "Text") Text $App.$SourceList.$_.Name
        Update-GUI ($_ + "Image") Source ($App.ZKToolPath + "Resources\Images\" + $App.$SourceList.$_.Image)
    }
    elseif ($_ -notlike "*Folder") {
        Update-GUI $_ Content $App.$SourceList.$_.Name
    }

    Update-GUI $_ Visibility Visible
    
    if ((($App.$SourceList.$_.Enabled).Length -gt 0) -and ($App.$SourceList.$_.Enabled -eq "False")) {
        Update-GUI $_ IsEnabled $false
        Update-GUI $_ Opacity ".5"
    }

    $App.$_.Add_Checked({
        $App.SelectedButtons.Add($this.Name)
    })
    $App.$_.Add_Unchecked({
        $App.SelectedButtons.Remove($this.Name)
    })
}

@("Export","Import") | ForEach-Object {
    $App.$_.Add_Checked({
        @("Export","Import") | ForEach-Object {
            if ($_ -ne $this.Name) {
                Update-GUI $_ IsChecked $false
                $App.SelectedButtons.Remove($_)
            }
        }
        $App.SelectedButtons.Add($this.Name)        
    })
    $App.$_.Add_Unchecked({
        $App.SelectedButtons.Remove($this.Name)
    })
}

$App.SelectAllFolders.Add_Checked({
    $UserFolders | ForEach-Object {
        Update-GUI $_ IsChecked $false
    }
    $this.Content = "Deseleccionar todo"
    $UserFolders | ForEach-Object {
        Update-GUI $_ IsChecked $true
    }
})

$App.SelectAllFolders.Add_Unchecked({
    $this.Content = "Seleccionar todo"
    $UserFolders | ForEach-Object {
        Update-GUI $_ IsChecked $false
    }
})

$App.DisksList | ForEach-Object {
    $App.$_.Add_Checked({
        $App.DisksList | ForEach-Object {
            if ($_ -ne $this.Name) {
                Update-GUI $_ IsChecked $false
                $App.SelectedButtons.Remove($_)
            }
        }
        $App.SelectedButtons.Add($this.Name)
    })
    $App.$_.Add_Unchecked({
        $App.SelectedButtons.Remove($this.Name)
    })
}

$App.IndexIP = 20
$App.SearchIp.Add_Click({
    $NewRunspace = [RunspaceFactory]::CreateRunspace()
    $NewRunspace.ApartmentState = "STA"
    $NewRunspace.ThreadOptions = "ReuseThread"          
    $NewRunspace.Open()
    $NewRunspace.SessionStateProxy.SetVariable("App", $App)
    $Logic = [PowerShell]::Create().AddScript({
        . ($App.FunctionsPath + "Update-GUI.ps1")

        if ($App.SearchIp.Content -eq "Buscando...") {
            return
        }

        $App.FoundIPList = New-Object System.Collections.Generic.List[System.Object]

        Update-GUI SearchIp Background $App.AccentColor
        Update-GUI SearchIp Content Buscando...
        $Gateway = Get-NetIPConfiguration -InterfaceAlias Ethernet | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop
        $FoundIPs = 1
        for ($App.IndexIP; ($App.IndexIP -lt 254) -and ($FoundIPs -le 6); $App.IndexIP++) {
            $TestIP = $Gateway.Substring(0,10) + $App.IndexIP
            if (!(Test-Connection $TestIP -Count 1 -Quiet)) {
                $App.FoundIPList.Add($TestIP)
                Update-GUI ("IP" + $FoundIPs) Content $App.FoundIPList[$FoundIPs - 1]
                Update-GUI ("IP" + $FoundIPs) Visibility Visible
                $FoundIPs++
            }
        }

        Update-GUI SearchIp Background $App.HoverColor
        Update-GUI SearchIp Content "Buscar más IPs"
    })
    $Logic.Runspace = $NewRunspace
    $Logic.BeginInvoke() | Out-Null
})


$App.IPList | ForEach-Object {
    $App.$_.Add_Checked({
        $App.IPList | ForEach-Object {
            if ($_ -ne $this.Name) {
                Update-GUI $_ IsChecked $false
                $App.SelectedButtons.Remove($_)
            }
        }
        $App.SelectedButtons.Add($this.Name)
    })
    $App.$_.Add_Unchecked({
        $App.SelectedButtons.Remove($this.Name)
    })
}

$DNSList | ForEach-Object {
    Update-GUI $_ Visibility Visible
    $App.$_.Add_Checked({
        $DNSList | ForEach-Object {
            if ($_ -ne $this.Name) {
                Update-GUI $_ IsChecked $false
                $App.SelectedButtons.Remove($_) 
            }
        }
        $App.SelectedButtons.Add($this.Name)
    })
    $App.$_.Add_Unchecked({
        $App.SelectedButtons.Remove($this.Name)
    })
}

$App.GitHubLogo.Add_Click({
    Start-Process "https://github.com/Zarckash/ZKTool"
})

$App.ZKLogo.Add_Click({
    $Buttons = @("App1","App2","App3","App4","App5","App8","App9","App11","Tweak1","Tweak2","Tweak3","Tweak4","Tweak9","Tweak10","Tweak13","Tweak17","Tweak18","Tweak19",
    "Tweak21","Tweak22","Extra1","Extra2")
    $Buttons | ForEach-Object {
        Update-GUI $_ IsChecked $true
    }
})