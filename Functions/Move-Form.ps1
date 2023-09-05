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

            $PrimaryScreen = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
            $AllScreens = [System.Windows.Forms.Screen]::AllScreens.WorkingArea

            $Screen = @{
                Width = ($AllScreens.Width | Select-Object -First 1) + ($AllScreens.Width | Select-Object -Last 1)
                Height = 0
            }

            $CurrentX = [System.Windows.Forms.Cursor]::Position.X
            $CurrentY = [System.Windows.Forms.Cursor]::Position.Y

            if (($CurrentX -gt $PrimaryScreen.Width) -or ($CurrentX -lt 0)) {
                $Screen.Height = $AllScreens.Bottom | Select-Object -Last 1
            }elseif (($AllScreens.Top | Select-Object -Last 1) -ge $PrimaryScreen.Height) {
                $Screen.Height = $AllScreens.Bottom | Select-Object -Last 1
            }else {
                $Screen.Height = $PrimaryScreen.Bottom
            }

            [int]$NewX = [Math]::Min($CurrentX - $global:MouseDragX, $Screen.Width - ($CloseFormPanel.Height + 2))
            [int]$NewY = [Math]::Min($CurrentY - $global:MouseDragY, $Screen.Height - ($CloseFormPanel.Height + 2))

            $Form.Location = New-Object System.Drawing.Point($NewX, $NewY)
        }
    })

    $SelectedLabel.Add_MouseUp({
        $global:Dragging = $false
    })
}