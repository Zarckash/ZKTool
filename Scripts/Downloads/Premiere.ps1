If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$file = "https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/PremierePortable.zip"
$filepath = "$env:userprofile\AppData\Local\Temp\ZKTool\Apps\PremierePortable.zip"

Write-Host "Descargando Premiere Portable..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)

Expand-Archive -Path $filepath -DestinationPath "C:\Program Files\Adobe\Premiere" -Force
Move-Item -Path "C:\Program Files\Adobe\Premiere\Premiere.lnk" -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"