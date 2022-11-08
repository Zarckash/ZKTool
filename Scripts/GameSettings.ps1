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
$TextColor = [System.Drawing.ColorTranslator]::FromHtml("#00e6ff")
$ButtonColor = [System.Drawing.ColorTranslator]::FromHtml("#3E434F")
$ProcessingColor = [System.Drawing.ColorTranslator]::FromHtml("#ff006e")

$PanelSize = 233 # Sets Each Panel Location

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Game Settings"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#272E3D")
$Form.AutoScaleDimensions        = '192, 192'
$Form.AutoScaleMode              = "Dpi"
$Form.AutoSize                   = $True
$Form.ClientSize                 = "1050, 700"
$Form.FormBorderStyle            = "FixedSingle"
$Form.Width                      = $objImage.Width
$Form.Height                     = $objImage.Height
$Form.ForeColor                  = $FormTextColor
$Form.MaximizeBox                = $False
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ZKLogo.ico")


            ##################################
            ############ SOFTWARE ############
            ##################################


# Software Label
$Label                           = New-Object System.Windows.Forms.Label
$Label.Text                      = "G A M E    S E T T I N G S"
$Label.AutoSize                  = $true
$Label.Width                     = 215
$Label.Height                    = 25
$Label.Location                  = New-Object System.Drawing.Point(225,13)
$Label.Font                      = New-Object System.Drawing.Font('Berserker',16)
$Label.ForeColor                 = $TextColor
$Form.Controls.Add($Label)

$PanelSize                        = 233 # Sets Each Panel Location
$Row                             = 0
$Position                        = 10

# Software Panel
$Panel                           = New-Object System.Windows.Forms.Panel
$Panel.Height                    = 60
$Panel.Width                     = 699
$Panel.Location                  = New-Object System.Drawing.Point(($PanelSize*0),55)
$Form.Controls.Add($Panel)

# Pubg
$B1                              = New-Object System.Windows.Forms.Button
$B1.Text                         = "Pubg"
$B1.Width                        = 165
$B1.Height                       = 50
$B1.Location                     = New-Object System.Drawing.Point($Position,(60*$Row))
$B1.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$B1.BackColor                    = $ButtonColor
$Panel.Controls.Add($B1)
$Position += 172

# The Cycle
$B2                              = New-Object System.Windows.Forms.Button
$B2.Text                         = "The Cycle"
$B2.Width                        = 165
$B2.Height                       = 50
$B2.Location                     = New-Object System.Drawing.Point($Position,(60*$Row))
$B2.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$B2.BackColor                    = $ButtonColor
$Panel.Controls.Add($B2)
$Position += 172

# Modern Warfare II
$B3                              = New-Object System.Windows.Forms.Button
$B3.Text                         = "Modern Warfare II"
$B3.Width                        = 165
$B3.Height                       = 50
$B3.Location                     = New-Object System.Drawing.Point($Position,(60*$Row))
$B3.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$B3.BackColor                    = $ButtonColor
$Panel.Controls.Add($B3)
$Position += 172

# Rogue Company
$B4                              = New-Object System.Windows.Forms.Button
$B4.Text                         = "Rogue Company"
$B4.Width                        = 165
$B4.Height                       = 50
$B4.Location                     = New-Object System.Drawing.Point($Position,(60*$Row))
$B4.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$B4.BackColor                    = $ButtonColor
$Panel.Controls.Add($B4)
$Position += 172

$Row                             = 1
$Position                        = 10

# Google Chrome
$B5                              = New-Object System.Windows.Forms.Button
$B5.Text                         = "Juego"
$B5.Width                        = 165
$B5.Height                       = 50
$B5.Location                     = New-Object System.Drawing.Point($Position,(60*$Row))
$B5.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$B5.BackColor                    = $ButtonColor
$Panel.Controls.Add($B5)
$Position += 172

# Google Chrome
$B6                              = New-Object System.Windows.Forms.Button
$B6.Text                         = "Juego"
$B6.Width                        = 165
$B6.Height                       = 50
$B6.Location                     = New-Object System.Drawing.Point($Position,(60*$Row))
$B6.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$B6.BackColor                    = $ButtonColor
$Panel.Controls.Add($B6)
$Position += 172

# Google Chrome
$B7                              = New-Object System.Windows.Forms.Button
$B7.Text                         = "Juego"
$B7.Width                        = 165
$B7.Height                       = 50
$B7.Location                     = New-Object System.Drawing.Point($Position,(60*$Row))
$B7.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$B7.BackColor                    = $ButtonColor
$Panel.Controls.Add($B7)
$Position += 172

