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

        if ($AppsList.$App.Source -eq "Winget") {
            #winget install -h --force --accept-package-agreements --accept-source-agreements -e --id $AppsList.$App.Installer | Out-File $LogPath -Encoding UTF8 -Append
        }
        elseif ($AppsList.$App.Source -eq ".exe") {
            $Download.DownloadFile($GetPath, $SetPath)
            Start-Process $SetPath
        }  
        elseif ($AppsList.$App.Source -eq ".appx") {
            $Download.DownloadFile($GetPath, $SetPath)
            & {$ProgressPreference = 'SilentlyContinue'; Add-AppPackage $SetPath}
        }

        $i++
    }
}