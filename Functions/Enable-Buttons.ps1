$App.AppsList = Get-Content ($App.ResourcesPath + "Apps.json") -Raw | ConvertFrom-Json
$App.TweaksList = Get-Content ($App.ResourcesPath + "Tweaks.json") -Raw | ConvertFrom-Json
$App.ExtraList = Get-Content ($App.ResourcesPath + "Extra.json") -Raw | ConvertFrom-Json
$App.ConfigsList = Get-Content ($App.ResourcesPath + "Configs.json") -Raw | ConvertFrom-Json
$UserFolders = @("DesktopFolder","DownloadsFolder","DocumentsFolder","PicturesFolder","VideosFolder","MusicFolder")

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
})

$App.Close.Add_Click({
    $App.Window.Close()
})


$App.SelectedButtons = New-Object System.Collections.Generic.List[System.Object]

$App.AppsList.psobject.properties.name | ForEach-Object {
    Update-GUI $_ Content $App.AppsList.$_.Name
    Update-GUI $_ Visibility Visible
    $App.$_.Add_Click({
        if ($this.BorderThickness -eq 0) {
            $this.BorderThickness = 1.5
            $App.SelectedButtons.Add($this.Name)
        }
        else {
            $this.BorderThickness = 0
            $App.SelectedButtons.Remove($this.Name)
        }
    })
}

$App.TweaksList.psobject.properties.name | ForEach-Object {
    Update-GUI $_ Content $App.TweaksList.$_.Name
    Update-GUI $_ Visibility Visible
    $App.$_.Add_Click({
        if ($this.BorderThickness -eq 0) {
            $this.BorderThickness = 1.5
            $App.SelectedButtons.Add($this.Name)
        }
        else {
            $this.BorderThickness = 0
            $App.SelectedButtons.Remove($this.Name)
        }
    })
}

$App.ExtraList.psobject.properties.name | ForEach-Object {
    Update-GUI $_ Content $App.ExtraList.$_.Name
    Update-GUI $_ Visibility Visible
    $App.$_.Add_Click({
        if ($this.BorderThickness -eq 0) {
            $this.BorderThickness = 1.5
            $App.SelectedButtons.Add($this.Name)
        }
        else {
            $this.BorderThickness = 0
            $App.SelectedButtons.Remove($this.Name)
        }
    })
}

$App.ConfigsList.psobject.properties.name | ForEach-Object {
    Update-GUI ($_ + "Text") Text $App.ConfigsList.$_.Name
    Update-GUI ($_ + "Image") Source ($App.ZKToolPath + "Resources\Images\" + $App.ConfigsList.$_.Image)
    Update-GUI $_ Visibility Visible
    $App.$_.Add_Click({
        if ($this.BorderThickness -eq 0) {
            $this.BorderThickness = 1.5
            $App.SelectedButtons.Add($this.Name)
        }
        else {
            $this.BorderThickness = 0
            $App.SelectedButtons.Remove($this.Name)
        }
    })
}

@("Export","Import") | ForEach-Object {
    $App.$_.Add_Click({
        if ($this.BorderThickness -eq 0) {
            @("Export","Import") | ForEach-Object {
                Update-GUI $_ BorderThickness 0
                $App.SelectedButtons.Remove("Export")
                $App.SelectedButtons.Remove("Import")
            }
            $this.BorderThickness = 1.5
            $App.SelectedButtons.Add($this.Name)
        }
        else {
            $this.BorderThickness = 0
            $App.SelectedButtons.Remove($this.Name)
        }
    })
}

$UserFolders | ForEach-Object {
    Update-GUI $_ Visibility Visible
    $App.$_.Add_Click({
        if ($this.BorderThickness -eq 0) {
            $this.BorderThickness = 1.5
            $App.SelectedButtons.Add($this.Name)
        }
        else {
            $this.BorderThickness = 0
            $App.SelectedButtons.Remove($this.Name)
        }
    })
}

$App.SelectAllFolders.Add_Click({
    $UserFolders | ForEach-Object {
        $App.SelectedButtons.Remove($_)
    }
    if ($this.BorderThickness -eq 0) {
        $this.Content = "Deseleccionar todo"
        $this.BorderThickness = 1.5
        $UserFolders | ForEach-Object {
            Update-GUI $_ BorderThickness 1.5
            $App.SelectedButtons.Add($_)
        }
    }
    else {
        $this.Content = "Seleccionar todo"
        $this.BorderThickness = 0
        $UserFolders | ForEach-Object {
            Update-GUI $_ BorderThickness 0
            $App.SelectedButtons.Remove($_)
        }
    }
})

$App.DisksList | ForEach-Object {
    $App.$_.Add_Click({
        if ($this.BorderThickness -eq 0) {
            $App.DisksList | ForEach-Object {
                Update-GUI $_ BorderThickness 0
                $App.SelectedButtons.Remove($_)
            }
            $this.BorderThickness = 1.5
            $App.SelectedButtons.Add($this.Name)
        }
        else {
            $this.BorderThickness = 0
            $App.SelectedButtons.Remove($this.Name)
        }
    })
}