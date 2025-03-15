$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Run Script As Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process Powershell -Verb RunAs {
        Invoke-Expression (Invoke-WebRequest -useb "https://raw.githubusercontent.com/Zarckash/ZKTool/main/Functions/FirstRun.ps1")
    }
    exit
}

Set-ExecutionPolicy Bypass

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

Add-MpPreference -ExclusionPath "$env:temp\ZKTool\"
Add-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool"

New-Item "$env:temp\ZKTool\Files\" -ItemType Directory -Force | Out-Null

(New-Object System.Net.WebClient).DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/ZKTool.zip", "$env:temp\ZKTool\Files\ZKTool.zip")
Expand-Archive -Path "$env:temp\ZKTool\Files\ZKTool.zip" -DestinationPath "$env:temp\ZKTool\Files\Temp" -Force

Start-Process "$env:temp\ZKTool\Files\Temp\Setup.exe" -ArgumentList "-Install"

Start-Sleep 1

exit