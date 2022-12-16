$ErrorActionPreference = 'SilentlyContinue'

Get-Process "ZKTool" | Stop-Process | Out-Null

Remove-Item -Path $env:ProgramFiles\ZKTool -Recurse -Force | Out-Null
Remove-Item -Path "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk"

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
Remove-Item -Path "HKCR:\Directory\Background\shell\ZKTool" -Recurse -Force | Out-Null

Remove-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool\ZKTool.exe"
Remove-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool\UninstallZKTool.exe"

Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Recurse -Force | Out-Null

Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse -Force