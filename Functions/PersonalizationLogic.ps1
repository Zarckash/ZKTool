if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme") -eq 0) {
    Update-GUI DarkThemeToggle IsChecked $true
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


if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency") -eq 1) {
    Update-GUI TransparencyToggle IsChecked $true
}

$App.TransparencyToggle.Add_Checked({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 1
    Get-Process "Explorer" | Stop-Process
})

$App.TransparencyToggle.Add_Unchecked({
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 0
    Get-Process "Explorer" | Stop-Process
})











# Al hacer click en OK pillar el color seleccionado y actualizar GUI