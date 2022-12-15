Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/ZKTool.exe" -OutFile "$env:ProgramFiles\ZKTool\ZKTool.exe"
Invoke-WebRequest -Uri "https://github.com/Zarckash/ZKTool/raw/main/Apps/ZKTool.lnk" -OutFile "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\ZKTool.lnk"
Start-Process $env:ProgramFiles\ZKTool\ZKTool.exe
Start-Sleep 2
Exit