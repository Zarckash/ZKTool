$App.PersonalizationDisabledButtons = @('WallpaperBox1','WallpaperBox2','ActualPreset','Preset1','Preset2','Preset3','Preset4','ApplyTheme')

$App.PersonalizationDisabledButtons | ForEach-Object {
    Update-GUI $_ IsEnabled $false
    Update-GUI $_ Opacity ".5"
}

if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme") -eq 0) {
    Update-GUI DarkThemeToggle IsChecked $true
}

if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency") -eq 1) {
    Update-GUI TransparencyToggle IsChecked $true
}

if ((Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode") -eq 0) {
    Update-GUI HideSearchButtonToggle IsChecked $true
}

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

    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Wallpapers.zip"),($App.FilesPath + "Wallpapers.zip"))
    Expand-Archive -Path ($App.FilesPath + "Wallpapers.zip") -DestinationPath ($App.FilesPath + "Wallpapers") -Force

    $App.Download.DownloadFile(($App.GitHubFilesPath + ".exe/AccentColorizer.exe"),($App.FilesPath + "AccentColorizer.exe"))

    $App.PersonalizationDisabledButtons | ForEach-Object {
        Update-GUI $_ IsEnabled $true
        Update-GUI $_ Opacity "1"
    }
})

$Logic.Runspace = $NewRunspace
$Logic.BeginInvoke() | Out-Null

$ColorDialog = New-Object System.Windows.Forms.ColorDialog
$ColorDialog.FullOpen = $true
$ColorDialog.AnyColor = $true

function Set-Color {
    param (
        $ControlName
    )

    $Dialog = $ColorDialog.ShowDialog()

    if ($Dialog -eq 'Cancel') {
        return
    }

    $SelectedColor = $ColorDialog.Color.Name

    switch ($SelectedColor) {
        Black       { $SelectedColor = "#FF0000" }
        DarkBlue    { $SelectedColor = "#00008B" }
        DarkGreen   { $SelectedColor = "#006400" }
        DarkCyan    { $SelectedColor = "#008B8B" }
        DarkRed     { $SelectedColor = "#8B0000" }
        DarkMagenta { $SelectedColor = "#8B008B" }
        Gray        { $SelectedColor = "#808080" }
        DarkGray    { $SelectedColor = "#A9A9A9" }
        Blue        { $SelectedColor = "#0000FF" }
        Green       { $SelectedColor = "#00FF00" }
        Cyan        { $SelectedColor = "#00FFFF" }
        Red         { $SelectedColor = "#FF0000" }
        Magenta     { $SelectedColor = "#FF00FF" }
        Yellow      { $SelectedColor = "#FFFF00" }
        White       { $SelectedColor = "#FFFFFF" }
        default     { $SelectedColor = ("#" + $SelectedColor.Substring(2,6)) }
    }

    Update-GUI $ControlName Background $SelectedColor
}

$Colors = @('ColorBox1','ColorBox2','ColorBox3','ColorBox4','ColorBox5')

$Colors | ForEach-Object {
    $App.$_.Add_Click({
        Set-Color -ControlName $this.Name
    })
}

function Set-WallPaperBox {
    param (
        $Box
    )

    $Dialog = $FileDialog.ShowDialog()

    if ($Dialog -eq 'Cancel') {
        return
    }

    $App.($Box -replace 'Box','') = $FileDialog.FileName
    Update-GUI ($Box + "Image") Source $App.($Box -replace 'Box','')
    Update-GUI $Box Height ($App.$Box.ActualWidth / 1.77)
    Update-GUI ($Box + "Label") Visibility Collapsed
    Update-GUI ($Box + "Image") Visibility Visible
}

$FileDialog = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    InitialDirectory = ($App.FilesPath + "Wallpapers")
    Filter = "Imágenes (*.png, *.jpg)|*.png;*.jpg"
}

$WallpaperBoxes = @('WallpaperBox1','WallpaperBox2')

$WallpaperBoxes | ForEach-Object {
    $App.$_.Add_Click({
        Set-WallPaperBox -Box $this.Name
    })
}

