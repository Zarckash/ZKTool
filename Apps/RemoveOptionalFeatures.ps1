If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$ErrorActionPreference = 'SilentlyContinue'

Write-Host "Desinstalando Grabacion De Acciones Del Usuario..."
dism /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0
Write-Host "Desinstalando Modo De Internet Explorer..."
dism /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0
Write-Host "Desinstalando Rostro De Windows Hello..."
dism /Online /Remove-Capability /CapabilityName:Hello.Face.20134~~~~0.0.1.0
Write-Host "Desinstalando Reconocedor Matematico..."
dism /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0
Write-Host "Desinstalando WordPad..."
dism /Online /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0
Write-Host "Desinstalando Servidor OpenSSH..."
dism /Online /Remove-Capability /CapabilityName:OpenSSH.Client~~~~0.0.1.0
Write-Host "Desinstalando Windows Powershell ISE..."
dism /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0