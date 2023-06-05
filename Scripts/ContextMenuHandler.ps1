Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Context Menu Handler"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $False
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#272E3D")
$Form.AutoScaleDimensions        = '192, 192'
$Form.AutoScaleMode              = "Dpi"
$Form.AutoSize                   = $True
$Form.ClientSize                 = "1050, 700"
$Form.FormBorderStyle            = "FixedSingle"
$Form.Width                      = $objImage.Width
$Form.Height                     = $objImage.Height
$Form.ForeColor                  = $DefaultForeColor
$Form.MaximizeBox                = $False
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon(($ImageFolder +"ZKLogo.ico"))

# Title Label
$TweaksLabel                     = New-Object System.Windows.Forms.Label
$TweaksLabel.Text                = "C O N T E X T    M E N U    H A N D L E R"
$TweaksLabel.Width               = 600
$TweaksLabel.Height              = 38
$TweaksLabel.Location            = New-Object System.Drawing.Point(5,5)
$TweaksLabel.Font                = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$TweaksLabel.ForeColor           = $LabelColor
$TweaksLabel.TextAlign           = [System.Drawing.ContentAlignment]::MiddleCenter
$TweaksLabel.BackgroundImage     = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelCMHBg.png"))
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
$PathLabel.BackgroundImage       = [System.Drawing.Image]::FromFile(($ImageFolder + "CMHLabelsBg.png"))
$Form.Controls.Add($PathLabel)

# Path TextBox
$PathBox                         = New-Object System.Windows.Forms.TextBox
$PathBox.width                   = 480
$PathBox.height                  = 40
$PathBox.location                = New-Object System.Drawing.Point(120,48)
$PathBox.Font                    = New-Object System.Drawing.Font('Segoe UI',12)
$PathBox.Text                    = "HKCR:"
$PathBox.AcceptsReturn           = $True
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
$NameLabel.BackgroundImage       = [System.Drawing.Image]::FromFile(($ImageFolder + "CMHLabelsBg.png"))
$Form.Controls.Add($NameLabel)

# Name TextBox
$NameBox                         = New-Object System.Windows.Forms.TextBox
$NameBox.width                   = 265
$NameBox.height                  = 40
$NameBox.location                = New-Object System.Drawing.Point(120,83)
$NameBox.Font                    = New-Object System.Drawing.Font('Segoe UI',12)
$NameBox.AcceptsReturn           = $True
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
$MUIVerbLabel.BackgroundImage    = [System.Drawing.Image]::FromFile(($ImageFolder + "CMHLabelsBg.png"))
$Form.Controls.Add($MUIVerbLabel)

# MUIVerb TextBox
$MUIVerbBox                      = New-Object System.Windows.Forms.TextBox
$MUIVerbBox.width                = 265
$MUIVerbBox.height               = 40
$MUIVerbBox.location             = New-Object System.Drawing.Point(120,118)
$MUIVerbBox.Font                 = New-Object System.Drawing.Font('Segoe UI',12)
$MUIVerbBox.AcceptsReturn        = $True
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
$IconLabel.BackgroundImage       = [System.Drawing.Image]::FromFile(($ImageFolder + "CMHLabelsBg.png"))
$Form.Controls.Add($IconLabel)

# Icon TextBox
$IconBox                         = New-Object System.Windows.Forms.TextBox
$IconBox.width                   = 480
$IconBox.height                  = 40
$IconBox.location                = New-Object System.Drawing.Point(120,153)
$IconBox.Font                    = New-Object System.Drawing.Font('Segoe UI',12)
$IconBox.AcceptsReturn           = $True
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
$CommandLabel.BackgroundImage    = [System.Drawing.Image]::FromFile(($ImageFolder + "CMHLabelsBg.png"))
$Form.Controls.Add($CommandLabel)

# Command TextBox
$CommandBox                      = New-Object System.Windows.Forms.TextBox
$CommandBox.width                = 480
$CommandBox.height               = 40
$CommandBox.location             = New-Object System.Drawing.Point(120,188)
$CommandBox.Font                 = New-Object System.Drawing.Font('Segoe UI',12)
$CommandBox.AcceptsReturn        = $True
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
$Cancel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "CancelAcceptButton.png"))
$ButtonsPanel.Controls.Add($Cancel)

# Accept Button
$Accept                          = New-Object System.Windows.Forms.Button
$Accept.text                     = "Aceptar"
$Accept.width                    = 117
$Accept.height                   = 35
$Accept.location                 = New-Object System.Drawing.Point(128,5)
$Accept.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "CancelAcceptButton.png"))
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
        $this.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverCancelAcceptButton.png"))
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
    $StatusBox.text = "| Creando Entrada En Context Menu...`r`n" + $StatusBox.text
    $Accept.BackColor = $ProcessingColor
    $Path = ($PathBox.Lines)
    $Name = ($NameBox.Lines)
    $MUIVerb = ($MUIVerbBox.Lines)
    $Icon = ($IconBox.Lines)
    $Command = ($CommandBox.Lines)
    $Path2 = ("$Path" + "\$Name")

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null

    if (($PathBox.Text -eq "HKCR:") -or ($NameBox.Text -eq "")) {
        [System.Windows.Forms.MessageBox]::Show("Path and Name are required", "Missing Values", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
    } else {
        New-Item -Path "$Path" -Name "$Name" | Out-Null
        Set-ItemProperty -Path "$Path2" -Name "Icon" -Value "$Icon"
        Set-ItemProperty -Path "$Path2" -Name "MUIVerb" -Value "$MUIVerb"
        New-Item -Path "$Path2" -Name "command" | Out-Null
        Set-ItemProperty -Path ("$Path2" + "\command") -Name "(default)" -Value "$Command"
    }  
})



[void]$Form.ShowDialog()