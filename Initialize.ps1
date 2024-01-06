Set-ExecutionPolicy Bypass -ErrorAction SilentlyContinue

$ProgressPreference = 'SilentlyContinue'

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0 -ErrorAction SilentlyContinue

Add-MpPreference -ExclusionPath "$env:temp\ZKTool\" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool" -ErrorAction SilentlyContinue

New-Item "$env:temp\ZKTool\Files\" -ItemType Directory -Force | Out-Null

(New-Object System.Net.WebClient).DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip","$env:temp\ZKTool\Files\ZKTool.zip")
Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:temp\ZKTool" -Force

Start-Process "$env:temp\ZKTool\Setup.exe" -ArgumentList "-Install"

exit