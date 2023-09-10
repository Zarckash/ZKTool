function Install-App {
    param (
        [array]$Apps
    )

    $i = 1

    foreach ($App in $Apps) {
        if ($Apps.Count -eq 1) {
            Write-UserOutput -Message ($AppsList.$App.Output + $AppsList.$App.Name)
        }
        else {
            Write-UserOutput -Message ($AppsList.$App.Output + $AppsList.$App.Name) -Progress ("$i de " + $Apps.Count)
        }

        $GetPath = "$GitHubPath/Files/" + $AppsList.$App.Source + "/"  + $AppsList.$App.Installer
        $SetPath = "$TempPath\Files\"  + $AppsList.$App.Installer
        $WingetLog = $LogFolder + "\" + $AppsList.$App.Name + ".log"

        if ($AppsList.$App.Source -eq "Winget") {
            $WingetApp = $AppsList.$App.Installer
            $WingetInstall = {
                param (
                    $WingetApp,
                    $WingetLog
                )
                winget install -h --force --accept-package-agreements --accept-source-agreements -e --id $WingetApp | Out-File $WingetLog -Encoding UTF8 -Append
            }
            Start-Job -Name ("Job-$WingetApp") -ScriptBlock $WingetInstall -ArgumentList @($WingetApp,$WingetLog)
        }
        elseif ($AppsList.$App.Source -eq ".exe") {
            $Download.DownloadFile($GetPath, $SetPath)
            if ($AppsList.$App.Arguments -eq " ") {
                Start-Process $SetPath
            }else {
                Start-Process $SetPath -ArgumentList $AppsList.$App.Arguments
            }
        }  
        elseif ($AppsList.$App.Source -eq ".appx") {
            $Download.DownloadFile($GetPath, $SetPath)
            Add-AppPackage $SetPath
        }

        $i++
    }
    while (Get-Job -State Running) {
        Start-Sleep 1
    }
    Get-Job | Remove-Job
}