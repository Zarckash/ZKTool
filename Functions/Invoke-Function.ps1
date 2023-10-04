function Invoke-Function {
    . ($App.FunctionsPath + "Functions.ps1")
    $App.FunctionsToRun | ForEach-Object {
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
            . ($App.FunctionsPath + "Import-Configs.ps1")
            $SourceList = "ConfigsList"
        }

        Update-GUI $_ Foreground $App.AccentColor
        & $App.$SourceList.$_.FunctionName -Wait
    }
}