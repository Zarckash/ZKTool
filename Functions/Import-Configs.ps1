$DocumentsPath = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"

function ModernWarfareIII {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/ModernWarfareIII.zip"), ($App.FilesPath + "ModernWarfareIII.zip"))
    Expand-Archive -Path (($App.FilesPath + "ModernWarfareIII.zip")) -DestinationPath (($App.FilesPath + "ModernWarfareIII")) -Force
    $CpuCores = (((Get-ComputerInfo -Property CsProcessors).CsProcessors).NumberOfCores) - 1
    (Get-Content -Path ($App.FilesPath + "ModernWarfareIII\options.4.cod23.cst")).Replace("RendererWorkerCount:1.0 = `"`"","RendererWorkerCount:1.0 = `"$CpuCores`"") | Set-Content -Path ($App.FilesPath + "ModernWarfareIII\options.4.cod23.cst")
    Move-Item -Path ($App.FilesPath + "ModernWarfareIII\options.4.cod23.cst") -Destination "$DocumentsPath\Call of Duty\players" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config1.Name + " aplicada")
}

function PUBG {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/PUBG.zip"), ($App.FilesPath + "PUBG.zip"))
    Expand-Archive -Path ($App.FilesPath + "PUBG.zip") -DestinationPath "$env:localappdata\TslGame\Saved\Config\WindowsNoEditor" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config2.Name + " aplicada")
}

function ApexLegends {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Apex.zip"), ($App.FilesPath + "\Apex.zip"))
    Expand-Archive -Path ($App.FilesPath + "Apex.zip") -DestinationPath "$env:userprofile\Saved Games\Respawn\Apex" -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config3.Name + " aplicada")
}

function XDefiant {
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/XDefiant.zip"), ($App.FilesPath + "\XDefiant.zip"))
    Expand-Archive -Path ($App.FilesPath + "XDefiant.zip") -DestinationPath ($App.FilesPath + "XDefiant") -Force
    Get-Item -Path ($App.FilesPath + "XDefiant\bc_general_settings_.cfg") | Rename-Item -NewName (Get-Item ($DocumentsPath + "\My Games\XDefiant\bc_general_settings_*")).Name -Force
    Get-ChildItem -Path ($App.FilesPath + "XDefiant") | Move-Item -Destination "$DocumentsPath\My Games\XDefiant" -Force
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

function Plutonium {
    $App.Download.DownloadFile(($App.GitHubFilesPathPath + ".zip/Plutonium.zip"), ($App.FilesPath + "Plutonium.zip"))
    Expand-Archive -Path ($App.FilesPath + "Plutonium.zip") -DestinationPath ("$env:localappdata\Plutonium") -Force
    Write-UserOutput ("Configuracion de " + $App.ConfigsList.Config17.Name + " aplicada")
}