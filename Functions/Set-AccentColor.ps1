function Set-AccentColor {
    
    param (
        $Color = 2
    )

    $App.AccentColor = "#"
    $Color = $Color - 1

    $GetWindowsAccentColor = (Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette") | Select-Object -Skip ($Color*4) | Select-Object -First 3

    $GetWindowsAccentColor | ForEach-Object {
        if ($_ -lt 10) {
            $App.AccentColor += ("0$_").ToUpper()
        }
        else {
            $App.AccentColor += ([convert]::Tostring($_, 16)).ToUpper()
        }
    }

    if (($App.AccentColor -eq "#000000") -or ($App.AccentColor -eq "#FFFFFF")) {
        Set-AccentColor 4
    }

    if ($App.AccentColor -eq "#4CC2FF") {
        $App.AccentColor = "#ACA5F3" # Default app color
    }

    $Utf8WithBOM = New-Object System.Text.UTF8Encoding $true
    $MyRawString = (Get-Content -Path ($App.ZKToolPath + "WPF\StylesDictionary.xaml") -Raw) -replace '"AppAccentColor" Color=".*"', ('"AppAccentColor" Color=' + ('"' + $App.AccentColor + '"'))
    [System.IO.File]::WriteAllLines(($App.ZKToolPath + "WPF\StylesDictionary.xaml"), $MyRawString, $Utf8WithBOM)
}