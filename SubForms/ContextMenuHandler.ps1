﻿Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Context Menu Handler"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#272E3D")
$Form.AutoSize                   = $true
$Form.FormBorderStyle            = "FixedSingle"
$Form.Width                      = $objImage.Width
$Form.Height                     = $objImage.Height
$Form.ForeColor                  = $DefaultForeColor
$Form.MaximizeBox                = $false
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon("$ImagesFolder\ZKLogo.ico")

# Title Label
$TweaksLabel                     = New-Object System.Windows.Forms.Label
$TweaksLabel.Text                = "C O N T E X T    M E N U    H A N D L E R"
$TweaksLabel.Width               = 600
$TweaksLabel.Height              = 38
$TweaksLabel.Location            = New-Object System.Drawing.Point(5,5)
$TweaksLabel.Font                = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$TweaksLabel.ForeColor           = $LabelColor
$TweaksLabel.TextAlign           = [System.Drawing.ContentAlignment]::MiddleCenter
$TweaksLabel.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\LabelCMHBg.png")
$Form.Controls.Add($TweaksLabel)

# Path Label
$PathLabel                       = New-Object System.Windows.Forms.Label
$PathLabel.Text                  = "  Path"
$PathLabel.Width                 = 115
$PathLabel.Height                = 30
$PathLabel.Location              = New-Object System.Drawing.Point(5,48)
$PathLabel.Font                  = New-Object System.Drawing.Font('Segoe UI',15)
$PathLabel.ForeColor             = $LabelColor
$PathLabel.TextAlign             = [System.Drawing.ContentAlignment]::MiddleLeft
$PathLabel.BackgroundImage       = [System.Drawing.Image]::FromFile("$ImagesFolder\CMHLabelsBg.png")
$Form.Controls.Add($PathLabel)

# Path TextBox
$PathBox                         = New-Object System.Windows.Forms.TextBox
$PathBox.width                   = 480
$PathBox.height                  = 40
$PathBox.location                = New-Object System.Drawing.Point(120,48)
$PathBox.Font                    = New-Object System.Drawing.Font('Segoe UI',12)
$PathBox.Text                    = "HKCR:\Directory\Background\shell"
$PathBox.AcceptsReturn           = $true
$PathBox.BackColor               = $PanelBackColor
$PathBox.ForeColor               = $DefaultForeColor
$Form.Controls.Add($PathBox)

# Name Label
$NameLabel                       = New-Object System.Windows.Forms.Label
$NameLabel.Text                  = "  Name"
$NameLabel.Width                 = 115
$NameLabel.Height                = 30
$NameLabel.Location              = New-Object System.Drawing.Point(5,83)
$NameLabel.Font                  = New-Object System.Drawing.Font('Segoe UI',15)
$NameLabel.ForeColor             = $LabelColor
$NameLabel.TextAlign             = [System.Drawing.ContentAlignment]::MiddleLeft
$NameLabel.BackgroundImage       = [System.Drawing.Image]::FromFile("$ImagesFolder\CMHLabelsBg.png")
$Form.Controls.Add($NameLabel)

# Name TextBox
$NameBox                         = New-Object System.Windows.Forms.TextBox
$NameBox.width                   = 265
$NameBox.height                  = 40
$NameBox.location                = New-Object System.Drawing.Point(120,83)
$NameBox.Font                    = New-Object System.Drawing.Font('Segoe UI',12)
$NameBox.AcceptsReturn           = $true
$NameBox.BackColor               = $PanelBackColor
$NameBox.ForeColor               = $DefaultForeColor
$Form.Controls.Add($NameBox)

# MUIVerb Label
$MUIVerbLabel                    = New-Object System.Windows.Forms.Label
$MUIVerbLabel.Text               = "  MUIVerb"
$MUIVerbLabel.Width              = 115
$MUIVerbLabel.Height             = 30
$MUIVerbLabel.Location           = New-Object System.Drawing.Point(5,118)
$MUIVerbLabel.Font               = New-Object System.Drawing.Font('Segoe UI',15)
$MUIVerbLabel.ForeColor          = $LabelColor
$MUIVerbLabel.TextAlign          = [System.Drawing.ContentAlignment]::MiddleLeft
$MUIVerbLabel.BackgroundImage    = [System.Drawing.Image]::FromFile("$ImagesFolder\CMHLabelsBg.png")
$Form.Controls.Add($MUIVerbLabel)

# MUIVerb TextBox
$MUIVerbBox                      = New-Object System.Windows.Forms.TextBox
$MUIVerbBox.width                = 265
$MUIVerbBox.height               = 40
$MUIVerbBox.location             = New-Object System.Drawing.Point(120,118)
$MUIVerbBox.Font                 = New-Object System.Drawing.Font('Segoe UI',12)
$MUIVerbBox.AcceptsReturn        = $true
$MUIVerbBox.BackColor            = $PanelBackColor
$MUIVerbBox.ForeColor            = $DefaultForeColor
$Form.Controls.Add($MUIVerbBox)

# Icon Label
$IconLabel                       = New-Object System.Windows.Forms.Label
$IconLabel.Text                  = "  Icon"
$IconLabel.Width                 = 115
$IconLabel.Height                = 30
$IconLabel.Location              = New-Object System.Drawing.Point(5,153)
$IconLabel.Font                  = New-Object System.Drawing.Font('Segoe UI',15)
$IconLabel.ForeColor             = $LabelColor
$IconLabel.TextAlign             = [System.Drawing.ContentAlignment]::MiddleLeft
$IconLabel.BackgroundImage       = [System.Drawing.Image]::FromFile("$ImagesFolder\CMHLabelsBg.png")
$Form.Controls.Add($IconLabel)

