Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

$HoverGameButtonColor = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverGameButtonColor.png")
$ProcessingGameButtonColor = [System.Drawing.Image]::FromFile("$ImagesFolder\ProcessingGameButtonColor.png")

$Download.DownloadFile("$GitHubPath/Functions/Import-Export.ps1", "$TempPath\Functions\Import-Export.ps1")
. "$TempPath\Functions\Import-Export.ps1"

$FormSize = '721,182'

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Game Settings"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.FormBorderStyle            = "None"
$Form.Size                       = $FormSize
$Form.ForeColor                  = $DefaultForeColor
$Form.MaximizeBox                = $false
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon("$ImagesFolder\ZKLogo.ico")
$Form.BackColor                  = "LimeGreen"
$Form.TransparencyKey            = "LimeGreen"

$FormPanel                       = New-Object System.Windows.Forms.Panel
$FormPanel.Size                  = $FormSize
$FormPanel.Location              = "0,0"
$FormPanel.BackgroundImage       = [System.Drawing.Image]::FromFile("$ImagesFolder\GameSettingsBg.png")
$Form.Controls.Add($FormPanel)

$CloseFormPanel                  = New-Object System.Windows.Forms.Panel
$CloseFormPanel.Size             = '109,37'
$CloseFormPanel.Location         = "612,0"
$CloseFormPanel.BackgroundImage  = [System.Drawing.Image]::FromFile("$ImagesFolder\FormClosePanelBg.png")
$FormPanel.Controls.Add($CloseFormPanel)

# Close Form Button
$CloseButton                     = New-Object System.Windows.Forms.Button
$CloseButton.Location            = "72,3"
$CloseButton.Size                = "34,34"
$CloseButton.FlatStyle           = "Flat"
$CloseButton.BackColor           = $PanelBackColor
$CloseButton.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\CloseButton.png")
$CloseButton.FlatAppearance.BorderSize = 0
$CloseFormPanel.Controls.Add($CloseButton)

$CloseButton.Add_MouseEnter({
    $CloseButton.BackgroundImage    = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverCloseButton.png")
    $CloseFormPanel.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\FormClosePanelBgClose.png")
})

$CloseButton.Add_MouseLeave({
    $CloseButton.BackgroundImage    = [System.Drawing.Image]::FromFile("$ImagesFolder\CloseButton.png")
    $CloseFormPanel.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\FormClosePanelBg.png")
})

$CloseButton.Add_Click({
    $Form.Close()
})

# Maximize Form Button
$MaximizeButton                     = New-Object System.Windows.Forms.Button
$MaximizeButton.Location            = "36,1"
$MaximizeButton.Size                = "36,36"
$MaximizeButton.FlatStyle           = "Flat"
$MaximizeButton.BackColor           = $PanelBackColor
$MaximizeButton.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\MaximizeButton.png")
$MaximizeButton.FlatAppearance.BorderSize = 0
$CloseFormPanel.Controls.Add($MaximizeButton)

# Minimize Form Button
$MinimizeButton                     = New-Object System.Windows.Forms.Button
$MinimizeButton.Location            = "0,1"
$MinimizeButton.Size                = "36,36"
$MinimizeButton.FlatStyle           = "Flat"
$MinimizeButton.BackColor           = $PanelBackColor
$MinimizeButton.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\MinimizeButton.png")
$MinimizeButton.FlatAppearance.BorderSize = 0
$CloseFormPanel.Controls.Add($MinimizeButton)

$MinimizeButton.Add_Click({
    $Form.WindowState = 1
})

$MinimizeButton.Add_MouseEnter({
    $MinimizeButton.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverMinimizeButton.png")
})

$MinimizeButton.Add_MouseLeave({
    $MinimizeButton.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\MinimizeButton.png")
})

