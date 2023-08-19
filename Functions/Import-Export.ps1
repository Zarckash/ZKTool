function Import-Export {
    param (
        [switch]$Export,
        [switch]$Import
    )
    
    New-Item -Path "$TempPath\Files\Compress" -ItemType Directory -Force | Out-Null

    if ($Export.IsPresent) {
        Start-Process Powershell {
            $ErrorActionPreference = 'SilentlyContinue'
            $host.UI.RawUI.WindowTitle = 'Settings Exporter'
            $Path = @{
                File       = 'https://github.com/Zarckash/ZKTool/raw/main/Files/.exe/MEGAcmdSetup64.exe'
                Temp       = ($env:temp + '\ZKTool\Files')
                Documents  = Get-ItemPropertyValue -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name 'Personal'
                SavedGames = ($env:userprofile + '\Saved Games')
                OBS        = ($env:appdata + '\obs-studio')
                PUBG       = ($env:localappdata + '\TslGame')
                Spotify    = ($env:appdata + '\Spotify')
                CSGO       = (${env:ProgramFiles(x86)} + '\Steam\userdata')
                MSIAfterburner = (${env:ProgramFiles(x86)} + '\MSI Afterburner')
                RivaTuner  = (${env:ProgramFiles(x86)} + 'RivaTuner Statistics Server')
                Compressed = ($env:temp + '\ZKTool\Files\Compress')
            }
    
            function Write-TypeHost ([string]$s = '',[string]$TextColor = 'Cyan') {
                $s -split '' | ForEach-Object {
                    Write-Host $_ -NoNewline -ForegroundColor $TextColor
                    Start-Sleep -Milliseconds 20
                }
                Start-Sleep -Milliseconds 20
                Write-Host ''
            }
    
            Write-TypeHost 'Exportando Documentos...'
            #Compress-Archive -Path ($Path.Documents + '\*') -CompressionLevel NoCompression -DestinationPath ($Path.Compressed + '\Documents.zip')
    
            if (Test-Path ($Path.SavedGames + '\*')) {
                Write-TypeHost 'Exportando Juegos Guardados...'
                Get-ChildItem -Path $Path.SavedGames | Compress-Archive -DestinationPath ($Path.Compressed + '\SavedGames.zip')
            }
            if (Test-Path $Path.OBS) {
                Write-TypeHost 'Exportando OBS...'
                Compress-Archive -Path ($Path.OBS + '\global.ini'),($Path.OBS + '\basic') -DestinationPath ($Path.Compressed + '\OBS.zip')
            }
            if (Test-Path $Path.PUBG) {
                Write-TypeHost 'Exportando PUBG...'
                Compress-Archive -Path ($Path.PUBG + '\Saved\Config\WindowsNoEditor\*') -DestinationPath ($Path.Compressed + '\PUBG.zip')
            }
            if (Test-Path $Path.Spotify) {
                Write-TypeHost 'Exportando Spotify...'
                Compress-Archive -Path ($Path.Spotify + '\prefs') -DestinationPath ($Path.Compressed + '\Spotify.zip')
            }
            if (Test-Path ($Path.CSGO + '\*\730')) {
                Write-TypeHost 'Exportando CSGO...'
                $SteamIDs = Get-ChildItem -Path $Path.CSGO -Directory
                foreach ($ID in $SteamIDs.Name) {
                    if (Test-Path ($Path.CSGO + '\' + $ID + '\730\local\cfg\*')) {
                        New-Item -Path ($Path.Temp + '\CSGOFolders\' + $ID + '\730\local\cfg') -ItemType Directory -Force | Out-Null
                        Copy-Item -Path ($Path.CSGO + '\' + $ID + '\730\local\cfg\*') -Destination ($Path.Temp + '\CSGOFolders\$ID\730\local\cfg') -Force
                    }
                }
                Compress-Archive -Path ($Path.Temp + '\CSGOFolders\*') -DestinationPath ($Path.Compressed + '\CSGO.zip')
            }
            if (Test-Path $Path.MSIAfterburner) {
                Write-TypeHost 'Exportando MSIAfterburner...'
                Compress-Archive -Path ($Path.MSIAfterburner + '\Profiles\*') -DestinationPath ($Path.Compressed + '\MSIAfterburner.zip')
            }
            if (Test-Path $Path.RivaTuner) {
                Write-TypeHost 'Exportando RivaTuner...'
                Compress-Archive -Path ($Path.RivaTuner + '\Profiles\*'),($Path.RivaTuner + '\ProfileTemplates\Config') -DestinationPath ($Path.Compressed + '\RivaTuner.zip')
            }
        
            Write-TypeHost 'Comprimiendo Settings...'
            Get-ChildItem -Path ($Path.Compressed) | Compress-Archive -CompressionLevel NoCompression -DestinationPath ($Path.Temp + '\SettingsBackup.zip')

            Write-TypeHost 'Instalando MEGA...'
            (New-Object System.Net.WebClient).DownloadFile($Path.File,($Path.Temp + '\MEGAcmdSetup64.exe'))
            Start-Process ($Path.Temp + '\MEGAcmdSetup64.exe') /S
            Start-Sleep 10

            Write-TypeHost 'Subiendo Archivo...'
            Set-Location ($env:localappdata + '\MEGAcmd')
            .\mega-login 'zktoolapp@gmail.com' 'zktoolbackup'
            .\mega-put ($Path.Temp + '\SettingsBackup.zip') ('/Backup/' + $env:username + 'Backup.zip')
            .\mega-logout
            .\uninst
        }
    }
    elseif ($Import.IsPresent) {
        Start-Process Powershell {
            $ErrorActionPreference = 'SilentlyContinue'
            $host.UI.RawUI.WindowTitle = 'Settings Importer'
            $Path = @{
                File       = 'http://'
                Temp       = ($env:temp + '\ZKTool\Files')
                Documents  = Get-ItemPropertyValue -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -Name 'Personal'
                SavedGames = ($env:userprofile + '\Saved Games')
                OBS        = ($env:appdata + '\obs-studio')
                PUBG       = ($env:localappdata + '\TslGame')
                Spotify    = ($env:appdata + '\Spotify')
                CSGO       = (${env:ProgramFiles(x86)} + '\Steam\userdata')
                MSIAfterburner = (${env:ProgramFiles(x86)} + '\MSI Afterburner')
                RivaTuner  = (${env:ProgramFiles(x86)} + 'RivaTuner Statistics Server')
                Backup     = ($env:temp + '\ZKTool\Files\SettingsBackup')
            }
    
            function Write-TypeHost ([string]$s = '',[string]$TextColor = 'Cyan') {
                $s -split '' | ForEach-Object {
                    Write-Host $_ -NoNewline -ForegroundColor $TextColor
                    Start-Sleep -Milliseconds 20
                }
                Start-Sleep -Milliseconds 20
                Write-Host ''
            }

            Write-TypeHost 'Instalando MEGA...'
            (New-Object System.Net.WebClient).DownloadFile($Path.File,($Path.Temp + '\MEGAcmdSetup64.exe'))
            Start-Process ($Path.Temp + '\MEGAcmdSetup64.exe') /S
            Start-Sleep 10

            Write-TypeHost 'Descargando Archivo...'
            Set-Location ($env:localappdata + '\MEGAcmd')
            .\mega-login 'zktoolapp@gmail.com' 'zktoolbackup'
            .\mega-get ('/Backup/' + $env:username + 'Backup.zip') ($Path.Temp + '\SettingsBackup.zip')
            .\mega-logout
            .\uninst
        }
    }
}