function Get-AccentColor {
    param (
        $Color
    )

    $AccentColor = "#"
    $Color = $Color - 1

    $GetWindowsAccentColor = (Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette") | Select-Object -Skip ($Color*4) | Select-Object -First 3

    $GetWindowsAccentColor | ForEach-Object {
        if ($_ -lt 10) {
            $AccentColor += ("0$_").ToUpper()
        }
        else {
            $AccentColor += ([convert]::Tostring($_, 16)).ToUpper()
        }
    }
    return $AccentColor
}

function Get-CurrentPreset {
    Update-GUI ColorBox1 Background (Get-AccentColor -Color 2)
    Update-GUI ColorBox2 Background (Get-AccentColor -Color 1)
    Update-GUI ColorBox3 Background (Get-AccentColor -Color 6)
    Update-GUI ColorBox4 Background (Get-AccentColor -Color 5)

    $RGB = ((Get-ItemPropertyValue -Path "HKCU:\Control Panel\Colors" -Name "HotTrackingColor") -replace ' ',',') -split ','
    $Red = [convert]::Tostring($RGB[0], 16)
    $Green = [convert]::Tostring($RGB[1], 16)
    $Blue = [convert]::Tostring($RGB[2], 16)
    if ($Red.Length -eq 1) {
        $Red = '0' + $Red
    }
    if ($Green.Length -eq 1) {
        $Green = '0' + $Green
    }
    if ($Blue.Length -eq 1) {
        $Blue = '0' + $Blue
    }
    $RGBColorToHex = "#" + $Red + $Green + $Blue
    Update-GUI ColorBox5 Background $RGBColorToHex.ToUpper()

    $App.Wallpaper1 = ((Get-Monitor)[0] | Get-Wallpaper).Path
    if (Test-Path $App.Wallpaper1) {
        Update-GUI WallpaperBox1Image Source $App.Wallpaper1
        Update-GUI WallpaperBox1 Height ($App.WallpaperBox1.ActualWidth / 1.77)
        Update-GUI WallpaperBox1Label Visibility Collapsed
        Update-GUI WallpaperBox1Image Visibility Visible
    }

    $App.Wallpaper2 = ((Get-Monitor)[1] | Get-Wallpaper).Path
    
    if (Test-Path $App.Wallpaper2) {
        Update-GUI WallpaperBox2Image Source $App.Wallpaper2
        Update-GUI WallpaperBox2 Height ($App.WallpaperBox2.ActualWidth / 1.77)
        Update-GUI WallpaperBox2Label Visibility Collapsed
        Update-GUI WallpaperBox2Image Visibility Visible
    }     
}

function Set-AccentColor {
    # Get color boxes values and convert format
    $App.ColorBox1.Background -replace '#','' -split '(..)' -ne '' | ForEach-Object {$Color1ToHex += ($_ + ",")}
    $App.ColorBox2.Background -replace '#','' -split '(..)' -ne '' | ForEach-Object {$Color2ToHex += ($_ + ",")}
    $App.ColorBox3.Background -replace '#','' -split '(..)' -ne '' | ForEach-Object {$Color3ToHex += ($_ + ",")}
    $App.ColorBox4.Background -replace '#','' -split '(..)' -ne '' | ForEach-Object {$Color4ToHex += ($_ + ",")}

    # Set accent colors in binary values
    $MainColor    = $Color1ToHex.Substring(3,9) + "00,"
    $SecondColor  = $Color2ToHex.Substring(3,9) + "00,"
    $TaskManagerH = $Color4ToHex.Substring(3,9) + "00,"
    $TaskManagerT = $Color3ToHex.Substring(3,9) + "00,"
    $Color1       = "FF,FF,FF,00,"
    $Color2       = "FF,FF,FF,00"
    $MaskValue = $SecondColor + $MainColor + $MainColor + $SecondColor + $TaskManagerH + $TaskManagerT + $Color1 + $Color2
    $MaskValueToHex = $MaskValue.Split(',') | ForEach-Object { "0x$_" }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette" -Type Binary -Value ([byte[]]$MaskValueToHex)

    # Get hot tracking color value and convert to rgb
    $HEXColor = ($App.ColorBox5.Background -replace '#','').Substring(2,6)
    $Red = $HEXColor.Remove(2, 4)
    $Green = $HEXColor.Remove(4, 2)
    $Green = $Green.remove(0, 2)
    $Blue = $HEXColor.Remove(0, 4)
    $Red = [convert]::ToInt32($Red, 16)
    $Green = [convert]::ToInt32($Green, 16)
    $Blue = [convert]::ToInt32($Blue, 16)

    $RGBColor = "$Red " + "$Green " + $Blue
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "Hilight" -Value $RGBColor
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "HotTrackingColor" -Value $RGBColor
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "MenuHilight" -Value $RGBColor

    # Set accent color in windows glyphs
    Start-Process ($App.FilesPath + "AccentColorizer.exe")
}

function Set-SelectedWallpaper {
    if (Test-Path $App.Wallpaper1) {
        Copy-Item -Path $App.Wallpaper1 -Destination ($App.ZKToolPath + "Media\Wallpaper1.png") -Force

        $App.Wallpaper1 = ($App.ZKToolPath + "Media\Wallpaper1.png")

        (Get-Monitor)[0] | Set-WallPaper -Path $App.Wallpaper1

        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion" -Name "PersonalizationCSP" | Out-File $App.LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value ($App.ZKToolPath + "Media\Wallpaper1.png")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value ($App.ZKToolPath + "Media\Wallpaper1.png")
    }

    if ((Test-Path $App.Wallpaper2) -and ($App.WallpaperBox2.Visibility -eq "Visible")) {
        Copy-Item -Path $App.Wallpaper2 -Destination ($App.ZKToolPath + "Media\Wallpaper2.png") -Force

        $App.Wallpaper2 = ($App.ZKToolPath + "Media\Wallpaper2.png")

        (Get-Monitor)[1] | Set-WallPaper -Path $App.Wallpaper2
    }
}

$App.ApplyTheme.Add_Click({
    Set-AccentColor
    Set-SelectedWallpaper

    Get-Process -Name "Explorer" | Stop-Process
})

Get-CurrentPreset

$App.ActualPreset.Add_Click({
    Get-CurrentPreset
})

$App.PresetsList = Get-Content ($App.ResourcesPath + "Presets.json") -Raw | ConvertFrom-Json
$App.PresetsList.psobject.properties.name | ForEach-Object {
    Update-GUI $_ Visibility Visible
    $App.$_.Add_Click({
        $Colors | ForEach-Object {
            Update-GUI $_ Background $App.PresetsList.($this.Name).$_
        }

        $App.Wallpaper1 = ($App.FilesPath + "Wallpapers\" + $App.PresetsList.($this.Name).Wallpaper)
        $App.Wallpaper2 = $App.Wallpaper1

        Update-GUI WallpaperBox1Image Source $App.Wallpaper1
        Update-GUI WallpaperBox1Label Visibility Collapsed
        Update-GUI WallpaperBox1Image Visibility Visible

        Update-GUI WallpaperBox2 Height ($App.WallpaperBox2.ActualWidth / 1.77)
        Update-GUI WallpaperBox2Image Source $App.Wallpaper2
        Update-GUI WallpaperBox2Label Visibility Collapsed
        Update-GUI WallpaperBox2Image Visibility Visible

        (Get-Monitor)[0] | Set-WallPaper -Path $App.Wallpaper1
        (Get-Monitor)[1] | Set-WallPaper -Path $App.Wallpaper2
    })
}

$App.DarkThemeToggle.Add_Checked({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0
    Get-Process "Explorer" | Stop-Process
})

$App.DarkThemeToggle.Add_Unchecked({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 1
    Get-Process "Explorer" | Stop-Process
})

$App.TransparencyToggle.Add_Checked({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 1
    Get-Process "Explorer" | Stop-Process
})

$App.TransparencyToggle.Add_Unchecked({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 0
    Get-Process "Explorer" | Stop-Process
})

$App.HideSearchButtonToggle.Add_Checked({
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
    Get-Process "Explorer" | Stop-Process
})

$App.HideSearchButtonToggle.Add_Unchecked({
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 3
    Get-Process "Explorer" | Stop-Process
})