# Label
$Label                           = New-Object System.Windows.Forms.Label
$Label.Text                      = "G A M E    S E T T I N G S"
$Label.Size                      = "708,36"
$Label.Location                  = "7,1"
$Label.Font                      = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$Label.ForeColor                 = $AccentColor
$Label.BackColor                 = $PanelBackColor
$Label.TextAlign                 = [System.Drawing.ContentAlignment]::MiddleCenter
$FormPanel.Controls.Add($Label)

# Panel
$Panel                           = New-Object System.Windows.Forms.Panel
$Panel.Height                    = 67 * 2
$Panel.Width                     = 707
$Panel.BackColor                 = $FormBackColor
$Panel.BackgroundImage           = [System.Drawing.Image]::FromFile("$ImagesFolder\PanelBgGS.png")
$Panel.Location                  = New-Object System.Drawing.Point(7,46)
$FormPanel.Controls.Add($Panel)

# Modern Warfare II
$R1B1                            = New-Object System.Windows.Forms.Button
$R1B1.Text                       = "Modern Warfare II"

# PUBG
$R1B2                            = New-Object System.Windows.Forms.Button
$R1B2.Text                       = "PUBG"

# CSGO
$R1B3                            = New-Object System.Windows.Forms.Button
$R1B3.Text                       = "CSGO"

# Apex Legends
$R1B4                            = New-Object System.Windows.Forms.Button
$R1B4.Text                       = "Apex Legends"

# MSI Afterburner
$R2B1                            = New-Object System.Windows.Forms.Button
$R2B1.Text                       = "MSI Afterburner"

# RivaTuner
$R2B2                            = New-Object System.Windows.Forms.Button
$R2B2.Text                       = "RivaTuner"

# Export
$R2B3                            = New-Object System.Windows.Forms.Button
$R2B3.Text                       = "Export"
$R2B3.ForeColor                  = $AccentColor

# Import
$R2B4                            = New-Object System.Windows.Forms.Button
$R2B4.Text                       = "Import"
$R2B4.ForeColor                  = $AccentColor

# Game
$R3B1                            = New-Object System.Windows.Forms.Button
$R3B1.Text                       = "1"

# Game
$R3B2                            = New-Object System.Windows.Forms.Button
$R3B2.Text                       = "2"

# Game
$R3B3                            = New-Object System.Windows.Forms.Button
$R3B3.Text                       = "3"

# Game
$R3B4                            = New-Object System.Windows.Forms.Button
$R3B4.Text                       = "4"

$PositionX = 5
$PositionY = 5

$Buttons = @($R1B1,$R1B2,$R1B3,$R1B4,$R2B1,$R2B2,$R2B3,$R2B4,$R3B1,$R3B2,$R3B3,$R3B4)
foreach ($Button in $Buttons) {
    $Panel.Controls.Add($Button)
    $Button.Location             = "$PositionX,$PositionY"
    $PositionX += 177
    if ($PositionX -gt 536) {
        $PositionX = 5
        $PositionY += 68
    }
    
    $Button.Size                 = "165,50"
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.FlatStyle = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.Image = $DefaultGameButtonColor
    $Button.BackColor = $PanelBackColor
    

    $Button.Add_MouseEnter({
        if ($this.Image -eq $DefaultGameButtonColor) {
            $this.Image = $HoverGameButtonColor
        }
    })

    $Button.Add_MouseLeave({
        if ($this.Image -eq $HoverGameButtonColor) {
            $this.Image = $DefaultGameButtonColor
        }
    })

    $Button.Add_Click({
            $this.Image = $ProcessingGameButtonColor
            $this.ForeColor = "Black"
    })
}

$DocumentsPath = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"

# Modern Warfare II
$R1B1.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/ModernWarfareII.zip", "$TempPath\Files\ModernWarfareII.zip")
    Expand-Archive -Path ("$TempPath\Files\ModernWarfareII.zip") -DestinationPath ("$TempPath\Files\ModernWarfareII") -Force
    Move-Item -Path ("$TempPath\Files\ModernWarfareII\options.3.cod22.cst") -Destination ("$DocumentsPath\Call of Duty\players") -Force
    $CodPath = "$DocumentsPath\Call of Duty\players\" 
    $CodIDPath = ($CodPath + (Get-ChildItem $CodPath -Directory -Name 765*))
    Move-Item -Path ("$TempPath\Files\ModernWarfareII\settings.3.local.cod22.cst") -Destination $CodIDPath -Force
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

