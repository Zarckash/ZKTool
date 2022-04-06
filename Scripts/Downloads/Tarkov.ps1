If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$file = "https://github.com/Zarckash/FORMATEO/releases/download/W10/TarkovLauncher.exe"
$filepath = "$env:userprofile\AppData\Local\Temp\FORMATEO\PROGRAMAS\TarkovLauncher.exe"

Write-Host "Descargando Escape From Tarkov..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)

Start-Process $filepath