Function Update-GUI {
    Param (
        $Control,
        $Property,
        $Value
    )
    $App.$Control.Dispatcher.Invoke([action]{$App.$Control.$Property = $Value},"Normal")
}