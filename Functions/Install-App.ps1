function Install-App {
    param (
        $Item,
        $List
    )

    Update-GUI $Item Foreground $App.AccentColor
    Write-UserOutput -Message ($App.$List.$Item.Output + $App.$List.$Item.Name)

    $GitHubPath = $App.GitHubFilesPath + $App.$List.$Item.Source + "/" + $App.$List.$Item.Installer
    $LocalPath = $App.FilesPath + $App.$List.$Item.Installer
    $WingetLog = $App.LogFolder + $App.$List.$Item.Name + ".log"

    if ($App.$List.$Item.Source -eq 'Winget') {
        $App.WingetApps.Add($Item)

        $WingetApp = $App.$List.$Item.Installer
        $WingetArguments = $App.$List.$Item.Arguments

        if (($WingetArguments).Length -eq 0) {
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id $WingetApp | Out-File $WingetLog -Encoding UTF8 -Append
        }
        else {
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id $WingetApp --override "$WingetArguments" | Out-File $WingetLog -Encoding UTF8 -Append
        }
    }

    if ($App.$List.$Item.Source -eq '.exe') {
        if (($App.$List.$Item.Url).Length -eq 0) {
            $App.Download.DownloadFile($GitHubPath, $LocalPath)
        }
        else {
            $App.Download.DownloadFile($App.$List.$Item.Url, $LocalPath)
        }

        if (($App.$List.$Item.Arguments).Length -eq 0) {
            Start-Process $LocalPath
        }
        else {
            Start-Process $LocalPath -ArgumentList $App.$List.$Item.Arguments
        }
    }

    if ($App.$List.$Item.Source -eq '.appx') {
        $App.Download.DownloadFile($GitHubPath, $LocalPath)
        Add-AppPackage $LocalPath
    }
}