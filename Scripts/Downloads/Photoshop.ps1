If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$file = "https://github.com/Zarckash/FORMATEO/releases/download/W10/PhotoshopPortable.zip"
$filepath = "$env:userprofile\AppData\Local\Temp\FORMATEO\PROGRAMAS\PhotoshopPortable.zip"

Write-Host "Descargando Photoshop Portable..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)

Expand-Archive -Path $filepath -DestinationPath "C:\Program Files\Adobe\Photoshop" -Force
Move-Item -Path "C:\Program Files\Adobe\Photoshop\Photoshop.lnk" -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"