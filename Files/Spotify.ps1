$ErrorActionPreference = 'SilentlyContinue'
$Host.UI.RawUI.WindowTitle = 'Spotify Installer'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-Expression "& { $((Invoke-WebRequest -useb 'https://raw.githubusercontent.com/amd64fox/SpotX/main/Install.ps1').Content) } -new_theme -confirm_uninstall_ms_spoti -confirm_spoti_recomended_over -podcasts_off -block_update_on"

Add-Content $env:appdata\Spotify\prefs "app.autostart-configured=true`nui.hardware_acceleration=false`napp.autostart-mode=`"off`""
New-Item -Path "HKCU:\Software" -Name "Spotify" | Out-Null
New-Item -Path "HKCU:\Software\Spotify" -Name "Window Position" | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Spotify\Window Position" -Name "Heigh" -Type DWord -Value 634 
Set-ItemProperty -Path "HKCU:\Software\Spotify\Window Position" -Name "Left" -Type DWord -Value 457
Set-ItemProperty -Path "HKCU:\Software\Spotify\Window Position" -Name "Show State" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\Software\Spotify\Window Position" -Name "Top" -Type DWord -Value 203
Set-ItemProperty -Path "HKCU:\Software\Spotify\Window Position" -Name "Width" -Type DWord -Value 1003
Start-Sleep 1