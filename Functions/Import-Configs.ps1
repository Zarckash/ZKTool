$DocumentsPath = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"

function ModernWarfareII {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/ModernWarfareII.zip"), ($App.FilesPath + "ModernWarfareII.zip"))
    Expand-Archive -Path (($App.FilesPath + "ModernWarfareII.zip")) -DestinationPath (($App.FilesPath + "\ModernWarfareII")) -Force
    Move-Item -Path ($App.FilesPath + "ModernWarfareII\options.3.cod22.cst") -Destination ("$DocumentsPath\Call of Duty\players") -Force
    $CodPath = "$DocumentsPath\Call of Duty\players\" 
    $CodIDPath = ($CodPath + (Get-ChildItem $CodPath -Directory -Name 765*))
    Move-Item -Path ($App.FilesPath + "ModernWarfareII\settings.3.local.cod22.cst") -Destination $CodIDPath -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config1.Name + " aplicada")
}

function PUBG {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/PUBG.zip"), ($App.FilesPath + "PUBG.zip"))
    Expand-Archive -Path ($App.FilesPath + "PUBG.zip") -DestinationPath "$env:localappdata\TslGame\Saved\Config\WindowsNoEditor" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config2.Name + " aplicada")
}

function CSGO {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/CSGO.zip"), ($App.FilesPath + "CSGO.zip"))
    Expand-Archive -Path ($App.FilesPath + "\CSGO.zip") -DestinationPath $App.FilesPath -Force
    $UserIds = Get-ChildItem "C:\Program Files (x86)\Steam\userdata" -Directory
    foreach ($Id in $UserIds.name) {
        Copy-Item -Path ($App.FilesPath + "730") -Destination "C:\Program Files (x86)\Steam\userdata\$Id" -Recurse -Force
    }
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config3.Name + " aplicada")
}

function ApexLegends {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Apex.zip"), ($App.FilesPath + "\Apex.zip"))
    Expand-Archive -Path ($App.FilesPath + "Apex.zip") -DestinationPath "$env:userprofile\Saved Games\Respawn\Apex" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config4.Name + " aplicada")
}

function MSIAfterburner {
    $App.Download.DownloadFile(($App.GitHubFilesPathPath + ".zip/MSIAfterburner.zip"), ($App.FilesPath + "MSIAfterburner.zip"))
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