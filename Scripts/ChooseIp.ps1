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
$BackGroundColor = [System.Drawing.ColorTranslator]::FromHtml("#272E3D")
$TextColor = [System.Drawing.ColorTranslator]::FromHtml("#99FFFD")
$ButtonColor = [System.Drawing.ColorTranslator]::FromHtml("#3A3D45")

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Seleccionar IP"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = $BackGroundColor
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
$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 37 # Button Draw Size + Padding Bottom
$Panel1.width                    = 258
$Panel1.location                 = New-Object System.Drawing.Point(0,10)
$Form.Controls.Add($Panel1)

# Search IPs Button
$searchip                        = New-Object system.Windows.Forms.Button
$searchip.text                   = "Buscar IPs"
$searchip.width                  = 240
$searchip.height                 = 35
$searchip.location               = New-Object System.Drawing.Point(10,0)
$searchip.Font                   = New-Object System.Drawing.Font('Ubuntu Mono',12)
$searchip.BackColor              = $buttoncolor
$Panel1.Controls.Add($searchip)

# Avaible IPs Label
$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "IPs Disponibles:"
$Label1.AutoSize                 = $true
$Label1.width                    = 230
$Label1.height                   = 35
$Label1.location                 = New-Object System.Drawing.Point(8,55)
$Label1.Font                     = New-Object System.Drawing.Font('Ubuntu Mono',14)
$Label1.ForeColor                = $textcolor
$Form.Controls.Add($Label1)

# Avaible IPs
$avaibleips                      = New-Object system.Windows.Forms.Label
$avaibleips.width                = 245
$avaibleips.height               = 45
$avaibleips.location             = New-Object System.Drawing.Point(8,80)
$avaibleips.Font                 = New-Object System.Drawing.Font('Ubuntu Mono',12)
$avaibleips.ForeColor            = $formtextcolor
$Form.Controls.Add($avaibleips)

# Avaible IPs Label
$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Seleccionar IP:"
$Label2.AutoSize                 = $true
$Label2.width                    = 230
$Label2.height                   = 25
$Label2.location                 = New-Object System.Drawing.Point(8,145)
$Label2.Font                     = New-Object System.Drawing.Font('Ubuntu Mono',14)
$Label2.ForeColor                = $textcolor
$Form.Controls.Add($Label2)

# Input TextBox
$inputbox                        = New-Object system.Windows.Forms.TextBox
$inputbox.width                  = 238
$inputbox.height                 = 35
$inputbox.location               = New-Object System.Drawing.Point(11,170)
$inputbox.Font                   = New-Object System.Drawing.Font('Ubuntu Mono',12)
$inputbox.AcceptsReturn          = $true
$inputbox.Text                   = (Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop).Substring(0,10)
$inputbox.BackColor              = $buttoncolor
$inputbox.ForeColor              = $textcolor
$Form.Controls.Add($inputbox)

# Choose IP Panel
$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 37+18 # Button Draw Size + Padding Bottom
$Panel2.width                    = 258
$Panel2.location                 = New-Object System.Drawing.Point(0,195)
$Form.Controls.Add($Panel2)

# Cancel Button
$cancel                          = New-Object system.Windows.Forms.Button
$cancel.text                     = "Cancelar"
$cancel.width                    = 117
$cancel.height                   = 35
$cancel.location                 = New-Object System.Drawing.Point(10,10)
$cancel.Font                     = New-Object System.Drawing.Font('Ubuntu Mono',12)
$cancel.BackColor                = $buttoncolor
$Panel2.Controls.Add($cancel)

# Accept Button
$ok                              = New-Object system.Windows.Forms.Button
$ok.text                         = "Aceptar"
$ok.width                        = 117
$ok.height                       = 35
$ok.location                     = New-Object System.Drawing.Point(133,10)
$ok.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$ok.BackColor                    = $buttoncolor
$ok.ForeColor                    = $textcolor
$Panel2.Controls.Add($ok)

$gateway = Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop

# Search IPs Button
$searchip.Add_Click({
    $condition = $false

    while (!($condition)) {

        $found=0
        for ($hop = 24; $found -lt 6 -and $hop -lt 100; $hop++) {
            $testip = $gateway.Substring(0,10) + $hop
            if (!(Test-Connection $testip -Count 1 -Quiet)) {
                $avaibleips.Text += "$testip    "
                $found++
            }
        }
        $condition = $true
    }
})

# Cancel Button
$cancel.Add_Click({
    $Form.Close()
})

# Accept Button
$ok.Add_Click({
    $ip = ($inputbox.Lines).Substring(0,12)
    $statusbox.text = "|Estableciendo IP Estatica A $ip...`r`n" + $statusbox.text

    $interface = Get-NetIPConfiguration | Select-Object -ExpandProperty InterfaceAlias
    Remove-NetIPAddress -InterfaceAlias $interface
    Remove-NetRoute -InterfaceAlias $interface
    New-NetIPAddress -InterfaceAlias $interface -AddressFamily IPv4 $ip -PrefixLength 24 -DefaultGateway $gateway | Out-Null
    Set-DnsClientServerAddress -InterfaceAlias $interface -ServerAddresses 8.8.8.8, $gateway
    Disable-NetAdapter -Name $interface -Confirm:$false
    Enable-NetAdapter -Name $interface -Confirm:$false
    Start-Sleep 5
    $Form.Close()
})

[void]$Form.ShowDialog()