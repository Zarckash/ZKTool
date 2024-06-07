function Invoke-Function {
    . ($App.FunctionsPath + "Functions.ps1")
    $App.FunctionsToRun | Sort-Object {[regex]::Replace($_, '\d+',{$args[0].Value.Padleft(20)})} | ForEach-Object {
        if ($_ -like "App*") {
            $SourceList = "AppsList"
        }
        elseif ($_ -like "Tweak*") {
            $SourceList = "TweaksList"
        }
        elseif ($_ -like "Extra*") {
            $SourceList = "ExtraList"
        }
        else {
            $App.Download.DownloadFile(($App.GitHubPath + "Functions/Import-Configs.ps1"), ($App.FunctionsPath + "Import-Configs.ps1"))
            . ($App.FunctionsPath + "Import-Configs.ps1")
            $SourceList = "ConfigsList"
        }

        Update-GUI $_ Foreground $App.AccentColor
        & $App.$SourceList.$_.FunctionName -Wait
    }
}