function Move-Form {
    param (
        $SelectedLabel
    )
    
    $global:Dragging   = $false
    $global:MouseDragX = 0
    $global:MouseDragY = 0

    $SelectedLabel.Add_MouseDown({
        $global:Dragging   = $true
        $global:MouseDragX = [System.Windows.Forms.Cursor]::Position.X - $Form.Left
        $global:MouseDragY = [System.Windows.Forms.Cursor]::Position.Y - $Form.Top
    })

    $SelectedLabel.Add_MouseMove({ 
        if ($global:Dragging) {
            $Screen = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
            $CurrentX = [System.Windows.Forms.Cursor]::Position.X
            $CurrentY = [System.Windows.Forms.Cursor]::Position.Y
            [int]$NewX = [Math]::Min($CurrentX - $global:MouseDragX, $Screen.Right - $Form.Width)
            [int]$NewY = [Math]::Min($CurrentY - $global:MouseDragY, $Screen.Bottom - $Form.Height)
            $Form.Location = New-Object System.Drawing.Point($NewX, $NewY)
        }
    })

    $SelectedLabel.Add_MouseUp({
        $global:Dragging = $false
    })
}