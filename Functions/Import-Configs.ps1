$DocumentsPath = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"

function Find-GamePath {
    param (
        $Name
    )

    Write-UserOutput "Buscando ruta de $Name"
    
    $GetDisk = Get-Volume | Where-Object {(($_.DriveType -eq "Fixed") -and ($_.DriveLetter -like "?") -and ($_.FileSystemLabel -notlike ""))} | Sort-Object -Property DriveLetter | Select-Object -ExpandProperty DriveLetter

    $GetDisk | ForEach-Object {
        $GameInstallPath += Get-ChildItem ("$_" + ":") -Recurse -Directory | Where-Object {($_.Name -eq $Name) -and ($_.FullName -notmatch "Documents|Videos")}
    }

    if (-not (Test-Path $GameInstallPath.FullName)) {
        Write-UserOutput "Ruta de $Name no encontrada"
        exit
    }
    else {
        return $GameInstallPath.FullName
    }
}

function Battlefield6Beta {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Battlefield6Beta.zip"), ($App.FilesPath + "Battlefield6Beta.zip"))
    Expand-Archive -Path (($App.FilesPath + "Battlefield6Beta.zip")) -DestinationPath "$DocumentsPath\Battlefield 6 Open Beta\settings\" -Force

    Find-GamePath -Name "Glacier Events" | ForEach-Object {
        Copy-Item -Path "$DocumentsPath\Battlefield 6 Open Beta\settings\user.cfg" -Destination $_
    }

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config1.Name + " aplicada")
}

function BattlefieldLabs {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/BattlefieldLabs.zip"), ($App.FilesPath + "BattlefieldLabs.zip"))
    Expand-Archive -Path (($App.FilesPath + "BattlefieldLabs.zip")) -DestinationPath "$DocumentsPath\Battlefield Labs\settings\" -Force

    Find-GamePath -Name "Battlefield Labs" | ForEach-Object {
        Copy-Item -Path "$DocumentsPath\Battlefield Labs\settings\user.cfg" -Destination $_
    }

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config2.Name + " aplicada")
}

function ApexLegends {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Apex.zip"), ($App.FilesPath + "Apex.zip"))
    Expand-Archive -Path ($App.FilesPath + "Apex.zip") -DestinationPath "$env:userprofile\Saved Games\Respawn\Apex" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config3.Name + " aplicada")
}

function PUBG {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/PUBG.zip"), ($App.FilesPath + "PUBG.zip"))
    Expand-Archive -Path ($App.FilesPath + "PUBG.zip") -DestinationPath "$env:localappdata\TslGame\Saved\Config\WindowsNoEditor" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config4.Name + " aplicada")
}

function BlackOps6 {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/BO6.zip"), ($App.FilesPath + "BO6.zip"))
    Expand-Archive -Path (($App.FilesPath + "BO6.zip")) -DestinationPath "$DocumentsPath\Call of Duty\players\" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config5.Name + " aplicada")
}

function DeltaForce {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/DeltaForce.zip"), ($App.FilesPath + "DeltaForce.zip"))

    Find-GamePath -Name "Delta Force" | ForEach-Object {
        Expand-Archive -Path ($App.FilesPath + "DeltaForce.zip") -DestinationPath ($_ + "\Game\DeltaForce\Saved\Config\WindowsClient")
    }

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config6.Name + " aplicada")
}

function MarvelRivals {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/MarvelRivals.zip"), ($App.FilesPath + "MarvelRivals.zip"))
    Expand-Archive -Path ($App.FilesPath + "MarvelRivals.zip") -DestinationPath "$env:localappdata\Marvel\Saved\Config\Windows" -Force

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config7.Name + " aplicada")
}

function CS2 {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/CS2.zip"), ($App.FilesPath + "CS2.zip"))
    $UserIds = Get-ChildItem "C:\Program Files (x86)\Steam\userdata" -Directory
    $UserIds.Name | ForEach-Object {
        Expand-Archive -Path ($App.FilesPath + "CS2.zip") -DestinationPath "C:\Program Files (x86)\Steam\userdata\$_\730\local" -Recurse -Force
    }
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config8.Name + " aplicada")
}

function Plutonium {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Plutonium.zip"), ($App.FilesPath + "Plutonium.zip"))
    Expand-Archive -Path ($App.FilesPath + "Plutonium.zip") -DestinationPath ("$env:localappdata\Plutonium") -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config9.Name + " aplicada")
}

function MSIAfterburner {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/MSIAfterburner.zip"), ($App.FilesPath + "MSIAfterburner.zip"))
    Expand-Archive -Path ($App.FilesPath + "MSIAfterburner.zip") -DestinationPath ($App.FilesPath + "MSIAfterburner") -Force

    # Check if MSI Afterburner is running
    if ($null -ne (Get-Process "MSIAfterburner")) {
        $MSIABRunning = $true
        Stop-Process -Name "MSIAfterburner"
    }

    Move-Item -Path ($App.FilesPath + "MSIAfterburner\Profiles\*") -Destination 'C:\Program Files (x86)\MSI Afterburner\Profiles' -Force

    if ($MSIABRunning) {
        Start-Process "${env:ProgramFiles(x86)}\MSI Afterburner\MSIAfterburner.exe"
    }

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config15.Name + " aplicada")
}

function RivaTuner {
    $Path = 'C:\Program Files (x86)\RivaTuner Statistics Server\Profiles'
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/RivaTuner.zip"), ($App.FilesPath + "RivaTuner.zip"))
    Expand-Archive -Path ($App.FilesPath + "RivaTuner.zip") -DestinationPath ($App.FilesPath + "RivaTuner") -Force
    New-Item -Path $Path -ItemType Directory | Out-Null

    # Check if MSI Afterburner is running
    if ($null -ne (Get-Process "MSIAfterburner")) {
        $MSIABRunning = $true
        Stop-Process -Name "MSIAfterburner"
    }

    Move-Item -Path ($App.FilesPath + "RivaTuner\Profiles\*") -Destination $Path -Force
    Move-Item -Path ($App.FilesPath + "RivaTuner\Config") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\ProfileTemplates' -Force
    Move-Item -Path ($App.FilesPath + "RivaTuner\default.ovl") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\Plugins\Clients\Overlays' -Force
    Get-ChildItem $Path | ForEach-Object {
        (Get-Content $_.FullName) -replace ('PositionX=.*','PositionX=6') -replace ('PositionY=.*','PositionY=1') -replace ('SyncLimiter=.*','SyncLimiter=3') -replace ('PassiveWait=.*','PassiveWait=0') -replace ('Face=.*','Face=GeForce') -replace ('Weight=.*','Weight=700') | Set-Content $_.FullName
    }

    if ($MSIABRunning) {
        Start-Process "${env:ProgramFiles(x86)}\MSI Afterburner\MSIAfterburner.exe"
    }

    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config16.Name + " aplicada")
}