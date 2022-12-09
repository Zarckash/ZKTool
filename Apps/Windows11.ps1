If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

$DesktopPath = Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Desktop" | Select-Object -ExpandProperty Desktop
$file = "http://zktoolip.ddns.net/files/Windows11.iso"
$filepath = $DesktopPath + "\Windows11.iso"


Write-Host "Descargando Windows11.iso..."

(New-Object Net.WebClient).DownloadFile($file, $filepath)