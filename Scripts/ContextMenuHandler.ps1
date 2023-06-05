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

$LabelColor = [System.Drawing.ColorTranslator]::FromHtml("#26FFB3") 
$DefaultForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
$PanelBackColor = [System.Drawing.ColorTranslator]::FromHtml("#3D4351")
$ActiveButtonColor = [System.Drawing.Image]::FromFile(($ImageFolder + "ActiveButtonColor.png"))
$HoverButtonColor = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverButtonColor.png"))
$ActiveButtonColorBig = [System.Drawing.Image]::FromFile(($ImageFolder + "ActiveButtonColorBig.png"))
$HoverButtonColorBig = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverButtonColorBig.png"))

# Title Label
$TweaksLabel                     = New-Object System.Windows.Forms.Label
$TweaksLabel.Text                = "C O N T E X T    M E N U    H A N D L E R"
$TweaksLabel.Width               = 600
$TweaksLabel.Height              = 38
$TweaksLabel.Location            = New-Object System.Drawing.Point(5,5)
$TweaksLabel.Font                = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$TweaksLabel.ForeColor           = $LabelColor
$TweaksLabel.TextAlign           = [System.Drawing.ContentAlignment]::MiddleCenter
$TweaksLabel.BackgroundImage     = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBg.png"))
$Form.Controls.Add($TweaksLabel)

# Path Label
$PathLabel                       = New-Object System.Windows.Forms.Label
$PathLabel.Text                  = "Path"
$PathLabel.Width                 = 65
$PathLabel.Height                = 30
$PathLabel.Location              = New-Object System.Drawing.Point(5,48)
$PathLabel.Font                  = New-Object System.Drawing.Font('Segoe UI',15)
$PathLabel.ForeColor             = $LabelColor
$PathLabel.TextAlign             = [System.Drawing.ContentAlignment]::MiddleLeft
$PathLabel.BackgroundImage       = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBg.png"))
$Form.Controls.Add($PathLabel)

# Path TextBox
$PathBox                         = New-Object System.Windows.Forms.TextBox
$PathBox.width                   = 530
$PathBox.height                  = 40
$PathBox.location                = New-Object System.Drawing.Point(70,48)
$PathBox.Font                    = New-Object System.Drawing.Font('Segoe UI',12)
$PathBox.AcceptsReturn           = $True
$PathBox.BackColor               = $PanelBackColor
$PathBox.ForeColor               = $DefaultForeColor
$Form.Controls.Add($PathBox)

# Name Label
$NameLabel                       = New-Object System.Windows.Forms.Label
$NameLabel.Text                  = "Name"
$NameLabel.Width                 = 65
$NameLabel.Height                = 30
$NameLabel.Location              = New-Object System.Drawing.Point(5,83)
$NameLabel.Font                  = New-Object System.Drawing.Font('Segoe UI',15)
$NameLabel.ForeColor             = $LabelColor
$NameLabel.TextAlign             = [System.Drawing.ContentAlignment]::MiddleLeft
$NameLabel.BackgroundImage       = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBg.png"))
$Form.Controls.Add($NameLabel)

# Name TextBox
$NameBox                         = New-Object System.Windows.Forms.TextBox
$NameBox.width                   = 265
$NameBox.height                  = 40
$NameBox.location                = New-Object System.Drawing.Point(70,83)
$NameBox.Font                    = New-Object System.Drawing.Font('Segoe UI',12)
$NameBox.AcceptsReturn           = $True
$NameBox.BackColor               = $PanelBackColor
$NameBox.ForeColor               = $DefaultForeColor
$Form.Controls.Add($NameBox)

# Value Label
$ValueLabel                      = New-Object System.Windows.Forms.Label
$ValueLabel.Text                 = "Value"
$ValueLabel.Width                = 65
$ValueLabel.Height               = 30
$ValueLabel.Location             = New-Object System.Drawing.Point(5,118)
$ValueLabel.Font                 = New-Object System.Drawing.Font('Segoe UI',15)
$ValueLabel.ForeColor            = $LabelColor
$ValueLabel.TextAlign            = [System.Drawing.ContentAlignment]::MiddleLeft
$ValueLabel.BackgroundImage      = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBg.png"))
$Form.Controls.Add($ValueLabel)

# Value TextBox
$ValueBox                        = New-Object System.Windows.Forms.TextBox
$ValueBox.width                  = 530
$ValueBox.height                 = 40
$ValueBox.location               = New-Object System.Drawing.Point(70,118)
$ValueBox.Font                   = New-Object System.Drawing.Font('Segoe UI',12)
$ValueBox.AcceptsReturn          = $True
$ValueBox.BackColor              = $PanelBackColor
$ValueBox.ForeColor              = $DefaultForeColor
$Form.Controls.Add($ValueBox)

# Buttons Panel
$ButtonsPanel                    = New-Object System.Windows.Forms.Panel
$ButtonsPanel.height             = 45
$ButtonsPanel.width              = 255 - 2
$ButtonsPanel.location           = New-Object System.Drawing.Point(178,148)
$ButtonsPanel.BackgroundImage    = [System.Drawing.Image]::FromFile(($ImageFolder + "ChooseIPPanelBg.png"))
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

# Cancel Button
$Cancel.Add_Click({
    $Form.Close()
})

# Accept Button
$Accept.Add_Click({
    $StatusBox.text = "|Creando Entrada En Context Menu...`r`n" + $StatusBox.text
    $Accept.BackColor = $ProcessingColor
    $Path = ($PathBox.Lines)
    $Name = ($NameBox.Lines)
    $Value = ($ValueBox.Lines)

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null

    if ($ValueBox.Text -eq "") { # Use New-Item
        New-Item -Path "$Path" -Name "$Name"
    }else { # Use Set-ItemProperty
        Set-ItemProperty -Path "$Path" -Name "$Name" -Value "$Value"
    }
})



[void]$Form.ShowDialog()