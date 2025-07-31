function Invoke-Function {
    param (
        $Item,
        $List
    )
    . ($App.FunctionsPath + "Functions.ps1")
    . ($App.FunctionsPath + "Import-Configs.ps1")

    Update-GUI $Item Foreground $App.AccentColor
    & $App.$List.$Item.FunctionName -Wait
}