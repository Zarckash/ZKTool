$App.AppsList = Get-Content ($App.ResourcesPath + "Apps.json") -Raw | ConvertFrom-Json
$App.TweaksList = Get-Content ($App.ResourcesPath + "Tweaks.json") -Raw | ConvertFrom-Json
$App.ExtraList = Get-Content ($App.ResourcesPath + "Extra.json") -Raw | ConvertFrom-Json
$App.UtilitiesList = Get-Content ($App.ResourcesPath + "Utilities.json") -Raw | ConvertFrom-Json
$App.ConfigsList = Get-Content ($App.ResourcesPath + "Configs.json") -Raw | ConvertFrom-Json

$AppKeys = $App.Keys | Sort-Object {[regex]::Replace($_, '\d+',{$args[0].Value.Padleft(20)})}

$ToExport = $AppKeys | Where-Object {$_ -Like "ToExport*"}
$UserFolders = $AppKeys | Where-Object {$_ -Like "*Folder"} | Where-Object {$_ -NotLike "LogFolder"}
$App.IPList = $AppKeys | Where-Object {$_ -Like "IP[0-9]"}
$DNSList = $AppKeys | Where-Object {$_ -Like "DNS[0-9]"}

$InteractionButtons = @('Minimize','Maximize','Close')

. ($App.FunctionsPath + "Update-GUI.ps1")

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
    
    Update-GUI WallpaperBox1 Height ($App.WallpaperBox1.ActualWidth / 1.77)
    Update-GUI WallpaperBox2 Height ($App.WallpaperBox2.ActualWidth / 1.77)
})

$App.Close.Add_Click({
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
            $App.Window.Close()
            Start-Process Powershell -WindowStyle Hidden {
                Restart-Computer
            }
        }
        else {
            $App.Window.Close()
        }
    } else {
        $App.Window.Close()
    }
})


$App.SelectedButtons = New-Object System.Collections.Generic.List[System.Object]

$App.ListItemsNames = $App.AppsList.psobject.properties.name + $App.TweaksList.psobject.properties.name + $App.ExtraList.psobject.properties.name + $App.UtilitiesList.psobject.properties.name + $App.ConfigsList.psobject.properties.name + $UserFolders

$App.ListItemsNames | ForEach-Object {

    if ($_ -like "App*") {
        $App.SourceList = "AppsList"
    }
    elseif ($_ -like "Tweak*") {
        $App.SourceList = "TweaksList"
    }
    elseif ($_ -like "Extra*") {
        $App.SourceList = "ExtraList"
    }
    elseif ($_ -like "Utility*") {
        $App.SourceList = "UtilitiesList"
    }
    elseif ($_ -like "Config*") {
        $App.SourceList = "ConfigsList"
    }

    if ($_ -like "Config*") {
        Update-GUI ($_ + "Text") Text $App.($App.SourceList).$_.Name
        Update-GUI ($_ + "Image") Source ($App.ZKToolPath + "Resources\Images\" + $App.($App.SourceList).$_.Image)
    }
    elseif ($_ -notlike "*Folder") {
        Update-GUI $_ Content $App.($App.SourceList).$_.Name
    }

    Update-GUI $_ Visibility Visible
    
    if ((($App.($App.SourceList).$_.Enabled).Length -gt 0) -and ($App.($App.SourceList).$_.Enabled -eq "False")) {
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

$ToExportText = @("Documentos","Partidas guardadas","OBS","PUBG","Ready Or Not","Spotify","CSGO","Valorant","League of Legends","MSI Afterburner","RivaTuner")
for ($i = 0; $i -lt $ToExport.Count; $i++) {
    Update-GUI $ToExport[$i] Text $ToExportText[$i]
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

Update-GUI ApplyTheme IsEnabled $false
Update-GUI ApplyTheme Opacity ".5"

$App.GitHubLogo.Add_Click({
    Start-Process "https://github.com/Zarckash/ZKTool"
})

$App.ZKLogo.Add_Click({
    $App.ListItemsNames | ForEach-Object {
        if ($_ -like "App*") {
            $App.SourceList = "AppsList"
        }
        elseif ($_ -like "Tweak*") {
            $App.SourceList = "TweaksList"
        }
        elseif ($_ -like "Extra*") {
            $App.SourceList = "ExtraList"
        }
        elseif ($_ -like "Utility*") {
            $App.SourceList = "UtilitiesList"
        }
        elseif ($_ -like "Config*") {
            $App.SourceList = "ConfigsList"
        }
        
        if (($App.($App.SourceList).$_.Preset -eq "True") -and !($App.ZKLogoPressed)) {
            Update-GUI $_ IsChecked $true
        } elseif (($App.($App.SourceList).$_.Preset -eq "True") -and ($App.ZKLogoPressed)) {
            Update-GUI $_ IsChecked $false
        }

        if ($App.($App.SourceList).$_.Enabled -eq "False") {
            Update-GUI $_ IsEnabled $false
        }
    }
    if ($App.ZKLogoPressed) {
        $App.ZKLogoPressed = $false
    } else {
        $App.ZKLogoPressed = $true
    }          
})