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
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/PresetsWallpapers.zip"),($App.FilesPath + "PresetsWallpapers.zip"))
    Expand-Archive -Path ($App.FilesPath + "PresetsWallpapers.zip") -DestinationPath ($App.FilesPath + "PresetsWallpapers")
})

$Logic.Runspace = $NewRunspace
$Logic.BeginInvoke() | Out-Null

$Script:ColorDialog = New-Object System.Windows.Forms.ColorDialog
$ColorDialog.FullOpen = $true
$ColorDialog.AnyColor = $true

function Script:Set-Color {
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

$Script:Colors = @('ColorBox1','ColorBox2','ColorBox3','ColorBox4','ColorBox5')

$Colors | ForEach-Object {
    $App.$_.Add_Click({
        Set-Color -ControlName $this.Name
    })
}

$Script:FileDialog = New-Object System.Windows.Forms.OpenFileDialog
$FileDialog.Filter = "Imágenes (*.png, *.jpg)|*.png;*.jpg"

$App.WallpaperBox.Add_Click({
    if ($FileDialog.ShowDialog() -eq 'OK') {
        Update-GUI WallpaperBoxImage Source $FileDialog.FileName
        Update-GUI WallpaperBox Height ($App.WallpaperBox.ActualWidth / 1.77)
        Update-GUI WallpaperBoxLabel Visibility Collapsed
        Update-GUI WallpaperBoxImage Visibility Visible
    }
})

function Script:Set-WallPaper {

    param (
        [parameter(Mandatory=$True)]
        [string]$Path
    )
 
    Add-Type -TypeDefinition @" 
    using System; 
    using System.Runtime.InteropServices;
  
    public class Params
    { 
        [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
        public static extern int SystemParametersInfo (Int32 uAction, 
                                                       Int32 uParam, 
                                                       String lpvParam, 
                                                       Int32 fuWinIni);
    }
"@ 
  
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
  
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
  
    [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Path, $fWinIni)
}

$App.ApplyTheme.Add_Click({

    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Type DWord -Value 0

    # Convert colors to hex
    $App.ColorBox1.Background -replace '#','' -split '(..)' -ne '' | ForEach-Object {$Color1ToHex += ($_ + ",")}
    $App.ColorBox2.Background -replace '#','' -split '(..)' -ne '' | ForEach-Object {$Color2ToHex += ($_ + ",")}
    $App.ColorBox3.Background -replace '#','' -split '(..)' -ne '' | ForEach-Object {$Color3ToHex += ($_ + ",")}
    $App.ColorBox4.Background -replace '#','' -split '(..)' -ne '' | ForEach-Object {$Color4ToHex += ($_ + ",")}

    $MainColor    = $Color1ToHex.Substring(3,9) + "00,"
    $SecondColor  = $Color2ToHex.Substring(3,9) + "00,"
    $TaskManagerH = $Color4ToHex.Substring(3,9) + "00,"
    $TaskManagerT = $Color3ToHex.Substring(3,9) + "00,"
    $Color1       = "FF,FF,FF,00,"
    $Color2       = "FF,FF,FF,00"
    $MaskValue = $SecondColor + $MainColor + $MainColor + $SecondColor + $TaskManagerH + $TaskManagerT + $Color1 + $Color2
    $MaskValueToHex = $MaskValue.Split(',') | ForEach-Object { "0x$_" }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette" -Type Binary -Value ([byte[]]$MaskValueToHex)

    # Hot tracking color to rgb
    $HEXColor = ($App.ColorBox5.Background -replace '#','').Substring(2,6)
    $red = $HEXColor.Remove(2, 4)
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

    if ($App.WallpaperBoxImage.Visibility -eq "Visible") {
        New-Item -Path ($App.ZKToolPath + "Media\") -ItemType Directory -Force | Out-File $App.LogPath -Encoding UTF8 -Append
        Copy-Item -Path $FileDialog.FileName -Destination ($App.ZKToolPath + "Media\" + ($FileDialog.FileName | Split-Path -Leaf)) -Force
        & Set-WallPaper -Path ($App.ZKToolPath + "Media\" + ($FileDialog.FileName | Split-Path -Leaf))
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion" -Name "PersonalizationCSP" | Out-File $App.LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value ($App.ZKToolPath + "Media\" + ($FileDialog.FileName | Split-Path -Leaf))
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value ($App.ZKToolPath + "Media\" + ($FileDialog.FileName | Split-Path -Leaf))
    }
    
    Get-Process "Explorer" | Stop-Process
})

function Script:Get-AccentColor {
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

$App.ActualPreset.Add_Click({
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

    $WallpaperPath = Get-ItemPropertyValue -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper"

    if (Test-Path $WallpaperPath) {
        $FileDialog.FileName = $WallpaperPath
        Update-GUI WallpaperBoxImage Source $WallpaperPath
        Update-GUI WallpaperBox Height ($App.WallpaperBox.ActualWidth / 1.77)
        Update-GUI WallpaperBoxLabel Visibility Collapsed
        Update-GUI WallpaperBoxImage Visibility Visible
    }
})

$App.PresetsList = Get-Content ($App.ResourcesPath + "Presets.json") -Raw | ConvertFrom-Json
$App.PresetsList.psobject.properties.name | ForEach-Object {
    Update-GUI $_ Visibility Visible
    $App.$_.Add_Click({
        $Colors | ForEach-Object {
            Update-GUI $_ Background $App.PresetsList.($this.Name).$_
        }
        $FileDialog.FileName = ($App.FilesPath + "PresetsWallpapers\" + $App.PresetsList.($this.Name).Wallpaper)
        Update-GUI WallpaperBoxImage Source ($App.FilesPath + "PresetsWallpapers\" + $App.PresetsList.($this.Name).Wallpaper)
        Update-GUI WallpaperBoxLabel Visibility Collapsed
        Update-GUI WallpaperBoxImage Visibility Visible
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