# Google Chrome
$B8                              = New-Object System.Windows.Forms.Button
$B8.Text                         = "Juego"
$B8.Width                        = 165
$B8.Height                       = 50
$B8.Location                     = New-Object System.Drawing.Point($Position,(60*$Row))
$B8.Font                         = New-Object System.Drawing.Font('Ubuntu Mono',12)
$B8.BackColor                    = $ButtonColor
$Panel.Controls.Add($B8)
$Position += 172

$Buttons = @($B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8)
foreach ($Button in $Buttons) {
    $Button.Add_MouseEnter({
        if ($this.BackColor -eq $ButtonColor) {
            $this.BackColor = $ProcessingColor
        }
    })

    $Button.Add_MouseLeave({
        if ($this.BackColor -eq $ProcessingColor) {
            $this.BackColor = $ButtonColor
        }
    })
}

$FromPath = "https://github.com/Zarckash/ZKTool/raw/main" # GitHub Downloads URL
$ToPath   = "$env:userprofile\AppData\Local\Temp\ZKTool"  # Folder Structure Path
$DocumentsPath = Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal" | Select-Object -ExpandProperty Personal
$Download = New-Object net.webclient

# Player Unknown Battlegrounds
$B1.Add_Click({
    $B1.BackColor = $ProcessingColor
    $B1.ForeColor = $FormTextColor
    $Download.DownloadFile($FromPath+"/Configs/Pubg.zip", $ToPath+"\Configs\Pubg.zip")
    Expand-Archive -Path ($ToPath+"\Configs\Pubg.zip") -DestinationPath "$env:userprofile\AppData\Local\TslGame\Saved\Config\WindowsNoEditor" -Force
    $B1.ForeColor = $ProcessingColor
    $B1.BackColor = $ButtonColor
})

# The Cycle: Frontier
$B2.Add_Click({
    $B2.BackColor = $ProcessingColor
    $B2.ForeColor = $FormTextColor
    $Download.DownloadFile($FromPath+"/Configs/TheCycleFrontier.zip", $ToPath+"\Configs\TheCycleFrontier.zip")
    Expand-Archive -Path ($ToPath+"\Configs\TheCycleFrontier.zip") -DestinationPath "$env:userprofile\AppData\Local\Prospect\Saved\Config\WindowsNoEditor" -Force
    $B2.ForeColor = $ProcessingColor
    $B2.BackColor = $ButtonColor
})

# Modern Warfare II
$B3.Add_Click({
    $B3.BackColor = $ProcessingColor
    $B3.ForeColor = $FormTextColor
    $Download.DownloadFile($FromPath+"/Configs/ModernWarfareII.zip", $ToPath+"\Configs\ModernWarfareII.zip")
    Expand-Archive -Path ($ToPath+"\Configs\ModernWarfareII.zip") -DestinationPath ($DocumentsPath+"\Call of Duty\players") -Force
    $B3.ForeColor = $ProcessingColor
    $B3.BackColor = $ButtonColor
})

# Rogue Company
$B4.Add_Click({
    $B4.BackColor = $ProcessingColor
    $B4.ForeColor = $FormTextColor
    $Download.DownloadFile($FromPath+"/Configs/RogueCompany.zip", $ToPath+"\Configs\RogueCompany.zip")
    Expand-Archive -Path ($ToPath+"\Configs\RogueCompany.zip") -DestinationPath "$env:userprofile\AppData\Local\RogueCompany\Saved\Config\WindowsNoEditor" -Force
    $B4.ForeColor = $ProcessingColor
    $B4.BackColor = $ButtonColor
})

$B5.Add_Click({
    $B5.BackColor = $ProcessingColor
    $B5.ForeColor = $FormTextColor
    $B5.ForeColor = $ProcessingColor
    $B5.BackColor = $ButtonColor
})

$B6.Add_Click({
    $B6.BackColor = $ProcessingColor
    $B6.ForeColor = $FormTextColor
    $B6.ForeColor = $ProcessingColor
    $B6.BackColor = $ButtonColor
})

$B7.Add_Click({
    $B7.BackColor = $ProcessingColor
    $B7.ForeColor = $FormTextColor
    $B7.ForeColor = $ProcessingColor
    $B7.BackColor = $ButtonColor
})

$B8.Add_Click({
    $B8.BackColor = $ProcessingColor
    $B8.ForeColor = $FormTextColor
    $B8.ForeColor = $ProcessingColor
    $B8.BackColor = $ButtonColor
})
[void]$Form.ShowDialog()