# Player Unknown Battlegrounds
$R1B2.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/PUBG.zip", "$TempPath\Files\PUBG.zip")
    Expand-Archive -Path ("$TempPath\Files\PUBG.zip") -DestinationPath "$env:localappdata\TslGame\Saved\Config\WindowsNoEditor" -Force
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

# CSGO
$R1B3.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/CSGO.zip", "$TempPath\Files\CSGO.zip")
    Expand-Archive -Path ("$TempPath\Files\CSGO.zip") -DestinationPath ("$TempPath\Files\") -Force
    $UserIds = Get-ChildItem "C:\Program Files (x86)\Steam\userdata" -Directory
    foreach ($Id in $UserIds.name) {
        Copy-Item -Path ("$TempPath\Files\730") -Destination "C:\Program Files (x86)\Steam\userdata\$Id" -Recurse -Force
    }
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

# Apex Legends
$R1B4.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/Apex.zip", "$TempPath\Files\Apex.zip")
    Expand-Archive -Path ("$TempPath\Files\Apex.zip") -DestinationPath "$env:userprofile\Saved Games\Respawn\Apex" -Force
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

# CSGO
$R2B1.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/CSGO.zip", "$TempPath\Files\CSGO.zip")
    Expand-Archive -Path ("$TempPath\Files\CSGO.zip") -DestinationPath ("$TempPath\Files\") -Force
    $UserIds = Get-ChildItem "C:\Program Files (x86)\Steam\userdata" -Directory
    foreach ($Id in $UserIds.name) {
        Copy-Item -Path ("$TempPath\Files\730") -Destination "C:\Program Files (x86)\Steam\userdata\$Id" -Recurse -Force
    }
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

# MSI Afterburner
$R2B1.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/MSIAfterburner.zip", "$TempPath\Files\MSIAfterburner.zip")
    Expand-Archive -Path ("$TempPath\Files\MSIAfterburner.zip") -DestinationPath ("$TempPath\Files\MSIAfterburner") -Force
    Move-Item -Path ("$TempPath\Files\MSIAfterburner\Profiles\*") -Destination 'C:\Program Files (x86)\MSI Afterburner\Profiles' -Force
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

# RivaTuner
$R2B2.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/RivaTuner.zip", "$TempPath\Files\RivaTuner.zip")
    Expand-Archive -Path ("$TempPath\Files\RivaTuner.zip") -DestinationPath ("$TempPath\Files\RivaTuner") -Force
    New-Item -Path 'C:\Program Files (x86)\RivaTuner Statistics Server\Profiles' -ItemType Directory | Out-Null
    Move-Item -Path ("$TempPath\Files\RivaTuner\Profiles\*") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\Profiles' -Force
    Move-Item -Path ("$TempPath\Files\RivaTuner\Config") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\ProfileTemplates' -Force
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

$Buttons = @($R1B1,$R1B2,$R1B3,$R1B4,$R2B1,$R2B2,$R2B3,$R2B4,$R3B1,$R3B2,$R3B3,$R3B4)
foreach ($Button in $Buttons) {
    $Button.Add_Click({
        $this.Image = $DefaultGameButtonColor
        $this.ForeColor = $AccentColor
        Start-Sleep 2
    })
}

# Export
$R2B3.Add_Click({
    $R2B3.ForeColor = "Black"
    Write-UserOutput "Exportando configuración"
    Import-Export -Export
})

# Import
$R2B4.Add_Click({
    $R2B4.ForeColor = "Black"
    Write-UserOutput "Importando configuración"
    Import-Export -Import
})

$Form.Add_Closing({
    $HB1.Image = $DefaultButtonColor
    $HB1.ForeColor = $AccentColor
})

[void]$Form.ShowDialog()