Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$FormSize = "265,282"

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Seleccionar IP"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.FormBorderStyle            = "None"
$Form.Size                       = $FormSize
$Form.ForeColor                  = $DefaultForeColor
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon("$ImagesFolder\ZKLogo.ico")
$Form.BackColor                  = "LimeGreen"
$Form.TransparencyKey            = "LimeGreen"

$FormPanel                       = New-Object System.Windows.Forms.Panel
$FormPanel.Size                  = $FormSize
$FormPanel.Location              = "0,0"
$FormPanel.BackgroundImage       = [System.Drawing.Image]::FromFile("$ImagesFolder\NetworkConfigBg.png")
$Form.Controls.Add($FormPanel)

# Search IPs Panel
$Panel                           = New-Object System.Windows.Forms.Panel
$Panel.Size                      = "251,46"
$Panel.Location                  = "7,7"
$Panel.BackColor                 = $FormBackColor
$Panel.BackgroundImage           = [System.Drawing.Image]::FromFile("$ImagesFolder\SearchIPPanelBg.png")
$FormPanel.Controls.Add($Panel)

# Search IPs Button
$SearchIP                        = New-Object System.Windows.Forms.Button
$SearchIP.Text                   = "Buscar IPs"
$SearchIP.Size                   = "240,35"
$SearchIP.location               = New-Object System.Drawing.Point(5,5)
$SearchIP.BackColor              = $FormBackColor
$Panel.Controls.Add($SearchIP)

# Avaible IPs Label
$AvaibleIPsLabel                 = New-Object System.Windows.Forms.Label
$AvaibleIPsLabel.Text            = "IPs Disponibles:"
$AvaibleIPsLabel.Size            = "251,30"
$AvaibleIPsLabel.Location        = "7,60"
$AvaibleIPsLabel.Font            = New-Object System.Drawing.Font('Segoe UI Semibold',13)
$AvaibleIPsLabel.ForeColor       = $AccentColor
$AvaibleIPsLabel.Padding         = "5, 0, 0, 0"
$AvaibleIPsLabel.BackColor       = $FormBackColor
$AvaibleIPsLabel.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\AvaibleIPLabelBg.png")
$FormPanel.Controls.Add($AvaibleIPsLabel)

# Avaible IPs
$AvaibleIPs                      = New-Object System.Windows.Forms.Label
$AvaibleIPs.Size                 = "251,75"
$AvaibleIPs.Location             = "7,85"
$AvaibleIPs.Font                 = New-Object System.Drawing.Font('Segoe UI',12)
$AvaibleIPs.Padding              = "5, 0, 0, 0"
$AvaibleIPs.BackColor            = $FormBackColor
$AvaibleIPs.BackgroundImage      = [System.Drawing.Image]::FromFile("$ImagesFolder\AvaibleIPBg.png")
$FormPanel.Controls.Add($AvaibleIPs)

# Choose IP Label
$ChooseIPLabel                   = New-Object System.Windows.Forms.Label
$ChooseIPLabel.Text              = "Seleccionar IP y DNS"
$ChooseIPLabel.Size              = "251,30"
$ChooseIPLabel.Location          = "7,167"
$ChooseIPLabel.Font              = New-Object System.Drawing.Font('Segoe UI Semibold',13)
$ChooseIPLabel.ForeColor         = $AccentColor
$ChooseIPLabel.Padding           = "5, 0, 0, 0"
$ChooseIPLabel.BackColor         = $FormBackColor
$ChooseIPLabel.BackgroundImage   = [System.Drawing.Image]::FromFile("$ImagesFolder\AvaibleIPLabelBg.png")
$FormPanel.Controls.Add($ChooseIPLabel)

# Input TextBox
$InputBox                        = New-Object System.Windows.Forms.TextBox
$InputBox.Size                   = "251,40"
$InputBox.Location               = "7,197"
$InputBox.Font                   = New-Object System.Drawing.Font('Consolas',10)
$InputBox.AcceptsReturn          = $true
$InputBox.Text                   = " " + (Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop).Substring(0,10) + " | 8.8.8.8 | 8.8.4.4"
$InputBox.BackColor              = $PanelBackColor
$InputBox.ForeColor              = $DefaultForeColor
$InputBox.MaxLength = 35
$FormPanel.Controls.Add($InputBox)

