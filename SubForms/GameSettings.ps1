﻿Add-Type -AssemblyName System.Windows.Forms
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

$FromPath = "https://github.com/Zarckash/ZKTool/raw/main" # GitHub Downloads URL
$ToPath   = "$env:temp\ZKTool"  # Folder Structure Path
$DocumentsPath = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal"
$Download = New-Object net.webclient

# Modern Warfare II
$R1B1.Add_Click({
    $Download.DownloadFile($FromPath+"/Configs/ModernWarfareII.zip", $ToPath+"\Configs\ModernWarfareII.zip")
    Expand-Archive -Path ($ToPath+"\Configs\ModernWarfareII.zip") -DestinationPath ($ToPath+"\Configs\ModernWarfareII") -Force
    Move-Item -Path ($ToPath+"\Configs\ModernWarfareII\options.3.cod22.cst") -Destination ($DocumentsPath+"\Call of Duty\players") -Force
    $CodPath = $DocumentsPath+"\Call of Duty\players\" 
    $CodIDPath = ($CodPath + (Get-ChildItem $CodPath -Directory -Name 765*))
    Move-Item -Path ($ToPath+"\Configs\ModernWarfareII\settings.3.local.cod22.cst") -Destination $CodIDPath -Force
    $StatusBox.Text = "| Configuracion De " + $this.Text + " Aplicada..."
})

# Player Unknown Battlegrounds
$R1B2.Add_Click({
    $Download.DownloadFile($FromPath+"/Configs/PUBG.zip", $ToPath+"\Configs\PUBG.zip")
    Expand-Archive -Path ($ToPath+"\Configs\PUBG.zip") -DestinationPath "$env:userprofile\AppData\Local\TslGame\Saved\Config\WindowsNoEditor" -Force
    $StatusBox.Text = "| Configuracion De " + $this.Text + " Aplicada..."
})

# Rogue Company
$R1B3.Add_Click({
    $Download.DownloadFile($FromPath+"/Configs/RogueCompany.zip", $ToPath+"\Configs\RogueCompany.zip")
    Expand-Archive -Path ($ToPath+"\Configs\RogueCompany.zip") -DestinationPath "$env:userprofile\AppData\Local\RogueCompany\Saved\Config\WindowsNoEditor" -Force
    $StatusBox.Text = "| Configuracion De " + $this.Text + " Aplicada..."
})

# Battlefield 2042
$R1B4.Add_Click({
    $Download.DownloadFile($FromPath+"/Configs/Battlefield2042.zip", $ToPath+"\Configs\Battlefield2042.zip")
    Expand-Archive -Path ($ToPath+"\Configs\Battlefield2042.zip") -DestinationPath ($DocumentsPath+"\Battlefield 2042\settings") -Force
    $StatusBox.Text = "| Configuracion De " + $this.Text + " Aplicada..."
})

# CSGO
$R2B1.Add_Click({
    $Download.DownloadFile($FromPath+"/Configs/CSGO.zip", $ToPath+"\Configs\CSGO.zip")
    Expand-Archive -Path ($ToPath+"\Configs\CSGO.zip") -DestinationPath ($ToPath+"\Configs\") -Force
    $userids = Get-ChildItem "C:\Program Files (x86)\Steam\userdata" -Directory
    foreach ($id in $userids.name) {
        Copy-Item -Path ($ToPath+"\Configs\730") -Destination "C:\Program Files (x86)\Steam\userdata\$id" -Recurse -Force
    }
    $StatusBox.Text = "| Configuracion De " + $this.Text + " Aplicada..."
})

# Apex
$R2B2.Add_Click({
    $Download.DownloadFile($FromPath+"/Configs/Apex.zip", $ToPath+"\Configs\Apex.zip")
    Expand-Archive -Path ($ToPath+"\Configs\Apex.zip") -DestinationPath "$env:userprofile\Saved Games\Respawn\Apex" -Force
    $StatusBox.Text = "| Configuracion De " + $this.Text + " Aplicada..."
})

# Export
$R2B3.Add_Click({
    $StatusBox.Text = "| Exportando configuración..."
    $Download.DownloadFile($FromPath+"/Apps/ImportExport.ps1", $ToPath+"\Apps\ImportExport.ps1")
    Push-Location
    Set-Location "$ToPath\Apps"
    .\ImportExport.ps1 -Export
    Pop-Location
})

# Import
$R2B4.Add_Click({
    $StatusBox.Text = "| Importando configuración..."
    $Download.DownloadFile($FromPath+"/Apps/ImportExport.ps1", $ToPath+"\Apps\ImportExport.ps1")
    Push-Location
    Set-Location "$ToPath\Apps"
    .\ImportExport.ps1 -Import
    Pop-Location
})

$Buttons = @($R1B1,$R1B2,$R1B3,$R1B4,$R2B1,$R2B2,$R2B3,$R2B4,$R3B1,$R3B2,$R3B3,$R3B4)
foreach ($Button in $Buttons) {
    $Button.Add_Click({
        Start-Sleep 2
        $this.Image = $DefaultGameButtonColor
        $this.ForeColor = $LabelColor
    })
}

$Form.Add_Closing({
    $HB1.Image = $DefaultButtonColor
    $HB1.ForeColor = $LabelColor
})

[void]$Form.ShowDialog()