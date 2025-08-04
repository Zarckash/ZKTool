function Set-AccentColor {
    
    param (
        $Color = 2
    )

    $App.AccentColor = "#"
    $Color = $Color - 1
    $DefaultAppColor = "#33CCCC"

    $GetWindowsAccentColor = (Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette") | Select-Object -Skip ($Color*4) -First 3


    if (($GetWindowsAccentColor[0] -ge 225) -and ($GetWindowsAccentColor[1] -ge 225) -and ($GetWindowsAccentColor[2] -ge 225)) {
        if ($Color -lt 5) {
            Set-AccentColor ($Color + 3)
        }
        else {
            $App.AccentColor = $DefaultAppColor
        }
    }
    else {
        $GetWindowsAccentColor | ForEach-Object {
            if ($_ -lt 10) {
                $App.AccentColor += ("0$_").ToUpper()
            }
            else {
                $App.AccentColor += ([convert]::Tostring($_, 16)).ToUpper()
            }
        }
    }

    if ($App.AccentColor -eq "#4CC2FF") {
        $App.AccentColor = $DefaultAppColor
    }

    if ($App.AccentColor -eq "#000000") {
        if ($Color -lt 5) {
            Set-AccentColor ($Color + 3)
        }
        else {
            $App.AccentColor = $DefaultAppColor
        }
    }

    $Utf8WithBOM = New-Object System.Text.UTF8Encoding $true
    $MyRawString = (Get-Content -Path ($App.ZKToolPath + "WPF\StylesDictionary.xaml") -Raw) -replace '"AppAccentColor" Color=".*"', ('"AppAccentColor" Color=' + ('"' + $App.AccentColor + '"'))
    [System.IO.File]::WriteAllLines(($App.ZKToolPath + "WPF\StylesDictionary.xaml"), $MyRawString, $Utf8WithBOM)
}