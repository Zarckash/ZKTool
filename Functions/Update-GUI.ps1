function Update-GUI {
    Param (
        [String]$Control,
        [String]$Property,
        $Value
    )
    $App.$Control.Dispatcher.Invoke([action]{$App.$Control.$Property = $Value},"Normal")
}