If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$file = "https://github.com/Zarckash/FORMATEO/releases/download/W10/PrimeVideo.appx"
$filepath = "$env:userprofile\AppData\Local\Temp\FORMATEO\PROGRAMAS\PrimeVideo.appx"

Write-Host "Descargando Amazon Prime Video..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)

Add-AppxPackage $filepath