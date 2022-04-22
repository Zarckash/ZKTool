If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$file = "https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/RGBFusion.exe"
$filepath = "$env:userprofile\AppData\Local\Temp\ZKTool\Apps\RGBFusion.exe"

Write-Host "Descargando RGB Fusion..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)

Start-Process $filepath