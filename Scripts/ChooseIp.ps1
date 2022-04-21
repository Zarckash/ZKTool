Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$FormTextColor = [System.Drawing.ColorTranslator]::FromHtml("#F1F1F1")
$SelectedTextColor = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$TextColor = [System.Drawing.ColorTranslator]::FromHtml("#99FFFD")
$ButtonColor = [System.Drawing.ColorTranslator]::FromHtml("#3A3D45")
$ProcessingColor = [System.Drawing.ColorTranslator]::FromHtml("#DC4995")

$Location = 233 # Sets Each Panel Location
$XRes = Get-WmiObject -Class "Win32_VideoController" | Select-Object -ExpandProperty "CurrentHorizontalResolution" # Resolucion Horizontal
$YRes = Get-WmiObject -Class "Win32_VideoController" | Select-Object -ExpandProperty "CurrentVerticalResolution" # Resolucion Vertical
$FormXLocation = ($XRes / 2) - (258 / 2) - 15
$FormYLocation = ($YRes / 2) - (602 / 2) - 85

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Seleccionar IP"
$Form.StartPosition              = "Manual"
$Form.Location                   = New-Object System.Drawing.Point($FormXLocation, $FormYLocation)
$Form.TopMost                    = $False
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#272E3D")
$Form.AutoScaleDimensions        = '192, 192'
$Form.AutoScaleMode              = "Dpi"
$Form.AutoSize                   = $True
$Form.ClientSize                 = "1050, 700"
$Form.FormBorderStyle            = "FixedSingle"
$Form.Width                      = $objImage.Width
$Form.Height                     = $objImage.Height
$Form.ForeColor                  = $FormTextColor
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\ZKLogo.ico")

# Search IPs Panel
$Panel                           = New-Object System.Windows.Forms.Panel
$Panel.height                    = 37 # Button Draw Size + Padding Bottom
$Panel.width                     = 258
$Panel.location                  = New-Object System.Drawing.Point(0,10)
$Form.Controls.Add($Panel)

# Search IPs Button
$SearchIP                        = New-Object System.Windows.Forms.Button
$SearchIP.text                   = "Buscar IPs"
$SearchIP.width                  = 240
$SearchIP.height                 = 35
$SearchIP.location               = New-Object System.Drawing.Point(10,0)
$SearchIP.Font                   = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SearchIP.BackColor              = $ButtonColor
$Panel.Controls.Add($SearchIP)

# Avaible IPs Label
$AvaibleIPsLabel                 = New-Object System.Windows.Forms.Label
$AvaibleIPsLabel.text            = "IPs Disponibles:"
$AvaibleIPsLabel.AutoSize        = $True
$AvaibleIPsLabel.width           = 230
$AvaibleIPsLabel.height          = 35
$AvaibleIPsLabel.location        = New-Object System.Drawing.Point(8,55)
$AvaibleIPsLabel.Font            = New-Object System.Drawing.Font('Ubuntu Mono',14)
$AvaibleIPsLabel.ForeColor       = $TextColor
$Form.Controls.Add($AvaibleIPsLabel)

# Avaible IPs
$AvaibleIPs                      = New-Object System.Windows.Forms.Label
$AvaibleIPs.width                = 245
$AvaibleIPs.height               = 45
$AvaibleIPs.location             = New-Object System.Drawing.Point(8,80)
$AvaibleIPs.Font                 = New-Object System.Drawing.Font('Ubuntu Mono',12)
$AvaibleIPs.ForeColor            = $FormTextColor
$Form.Controls.Add($AvaibleIPs)

# Choose IP Label
$ChooseIPLabel                   = New-Object System.Windows.Forms.Label
$ChooseIPLabel.text              = "Seleccionar IP:"
$ChooseIPLabel.AutoSize          = $True
$ChooseIPLabel.width             = 230
$ChooseIPLabel.height            = 25
$ChooseIPLabel.location          = New-Object System.Drawing.Point(8,145)
$ChooseIPLabel.Font              = New-Object System.Drawing.Font('Ubuntu Mono',14)
$ChooseIPLabel.ForeColor         = $TextColor
$Form.Controls.Add($ChooseIPLabel)

# Input TextBox
$InputBox                        = New-Object System.Windows.Forms.TextBox
$InputBox.width                  = 238
$InputBox.height                 = 35
$InputBox.location               = New-Object System.Drawing.Point(11,170)
$InputBox.Font                   = New-Object System.Drawing.Font('Ubuntu Mono',12)
$InputBox.AcceptsReturn          = $True
$InputBox.Text                   = (Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop).Substring(0,10)
$InputBox.BackColor              = $ButtonColor
$InputBox.ForeColor              = $FormTextColor
$Form.Controls.Add($InputBox)

# Choose IP Panel
$Panel2                          = New-Object System.Windows.Forms.Panel
$Panel2.height                   = 37+18 # Button Draw Size + Padding Bottom
$Panel2.width                    = 258
$Panel2.location                 = New-Object System.Drawing.Point(0,195)
$Form.Controls.Add($Panel2)

# Cancel Button
$Cancel                          = New-Object System.Windows.Forms.Button
$Cancel.text                     = "Cancelar"
$Cancel.width                    = 117
$Cancel.height                   = 35
$Cancel.location                 = New-Object System.Drawing.Point(10,10)
$Cancel.Font                     = New-Object System.Drawing.Font('Ubuntu Mono',12)
$Cancel.BackColor                = $ButtonColor
$Panel2.Controls.Add($Cancel)

# Accept Button
$Accept                          = New-Object System.Windows.Forms.Button
$Accept.text                     = "Aceptar"
$Accept.width                    = 117
$Accept.height                   = 35
$Accept.location                 = New-Object System.Drawing.Point(133,10)
$Accept.Font                     = New-Object System.Drawing.Font('Ubuntu Mono',12)
$Accept.BackColor                = $ButtonColor
$Accept.ForeColor                = $TextColor
$Panel2.Controls.Add($Accept)

$Gateway = Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop

# Search IPs Button
$SearchIP.Add_Click({
    $SearchIP.BackColor = $ProcessingColor
    $Condition = $False

    while (!($Condition)) {

        $Found=0
        for ($Hop = 24; $Found -lt 6 -and $Hop -lt 100; $Hop++) {
            $TestIP = $Gateway.Substring(0,10) + $Hop
            if (!(Test-Connection $TestIP -Count 1 -Quiet)) {
                $AvaibleIPs.Text += "$TestIP    "
                $Found++
            }
        }
        $Condition = $True
    }
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
    $StatusBox.text = "|Estableciendo IP Estatica A $IP...`r`n" + $StatusBox.text

    $Interface = Get-NetIPConfiguration | Select-Object -ExpandProperty InterfaceAlias
    Remove-NetIPAddress -InterfaceAlias $Interface
    Remove-NetRoute -InterfaceAlias $Interface
    New-NetIPAddress -InterfaceAlias $Interface -AddressFamily IPv4 $IP -PrefixLength 24 -DefaultGateway $Gateway | Out-Null
    Set-DnsClientServerAddress -InterfaceAlias $Interface -ServerAddresses 8.8.8.8, $Gateway
    Disable-NetAdapter -Name $Interface -Confirm:$False
    Enable-NetAdapter -Name $Interface -Confirm:$False
    Start-Sleep 5
    $Form.Close()
})

[void]$Form.ShowDialog()