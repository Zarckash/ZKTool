function Install-App {  
    $i = 1
    $App.WingetApps = New-Object System.Collections.Generic.List[System.Object]

    $App.AppsToInstall | Sort-Object {[regex]::Replace($_, '\d+',{$args[0].Value.Padleft(20)})} | ForEach-Object {
        if ($_ -like "App*") {
            $SourceList = "AppsList"
        }
        elseif ($_ -like "Extra*") {
            $SourceList = "ExtraList"
        }elseif ($_ -like "Utility*") {
            $SourceList = "UtilitiesList"
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
            $WingetArguments = $App.$SourceList.$_.Arguments
            $WingetInstall = {
                param (
                    $WingetApp,
                    $WingetArguments,
                    $WingetLog
                )
                if (($WingetArguments).Length -eq 0) {
                    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id $WingetApp | Out-File $WingetLog -Encoding UTF8 -Append
                }else {
                    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id $WingetApp --override "$WingetArguments" | Out-File $WingetLog -Encoding UTF8 -Append
                }
                
            }
            Start-Job -Name ("Job-$WingetApp") -ScriptBlock $WingetInstall -ArgumentList @($WingetApp,$WingetArguments,$WingetLog)
        }
        elseif ($App.$SourceList.$_.Source -eq ".exe") {
            if (($App.$SourceList.$_.Url).Length -eq 0) {
                $App.Download.DownloadFile($GitHubPath, $LocalPath)
            }else {
                $App.Download.DownloadFile($App.$SourceList.$_.Url,$LocalPath)
            }
            
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
    $getEncoding = [Console]::OutputEncoding
    [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

    $WingetList = winget list -s winget | Select-Object -Skip 4 | ConvertFrom-String -PropertyNames "Name", "Id", "Version", "Available" -Delimiter '\s{2,}'
    $WingetList += winget list -s msstore | Select-Object -Skip 4 | ConvertFrom-String -PropertyNames "Name", "Id", "Version", "Available" -Delimiter '\s{2,}'

    [Console]::OutputEncoding = $getEncoding

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

        if (!($WingetList.Id -contains $App.$SourceList.$_.Installer)) {
            Update-GUI $_ Foreground Red
        }
        $i++
    }
}