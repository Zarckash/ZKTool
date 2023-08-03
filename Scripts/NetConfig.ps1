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
$Form.Text                       = "Seleccionar IP"
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

# Search IPs Panel
$Panel                           = New-Object System.Windows.Forms.Panel
$Panel.height                    = 45
$Panel.width                     = 260 - 2
$Panel.location                  = New-Object System.Drawing.Point(0,5)
$Panel.BackgroundImage           = [System.Drawing.Image]::FromFile(($ImageFolder + "SearchIPPanelBg.png"))

$Form.Controls.Add($Panel)

# Search IPs Button
$SearchIP                        = New-Object System.Windows.Forms.Button
$SearchIP.text                   = "Buscar IPs"
$SearchIP.width                  = 240
$SearchIP.height                 = 35
$SearchIP.location               = New-Object System.Drawing.Point(10,5)
$Panel.Controls.Add($SearchIP)

# Avaible IPs Label
$AvaibleIPsLabel                 = New-Object System.Windows.Forms.Label
$AvaibleIPsLabel.text            = "IPs Disponibles:"
$AvaibleIPsLabel.width           = 260 - 2
$AvaibleIPsLabel.height          = 30
$AvaibleIPsLabel.location        = New-Object System.Drawing.Point(0,58)
$AvaibleIPsLabel.Font            = New-Object System.Drawing.Font('Segoe UI Semibold',13)
$AvaibleIPsLabel.ForeColor       = $LabelColor
$AvaibleIPsLabel.Padding         = "10, 0, 0, 0"
$AvaibleIPsLabel.BackgroundImage = [System.Drawing.Image]::FromFile(($ImageFolder + "AvaibleIPLabelBg.png"))
$Form.Controls.Add($AvaibleIPsLabel)

# Avaible IPs
$AvaibleIPs                      = New-Object System.Windows.Forms.Label
$AvaibleIPs.width                = 260 - 2
$AvaibleIPs.height               = 75
$AvaibleIPs.location             = New-Object System.Drawing.Point(0,81)
$AvaibleIPs.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
$AvaibleIPs.Padding              = "10, 0, 0, 0"
$AvaibleIPs.BackgroundImage      = [System.Drawing.Image]::FromFile(($ImageFolder + "AvaibleIPBg.png"))
$Form.Controls.Add($AvaibleIPs)

# Choose IP Label
$ChooseIPLabel                   = New-Object System.Windows.Forms.Label
$ChooseIPLabel.text              = "Seleccionar IP:"
$ChooseIPLabel.width             = 260 - 2
$ChooseIPLabel.height            = 30
$ChooseIPLabel.location          = New-Object System.Drawing.Point(0,163)
$ChooseIPLabel.Font              = New-Object System.Drawing.Font('Segoe UI Semibold',13)
$ChooseIPLabel.ForeColor         = $LabelColor
$ChooseIPLabel.Padding           = "10, 0, 0, 0"
$ChooseIPLabel.BackgroundImage   = [System.Drawing.Image]::FromFile(($ImageFolder + "AvaibleIPLabelBg.png"))
$Form.Controls.Add($ChooseIPLabel)

# Input TextBox
$InputBox                        = New-Object System.Windows.Forms.TextBox
$InputBox.width                  = 250
$InputBox.height                 = 40
$InputBox.location               = New-Object System.Drawing.Point(5,192)
$InputBox.Font                   = New-Object System.Drawing.Font('Segoe UI',12)
$InputBox.AcceptsReturn          = $True
$InputBox.Text                   = "" + (Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop).Substring(0,10)
$InputBox.BackColor              = $PanelBackColor
$InputBox.ForeColor              = $DefaultForeColor
$Form.Controls.Add($InputBox)

# Choose IP Panel
$Panel2                          = New-Object System.Windows.Forms.Panel
$Panel2.height                   = 83
$Panel2.width                    = 260 - 2
$Panel2.location                 = New-Object System.Drawing.Point(0,193)
$Panel2.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "ChooseIPPanelBg.png"))
$Form.Controls.Add($Panel2)

# Cancel Button
$Cancel                          = New-Object System.Windows.Forms.Button
$Cancel.text                     = "Cancelar"
$Cancel.width                    = 117
$Cancel.height                   = 35
$Cancel.location                 = New-Object System.Drawing.Point(10,40)
$Cancel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "CancelAcceptButton.png"))
$Panel2.Controls.Add($Cancel)

# Accept Button
$Accept                          = New-Object System.Windows.Forms.Button
$Accept.text                     = "Aceptar"
$Accept.width                    = 117
$Accept.height                   = 35
$Accept.location                 = New-Object System.Drawing.Point(133,40)
$Accept.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "CancelAcceptButton.png"))
$Accept.ForeColor                = $LabelColor
$Panel2.Controls.Add($Accept)

$Buttons = @($SearchIP,$Cancel,$Accept)
foreach ($Button in $Buttons) {
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.BackColor = $PanelBackColor
    $Button.Image = $DefaultButtonColor

    $Button.Add_MouseEnter({
        if (($this.text -eq "Buscar IPs") -or ($this.text -eq "Buscar Mas IPs")) {
            $this.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverSearchIPButton.png"))
        } else {
            $this.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverCancelAcceptButton.png"))
        }
    })

    $Button.Add_MouseLeave({
        $this.Image = $None
    })
}

$Gateway = Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop
$i = New-Object System.Windows.Forms.Button
$i.Width = 20

# Search IPs Button
$SearchIP.Add_Click({
    $SearchIP.BackColor = $ProcessingColor
    $Condition = $False
    $AvaibleIPs.Text = ""

    while (!($Condition)) {
        $Found=0
        for ($i.Width; $Found -lt 6 -and $i.Width -lt 100; $i.Width++) {
            $TestIP = $Gateway.Substring(0,10) + $i.Width
            if (!(Test-Connection $TestIP -Count 1 -Quiet)) {
                $AvaibleIPs.Text += "$TestIP        "
                $Found++
            }
        }
        $Condition = $True
    }
    
    $SearchIP.Text = "Buscar Mas IPs"
    $SearchIP.BackColor = $ButtonColor
})

# Cancel Button
$Cancel.Add_Click({
    $Form.Close()
})

# Accept Button
$Accept.Add_Click({
    $Accept.BackColor = $ProcessingColor
    $IP = ($InputBox.Lines).Substring(0,12)
    $StatusBox.text = "| Estableciendo IP Estatica A $IP..."

    $Interface = Get-NetIPConfiguration | Select-Object -ExpandProperty InterfaceAlias
    Remove-NetIPAddress -InterfaceAlias $Interface -Confirm:$False
    Remove-NetRoute -InterfaceAlias $Interface
    New-NetIPAddress -InterfaceAlias $Interface -AddressFamily IPv4 $IP -PrefixLength 24 -DefaultGateway $Gateway | Out-Null
    Set-DnsClientServerAddress -InterfaceAlias $Interface -ServerAddresses 1.1.1.1, 1.0.0.1
    Disable-NetAdapter -Name $Interface -Confirm:$False
    Enable-NetAdapter -Name $Interface -Confirm:$False
    Set-NetConnectionProfile -NetworkCategory Private
    Start-Sleep 5
    $Form.Close()
})

$Form.Add_Closing({
    $MTB8.Image = $DefaultButtonColor
    $MTB8.ForeColor = $LabelColor
})

[void]$Form.ShowDialog()