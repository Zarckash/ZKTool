$DocumentsPath = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"
$SteamPath = (Get-Content "${env:ProgramFiles(x86)}\Steam\config\libraryfolders.vdf" | Select-String "Path") -replace '"Path"','' -replace "`t","" -replace '"','' -replace '\\\\','\' | ForEach-Object {"$_\steamapps\common\"}
$GetDisk = Get-Volume | Where-Object {(($_.DriveType -eq "Fixed") -and ($_.DriveLetter -like "?") -and ($_.FileSystemLabel -notlike ""))} | Sort-Object -Property DriveLetter | Select-Object -ExpandProperty DriveLetter

function BattlefieldLabs {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/BattlefieldLabs.zip"), ($App.FilesPath + "BattlefieldLabs.zip"))
    Expand-Archive -Path (($App.FilesPath + "BattlefieldLabs.zip")) -DestinationPath "$DocumentsPath\Battlefield Labs\settings\" -Force

    $GetDisk | ForEach-Object {
        $GameInstallPath += Get-ChildItem ("$_" + ":") -Recurse -Directory | Where-Object {($_.Name -Like "Battlefield Labs") -and ($_.FullName -notmatch "Documents|Videos")}
    }

    Copy-Item -Path "$DocumentsPath\Battlefield Labs\settings\user.cfg" -Destination ($GameInstallPath.FullName + "\user.cfg")
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config1.Name + " aplicada")
}

function ApexLegends {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Apex.zip"), ($App.FilesPath + "Apex.zip"))
    Expand-Archive -Path ($App.FilesPath + "Apex.zip") -DestinationPath "$env:userprofile\Saved Games\Respawn\Apex" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config2.Name + " aplicada")
}

function BlackOps6 {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/BO6.zip"), ($App.FilesPath + "BO6.zip"))
    Expand-Archive -Path (($App.FilesPath + "BO6.zip")) -DestinationPath "$DocumentsPath\Call of Duty\players\" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config3.Name + " aplicada")
}

function DeltaForce {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/DeltaForce.zip"), ($App.FilesPath + "DeltaForce.zip"))

    $SteamPath | ForEach-Object {
        if (Test-Path ($_ + "Delta Force")) {
            $DeltaForcePath = ($_ + "Delta Force\Game\DeltaForce\Saved\Config\WindowsClient")
            Expand-Archive -Path ($App.FilesPath + "DeltaForce.zip") -DestinationPath $DeltaForcePath -Force
        }
    }

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config5.Name + " aplicada")
}

function MarvelRivals {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/MarvelRivals.zip"), ($App.FilesPath + "MarvelRivals.zip"))
    Expand-Archive -Path ($App.FilesPath + "MarvelRivals.zip") -DestinationPath "$env:localappdata\Marvel\Saved\Config\Windows" -Force

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config6.Name + " aplicada")
}

function Plutonium {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Plutonium.zip"), ($App.FilesPath + "Plutonium.zip"))
    Expand-Archive -Path ($App.FilesPath + "Plutonium.zip") -DestinationPath ("$env:localappdata\Plutonium") -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config9.Name + " aplicada")
}

function MSIAfterburner {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/MSIAfterburner.zip"), ($App.FilesPath + "MSIAfterburner.zip"))
    Expand-Archive -Path ($App.FilesPath + "MSIAfterburner.zip") -DestinationPath ($App.FilesPath + "MSIAfterburner") -Force
    Move-Item -Path ($App.FilesPath + "MSIAfterburner\Profiles\*") -Destination 'C:\Program Files (x86)\MSI Afterburner\Profiles' -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config15.Name + " aplicada")
}

function RivaTuner {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/RivaTuner.zip"), ($App.FilesPath + "RivaTuner.zip"))
    Expand-Archive -Path ($App.FilesPath + "RivaTuner.zip") -DestinationPath ($App.FilesPath + "RivaTuner") -Force
    New-Item -Path 'C:\Program Files (x86)\RivaTuner Statistics Server\Profiles' -ItemType Directory | Out-Null
    Move-Item -Path ($App.FilesPath + "RivaTuner\Profiles\*") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\Profiles' -Force
    Move-Item -Path ($App.FilesPath + "RivaTuner\Config") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\ProfileTemplates' -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config16.Name + " aplicada")
}