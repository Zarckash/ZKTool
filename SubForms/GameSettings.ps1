Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

$HoverGameButtonColor = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverGameButtonColor.png")
$ProcessingGameButtonColor = [System.Drawing.Image]::FromFile("$ImagesFolder\ProcessingGameButtonColor.png")

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Game Settings"
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


            ##################################
            ############ SOFTWARE ############
            ##################################


# Label
$Label                           = New-Object System.Windows.Forms.Label
$Label.Text                      = "G A M E    S E T T I N G S"
$Label.Width                     = 709 - 1
$Label.Height                    = 38
$Label.Location                  = New-Object System.Drawing.Point(0,5)
$Label.Font                      = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$Label.ForeColor                 = $LabelColor
$Label.TextAlign                 = [System.Drawing.ContentAlignment]::MiddleCenter
$Label.BackgroundImage           = [System.Drawing.Image]::FromFile("$ImagesFolder\LabelBgGS.png")
$Form.Controls.Add($Label)

# Panel
$Panel                           = New-Object System.Windows.Forms.Panel
$Panel.Height                    = 69 * 2
$Panel.Width                     = 709 - 1
$Panel.BackgroundImage           = [System.Drawing.Image]::FromFile("$ImagesFolder\PanelBgGS.png")
$Panel.Location                  = New-Object System.Drawing.Point(0,45)
$Form.Controls.Add($Panel)

# Modern Warfare II
$R1B1                            = New-Object System.Windows.Forms.Button
$R1B1.Text                       = "Modern Warfare II"

# PUBG
$R1B2                            = New-Object System.Windows.Forms.Button
$R1B2.Text                       = "PUBG"

# Rogue Company
$R1B3                            = New-Object System.Windows.Forms.Button
$R1B3.Text                       = "Rogue Company"

# Battlefield 2042
$R1B4                            = New-Object System.Windows.Forms.Button
$R1B4.Text                       = "Battlefield 2042"

# Game
$R2B1                            = New-Object System.Windows.Forms.Button
$R2B1.Text                       = "CSGO"

# Game
$R2B2                            = New-Object System.Windows.Forms.Button
$R2B2.Text                       = "Apex Legends"

# Game
$R2B3                            = New-Object System.Windows.Forms.Button
$R2B3.Text                       = "Export"

# Game
$R2B4                            = New-Object System.Windows.Forms.Button
$R2B4.Text                       = "Import"

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

$PositionX = 10
$PositionY = 10

$Buttons = @($R1B1,$R1B2,$R1B3,$R1B4,$R2B1,$R2B2,$R2B3,$R2B4,$R3B1,$R3B2,$R3B3,$R3B4)
foreach ($Button in $Buttons) {
    $Panel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point($PositionX,$PositionY)
    $PositionX += 175
    if ($PositionX -gt 700) {
        $PositionX = 10
        $PositionY += 70
    }
    
    $Button.Width                = 165
    $Button.Height               = 50
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

# Rogue Company
$R1B3.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/RogueCompany.zip", "$TempPath\Files\RogueCompany.zip")
    Expand-Archive -Path ("$TempPath\Files\RogueCompany.zip") -DestinationPath "$env:localappdata\AppData\Local\RogueCompany\Saved\Config\WindowsNoEditor" -Force
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

# Battlefield 2042
$R1B4.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/Battlefield2042.zip", "$TempPath\Files\Battlefield2042.zip")
    Expand-Archive -Path ("$TempPath\Files\Battlefield2042.zip") -DestinationPath ("$DocumentsPath\Battlefield 2042\settings") -Force
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

# Apex
$R2B2.Add_Click({
    $Download.DownloadFile("$GitHubPath/Files/.zip/Apex.zip", "$TempPath\Files\Apex.zip")
    Expand-Archive -Path ("$TempPath\Files\Apex.zip") -DestinationPath "$env:userprofile\Saved Games\Respawn\Apex" -Force
    Write-UserOutput ("Configuracion De " + $this.Text + " Aplicada")
})

# Export
$R2B3.Add_Click({
    Write-UserOutput "Exportando configuración"
    $Download.DownloadFile("$GitHubPath/Functions/Import-Export.ps1", "$TempPath\Functions\Import-Export.ps1")
    Push-Location
    Set-Location "$TempPath\Functions"
    .\ImportExport.ps1 -Export
    Pop-Location
})

# Import
$R2B4.Add_Click({
    Write-UserOutput "Importando configuración"
    $Download.DownloadFile("$GitHubPath/Files/Import-Export.ps1", "$TempPath\Files\Import-Export.ps1")
    Push-Location
    Set-Location "$TempPath\Files"
    .\Import-Export.ps1 -Import
    Pop-Location
})

$Buttons = @($R1B1,$R1B2,$R1B3,$R1B4,$R2B1,$R2B2,$R2B3,$R2B4,$R3B1,$R3B2,$R3B3,$R3B4)
foreach ($Button in $Buttons) {
    $Button.Add_Click({
        $this.Image = $DefaultGameButtonColor
        $this.ForeColor = $LabelColor
        Start-Sleep 2
    })
}

$Form.Add_Closing({
    $HB1.Image = $DefaultButtonColor
    $HB1.ForeColor = $LabelColor
})

[void]$Form.ShowDialog()