# Icon TextBox
$IconBox                         = New-Object System.Windows.Forms.TextBox
$IconBox.width                   = 480
$IconBox.height                  = 40
$IconBox.location                = New-Object System.Drawing.Point(120,153)
$IconBox.Font                    = New-Object System.Drawing.Font('Segoe UI',12)
$IconBox.AcceptsReturn           = $true
$IconBox.BackColor               = $PanelBackColor
$IconBox.ForeColor               = $DefaultForeColor
$Form.Controls.Add($IconBox)

# Command Label
$CommandLabel                    = New-Object System.Windows.Forms.Label
$CommandLabel.Text               = "  Command"
$CommandLabel.Width              = 115
$CommandLabel.Height             = 30
$CommandLabel.Location           = New-Object System.Drawing.Point(5,188)
$CommandLabel.Font               = New-Object System.Drawing.Font('Segoe UI',15)
$CommandLabel.ForeColor          = $LabelColor
$CommandLabel.TextAlign          = [System.Drawing.ContentAlignment]::MiddleLeft
$CommandLabel.BackgroundImage    = [System.Drawing.Image]::FromFile("$ImagesFolder\CMHLabelsBg.png")
$Form.Controls.Add($CommandLabel)

# Command TextBox
$CommandBox                      = New-Object System.Windows.Forms.TextBox
$CommandBox.width                = 480
$CommandBox.height               = 40
$CommandBox.location             = New-Object System.Drawing.Point(120,188)
$CommandBox.Font                 = New-Object System.Drawing.Font('Segoe UI',12)
$CommandBox.AcceptsReturn        = $true
$CommandBox.BackColor            = $PanelBackColor
$CommandBox.ForeColor            = $DefaultForeColor
$Form.Controls.Add($CommandBox)

# Buttons Panel
$ButtonsPanel                    = New-Object System.Windows.Forms.Panel
$ButtonsPanel.height             = 45
$ButtonsPanel.width              = 255 - 2
$ButtonsPanel.location           = New-Object System.Drawing.Point(178,218)
$Form.Controls.Add($ButtonsPanel)

# Cancel Button
$Cancel                          = New-Object System.Windows.Forms.Button
$Cancel.text                     = "Cancelar"
$Cancel.width                    = 117
$Cancel.height                   = 35
$Cancel.location                 = New-Object System.Drawing.Point(5,5)
$Cancel.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\CancelAcceptButton.png")
$ButtonsPanel.Controls.Add($Cancel)

# Accept Button
$Accept                          = New-Object System.Windows.Forms.Button
$Accept.text                     = "Aceptar"
$Accept.width                    = 117
$Accept.height                   = 35
$Accept.location                 = New-Object System.Drawing.Point(128,5)
$Accept.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\CancelAcceptButton.png")
$Accept.ForeColor                = $LabelColor
$ButtonsPanel.Controls.Add($Accept)

$Buttons = @($Cancel,$Accept)
foreach ($Button in $Buttons) {
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.BackColor = $PanelBackColor
    $Button.Image = $DefaultButtonColor

    $Button.Add_MouseEnter({
        $this.Image = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverCancelAcceptButton.png")
    })

    $Button.Add_MouseLeave({
        $this.Image = $None
    })
}

# Cancel Button
$Cancel.Add_Click({
    $Form.Close()
})

# Accept Button
$Accept.Add_Click({
    $Accept.BackColor = $ProcessingColor
    $Path     = ($PathBox.Lines)
    $Name     = ($NameBox.Lines)
    $MUIVerb  = ($MUIVerbBox.Lines)
    $Icon     = ($IconBox.Lines)
    $Command  = ($CommandBox.Lines)
    $Path2    = ("$Path\$Name")

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null

    if (($PathBox.Text -ne "HKCR:\Directory\Background\shell") -and ($PathBox.Text -ne "") -and ($NameBox.Text -eq "")) {
        Set-ItemProperty -Path "$Path" -Name "Subcommands" -Value ""
        New-Item -Path "$Path" -Name "shell"
    } elseif ((($PathBox.Text -ne "HKCR:\Directory\Background\shell") -and ($PathBox.Text -eq "")) -or ($NameBox.Text -eq "")) {
        [System.Windows.Forms.MessageBox]::Show("Path and Name are required", "Missing Values", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    } else {
        $StatusBox.Text = "| Creando Entrada En Context Menu..."
        New-Item -Path "$Path" -Name "$Name" | Out-Null
        Set-ItemProperty -Path "$Path2" -Name "Icon" -Value "$Icon"
        Set-ItemProperty -Path "$Path2" -Name "MUIVerb" -Value "$MUIVerb"
        New-Item -Path "$Path2" -Name "command" | Out-Null
        Set-ItemProperty -Path ("$Path2\command") -Name "(default)" -Value "$Command"
    }

    Start-Sleep 1

    $PathBox.Text = "HKCR:\Directory\Background\shell"
    $NameBox.Text = ""
    $MUIVerbBox.Text = ""
    $IconBox.Text = ""
    $CommandBox.Text = ""
})

$Form.Add_Closing({
    $HB3.Image = $DefaultButtonColor
    $HB3.ForeColor = $LabelColor
})

[void]$Form.ShowDialog()