function Export-Import {
    param (
        [switch]$Export,
        [switch]$Import
    )
    
    New-Item -Path ($App.FilesPath + "Compress") -ItemType Directory -Force | Out-Null

    if ($Export.IsPresent) {
        $Path = @{
            File       = "https://github.com/Zarckash/ZKTool/raw/main/Files/.exe/MEGAcmdSetup64.exe"
            Temp       = ($env:temp + "\ZKTool\Files")
            Documents  = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"
            SavedGames = ($env:userprofile + "\Saved Games")
            OBS        = ($env:appdata + "\obs-studio")
            PUBG       = ($env:localappdata + "\TslGame\Saved\Config\WindowsNoEditor")
            RoN        = ($env:localappdata + "\ReadyOrNot\Saved")
            Spotify    = ($env:appdata + "\Spotify")
            CSGO       = (${env:ProgramFiles(x86)} + "\Steam\userdata")
            Valorant   = ($env:localappdata + "\VALORANT\Saved\Config")
            LoL        = ($env:HOMEDRIVE + "\Riot Games\League of Legends\Config")
            MSIAfterburner = (${env:ProgramFiles(x86)} + "\MSI Afterburner\Profiles")
            RivaTuner  = (${env:ProgramFiles(x86)} + "\RivaTuner Statistics Server")
            Compressed = ($env:temp + "\ZKTool\Files\Compress")
        }

        Write-UserOutput "Exportando Documentos"        
        Get-ChildItem -Path ($Path.Documents) -Name | ForEach-Object {New-Item -Path ($Path.Temp + "\Documents\" + $_) -ItemType Directory | Out-Null}

        $ExcludeList = @("*.mcache","*.PcDx12","*.bin","*.dat","*.cache","*.log","*.binperf","*.png","*.jpg","*.mbytecode","*.jpeg","*.gif","*.mp4","*.webm","*.dds","*.wav","*.ogg","library_0x*","*.js","*.db","*.mdmp","*.html")        
        Get-ChildItem -Path ($Path.Documents) | ForEach-Object {$_ | Copy-Item -Destination ($Path.Temp + "\Documents\") -Recurse -Force -Exclude $ExcludeList}
        Get-ChildItem -Path ($Path.Temp + "\Documents\") -Recurse | Where-Object { $_.PSISContainer -and @( $_ | Get-ChildItem ).Count -eq 0 } | Remove-Item -Recurse -Force | Out-Null
        Compress-Archive -Path ($Path.Temp + "\Documents\*") -DestinationPath ($Path.Compressed + "\Documents.zip")

        if (Test-Path ($Path.SavedGames + "\*")) {
            Write-UserOutput "Exportando Juegos Guardados"
            Get-ChildItem -Path $Path.SavedGames | Compress-Archive -DestinationPath ($Path.Compressed + "\SavedGames.zip")
        }
        if (Test-Path $Path.OBS) {
            Write-UserOutput "Exportando OBS"
            Compress-Archive -Path ($Path.OBS + "\global.ini"),($Path.OBS + "\basic") -DestinationPath ($Path.Compressed + "\OBS.zip")
            Compress-Archive -Path ($Path.OBS + "\themes") -DestinationPath ($Path.Compressed + "\OBS.zip") -Update
        }
        if (Test-Path $Path.PUBG) {
            Write-UserOutput "Exportando PUBG"
            Compress-Archive -Path ($Path.PUBG + "\*") -DestinationPath ($Path.Compressed + "\PUBG.zip")
        }
        if (Test-Path $Path.RoN) {
            Write-UserOutput "Exportando Ready Or Not"
            Compress-Archive -Path ($Path.RoN + "\*") -DestinationPath ($Path.Compressed + "\RoN.zip")
        }
        if (Test-Path $Path.Spotify) {
            Write-UserOutput "Exportando Spotify"
            Compress-Archive -Path ($Path.Spotify + "\prefs") -DestinationPath ($Path.Compressed + "\Spotify.zip")
        }
        if (Test-Path ($Path.CSGO + "\*\730")) {
            Write-UserOutput "Exportando CSGO"
            $SteamIDs = Get-ChildItem -Path $Path.CSGO -Directory -Name
            foreach ($ID in $SteamIDs) {
                if (Test-Path ($Path.CSGO + "\$ID\730\local\cfg\*")) {
                    New-Item -Path ($Path.Temp + "\CSGOFolders\$ID\730\local\cfg") -ItemType Directory -Force | Out-Null
                    Copy-Item -Path ($Path.CSGO + "\$ID\730\local\cfg\") -Recurse -Destination ($Path.Temp + "\CSGOFolders\$ID\730\local") -Force
                }
            }
            Compress-Archive -Path ($Path.Temp + "\CSGOFolders\*") -DestinationPath ($Path.Compressed + "\CSGO.zip")
        }
        if (Test-Path ($Path.Valorant + "\*\Windows")) {
            Write-UserOutput "Exportando Valorant"
            $ValorantIDs = Get-ChildItem -Path $Path.Valorant -Directory -Name
            foreach ($ID in $ValorantIDs) {
                if (Test-Path ($Path.Valorant + "\$ID\Windows\GameUserSettings.ini")) {
                    New-Item -Path ($Path.Temp + "\ValorantFolders\$ID\Windows") -ItemType Directory -Force | Out-Null
                    Copy-Item -Path ($Path.Valorant + "\$ID\Windows\") -Recurse -Destination ($Path.Temp + "\ValorantFolders\$ID\Windows") -Force
                }
            }
            Compress-Archive -Path ($Path.Temp + "\ValorantFolders\*") -DestinationPath ($Path.Compressed + "\Valorant.zip")
        }
        if (Test-Path $Path.LoL) {
            Write-UserOutput "Exportando League of Legends"
            Compress-Archive -Path ($Path.LoL + "\game.cfg"),($Path.LoL + "\PersistedSettings.json") -DestinationPath ($Path.Compressed + "LoL.zip")
        }
        if (Test-Path $Path.MSIAfterburner) {
            Write-UserOutput "Exportando MSIAfterburner"
            Compress-Archive -Path ($Path.MSIAfterburner + "\*") -DestinationPath ($Path.Compressed + "\MSIAfterburner.zip")
        }
        if (Test-Path $Path.RivaTuner) {
            Write-UserOutput "Exportando RivaTuner"
            Compress-Archive -Path ($Path.RivaTuner + "\Profiles"),($Path.RivaTuner + "\ProfileTemplates\Config") -DestinationPath ($Path.Compressed + "\RivaTuner.zip")
        }
    
        Write-UserOutput "Comprimiendo Settings"
        Get-ChildItem -Path ($Path.Compressed) | Compress-Archive -DestinationPath ($Path.Temp + "\SettingsBackup.zip")

        Write-UserOutput "Instalando MEGA"
        (New-Object System.Net.WebClient).DownloadFile($Path.File,($Path.Temp + "\MEGAcmdSetup64.exe"))
        Start-Process ($Path.Temp + "\MEGAcmdSetup64.exe") /S
        Start-Sleep 10

        Write-UserOutput "Subiendo Archivo"
        $FilePath = ($env:temp + "\ZKTool\Files\SettingsBackup.zip")
        $MegaPath = ("/Backup/$env:username" + "Backup.zip")
        Start-Process "$env:localappdata\MEGAcmd\MEGAclient.exe" -ArgumentList "login zktoolapp@gmail.com zktoolbackup" -WindowStyle Hidden
        Start-Sleep 7
        Start-Process "$env:localappdata\MEGAcmd\MEGAclient.exe" -ArgumentList "put $FilePath $MegaPath" -Wait -WindowStyle Hidden
        Start-Process "$env:localappdata\MEGAcmd\MEGAclient.exe" -ArgumentList "logout" -WindowStyle Hidden
        Start-Sleep 3
        Start-Process "$env:localappdata\MEGAcmd\MEGAclient.exe" -ArgumentList "quit" -WindowStyle Hidden
        Start-Sleep 3

        Write-UserOutput "Desinstalando MEGA"
        Get-Process "MEGAcmdServer" | Stop-Process
        Get-ScheduledTask -TaskName "*MEGAcmd*" | Unregister-ScheduledTask
        Remove-Item -Path ($env:localappdata + "\MEGAcmd") -Recurse -Force
        Remove-Item -Path ($env:appdata + "\Microsoft\Windows\Start Menu\Programs\MEGAcmd") -Recurse -Force
        Remove-Item -Path ($env:appdata + "\Microsoft\Windows\Start Menu\Programs\Uninstall MEGAcmd.lnk")
        Remove-Item -Path ((Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Desktop") + "\MEGAcmd.lnk")
        Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\MEGAcmd" -Recurse -Force
    }

    elseif ($Import.IsPresent) {
        $Path = @{
            File       = "https://github.com/Zarckash/ZKTool/raw/main/Files/.exe/MEGAcmdSetup64.exe"
            Temp       = ($env:temp + "\ZKTool\Files")
            Documents  = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"
            SavedGames = ($env:userprofile + "\Saved Games")
            OBS        = ($env:appdata + "\obs-studio")
            PUBG       = ($env:localappdata + "\TslGame\Saved\Config\WindowsNoEditor")
            RoN        = ($env:localappdata + "\ReadyOrNot\Saved")
            Spotify    = ($env:appdata + "\Spotify")
            CSGO       = (${env:ProgramFiles(x86)} + "\Steam\userdata")
            Valorant   = ($env:localappdata + "\VALORANT\Saved\Config")
            LoL        = ($env:HOMEDRIVE + "\Riot Games\League of Legends\Config")
            MSIAfterburner = (${env:ProgramFiles(x86)} + "\MSI Afterburner\Profiles")
            RivaTuner  = (${env:ProgramFiles(x86)} + "\RivaTuner Statistics Server")
            Backup     = ($env:temp + "\ZKTool\Files\SettingsBackup")
        }

        Write-UserOutput "Instalando MEGA"
        (New-Object System.Net.WebClient).DownloadFile($Path.File,($Path.Temp + "\MEGAcmdSetup64.exe"))
        Start-Process ($Path.Temp + "\MEGAcmdSetup64.exe") /S
        Start-Sleep 10

        Write-UserOutput "Descargando Archivo"
        $MegaPath = ("/Backup/$env:username" + "Backup.zip")
        $FilePath = ("$env:temp\ZKTool\Files\$env:username" + "Backup.zip")
        Start-Process "$env:localappdata\MEGAcmd\MEGAclient.exe" -ArgumentList "login zktoolapp@gmail.com zktoolbackup" -WindowStyle Hidden
        Start-Sleep 7
        Start-Process "$env:localappdata\MEGAcmd\MEGAclient.exe" -ArgumentList "get $MegaPath $FilePath" -Wait -WindowStyle Hidden
        Start-Process "$env:localappdata\MEGAcmd\MEGAclient.exe" -ArgumentList "logout" -WindowStyle Hidden
        Start-Sleep 3
        Start-Process "$env:localappdata\MEGAcmd\MEGAclient.exe" -ArgumentList "quit" -WindowStyle Hidden
        Start-Sleep 3

        Write-UserOutput "Desinstalando MEGA"
        Get-Process "MEGAcmdServer" | Stop-Process
        Get-ScheduledTask -TaskName "*MEGAcmd*" | Unregister-ScheduledTask
        Remove-Item -Path ($env:localappdata + "\MEGAcmd") -Recurse -Force
        Remove-Item -Path ($env:appdata + "\Microsoft\Windows\Start Menu\Programs\MEGAcmd") -Recurse -Force
        Remove-Item -Path ($env:appdata + "\Microsoft\Windows\Start Menu\Programs\Uninstall MEGAcmd.lnk")
        Remove-Item -Path ((Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Desktop") + "\MEGAcmd.lnk")
        Remove-Item -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\MEGAcmd" -Recurse -Force
        
        Write-UserOutput "Descomprimiendo Archivo"
        Expand-Archive -Path ($Path.Temp + "\$env:username" + "Backup.zip") -DestinationPath $Path.Backup -Force

        Get-ChildItem -Path $Path.Backup | ForEach-Object {
            Write-UserOutput ("Importando " + $_.BaseName.Replace("Documents","Documentos").Replace("SavedGames","Juegos Guardados").Replace("RoN","Ready Or Not") + "")
            Expand-Archive -Path $_.FullName -DestinationPath $Path.($_.BaseName) -Force
        }

        if (Test-Path ($Path.Backup + "\RivaTuner.zip")) {
            Move-Item -Path ($Path.RivaTuner + "\Config") -Destination ($Path.RivaTuner + "\ProfileTemplates") -Force
        }
    }
}