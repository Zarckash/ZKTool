If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$file = "https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/TarkovLauncher.exe"
$filepath = "$env:userprofile\AppData\Local\Temp\ZKTool\Apps\TarkovLauncher.exe"

Write-Host "Descargando Escape From Tarkov..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)

Start-Sleep 5

Start-Process $filepath