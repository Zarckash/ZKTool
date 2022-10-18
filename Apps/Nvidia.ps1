If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$file = "https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/Nvidia.zip"
$filepath = "$env:userprofile\AppData\Local\Temp\ZKTool\Apps\Nvidia.zip"

Write-Host "Descargando Nvidia Drivers..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)

Expand-Archive -Path $filepath -DestinationPath "C:\Program Files\Adobe\Photoshop" -Force
Expand-Archive -Path $filepath -DestinationPath ("$env:userprofile\AppData\Local\Temp\ZKTool\Apps\Nvidia") -Force
Start-Process ($ToPath+"\Apps\Nvidia\setup.exe")