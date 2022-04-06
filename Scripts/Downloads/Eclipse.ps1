If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$file = "https://github.com/Zarckash/FORMATEO/releases/download/W10/Eclipse.exe"
$filepath = "$env:userprofile\AppData\Local\Temp\FORMATEO\PROGRAMAS\Eclipse.exe"

Write-Host "Descargando Eclipse IDE..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)

Start-Process $filepath