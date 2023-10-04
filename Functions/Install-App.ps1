function Install-App {  
    $i = 1
    $App.WingetApps = New-Object System.Collections.Generic.List[System.Object]

    $App.AppsToInstall | ForEach-Object {
        if ($_ -like "App*") {
            $SourceList = "AppsList"
        }
        else {
            $SourceList = "ExtraList"
        }

        Update-GUI $_ Foreground $App.AccentColor

        if ($App.AppsToInstall.Count -eq 1) {
            Write-UserOutput -Message ($App.$SourceList.$_.Output + $App.$SourceList.$_.Name)
        }
        else {
            Write-UserOutput -Message ($App.$SourceList.$_.Output + $App.$SourceList.$_.Name) -Progress ("$i de " + $App.AppsToInstall.Count)
        }

        $GitHubPath = $App.GitHubFilesPath + $App.$SourceList.$_.Source + "/" + $App.$SourceList.$_.Installer
        $LocalPath = $App.FilesPath + $App.$SourceList.$_.Installer
        $WingetLog = $App.LogFolder + $App.$SourceList.$_.Name + ".log"

        if ($App.$SourceList.$_.Source -eq "Winget") {
            $App.WingetApps.Add($_)

            $WingetApp = $App.$SourceList.$_.Installer
            $WingetInstall = {
                param (
                    $WingetApp,
                    $WingetLog
                )
                "Output test para $WingetApp" | Out-File $WingetLog
                winget install -h --force --accept-package-agreements --accept-source-agreements -e --id $WingetApp | Out-File $WingetLog -Encoding UTF8 -Append
            }
            Start-Job -Name ("Job-$WingetApp") -ScriptBlock $WingetInstall -ArgumentList @($WingetApp,$WingetLog)
        }
        elseif ($App.$SourceList.$_.Source -eq ".exe") {
            $App.Download.DownloadFile($GitHubPath, $LocalPath)
            if (($App.$SourceList.$_.Arguments).Length -eq 0) {
                Start-Process $LocalPath
            }else {
                Start-Process $LocalPath -ArgumentList $App.$SourceList.$_.Arguments
            }
        }  
        elseif ($App.$SourceList.$_.Source -eq ".appx") {
            $App.Download.DownloadFile($GitHubPath, $LocalPath)
            Add-AppPackage $LocalPath
        }
        
        $i++
    }

    # Wait to clean jobs
    while (Get-Job -State Running) {
        Start-Sleep 1
    }
    Get-Job | Remove-Job

    # Check winget installs
    $i = 1
    $App.WingetApps | ForEach-Object {
        if ($_ -like "App*") {
            $SourceList = "AppsList"
        }
        else {
            $SourceList = "ExtraList"
        }

        if ($App.WingetApps.Count -eq 1) {
            Write-UserOutput -Message ("Comprobando instalación de " + $App.$SourceList.$_.Name)
        }
        else {
            Write-UserOutput -Message ("Comprobando instalación de " + $App.$SourceList.$_.Name) -Progress ("$i de " + $App.WingetApps.Count)
        }

        $WingetListCheck = Winget List $App.$SourceList.$_.Installer | Select-String -Pattern $App.$SourceList.$_.Installer | ForEach-Object {$_.matches} | Select-Object -ExpandProperty Value
        if (!($WingetListCheck -eq $App.$SourceList.$_.Installer)) {
            Update-GUI $_ Foreground Red
        }
        $i++
    }
}