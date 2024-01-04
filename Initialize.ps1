$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

New-Item "$env:temp\ZKTool\Files" -ItemType Directory -Force | Out-Null

(New-Object System.Net.WebClient).DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources.zip/ZKTool.zip","$env:temp\ZKTool\Files\ZKTool.zip")
Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:ProgramFiles\ZKTool" -Force

Start-Process "$env:ProgramFiles\ZKTool\Setup.exe"