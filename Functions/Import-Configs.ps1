$DocumentsPath = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"

function Find-GamePath {
    param (
        $Name
    )
    
    $GetDisk = Get-Volume | Where-Object {(($_.DriveType -eq "Fixed") -and ($_.DriveLetter -like "?") -and ($_.FileSystemLabel -notlike ""))} | Sort-Object -Property DriveLetter | Select-Object -ExpandProperty DriveLetter

    $GetDisk | ForEach-Object {
        $GameInstallPath += Get-ChildItem ("$_" + ":") -Recurse -Directory | Where-Object {($_.Name -eq $Name) -and ($_.FullName -notmatch "Documents|Videos")}
    }

    return $GameInstallPath.FullName
}

function BattlefieldLabs {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/BattlefieldLabs.zip"), ($App.FilesPath + "BattlefieldLabs.zip"))
    Expand-Archive -Path (($App.FilesPath + "BattlefieldLabs.zip")) -DestinationPath "$DocumentsPath\Battlefield Labs\settings\" -Force

    Find-GamePath -Name "Battlefield Labs" | ForEach-Object {
        Copy-Item -Path "$DocumentsPath\Battlefield Labs\settings\user.cfg" -Destination $_
    }

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config1.Name + " aplicada")
}

function ApexLegends {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Apex.zip"), ($App.FilesPath + "Apex.zip"))
    Expand-Archive -Path ($App.FilesPath + "Apex.zip") -DestinationPath "$env:userprofile\Saved Games\Respawn\Apex" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config2.Name + " aplicada")
}

function PUBG {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/PUBG.zip"), ($App.FilesPath + "PUBG.zip"))
    Expand-Archive -Path ($App.FilesPath + "PUBG.zip") -DestinationPath "$env:localappdata\TslGame\Saved\Config\WindowsNoEditor" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config3.Name + " aplicada")
}

function BlackOps6 {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/BO6.zip"), ($App.FilesPath + "BO6.zip"))
    Expand-Archive -Path (($App.FilesPath + "BO6.zip")) -DestinationPath "$DocumentsPath\Call of Duty\players\" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config4.Name + " aplicada")
}

function DeltaForce {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/DeltaForce.zip"), ($App.FilesPath + "DeltaForce.zip"))

    Find-GamePath -Name "Delta Force" | ForEach-Object {
        Expand-Archive -Path ($App.FilesPath + "DeltaForce.zip") -DestinationPath ($_ + "\Game\DeltaForce\Saved\Config\WindowsClient")
    }

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config5.Name + " aplicada")
}

function MarvelRivals {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/MarvelRivals.zip"), ($App.FilesPath + "MarvelRivals.zip"))
    Expand-Archive -Path ($App.FilesPath + "MarvelRivals.zip") -DestinationPath "$env:localappdata\Marvel\Saved\Config\Windows" -Force

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config6.Name + " aplicada")
}

function CS2 {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/CS2.zip"), ($App.FilesPath + "CS2.zip"))
    $UserIds = Get-ChildItem "C:\Program Files (x86)\Steam\userdata" -Directory
    $UserIds.Name | ForEach-Object {
        Expand-Archive -Path ($App.FilesPath + "CS2.zip") -DestinationPath "C:\Program Files (x86)\Steam\userdata\$_\730\local" -Recurse -Force
    }
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config7.Name + " aplicada")
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