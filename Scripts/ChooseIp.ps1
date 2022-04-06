Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

# Dark Or Light Theme
if ((Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -name AppsUseLightTheme | select -exp AppsUseLightTheme) -eq 0) {
    $formtextcolor = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
    $bgcolor = [System.Drawing.ColorTranslator]::FromHtml("#363636")
    $textcolor = [System.Drawing.ColorTranslator]::FromHtml("#99FFF0")
    $buttoncolor = [System.Drawing.ColorTranslator]::FromHtml("#464646")
} else {
    $formtextcolor = [System.Drawing.ColorTranslator]::FromHtml("#000000")
    $bgcolor = [System.Drawing.ColorTranslator]::FromHtml("#F3F3F3")
    $textcolor = [System.Drawing.ColorTranslator]::FromHtml("#A85EE9")
    $buttoncolor = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050,700)
$Form.text                       = "Seleccionar IP"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = $bgcolor
$Form.AutoScaleDimensions        = '192, 192'
$Form.AutoScaleMode              = "Dpi"
$Form.AutoSize                   = $True
$Form.ClientSize                 = '1050, 700'
$Form.FormBorderStyle            = 'FixedSingle'
$Form.Location                   = New-Object System.Drawing.Point(1310, 199)

$iconBase64                      = 
'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'
$iconBytes                       = [Convert]::FromBase64String($iconBase64)
$stream                          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
$stream.Write($iconBytes, 0, $iconBytes.Length)
$Form.Icon                       = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())
$Form.Width                      = $objImage.Width
$Form.Height                     = $objImage.Height
$Form.ForeColor                  = $formtextcolor

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
    Start-Sleep 5
    $Form.Close()
})

[void]$Form.ShowDialog()