# Choose IP Panel
$Panel2                          = New-Object System.Windows.Forms.Panel
$Panel2.Size                     = "251,49"
$Panel2.Location                 = "7,226"
$Panel2.BackColor                = $FormBackColor
$Panel2.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\ChooseIPPanelBg.png")
$FormPanel.Controls.Add($Panel2)

# Cancel Button
$Cancel                          = New-Object System.Windows.Forms.Button
$Cancel.Text                     = "Cancelar"
$Cancel.Size                     = "117,35"
$Cancel.Location                 = "6,7"
$Cancel.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\CancelAcceptButton.png")
$Panel2.Controls.Add($Cancel)

# Accept Button
$Accept                          = New-Object System.Windows.Forms.Button
$Accept.Text                     = "Aceptar"
$Accept.Size                     = "117,35"
$Accept.Location                 = "128,7"
$Accept.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\CancelAcceptButton.png")
$Accept.ForeColor                = $AccentColor
$Panel2.Controls.Add($Accept)

$Buttons = @($SearchIP,$Cancel,$Accept)
foreach ($Button in $Buttons) {
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.BackColor = $PanelBackColor

    $Button.Add_MouseEnter({
        if (($this.Text -eq "Buscar IPs") -or ($this.Text -eq "Buscar Mas IPs")) {
            $this.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverSearchIPButton.png")
        } else {
            $this.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverCancelAcceptButton.png")
        }
    })

    $Button.Add_MouseLeave({
        if (($this.Text -eq "Buscar IPs") -or ($this.Text -eq "Buscar Mas IPs")) {
            $this.BackgroundImage = $None
        } else {
            $this.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\CancelAcceptButton.png")
        }

    })
}

$Gateway = Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop
$i = New-Object System.Windows.Forms.Button
$i.Width = 20

# Search IPs Button
$SearchIP.Add_Click({
    $SearchIP.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\ProcessingSearchIPButton.png")
    $SearchIP.ForeColor = "Black"
    $Condition = $false
    $AvaibleIPs.Text = ""

    while (!($Condition)) {
        $Found=0
        for ($i.Width; $Found -lt 6 -and $i.Width -lt 100; $i.Width++) {
            $TestIP = $Gateway.Substring(0,10) + $i.Width
            if (!(Test-Connection $TestIP -Count 1 -Quiet)) {
                $AvaibleIPs.Text += "$TestIP            "
                $Found++
            }
        }
        $Condition = $true
    }
    
    $SearchIP.Text = "Buscar Mas IPs"
    $SearchIP.ForeColor = $DefaultForeColor
    $SearchIP.BackgroundImage = $Empty
})

# Cancel Button
$Cancel.Add_Click({
    $Form.Close()
})

# Accept Button
$Accept.Add_Click({
    $Accept.BackColor = $ProcessingColor
    $GetValues = ($InputBox.Lines).Replace(' ','').Split('|')
    $IP = $GetValues[0]
    $DNS = $GetValues[1..2]
    Write-UserOutput = "Estableciendo IP $IP Y DNS $DNS"

    $Interface = Get-NetIPConfiguration | Select-Object -ExpandProperty InterfaceAlias
    Remove-NetIPAddress -InterfaceAlias $Interface -Confirm:$false
    Remove-NetRoute -InterfaceAlias $Interface
    New-NetIPAddress -InterfaceAlias $Interface -AddressFamily IPv4 $IP -PrefixLength 24 -DefaultGateway $Gateway | Out-Null
    Set-DnsClientServerAddress -InterfaceAlias $Interface -ServerAddresses $DNS[0], $DNS[1]
    Disable-NetAdapter -Name $Interface -Confirm:$false
    Enable-NetAdapter -Name $Interface -Confirm:$false
    Set-NetConnectionProfile -NetworkCategory Private
    Start-Sleep 5
    $Form.Close()
})

$Form.Add_Closing({
    $MTB8.Image = $DefaultButtonColor
    $MTB8.ForeColor = $AccentColor
})

[void]$Form.ShowDialog()