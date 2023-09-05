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
            $Screen = @{
                Right = [System.Windows.Forms.Screen]::AllScreens.WorkingArea.Right | Select-Object -Last 1
                Bottom = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom
            }
            $CurrentX = [System.Windows.Forms.Cursor]::Position.X
            $CurrentY = [System.Windows.Forms.Cursor]::Position.Y

            if ($CurrentX -gt [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Right) {
                $Screen.Bottom = [System.Windows.Forms.Screen]::AllScreens.WorkingArea.Bottom | Select-Object -Last 1
            }
            else {
                $Screen.Bottom = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Bottom
            }

            [int]$NewX = [Math]::Min($CurrentX - $global:MouseDragX, $Screen.Right - 50)
            [int]$NewY = [Math]::Min($CurrentY - $global:MouseDragY, $Screen.Bottom - 50)
            $Form.Location = New-Object System.Drawing.Point($NewX, $NewY)
        }
    })

    $SelectedLabel.Add_MouseUp({
        $global:Dragging = $false
    })
}