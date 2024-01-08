$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'SilentlyContinue'

Set-ExecutionPolicy Bypass

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

Add-MpPreference -ExclusionPath "$env:temp\ZKTool\"
Add-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool"

New-Item "$env:temp\ZKTool\Files\" -ItemType Directory -Force | Out-Null

(New-Object System.Net.WebClient).DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip", "$env:temp\ZKTool\Files\ZKTool.zip")
Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:temp\ZKTool\Files\Temp" -Force

Start-Process "$env:temp\ZKTool\Files\Temp\Setup.exe" -ArgumentList "-Install"

exit