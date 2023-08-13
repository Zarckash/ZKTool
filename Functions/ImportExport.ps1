param (
    [switch]$Export,
    [switch]$Import
)

$Path = @{
    Documents  = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"
    SavedGames = "$env:userprofile\Saved Games"
    OBS        = "$env:appdata\obs-studio"
    PUBG       = "$env:localappdata\TslGame"
    Spotify    = "$env:appdata\Spotify"
    CSGO       = "${env:ProgramFiles(x86)}\Steam\userdata"
    MSIAfterburner = "${env:ProgramFiles(x86)}\MSI Afterburner"
    RivaTuner  = "${env:ProgramFiles(x86)}\RivaTuner Statistics Server"
    Compressed = "$env:temp\ZKTool\Configs\Compress"
}

function ExportSettings {
    $StatusBox.Text = "| Exportando Configuraciones..."
    New-Item -Path $Path.Compressed -ItemType Directory | Out-Null

    #Compress-Archive -Path ($Path.Documents + "\*") -CompressionLevel NoCompression -DestinationPath ($Path.Compressed + "\Documents.zip")

    if (Test-Path ($Path.SavedGames + "\*")) {
        Get-ChildItem -Path $Path.SavedGames | Compress-Archive -DestinationPath ($Path.Compressed + "\SavedGames.zip")
    }
    if (Test-Path $Path.OBS) {
        Compress-Archive -Path ($Path.OBS + "\global.ini"),($Path.OBS + "\basic") -DestinationPath ($Path.Compressed + "\OBS.zip")
    }
    if (Test-Path $Path.PUBG) {
        Compress-Archive -Path ($Path.PUBG + "\Saved\Config\WindowsNoEditor\*") -DestinationPath ($Path.Compressed + "\PUBG.zip")
    }
    if (Test-Path $Path.Spotify) {
        Compress-Archive -Path ($Path.Spotify + "\prefs") -DestinationPath ($Path.Compressed + "\Spotify.zip")
    }
    if (Test-Path ($Path.CSGO + "\*\730")) {
        $SteamIDs = Get-ChildItem -Path $Path.CSGO -Directory
        foreach ($ID in $SteamIDs.Name) {
            if (Test-Path ($Path.CSGO + "\" + $ID + "\730\local\cfg\*")) {
                New-Item -Path ("$env:temp\ZKTool\Configs\CSGOFolders\$ID\730\local\cfg") -ItemType Directory -Force | Out-Null
                Copy-Item -Path ($Path.CSGO + "\" + $ID + "\730\local\cfg\*") -Destination ("$env:temp\ZKTool\Configs\CSGOFolders\$ID\730\local\cfg") -Force
            }
        }
        Compress-Archive -Path ("$env:temp\ZKTool\configs\CSGOFolders\*") -DestinationPath ($Path.Compressed + "\CSGO.zip")
    }
    if (Test-Path $Path.MSIAfterburner) {
        Compress-Archive -Path ($Path.MSIAfterburner + "\Profiles\*") -DestinationPath ($Path.Compressed + "\MSIAfterburner.zip")
    }
    if (Test-Path $Path.RivaTuner) {
        Compress-Archive -Path ($Path.RivaTuner + "\Profiles\*"),($Path.RivaTuner + "\ProfileTemplates\Config") -DestinationPath ($Path.Compressed + "\RivaTuner.zip")
    }

    Get-ChildItem -Path ($Path.Compressed) | Compress-Archive -CompressionLevel NoCompression -DestinationPath "$env:temp\ZKTool\Configs\ExportSettings.zip"
}

function ImportSettings {
    $StatusBox.Text = "| Importando Configuraciones..."
    New-Item -Path $Path.Compressed -ItemType Directory | Out-Null

    
}



if ($Export.IsPresent) {
    ExportSettings
}elseif ($Import.IsPresent) {
    ImportSettings
} 