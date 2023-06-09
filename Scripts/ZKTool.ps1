Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

Remove-Item $env:userprofile\AppData\Local\Temp\1ZKTool.log | Out-Null
$LogPath  = "$env:userprofile\AppData\Local\Temp\1ZKTool.log"

New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Configs\ -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Apps\ -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\ -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
Iwr "https://github.com/Zarckash/ZKTool/raw/main/Configs/Images.zip" -OutFile "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images.zip" | Out-File $LogPath -Encoding UTF8 -Append
Expand-Archive -Path $env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images.zip -DestinationPath $env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ -Force

$VersionFile = 2.2

# Update To Last Version
if (!(Test-Path "$env:ProgramFiles\ZKTool\$VersionFile")) {
    New-Item -Path $env:ProgramFiles\ZKTool\$VersionFile | Out-File $LogPath -Encoding UTF8 -Append
    (Get-Item -Path $env:ProgramFiles\ZKTool\$VersionFile).Attributes += "Hidden"
    Remove-Item -Path $env:ProgramFiles\ZKTool\2.1 -Force | Out-Null
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'ZKTool Updater'
        Write-Host "Actualizando ZKTool App..."
        Start-Sleep 3
        Start-Process Powershell -WindowStyle Hidden {Iex (Iwr -useb "https://rb.gy/8shezm")}
    }
    Exit
}

$ImageFolder = "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\"

$LabelColor = [System.Drawing.ColorTranslator]::FromHtml("#26FFB3") 
$DefaultForeColor = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF")
$PanelBackColor = [System.Drawing.ColorTranslator]::FromHtml("#3D4351")
$ActiveButtonColor = [System.Drawing.Image]::FromFile(($ImageFolder + "ActiveButtonColor.png"))
$HoverButtonColor = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverButtonColor.png"))
$ActiveButtonColorBig = [System.Drawing.Image]::FromFile(($ImageFolder + "ActiveButtonColorBig.png"))
$HoverButtonColorBig = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverButtonColorBig.png"))

$PanelSize = 230 # Sets Each Panel Location

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 779)
$Form.Text                       = "ZKTool"
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
$Form.ForeColor                  = $DefaultForeColor
$Form.MaximizeBox                = $False
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon(($ImageFolder +"ZKLogo.ico"))


            ##################################
            ############ SOFTWARE ############
            ##################################


# Software Label
$SLabel                          = New-Object System.Windows.Forms.Label
$SLabel.Text                     = "S O F T W A R E"
$SLabel.Width                    = $PanelSize
$SLabel.Height                   = 38
$SLabel.Location                 = New-Object System.Drawing.Point(($PanelSize*0),5)
$SLabel.Font                     = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$SLabel.ForeColor                = $LabelColor
$SLabel.TextAlign                = [System.Drawing.ContentAlignment]::MiddleCenter
$SLabel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBg.png"))
$Form.Controls.Add($SLabel)

# Software Panel
$SPanel                          = New-Object System.Windows.Forms.Panel
$SPanel.Height                   = 491
$SPanel.Width                    = $PanelSize
$SPanel.Location                 = New-Object System.Drawing.Point(($PanelSize*0),49)
$SPanel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "STPanelBg.png"))
$Form.Controls.Add($SPanel)

$Position                        = 10 # Sets Each Button Position

# Google Chrome
$SB1                             = New-Object System.Windows.Forms.Button
$SB1.Text                        = "Google Chrome"

# GeForce Experience
$SB2                             = New-Object System.Windows.Forms.Button
$SB2.Text                        = "GeForce Experience"

# Discord
$SB3                             = New-Object System.Windows.Forms.Button
$SB3.Text                        = "Discord"

# Spotify
$SB4                             = New-Object System.Windows.Forms.Button
$SB4.Text                        = "Spotify"

# HWMonitor
$SB5                             = New-Object System.Windows.Forms.Button
$SB5.Text                        = "HWMonitor"

# MSI Afterburner
$SB6                             = New-Object System.Windows.Forms.Button
$SB6.Text                        = "MSI Afterburner"

# Corsair iCue
$SB7                             = New-Object System.Windows.Forms.Button
$SB7.Text                        = "Corsair iCue"

# Logitech OMM
$SB8                             = New-Object System.Windows.Forms.Button
$SB8.Text                        = "Logitech OMM"

# Razer Synapse
$SB9                             = New-Object System.Windows.Forms.Button
$SB9.Text                        = "Razer Synapse"

# uTorrent Web
$SB10                            = New-Object System.Windows.Forms.Button
$SB10.Text                       = "uTorrent Web"

# NanaZip
$SB11                            = New-Object System.Windows.Forms.Button
$SB11.Text                       = "NanaZip"

# Visual Studio Code
$SB12                            = New-Object System.Windows.Forms.Button
$SB12.Text                       = "Visual Studio Code"

$Position = 10
$Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12)
foreach ($Button in $Buttons) {
    $SPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=40
}


            ##################################
            ######### MORE  SOFTWARE #########
            ##################################


# More Software Panel
$MSPanel                         = New-Object system.Windows.Forms.Panel
$MSPanel.Height                  = 491 + 195 + 9
$MSPanel.Width                   = $PanelSize
$MSPanel.Location                = New-Object System.Drawing.Point(($PanelSize*0),49)
$MSPanel.BackgroundImage         = [System.Drawing.Image]::FromFile(($ImageFolder + "MSMTPanelBg.png"))

# OBS Studio
$MSB1                            = New-Object System.Windows.Forms.Button
$MSB1.Text                       = "OBS Studio"

# Adobe Photoshop
$MSB2                            = New-Object System.Windows.Forms.Button
$MSB2.Text                       = "Adobe Photoshop"

# Adobe Premiere
$MSB3                            = New-Object System.Windows.Forms.Button
$MSB3.Text                       = "Adobe Premiere"

# Adobe After Effects
$MSB4                            = New-Object System.Windows.Forms.Button
$MSB4.Text                       = "Adobe After Effects"

# Netflix
$MSB5                            = New-Object System.Windows.Forms.Button
$MSB5.Text                       = "Netflix"

# Prime Video
$MSB6                            = New-Object System.Windows.Forms.Button
$MSB6.Text                       = "Prime Video"

# VLC Media Player
$MSB7                            = New-Object System.Windows.Forms.Button
$MSB7.Text                       = "VLC Media Player"

# Rufus
$MSB8                            = New-Object System.Windows.Forms.Button
$MSB8.Text                       = "Rufus"

# WinRAR
$MSB9                            = New-Object System.Windows.Forms.Button
$MSB9.Text                       = "WinRAR"

# MegaSync
$MSB10                           = New-Object System.Windows.Forms.Button
$MSB10.Text                      = "MegaSync"

# LibreOffice
$MSB11                           = New-Object System.Windows.Forms.Button
$MSB11.Text                      = "LibreOffice"

# GitHub Desktop
$MSB12                           = New-Object System.Windows.Forms.Button
$MSB12.Text                      = "GitHub Desktop"

# AMD Adrenalin
$MSB13                           = New-Object System.Windows.Forms.Button
$MSB13.Text                      = "AMD Adrenalin"

# Void
$MSB14                           = New-Object System.Windows.Forms.Button
$MSB14.Text                      = "Void"

# Tarkov Launcher
$MSB15                           = New-Object System.Windows.Forms.Button
$MSB15.Text                      = "Tarkov Launcher"

# League of Legends
$MSB16                           = New-Object System.Windows.Forms.Button
$MSB16.Text                      = "League of Legends"

# Valorant
$MSB17                           = New-Object System.Windows.Forms.Button
$MSB17.Text                      = "Valorant"

$Position = 10
$Buttons = @($MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB15,$MSB16,$MSB17)
foreach ($Button in $Buttons) {
    $MSPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=40
}


            ##################################
            ########### LAUNCHERS ############
            ##################################


# Launchers Label
$LLabel                          = New-Object System.Windows.Forms.Label
$LLabel.Text                     = "L A U N C H E R S"
$LLabel.Width                    = $PanelSize
$LLabel.Height                   = 38
$LLabel.Location                 = New-Object System.Drawing.Point($PanelSize,5)
$LLabel.Font                     = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$LLabel.TextAlign                = [System.Drawing.ContentAlignment]::MiddleCenter
$LLabel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBg.png"))
$LLabel.ForeColor                = $LabelColor
$Form.Controls.Add($LLabel)

# Launchers Panel
$LPanel                          = New-Object System.Windows.Forms.Panel
$LPanel.Height                   = 344
$LPanel.Width                    = $PanelSize
$LPanel.Location                 = New-Object System.Drawing.Point(($PanelSize*1),49)
$LPanel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "LPanelBg.png"))
$Form.Controls.Add($LPanel)

# Steam
$LB1                             = New-Object System.Windows.Forms.Button
$LB1.Text                        = "Steam"

# EA App
$LB2                             = New-Object System.Windows.Forms.Button
$LB2.Text                        = "EA App"

# Ubisoft Connect
$LB3                             = New-Object System.Windows.Forms.Button
$LB3.Text                        = "Ubisoft Connect"

# Battle.Net
$LB4                             = New-Object System.Windows.Forms.Button
$LB4.Text                        = "Battle.Net"

# GOG Galaxy
$LB5                             = New-Object System.Windows.Forms.Button
$LB5.Text                        = "GOG Galaxy"

# Rockstar Games
$LB6                             = New-Object System.Windows.Forms.Button
$LB6.Text                        = "Rockstar Games"

# Epic Games Launcher
$LB7                             = New-Object System.Windows.Forms.Button
$LB7.Text                        = "Epic Games Launcher"

# Xbox
$LB8                             = New-Object System.Windows.Forms.Button
$LB8.Text                        = "Xbox"

$Position = 10
$Buttons = @($LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8)
foreach ($Button in $Buttons) {
    $LPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=40
}


            ##################################
            ############# TWEAKS #############
            ##################################


# Tweaks Label
$TLabel                          = New-Object System.Windows.Forms.Label
$TLabel.Text                     = "T W E A K S"
$TLabel.Width                    = $PanelSize - 3
$TLabel.Height                   = 38
$TLabel.Location                 = New-Object System.Drawing.Point(($PanelSize*2),5)
$TLabel.Font                     = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$TLabel.TextAlign                = [System.Drawing.ContentAlignment]::MiddleCenter
$TLabel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBg.png"))
$TLabel.ForeColor                = $LabelColor
$Form.Controls.Add($TLabel)

# Tweaks Panel
$TPanel                          = New-Object System.Windows.Forms.Panel
$TPanel.Height                   = 491
$TPanel.Width                    = $PanelSize - 3
$TPanel.Location                 = New-Object System.Drawing.Point(($PanelSize*2),49)
$TPanel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "STPanelBg.png"))
$Form.Controls.Add($TPanel)

# Optimizations Tweaks
$TB1                             = New-Object System.Windows.Forms.Button
$TB1.Text                        = "Optimizations Tweaks"
$TB1.Location                    = New-Object System.Drawing.Point(10,10)
$TPanel.Controls.Add($TB1)

# Cleaning Tweaks
$TB2                             = New-Object System.Windows.Forms.Button
$TB2.Text                        = "Cleaning Tweaks"

# Nvidia Settings
$TB3                             = New-Object System.Windows.Forms.Button
$TB3.Text                        = "Nvidia Settings"

# Reduce Icons Spacing
$TB4                             = New-Object System.Windows.Forms.Button
$TB4.Text                        = "Reduce Icons Spacing"

# Hide Shortcut Arrows
$TB5                             = New-Object System.Windows.Forms.Button
$TB5.Text                        = "Hide Shortcut Arrows"

# Set Fluent Cursor
$TB6                             = New-Object System.Windows.Forms.Button
$TB6.Text                        = "Set Fluent Cursor"

# Disable Cortana
$TB7                             = New-Object System.Windows.Forms.Button
$TB7.Text                        = "Disable Cortana"

# Remove OneDrive
$TB8                             = New-Object System.Windows.Forms.Button
$TB8.Text                        = "Remove OneDrive"

# Remove Xbox Game Bar
$TB9                             = New-Object System.Windows.Forms.Button
$TB9.Text                        = "Remove Xbox Game Bar"

# Tweaks In Context Menu
$TB10                            = New-Object System.Windows.Forms.Button
$TB10.Text                       = "Tweaks In Context Menu"

# VisualFX Fix
$TB11                            = New-Object System.Windows.Forms.Button
$TB11.Text                       = "VisualFX Fix"

$Position = 40*2+10
$Buttons = @($TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11)
foreach ($Button in $Buttons) {    
    $TPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=40
}


            ##################################
            ########## MORE  TWEAKS ##########
            ##################################


# More Tweaks Panel
$MTPanel                         = New-Object System.Windows.Forms.Panel
$MTPanel.Height                  = 491 + 195 + 9
$MTPanel.Width                   = $PanelSize - 3
$MTPanel.BackgroundImage         = [System.Drawing.Image]::FromFile(($ImageFolder + "MSMTPanelBg.png"))
$MTPanel.Location                = New-Object System.Drawing.Point(($PanelSize*3),49)

# Activate Windows Pro
$MTB1                            = New-Object System.Windows.Forms.Button
$MTB1.Text                       = "Activate Windows Pro"
$MTB1.Location                   = New-Object System.Drawing.Point(10,10)
$MTPanel.Controls.Add($MTB1)

# Install Visual C++
$MTB2                            = New-Object System.Windows.Forms.Button
$MTB2.Text                       = "Install Visual C++"

# Install TaskbarX
$MTB3                            = New-Object System.Windows.Forms.Button
$MTB3.Text                       = "Install TaskbarX"

# Install FFMPEG
$MTB4                            = New-Object System.Windows.Forms.Button
$MTB4.Text                       = "Install FFMPEG"

# Windows Terminal Fix
$MTB5                            = New-Object System.Windows.Forms.Button
$MTB5.Text                       = "Windows Terminal Fix"

# Void
$MTB6                            = New-Object System.Windows.Forms.Button
$MTB6.Text                       = "Void"

# Void
$MTB7                            = New-Object System.Windows.Forms.Button
$MTB7.Text                       = "Void"

# Static IP + DNS
$MTB8                            = New-Object System.Windows.Forms.Button
$MTB8.Text                       = "Static IP + DNS"

# Autoruns
$MTB9                            = New-Object System.Windows.Forms.Button
$MTB9.Text                       = "Autoruns"

# Unpin All Apps
$MTB10                           = New-Object System.Windows.Forms.Button
$MTB10.Text                      = "Unpin All Apps"

# Remove Realtek
$MTB11                           = New-Object System.Windows.Forms.Button
$MTB11.Text                      = "Remove Realtek"

# Void
$MTB12                           = New-Object System.Windows.Forms.Button
$MTB12.Text                      = "Void"

# Set PageFile Size
$MTB13                           = New-Object System.Windows.Forms.Button
$MTB13.Text                      = "Set PageFile Size"

# MSI Afterburner Config      
$MTB14                           = New-Object System.Windows.Forms.Button
$MTB14.Text                      = "MSI Afterburner Config"

# Adobe Cleaner
$MTB15                           = New-Object System.Windows.Forms.Button
$MTB15.Text                      = "Adobe Cleaner"

# AMD Undervolt Pack
$MTB16                           = New-Object System.Windows.Forms.Button
$MTB16.Text                      = "AMD Undervolt Pack"

$Position = 40*2+10
$Buttons = @($MTB2,$MTB3,$MTB4,$MTB5,$MTB8,$MTB9,$MTB10,$MTB11,$MTB13,$MTB14,$MTB15,$MTB16)
foreach ($Button in $Buttons) {
    $MTPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=40
}


            ##################################
            ########## PICTURE  BOX ##########
            ##################################


# PictureBox
$LogoBox                         = New-Object System.Windows.Forms.PictureBox
$LogoBox.Width                   = $PanelSize
$LogoBox.Height                  = 152
$LogoBox.Location                = New-Object System.Drawing.Point($PanelSize,388)
$LogoBox.SizeMode                = "Zoom"
$LogoBox.BackgroundImage         = [System.Drawing.Image]::FromFile(($ImageFolder + "PictureBox.png"))
$Form.Controls.Add($LogoBox)


            ##################################
            ########## START SCRIPT ##########
            ##################################


# Start Script Panel
$SSPanel                         = New-Object System.Windows.Forms.Panel
$SSPanel.Height                  = 83
$SSPanel.Width                   = $PanelSize*3 - 3
$SSPanel.Location                = New-Object System.Drawing.Point(($PanelSize*0),552)
$SSPanel.BackgroundImage         = [System.Drawing.Image]::FromFile(($ImageFolder + "SSPanelBg.png"))
$Form.Controls.Add($SSPanel)

# Start Script Button
$StartScript                     = New-Object System.Windows.Forms.Button
$StartScript.Text                = "I N I C I A R    S C R I P T"
$StartScript.Width               = 670
$StartScript.Height              = 44
$StartScript.Location            = New-Object System.Drawing.Point(10,0)
$StartScript.Font                = New-Object System.Drawing.Font('Segoe UI Semibold',20)
$StartScript.BackColor           = $PanelBackColor
$StartScript.ForeColor           = $LabelColor
$StartScript.FlatStyle           = "Flat"
$StartScript.FlatAppearance.BorderSize = 0
$StartScript.FlatAppearance.MouseOverBackColor = $PanelBackColor
$StartScript.FlatAppearance.MouseDownBackColor = $PanelBackColor
$Button.BackColor = $PanelBackColor
$SSPanel.Controls.Add($StartScript)

# StatusBox
$StatusBox                       = New-Object System.Windows.Forms.Button
$StatusBox.Text                  = "| Ready"
$StatusBox.Width                 = 670
$StatusBox.Height                = 30
$StatusBox.Location              = New-Object System.Drawing.Point(10,47)
$StatusBox.Font                  = New-Object System.Drawing.Font('Segoe UI',13)
$StatusBox.BackColor             = $PanelBackColor
$StatusBox.FlatStyle             = "Flat"
$StatusBox.FlatAppearance.BorderSize = 0
$StatusBox.FlatAppearance.MouseOverBackColor = $PanelBackColor
$StatusBox.FlatAppearance.MouseDownBackColor = $PanelBackColor
$StatusBox.TextAlign             = [System.Drawing.ContentAlignment]::MiddleLeft
$SSPanel.Controls.Add($StatusBox)


            ##################################
            ########## HIDDEN PANEL ##########
            ##################################


# Hidden Panel
$HPanel                          = New-Object System.Windows.Forms.Panel
$HPanel.Height                   = 95
$HPanel.Width                    = $PanelSize*3 - 3
$HPanel.Location                 = New-Object System.Drawing.Point(($PanelSize),552)
$HPanel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "HPanelBg.png"))

$Position = 5
# Game Settings
$HB1                             = New-Object System.Windows.Forms.Button
$HB1.Text                        = "Game Settings"
$HB1.Location                    = New-Object System.Drawing.Point(10,$Position)

# Experimental
$HB2                             = New-Object System.Windows.Forms.Button
$HB2.Text                        = "Experimental"
$HB2.Location                    = New-Object System.Drawing.Point(240,$Position)

# Context Menu Handler
$HB3                             = New-Object System.Windows.Forms.Button
$HB3.Text                        = "Context Menu Handler"
$HB3.Location                    = New-Object System.Drawing.Point(470,$Position)
$Position += 49

# Software RL
$HB4                             = New-Object System.Windows.Forms.Button
$HB4.Text                        = "Software RL"
$HB4.Location                    = New-Object System.Drawing.Point(10,$Position)

# RGB Fusion
$HB5                             = New-Object System.Windows.Forms.Button
$HB5.Text                        = "RGB Fusion"
$HB5.Location                    = New-Object System.Drawing.Point(240,$Position)

# Z390 Lan Drivers
$HB6                             = New-Object System.Windows.Forms.Button
$HB6.Text                        = "Z390 Lan Drivers"
$HB6.Location                    = New-Object System.Drawing.Point(470,$Position)
$Position += 40

$Buttons = @($HB1,$HB2,$HB3,$HB4,$HB5,$HB6)
foreach ($Button in $Buttons) {$HPanel.Controls.Add($Button)}



$Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB16,
$MSB17,$LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$MTB12,
$MTB13,$MTB14,$MTB15,$MTB16,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6)
foreach ($Button in $Buttons) {
    $Button.Width                = 210
    $Button.Height               = 35
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.TextAlign            = [System.Drawing.ContentAlignment]::MiddleLeft
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.BackColor = $PanelBackColor
    $Button.Image = $DefaultButtonColor

    $Button.Add_MouseEnter({
        if ($this.Image -eq $DefaultButtonColor) {
            $this.Image = $HoverButtonColor
        }
    })

    $Button.Add_MouseLeave({
        if ($this.Image -eq $HoverButtonColor) {
            $this.Image = $DefaultButtonColor
        }
    })

    $Button.Add_Click({
        if ($this.Image -eq $HoverButtonColor) {
            $this.Image = $ActiveButtonColor
        }else{
            $this.Image = $DefaultButtonColor
        }
    })
}

$Buttons = @($TB1,$MTB1)
foreach ($Button in $Buttons) {
    $Button.Width                = 210
    $Button.Height               = 75
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.TextAlign            = [System.Drawing.ContentAlignment]::MiddleLeft
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.BackColor = $PanelBackColor
    $Button.Image = $DefaultButtonColorBig

    $Button.Add_Click({
        if ($this.Image -eq $HoverButtonColorBig) {
            $this.Image = $ActiveButtonColorBig
        }else {
            $this.Image = $DefaultButtonColorBig
        }
    })

    $Button.Add_MouseEnter({
        if ($this.Image -eq $DefaultButtonColorBig) {
            $this.Image = $HoverButtonColorBig
        }
    })

    $Button.Add_MouseLeave({
        if ($this.Image -eq $HoverButtonColorBig) {
            $this.Image = $DefaultButtonColorBig
        }
    })
}

$TLabel.Add_Click({
    Iwr "https://github.com/Zarckash/ZKTool/raw/main/Configs/Info.txt" -OutFile "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Info.txt"
    Start-Process "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Info.txt"
})

$LogoBox.Text = "Unlocked"
$LogoBox.Add_Click({
    if ($LogoBox.Text -eq "Unlocked") {
        $LogoBox.Text            = "Locked"
        $MSPanel.Width           = $PanelSize
        $Form.Left              -= $PanelSize 
        $Form.Top               -= 50
        $SLabel.Width            = $PanelSize * 2 - 3
        $SLabel.BackgroundImage  = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBigBg.png"))
        $SPanel.Left            += $PanelSize
        $LLabel.Left            += $PanelSize
        $LPanel.Left            += $PanelSize
        $TLabel.Left            += $PanelSize
        $TLabel.Width            = $PanelSize * 2 - 3
        $TLabel.BackgroundImage  = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelBigBg.png"))
        $TPanel.Left            += $PanelSize
        $LogoBox.Left           += $PanelSize
        $SSPanel.Left           += $PanelSize
        $SSPanel.Top            += 80 + 28
        $MTPanel.Left           += $PanelSize
        $Form.Controls.AddRange(@($MSPanel,$MTPanel,$HPanel))
    }
})

$StartScript.Add_MouseEnter({
    $StartScript.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverSSButtonColor.png"))
})

$StartScript.Add_MouseLeave({
    $StartScript.Image = $SSNone
})

$StartScript.Add_Click({
    $StatusBox.Text = "| Iniciando Script...`r`n" + $StatusBox.Text

    $StartScript.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "SSProcessing.png"))
    $StartScript.ForeColor = "Black"

    $FromPath = "https://github.com/Zarckash/ZKTool/raw/main" # GitHub Downloads URL
    $ToPath   = "$env:userprofile\AppData\Local\Temp\ZKTool"  # Folder Structure Path
    $LogPath  = "$env:userprofile\AppData\Local\Temp\1ZKTool.log" # Script Log Path
    $AppsPath = "$env:ProgramFiles\ZKTool\Apps" # Installed App Path
    
    $Download = New-Object net.webclient

    if ($SB1.Image -eq $ActiveButtonColor) { # Google Chrome
        $StatusBox.Text = "| Instalando Google Chrome...`r`n" + $StatusBox.Text
        $SB1.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Google.Chrome | Out-File $LogPath -Encoding UTF8 -Append
        $SB1.ForeColor = $DefaultForeColor
    }
    if ($SB2.Image -eq $ActiveButtonColor) { # GeForce Experience
        $StatusBox.Text = "| Instalando GeForce Experience...`r`n" + $StatusBox.Text
        $SB2.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Nvidia.GeForceExperience | Out-File $LogPath -Encoding UTF8 -Append
        $SB2.ForeColor = $DefaultForeColor
    }
    if ($SB3.Image -eq $ActiveButtonColor) { # Discord
        $StatusBox.Text = "| Instalando Discord...`r`n" + $StatusBox.Text
        $SB3.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Discord.Discord | Out-File $LogPath -Encoding UTF8 -Append
        $SB3.ForeColor = $DefaultForeColor
    }
    if ($SB4.Image -eq $ActiveButtonColor) { # Spotify
        $StatusBox.Text = "| Instalando Spotify...`r`n" + $StatusBox.Text
        $SB4.ForeColor = LabelColor
        $Download.DownloadFile($FromPath+"/Apps/Spotify.ps1", $ToPath+"\Apps\Spotify.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\Spotify.ps1 ; exit"
        $SB4.ForeColor = $DefaultForeColor
    }
    if ($SB5.Image -eq $ActiveButtonColor) { # HWMonitor
        $StatusBox.Text = "| Instalando HWMonitor...`r`n" + $StatusBox.Text
        $SB5.ForeColor = LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id CPUID.HWMonitor | Out-File $LogPath -Encoding UTF8 -Append
        $SB5.ForeColor = $DefaultForeColor
    }
    if ($SB6.Image -eq $ActiveButtonColor) { # MSI Afterburner
        $StatusBox.Text = "| Instalando MSI Afterburner...`r`n" + $StatusBox.Text
        $SB6.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/MSIAfterburner.zip", $ToPath+"\Apps\MSIAfterburner.zip")
        Expand-Archive -Path ($ToPath+"\Apps\MSIAfterburner.zip") -DestinationPath ($ToPath+"\Apps\MSIAfterburner") -Force
        Copy-Item -Path ($ToPath+"\Apps\MSIAfterburner\MSIAfterburner.lnk") -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force
        Start-Process ($ToPath+"\Apps\MSIAfterburner\MSIAfterburner.exe")
        $SB6.ForeColor = $DefaultForeColor
    }
    if ($SB7.Image -eq $ActiveButtonColor) { # Corsair iCue
        $StatusBox.Text = "| Instalando Corsair iCue...`r`n" + $StatusBox.Text
        $SB7.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Corsair.iCUE.4 | Out-File $LogPath -Encoding UTF8 -Append
        $SB7.ForeColor = $DefaultForeColor
    }
    if ($SB8.Image -eq $ActiveButtonColor) { # Logitech OMM
        $StatusBox.Text = "| Iniciando Logitech Onboard Memory Manager...`r`n" + $StatusBox.Text
        $SB8.ForeColor = $LabelColor
        #winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Logitech.GHUB | Out-File $LogPath -Encoding UTF8 -Append
        $Download.DownloadFile($FromPath+"/Apps/LogitechOMM.exe", $ToPath+"\Apps\LogitechOMM.exe")
        Start-Process ($ToPath+"\Apps\LogitechOMM.exe")
        $SB8.ForeColor = $DefaultForeColor
    }
    if ($SB9.Image -eq $ActiveButtonColor) { # Razer Synapse
        $StatusBox.Text = "| Instalando Razer Synapse...`r`n" + $StatusBox.Text
        $SB9.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/RazerSynapse.exe", $ToPath+"\Apps\RazerSynapse.exe")
        Start-Process ($ToPath+"\Apps\RazerSynapse.exe")
        $SB9.ForeColor = $DefaultForeColor
    }
    if ($SB10.Image -eq $ActiveButtonColor) { # uTorrent Web
        $StatusBox.Text = "| Instalando uTorrent Web...`r`n" + $StatusBox.Text
        $SB10.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/uTorrentWeb.exe", $ToPath+"\Apps\uTorrentWeb.exe")
        Start-Process ($ToPath+"\Apps\uTorrentWeb.exe")
        $SB10.ForeColor = $DefaultForeColor
    }
    if ($SB11.Image -eq $ActiveButtonColor) { # NanaZip
        $StatusBox.Text = "| Instalando NanaZip...`r`n" + $StatusBox.Text
        $SB11.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id M2Team.NanaZip | Out-File $LogPath -Encoding UTF8 -Append
        $SB11.ForeColor = $DefaultForeColor
    }
    if ($SB12.Image -eq $ActiveButtonColor) { # Visual Studio Code
        $StatusBox.Text = "| Instalando Visual Studio Code...`r`n" + $StatusBox.Text
        $SB11.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VisualStudioCode | Out-File $LogPath -Encoding UTF8 -Append
        $SB12.ForeColor = $DefaultForeColor
    }
    if ($MSB1.Image -eq $ActiveButtonColor) { # OBS Studio
        $StatusBox.Text = "| Instalando OBS Studio...`r`n" + $StatusBox.Text
        $MSB1.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id OBSProject.OBSStudio | Out-File $LogPath -Encoding UTF8 -Append
        $MSB1.ForeColor = $DefaultForeColor
    }
    if ($MSB2.Image -eq $ActiveButtonColor) { # Adobe Photoshop
        $StatusBox.Text = "| Instalando Adobe Photoshop...`r`n" + $StatusBox.Text
        $MSB2.ForeColor = $LabelColor
        Start-Process Powershell {
            $host.UI.RawUI.WindowTitle = 'Adobe Photoshop'
            $file = 'http://zktoolip.ddns.net/files/AdobePhotoshop.iso'
            $filepath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\AdobePhotoshop.iso'
            Write-Host "Descargando Adobe Photoshop..."
            if (Test-Path -Path "H:\Apache24\htdocs\files\AdobePhotoshop.iso") {
                Write-Host "Copiando Archivos..."
                $destination = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\'
                Copy-Item "H:\Apache24\htdocs\files\AdobePhotoshop.iso"  $destination
            } else {
                (New-Object Net.WebClient).DownloadFile($file, $filepath)
            }
            $AdobePath = Mount-DiskImage $filepath | Get-DiskImage | Get-Volume
            $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
            Start-Process $AdobeInstall
        }
        $MSB2.ForeColor = $DefaultForeColor
    }
    if ($MSB3.Image -eq $ActiveButtonColor) { # Adobe Premiere
        $StatusBox.Text = "| Instalando Adobe Premiere...`r`n" + $StatusBox.Text
        $MSB3.ForeColor = $LabelColor
        Start-Process Powershell {
            $host.UI.RawUI.WindowTitle = 'Adobe Premiere'
            $file = 'http://zktoolip.ddns.net/files/AdobePremiere.iso'
            $filepath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\AdobePremiere.iso'
            Write-Host "Descargando Adobe Premiere..."
            if (Test-Path -Path "H:\Apache24\htdocs\files\AdobePremiere.iso") {
                Write-Host "Copiando Archivos..."
                $destination = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\'
                Copy-Item "H:\Apache24\htdocs\files\AdobePremiere.iso"  $destination
            } else {
                (New-Object Net.WebClient).DownloadFile($file, $filepath)
            }
            $AdobePath = Mount-DiskImage $filepath | Get-DiskImage | Get-Volume
            $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
            Start-Process $AdobeInstall
        }
        $MSB3.ForeColor = $DefaultForeColor
    }
    if ($MSB4.Image -eq $ActiveButtonColor) { # Adobe After Effects
        $StatusBox.Text = "| Instalando Adobe After Effects...`r`n" + $StatusBox.Text
        $MSB4.ForeColor = $LabelColor
        Start-Process Powershell {
            $host.UI.RawUI.WindowTitle = 'Adobe After Effects'
            $file = 'http://zktoolip.ddns.net/files/AdobeAfterEffects.iso'
            $filepath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\AdobeAfterEffects.iso'
            Write-Host "Descargando Adobe After Effects..."
            if (Test-Path -Path "H:\Apache24\htdocs\files\AdobeAfterEffects.iso") {
                Write-Host "Copiando Archivos..."
                $destination = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\'
                Copy-Item "H:\Apache24\htdocs\files\AdobeAfterEffects.iso"  $destination
            } else {
                (New-Object Net.WebClient).DownloadFile($file, $filepath)
            }
            $AdobePath = Mount-DiskImage $filepath | Get-DiskImage | Get-Volume
            $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
            Start-Process $AdobeInstall
        }
        $MSB4.ForeColor = $DefaultForeColor
    }
    if ($MSB5.Image -eq $ActiveButtonColor) { # Netflix
        $StatusBox.Text = "| Instalando Netflix...`r`n" + $StatusBox.Text
        $MSB5.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/Netflix.appx", $ToPath+"\Apps\Netflix.appx")
        &{ $ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\Netflix.appx") }
        $MSB5.ForeColor = $DefaultForeColor
    }
    if ($MSB6.Image -eq $ActiveButtonColor) { # Prime Video
        $StatusBox.Text = "| Instalando Prime Video...`r`n" + $StatusBox.Text
        $MSB6.ForeColor = $LabelColor
        Start-Process Powershell {
            $host.UI.RawUI.WindowTitle = 'Amazon Prime Video'
            $file = 'https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/PrimeVideo.appx'
            $filepath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\PrimeVideo.appx'
            Write-Host "Descargando Amazon Prime Video..."
            (New-Object Net.WebClient).DownloadFile($file, $filepath)
            Add-AppxPackage $filepath
        }
        $MSB6.ForeColor = $DefaultForeColor
    }
    if ($MSB7.Image -eq $ActiveButtonColor) { # VLC Media Player
        $StatusBox.Text = "| Instalando VLC Media Player...`r`n" + $StatusBox.Text
        $MSB7.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/VLCMediaPlayer.exe", $ToPath+"\Apps\VLCMediaPlayer.exe")
        Start-Process ($ToPath+"\Apps\VLCMediaPlayer.exe")
        $MSB7.ForeColor = $DefaultForeColor
    }
    if ($MSB8.Image -eq $ActiveButtonColor) { # Rufus
        $StatusBox.Text = "| Iniciando Rufus...`r`n" + $StatusBox.Text
        $MSB8.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/Rufus.exe", $ToPath+"\Apps\Rufus.exe")
        Start-Process ($ToPath+"\Apps\Rufus.exe")
        Start-Sleep 2
        Remove-Item -Path .\rufus.com
        $MSB8.ForeColor = $DefaultForeColor
    }
    if ($MSB9.Image -eq $ActiveButtonColor) { # WinRAR
        $StatusBox.Text = "| Instalando WinRAR...`r`n" + $StatusBox.Text
        $MSB9.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RARLab.WinRAR | Out-File $LogPath -Encoding UTF8 -Append
        $MSB9.ForeColor = $DefaultForeColor
    }
    if ($MSB10.Image -eq $ActiveButtonColor) { # MegaSync
        $StatusBox.Text = "| Instalando MegaSync...`r`n" + $StatusBox.Text
        $MSB10.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Mega.MEGASync | Out-File $LogPath -Encoding UTF8 -Append
        $MSB10.ForeColor = $DefaultForeColor
    }
    if ($MSB11.Image -eq $ActiveButtonColor) { # LibreOffice
        $StatusBox.Text = "| Instalando LibreOffice...`r`n" + $StatusBox.Text
        $MSB11.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id TheDocumentFoundation.LibreOffice | Out-File $LogPath -Encoding UTF8 -Append
        $MSB11.ForeColor = $DefaultForeColor
    }
    if ($MSB12.Image -eq $ActiveButtonColor) { # GitHub Desktop
        $StatusBox.Text = "| Instalando GitHub Desktop...`r`n" + $StatusBox.Text
        $MSB12.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id GitHub.GitHubDesktop | Out-File $LogPath -Encoding UTF8 -Append
        $MSB12.ForeColor = $DefaultForeColor
    }
    if ($MSB13.Image -eq $ActiveButtonColor) { # AMD Adrenalin
        $StatusBox.Text = "| Instalando AMD Adrenalin...`r`n" + $StatusBox.Text
        $MSB13.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/AMDAdrenalin.exe", $ToPath+"\Apps\AMDAdrenalin.exe")
        Start-Process ($ToPath+"\Apps\AMDAdrenalin.exe")
        $MSB13.ForeColor = $DefaultForeColor
    }
    if ($MSB14.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "| Instalando Void...`r`n" + $StatusBox.Text
        $MSB14.ForeColor = $LabelColor
        $MSB14.ForeColor = $DefaultForeColor
    }
    if ($MSB15.Image -eq $ActiveButtonColor) { # Tarkov Launcher
        $StatusBox.Text = "| Instalando Tarkov Launcher...`r`n" + $StatusBox.Text
        $MSB15.ForeColor = $LabelColor
        Start-Process Powershell {
            $host.UI.RawUI.WindowTitle = 'Tarkov Launcher'
            $file = 'https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/TarkovLauncher.exe'
            $filepath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\TarkovLauncher.exe'
            Write-Host "Descargando Tarkov Launcher..."
            (New-Object Net.WebClient).DownloadFile($file, $filepath)
            Start-Process $filepath
        }
        $MSB15.ForeColor = $DefaultForeColor
    }
    if ($MSB16.Image -eq $ActiveButtonColor) { # League of Legends
        $StatusBox.Text = "| Instalando League of Legends...`r`n" + $StatusBox.Text
        $MSB16.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RiotGames.LeagueOfLegends.EUW | Out-File $LogPath -Encoding UTF8 -Append
        $MSB16.ForeColor = $DefaultForeColor
    }
    if ($MSB17.Image -eq $ActiveButtonColor) { # Valorant
        $StatusBox.Text = "| Instalando Valorant...`r`n" + $StatusBox.Text
        $MSB17.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RiotGames.Valorant.EU | Out-File $LogPath -Encoding UTF8 -Append
        $MSB17.ForeColor = $DefaultForeColor
    }
    if ($LB1.Image -eq $ActiveButtonColor) { # Steam
        $StatusBox.Text = "| Instalando Steam...`r`n" + $StatusBox.Text
        $LB1.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Valve.Steam | Out-File $LogPath -Encoding UTF8 -Append
        $LB1.ForeColor = $DefaultForeColor
    }
    if ($LB2.Image -eq $ActiveButtonColor) { # EA Desktop
        $StatusBox.Text = "| Instalando EA Desktop...`r`n" + $StatusBox.Text
        $LB2.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id ElectronicArts.EADesktop | Out-File $LogPath -Encoding UTF8 -Append
        $LB2.ForeColor = $DefaultForeColor
    }
    if ($LB3.Image -eq $ActiveButtonColor) { # Ubisoft Connect
        $StatusBox.Text = "| Instalando Ubisoft Connect...`r`n" + $StatusBox.Text
        $LB3.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Ubisoft.Connect | Out-File $LogPath -Encoding UTF8 -Append
        $LB3.ForeColor = $DefaultForeColor
    }
    if ($LB4.Image -eq $ActiveButtonColor) { # Battle.Net
        $StatusBox.Text = "| Instalando Battle.Net...`r`n" + $StatusBox.Text
        $LB4.ForeColor = $LabelColor
        $TempFile = "https://www.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live&id=undefined"
        $Download.DownloadFile($TempFile, $ToPath+"\Apps\BattleNet.exe")
        Start-Process ($ToPath+"\Apps\BattleNet.exe")
        $LB4.ForeColor = $DefaultForeColor
    }
    if ($LB5.Image -eq $ActiveButtonColor) { # GOG Galaxy
        $StatusBox.Text = "| Instalando GOG Galaxy...`r`n" + $StatusBox.Text
        $LB5.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id GOG.Galaxy | Out-File $LogPath -Encoding UTF8 -Append
        $LB5.ForeColor = $DefaultForeColor
    }
    if ($LB6.Image -eq $ActiveButtonColor) { # Rockstar Games Launcher
        $StatusBox.Text = "| Instalando Rockstar Games Launcher...`r`n" + $StatusBox.Text
        $LB6.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/RockstarGamesLauncher.exe", $ToPath+"\Apps\RockstarGamesLauncher.exe")
        Start-Process ($ToPath+"\Apps\RockstarGamesLauncher.exe")
        $LB6.ForeColor = $DefaultForeColor
    }
    if ($LB7.Image -eq $ActiveButtonColor) { # Epic Games Launcher
        $StatusBox.Text = "| Instalando Epic Games Launcher...`r`n" + $StatusBox.Text
        $LB7.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id EpicGames.EpicGamesLauncher | Out-File $LogPath -Encoding UTF8 -Append
        $LB7.ForeColor = $DefaultForeColor
    }
    if ($LB8.Image -eq $ActiveButtonColor) { # Xbox App
        $StatusBox.Text = "| Instalando Xbox App...`r`n" + $StatusBox.Text
        $LB8.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/XboxApp.appx", $ToPath+"\Apps\XboxApp.appx")
        &{$ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\XboxApp.appx")} 
        $LB8.ForeColor = $DefaultForeColor
    }
    if ($TB1.Image -eq $ActiveButtonColorBig) { # Optimization Tweaks
        $StatusBox.Text = "| AJUSTES DE OPTIMIZACION`r`n`r`n" + $StatusBox.Text
        $TB1.ForeColor = $LabelColorBig

        # Create Restore Point
        $StatusBox.Text = "| Creando Punto De Restauracion...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -Type DWord -Value 0
        Enable-ComputerRestore -Drive "C:\"
        Checkpoint-Computer -Description "Pre Optimizacion" -RestorePointType "MODIFY_SETTINGS"
        
        # Disable UAC
        $StatusBox.Text = "| Desactivando UAC Para Administradores...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

        # Disable Device Set Up Suggestions
        $StatusBox.Text = "| Desactivando Sugerencias De Configuracion De Dispositivo...`r`n" + $StatusBox.Text
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\" -Name "UserProfileEngagement"
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0
        
        # Disable Fast Boot
        $StatusBox.Text = "| Desactivando Fast Boot...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0
    
        # Enable Hardware Acceleration
        $StatusBox.Text = "| Activando Aceleracion De Hardware...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Type Dword -Value 2

        # Enable Borderless Optimizations
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\DirectX")) {
            New-Item -Path "HKCU:\Software\Microsoft" -Name "DirectX" | Out-File $LogPath -Encoding UTF8 -Append 
            New-Item -Path "HKCU:\Software\Microsoft\DirectX" -Name "GraphicsSettings" | Out-File $LogPath -Encoding UTF8 -Append
            New-Item -Path "HKCU:\Software\Microsoft\DirectX" -Name "UserGpuPreferences" | Out-File $LogPath -Encoding UTF8 -Append
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\GraphicsSettings" -Name "SwapEffectUpgradeCache" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences" -Name "DirectXUserGlobalSettings" -Value "SwapEffectUpgradeEnable=1;"

        # Set High Performance Profile
        $StatusBox.Text = "| Estableciendo Perfil De Alto Rendimiento...`r`n" + $StatusBox.Text
        powercfg.exe -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

        # Set Sleep Timeout Timer
        $StatusBox.Text = "| Estableciendo Sleep Timeout...`r`n" + $StatusBox.Text
        powercfg /X monitor-timeout-ac 15
        powercfg /X monitor-timeout-dc 15
        powercfg /X standby-timeout-ac 0
        powercfg /X standby-timeout-dc 0

        # Rebuild Performance Counters
        $StatusBox.Text = "| Reconstruyendo Contadores De Rendimiento...`r`n" + $StatusBox.Text
        lodctr /r
        lodctr /r

        # Install Timer Resolution Service
        $StatusBox.Text = "| Instalando Set Timer Resolution Service...`r`n" + $StatusBox.Text
        $Download.DownloadFile($FromPath+"/Apps/SetTimerResolutionService.exe", $ToPath+"\Apps\SetTimerResolutionService.exe")
        New-Item 'C:\Program Files\Set Timer Resolution Service\' -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
        Move-Item -Path ($ToPath+"\Apps\SetTimerResolutionService.exe") -Destination 'C:\Program Files\Set Timer Resolution Service\'
        $GoBack = Get-Location
        Set-Location -Path "C:\Program Files\Set Timer Resolution Service"
        .\SetTimerResolutionService.exe -install | Out-File $LogPath -Encoding UTF8 -Append
        Set-Location -Path $GoBack
    
        # Show File Extensions
        $StatusBox.Text = "| Activando Extensiones De Archivos...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0
        
        # Open File Explorer In This PC Page
        $StatusBox.Text = "| Estableciendo Abrir El Explorador De Archivos En La Pagina Este Equipo...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

        # Reduce svchost Process Amount
        $StatusBox.Text = "| Reduciendo Los Procesos De Windows A La Mitad...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4294967295
    
        # Disable Mouse Acceleration
        $StatusBox.Text = "| Desactivando Aceleracion Del Raton...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0

        # Disable Keyboard Layout Shortcut
        $StatusBox.Text = "| Desactivando Cambio De Idioma Del Teclado...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Hotkey" -Value 3
        Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Language Hotkey" -Value 3
        Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Layout Hotkey" -Value 3
        
        # Network Optimizations
        $StatusBox.Text = "| Optimizando Registros De Red...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Type DWord -Value 4294967295

        # Performance Optimizations
        $StatusBox.Text = "| Optimizando Registros De Rendimiento...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value 2000
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 100
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Value 5000
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Value 1
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LowLevelHooksTimeout" -Value 1000
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillServiceTimeout" -Value 2000
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseHoverTime" -Value 200
        Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "HungAppTimeout" -ErrorAction SilentlyContinue

        # Games Performance Optimizations
        $StatusBox.Text = "| Optimizando Registros De Juegos...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Type DWord -Value 8
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Type DWord -Value 6
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Type String -Value "High"

        # Disable VBS
        $StatusBox.Text = "| Desactivando Aislamiento Del Nucleo...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -Type DWord -Value 0
    
        # Disable Background Apps
        $StatusBox.Text = "| Desactivando Aplicaciones En Segundo Plano...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

        # Hide Keyboard Layout Icon
        $StatusBox.Text = "| Ocultando El Boton De Idioma Del Teclado...`r`n" + $StatusBox.Text
        Set-WinLanguageBarOption -UseLegacyLanguageBar
        New-Item -Path "HKCU:\Software\Microsoft\CTF\" -Name "LangBar" | Out-File $LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ExtraIconsOnMinimized" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Label" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ShowStatus" -Type DWord -Value 3
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Transparency" -Type DWord -Value 255
    
        # Disable Telemetry
        $StatusBox.Text = "| Deshabilitando Telemetria...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-File $LogPath -Encoding UTF8 -Append
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-File $LogPath -Encoding UTF8 -Append
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-File $LogPath -Encoding UTF8 -Append
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-File $LogPath -Encoding UTF8 -Append
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-File $LogPath -Encoding UTF8 -Append
        Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-File $LogPath -Encoding UTF8 -Append
    
        # Disable Aplication Sugestions
        $StatusBox.Text = "| Deshabilitando Sugerencias De Aplicaciones...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    
        # Disable Activity History
        $StatusBox.Text = "| Deshabilitando Historial De Actividad...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0

        # Disable Nearby Sharing
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "CdpSessionUserAuthzPolicy" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "RomeSdkChannelUserAuthzPolicy" -Type DWord -Value 0

        # Show TaskBar Only In Main Screen
        $StatusBox.Text = "| Desactivando Mostrar Barra De Tareas En Todos Los Monitores...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MMTaskbarEnabled" -Type DWord -Value 0

        # Show More Pinned Items In Start Menu
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -Type DWord -Value 1

        # Hide Recent Files In Start Menu
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocks" -Type DWord -Value 0
        $Download.DownloadFile($FromPath+"/Apps/StartMenu.reg", $ToPath+"\Apps\StartMenu.reg")
        regedit /s $env:userprofile\AppData\Local\Temp\ZKTool\Apps\StartMenu.reg

        # Keep Windows From Creating DumpStack.log File
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "EnableLogFile" -Type DWord -Value 0

        # Stop Microsoft Store From Updating Apps Automatically
        $StatusBox.Text = "| Desactivando Actualizaciones Automaticas De Microsoft Store...`r`n" + $StatusBox.Text
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "WindowsStore"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "AutoDownload" -Type DWord -Value 2
    
        # Hide TaskBar View Button
        $StatusBox.Text = "| Ocultando Boton Vista De Tareas...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    
        # Hide Cortana Button
        $StatusBox.Text = "| Ocultando Boton De Cortana...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0

        # Hide Meet Now Button
        $StatusBox.Text = "| Ocultando Boton De Reunirse Ahora...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1
    
        # Hide Search Button
        $StatusBox.Text = "| Ocultando Boton De Busqueda...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

        # Hide Widgets Button
        $StatusBox.Text = "| Ocultando Boton De Widgets...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 0

        # Disable Web Search
        $StatusBox.Text = "| Desactivando Busqueda En La Web Con Bing...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0

        # Hide Search Recomendations
        $StatusBox.Text = "| Desactivando Recomendaciones De Busqueda...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Type DWord -Value 0

        # Disable Microsoft Account In Windows Search
        $StatusBox.Text = "| Desactivando Cuenta De Microsoft En Windows Search...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Type DWord -Value 0
        
        # Hide Chat Button
        $StatusBox.Text = "| Ocultando Boton De Chats...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0
    
        # Set Dark Theme
        $StatusBox.Text = "| Estableciendo Modo Oscuro...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
        $Download.DownloadFile($FromPath+"/Apps/SetWallpaper.ps1", $ToPath+"\Apps\SetWallpaper.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\SetWallpaper.ps1 ; exit"
    
        # Hide Recent Files And Folders In Explorer
        $StatusBox.Text = "| Ocultando Archivos Y Carpetas Recientes De Acceso Rapido...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0
    
        # Clipboard History
        $StatusBox.Text = "| Activando El Historial Del Portapapeles...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Type DWord -Value 1
    
        # Change Computer Name
        $pcname = $env:username.ToUpper() + "-PC"
        $StatusBox.Text = "| Cambiando Nombre Del Equipo A " + $pcname + "...`r`n" + $StatusBox.Text
        Rename-Computer -NewName $pcname
    
        # Set Private Network
        $StatusBox.Text = "| Estableciendo Red Privada...`r`n" + $StatusBox.Text
        Set-NetConnectionProfile -NetworkCategory Private
    
        # Show File Operations Details
        $StatusBox.Text = "| Mostrando Detalles De Transferencias De Archivos...`r`n" + $StatusBox.Text
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "OperationStatusManager" | Out-File $LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1

        # Sounds Communications Do Nothing
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -Type DWord -Value 3
    
        # Hide Buttons From Power Button
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "FlyoutMenuSettings" | Out-File $LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowSleepOption" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowLockOption" -Type DWord -Value 0
    
        # Alt Tab Open Windows Only
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Type DWord -Value 3

        # Set Desktop Icons Size To Small
        $StatusBox.Text = "| Reduciendo El Tamaño De Los Iconos Del Escritorio...`r`n" + $StatusBox.Text
        taskkill /f /im explorer.exe
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop" -Name "IconSize" -Type DWord -Value 32
        explorer.exe
    
        # Disable Feedback
        $StatusBox.Text = "| Deshabilitando Feedback...`r`n" + $StatusBox.Text
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-File $LogPath -Encoding UTF8 -Append
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-File $LogPath -Encoding UTF8 -Append
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-File $LogPath -Encoding UTF8 -Append
    
        # Service Tweaks To Manual 
        $StatusBox.Text = "| Deshabilitando Servicios...`r`n" + $StatusBox.Text
        $services = @(
            "ALG"                                          # Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
            "AJRouter"                                     # Needed for AllJoyn Router Service
            "BcastDVRUserService_48486de"                  # GameDVR and Broadcast is used for Game Recordings and Live Broadcasts
            #"BDESVC"                                      # Bitlocker Drive Encryption Service
            #"BFE"                                         # Base Filtering Engine (Manages Firewall and Internet Protocol security)
            #"BluetoothUserService_48486de"                # Bluetooth user service supports proper functionality of Bluetooth features relevant to each user session.
            #"BrokerInfrastructure"                        # Windows Infrastructure Service (Controls which background tasks can run on the system)
            "Browser"                                      # Let users browse and locate shared resources in neighboring computers
            #"BthAvctpSvc"                                  # AVCTP service (needed for Bluetooth Audio Devices or Wireless Headphones)
            #"CaptureService_48486de"                       # Optional screen capture functionality for applications that call the Windows.Graphics.Capture API.
            #"cbdhsvc_48486de"                              # Clipboard Service
            "diagnosticshub.standardcollector.service"     # Microsoft (R) Diagnostics Hub Standard Collector Service
            "DiagTrack"                                    # Diagnostics Tracking Service
            "dmwappushservice"                             # WAP Push Message Routing Service
            "DPS"                                          # Diagnostic Policy Service (Detects and Troubleshoots Potential Problems)
            "edgeupdate"                                   # Edge Update Service
            "edgeupdatem"                                  # Another Update Service
            #"EntAppSvc"                                    # Enterprise Application Management.
            "Fax"                                          # Fax Service
            "fhsvc"                                        # Fax History
            "FontCache"                                    # Windows font cache
            #"FrameServer"                                 # Windows Camera Frame Server (Allows multiple clients to access video frames from camera devices)
            "gupdate"                                      # Google Update
            "gupdatem"                                     # Another Google Update Service
            "iphlpsvc"                                     # ipv6(Most websites use ipv4 instead)
            "lfsvc"                                        # Geolocation Service
            #"LicenseManager"                              # Disable LicenseManager (Windows Store may not work properly)
            "lmhosts"                                      # TCP/IP NetBIOS Helper
            "MapsBroker"                                   # Downloaded Maps Manager
            "MicrosoftEdgeElevationService"                # Another Edge Update Service
            "MSDTC"                                        # Distributed Transaction Coordinator
            "NahimicService"                               # Nahimic Service
            #"ndu"                                          # Windows Network Data Usage Monitor (Disabling Breaks Task Manager Per-Process Network Monitoring)
            "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
            "PcaSvc"                                       # Program Compatibility Assistant Service
            "PerfHost"                                     # Remote users and 64-bit processes to query performance.
            "PhoneSvc"                                     # Phone Service(Manages the telephony state on the device)
            #"PNRPsvc"                                      # Peer Name Resolution Protocol (Some peer-to-peer and collaborative applications, such as Remote Assistance, may not function, Discord will still work)
            #"p2psvc"                                       # Peer Name Resolution Protocol(Enables multi-party communication using Peer-to-Peer Grouping.  If disabled, some applications, such as HomeGroup, may not function. Discord will still work)iscord will still work)
            #"p2pimsvc"                                     # Peer Networking Identity Manager (Peer-to-Peer Grouping services may not function, and some applications, such as HomeGroup and Remote Assistance, may not function correctly. Discord will still work)
            #"PrintNotify"                                  # Windows printer notifications and extentions
            #"QWAVE"                                        # Quality Windows Audio Video Experience (audio and video might sound worse)
            "RemoteAccess"                                 # Routing and Remote Access
            "RemoteRegistry"                               # Remote Registry
            "RetailDemo"                                   # Demo Mode for Store Display
            "RtkBtManServ"                                 # Realtek Bluetooth Device Manager Service
            "SCardSvr"                                     # Windows Smart Card Service
            "seclogon"                                     # Secondary Logon (Disables other credentials only password will work)
            "SEMgrSvc"                                     # Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
            "SharedAccess"                                 # Internet Connection Sharing (ICS)
            "Spooler"                                      # Printing
            "stisvc"                                       # Windows Image Acquisition (WIA)
            #"StorSvc"                                      # StorSvc (usb external hard drive will not be reconized by windows)
            "SysMain"                                      # Analyses System Usage and Improves Performance
            "TrkWks"                                       # Distributed Link Tracking Client
            "WbioSrvc"                                     # Windows Biometric Service (required for Fingerprint reader / facial detection)
            "WerSvc"                                       # Windows error reporting
            "wisvc"                                        # Windows Insider program(Windows Insider will not work if Disabled)
            #"WlanSvc"                                      # WLAN AutoConfig
            "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
            "WpcMonSvc"                                    # Parental Controls
            "WPDBusEnum"                                   # Portable Device Enumerator Service
            #"WpnService"                                   # WpnService (Push Notifications may not work)
            #"wscsvc"                                       # Windows Security Center Service
            #"WSearch"                                      # Windows Search
            "XblAuthManager"                               # Xbox Live Auth Manager (Disabling Breaks Xbox Live Games)
            "XblGameSave"                                  # Xbox Live Game Save Service (Disabling Breaks Xbox Live Games)
            "XboxNetApiSvc"                                # Xbox Live Networking Service (Disabling Breaks Xbox Live Games)
            "XboxGipSvc"                                   # Xbox Accessory Management Service
            # Hp services
            "HPAppHelperCap"
            "HPDiagsCap"
            "HPNetworkCap"
            "HPSysInfoCap"
            "HpTouchpointAnalyticsService"
            # Hyper-V services
            "HvHost"
            "vmicguestinterface"
            "vmicheartbeat"
            "vmickvpexchange"
            "vmicrdv"
            "vmicshutdown"
            "vmictimesync"
            "vmicvmsession"
            # Services that cannot be disabled
            #"WdNisSvc"
        )
    
        foreach ($service in $services) {
            Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Manual
        }
    
        Stop-Service "DiagTrack"
        Set-Service "DiagTrack" -StartupType Disabled
    
        Stop-Service "DiagTrack" -WarningAction SilentlyContinue
        Set-Service "DiagTrack" -StartupType Disabled
    
        Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
        Set-Service "dmwappushservice" -StartupType Disabled
    
        Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
        Set-Service "HomeGroupListener" -StartupType Disabled
        Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
        Set-Service "HomeGroupProvider" -StartupType Disabled
    
        Stop-Service "SysMain" -WarningAction SilentlyContinue
        Set-Service "SysMain" -StartupType Disabled
    
        $TB1.ForeColor = $DefaultForeColorBig
    }
    if ($TB2.Image -eq $ActiveButtonColor) { # Cleaning Tweaks
        $StatusBox.Text = "| Aplicando Cleaning Tweaks...`r`n`r`n" + $StatusBox.Text
        $TB2.ForeColor = $LabelColor

        # Uninstall Microsoft Bloatware
        $StatusBox.Text = "| Desinstalando Microsoft Bloatware...`r`n" + $StatusBox.Text
        &{ $ProgressPreference = 'SilentlyContinue'
        Get-AppxPackage -All "Microsoft.3DBuilder" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.AppConnector" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.BingFinance" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.BingNews" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.BingSports" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.BingTranslator" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.BingWeather" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.CommsPhone" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.ConnectivityStore" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.GetHelp" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.Getstarted" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.Messaging" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.Microsoft3DViewer" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.MicrosoftPowerBIForWindows" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.MicrosoftStickyNotes" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.NetworkSpeedTest" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.MicrosoftOfficeHub" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.Office.OneNote" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.Office.Sway" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.OneConnect" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.People" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.Print3D" | Remove-AppxPackage
        Get-AppxPackage -All "Microsoft.Paint" | Remove-AppxPackage  
        Get-AppxPackage -All "Microsoft.Wallet" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.WindowsAlarms" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.WindowsCamera" | Remove-AppxPackage 
        Get-AppxPackage -All "microsoft.windowscommunicationsapps" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.WindowsFeedbackHub" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.WindowsMaps" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.WindowsPhone" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.WindowsSoundRecorder" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.YourPhone" | Remove-AppxPackage 
        Get-AppxPackage -All "MicrosoftWindows.Client.WebExperience" | Remove-AppxPackage 
        Get-AppxPackage -All "MicrosoftTeams" | Remove-AppxPackage 
        Get-AppxPackage -All "Microsoft.MSPaint" | Remove-AppxPackage
        Get-AppxPackage -All "Microsoft.MixedReality.Portal" | Remove-AppxPackage
        Get-AppxPackage -All "Clipchamp.Clipchamp" | Remove-AppxPackage
        Get-AppxPackage -All "Microsoft.PowerAutomateDesktop" | Remove-AppxPackage
        Get-AppxPackage -All "Microsoft.Todos" | Remove-AppxPackage
        Get-AppxPackage -All "Microsoft.ZuneMusic" | Remove-AppxPackage
        Get-AppxPackage -All "MicrosoftCorporationII.MicrosoftFamily" | Remove-AppxPackage
        Get-AppxPackage -All "Disney.37853FC22B2CE" | Remove-AppxPackage
        }

        # Clean "New" In Context Menu
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-File $LogPath -Encoding UTF8 -Append
        # Texto OpenDocument
        Remove-ItemProperty -Path "HKCR:\.odt\LibreOffice.WriterDocument.1\ShellNew" -Name "FileName"
        # Hoja De Calculo OpenDocument
        Remove-ItemProperty -Path "HKCR:\.ods\LibreOffice.CalcDocument.1\ShellNew" -Name "FileName"
        # Presentacion OpenDocument
        Remove-ItemProperty -Path "HKCR:\.odp\LibreOffice.ImpressDocument.1\ShellNew" -Name "FileName"
        # Dibujo OpenDocument
        Remove-ItemProperty -Path "HKCR:\.odg\LibreOffice.DrawDocument.1\ShellNew" -Name "FileName"
        # PSD File
        Remove-Item -Path "HKCR:\.psd\ShellNew"
        # Carpeta Comprimida En Zip
        Remove-ItemProperty -Path "HKCR:\.zip\CompressedFolder\ShellNew" -Name "Data"
        Remove-ItemProperty -Path "HKCR:\.zip\CompressedFolder\ShellNew" -Name "ItemName"
    
        # Uninstall Windows Optional Features
        &{ $ProgressPreference = 'SilentlyContinue'
        $StatusBox.Text = "| Desinstalando Servidor OpenSSH...`r`n" + $StatusBox.Text
        Get-WindowsPackage -Online | Where PackageName -like *SSH* | Remove-WindowsPackage -Online -NoRestart | Out-File $LogPath -Encoding UTF8 -Append
        $StatusBox.Text = "| Desinstalando Rostro De Windows Hello...`r`n" + $StatusBox.Text
        Get-WindowsPackage -Online | Where PackageName -like *Hello-Face* | Remove-WindowsPackage -Online -NoRestart | Out-File $LogPath -Encoding UTF8 -Append
        $StatusBox.Text = "| Desinstalando Grabacion De Acciones Del Usuario...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
        $StatusBox.Text = "| Desinstalando Modo De Internet Explorer...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
        $StatusBox.Text = "| Desinstalando WordPad...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
        $StatusBox.Text = "| Desinstalando Windows Powershell ISE...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
        $StatusBox.Text = "| Desinstalando Reconocedor Matematico...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
        }
        $TB2.ForeColor = $DefaultForeColor
    } 
    if ($TB3.Image -eq $ActiveButtonColor) { # Nvidia Settings
        $StatusBox.Text = "| Aplicando Ajustes Al Panel De Control De Nvidia...`r`n" + $StatusBox.Text
        $TB3.ForeColor = $LabelColor
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" -Name "EnableGR535" -Type DWord -Value 0
        $Download.DownloadFile($FromPath+"/Apps/ProfileInspector.exe", $ToPath+"\Apps\ProfileInspector.exe")
        $Download.DownloadFile($FromPath+"/Configs/NvidiaProfiles.nip", $ToPath+"\Configs\NvidiaProfiles.nip")
        Start-Process ($ToPath+"\Apps\ProfileInspector.exe")($ToPath+"\Configs\NvidiaProfiles.nip")
        $TB3.ForeColor = $DefaultForeColor
    } 
    if ($TB4.Image -eq $ActiveButtonColor) { # Reduce Icons Spacing
        $StatusBox.Text = "| Reduciendo Espacio Entre Iconos...`r`n" + $StatusBox.Text
        $TB4.ForeColor = $LabelColor
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "IconSpacing" -Value -900
        $TB4.ForeColor = $DefaultForeColor
    } 
    if ($TB5.Image -eq $ActiveButtonColor) { # Hide Shortcut Arrows
        $StatusBox.Text = "| Ocultando Flechas De Acceso Directo...`r`n" + $StatusBox.Text
        $TB5.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Configs/Blank.ico", $ToPath+"\Configs\Blank.ico")
        Unblock-File ($ToPath+"\Configs\Blank.ico")
        Copy-Item -Path ($ToPath+"\Configs\Blank.ico") -Destination "C:\Windows\System32" -Force
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-File $LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKCR:\IE.AssocFile.URL" -Name "IsShortcut" -Value ""
        Set-ItemProperty -Path "HKCR:\InternetShortcut" -Name "IsShortcut" -Value ""
        Set-ItemProperty -Path "HKCR:\lnkfile" -Name "IsShortcut" -Value ""
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "Shell Icons" | Out-File $LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" -Name "29" -Value "%windir%\System32\Blank.ico"
        $TB5.ForeColor = $DefaultForeColor
    } 
    if ($TB6.Image -eq $ActiveButtonColor) { # Set Fluent Cursor
        $StatusBox.Text = "| Estableciendo Cursor Personalizado...`r`n" + $StatusBox.Text
        $TB6.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Configs/FluentCursor.zip", $ToPath+"\Configs\FluentCursor.zip")
        Expand-Archive -Path ($ToPath+"\Configs\FluentCursor.zip") -DestinationPath 'C:\Windows\Cursors\Fluent Cursor' -Force
        $Download.DownloadFile($FromPath+"/Apps/FluentCursor.reg", $ToPath+"\Apps\FluentCursor.reg")
        regedit /s $env:userprofile\AppData\Local\Temp\ZKTool\Apps\FluentCursor.reg
        $TB6.ForeColor = $DefaultForeColor
    } 
    if ($TB7.Image -eq $ActiveButtonColor) { # Disable Cortana
        $StatusBox.Text = "| Deshabilitando Cortana...`r`n" + $StatusBox.Text
        $TB7.ForeColor = $LabelColor
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-File $LogPath -Encoding UTF8 -Append
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-File $LogPath -Encoding UTF8 -Append
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-File $LogPath -Encoding UTF8 -Append
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-File $LogPath -Encoding UTF8 -Append
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
        $TB7.ForeColor = $DefaultForeColor
    } 
    if ($TB8.Image -eq $ActiveButtonColor) { # Remove OneDrive
        $StatusBox.Text = "| Desinstalando One Drive...`r`n" + $StatusBox.Text
        $TB8.ForeColor = $LabelColor
        Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
        Start-Sleep -s 2
        $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
        If (!(Test-Path $onedrive)) {
            $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
        }
        Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
        Start-Sleep -s 2
        Stop-Process -Name "explorer" -ErrorAction SilentlyContinue
        Start-Sleep -s 2
        Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-File $LogPath -Encoding UTF8 -Append
        Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
        &{ $ProgressPreference = 'SilentlyContinue'; Get-AppxPackage Microsoft.OneDriveSync | Remove-AppxPackage }
        $TB8.ForeColor = $DefaultForeColor
    } 
    if ($TB9.Image -eq $ActiveButtonColor) { # Remove Xbox Game Bar
        $StatusBox.Text = "| Desinstalando Xbox Game Bar...`r`n" + $StatusBox.Text
        $TB9.ForeColor = $LabelColor
        &{ $ProgressPreference = 'SilentlyContinue'
        Get-AppxPackage "Microsoft.XboxGamingOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage
        Get-AppxPackage "Microsoft.GamingApp" | Remove-AppxPackage
        Get-AppxPackage "Microsoft.GamingServices" | Remove-AppxPackage
        }
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
        $TB9.ForeColor = $DefaultForeColor
    } 
    if ($TB10.Image -eq $ActiveButtonColor) { # Tweaks In Context Menu
        $StatusBox.Text = "| Activando Tweaks En Context Menu...`r`n" + $StatusBox.Text
        $TB10.ForeColor = $LabelColor
        
        # Enable App Submenu
        $Download.DownloadFile($FromPath+"/Apps/ContextMenuTweaks.zip", $ToPath+"\Apps\ContextMenuTweaks.zip")
        Expand-Archive -Path ($ToPath+"\Apps\ContextMenuTweaks.zip") -DestinationPath $AppsPath -Force
        Add-MpPreference -ExclusionPath ($AppsPath+"\CleanFiles.exe")
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Subcommands" -Value ""
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "shell" | Out-Null
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "01App" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "Icon" -Value "C:\Program Files\ZKTool\ZKTool.exe,0"
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "MUIVerb" -Value "App"
            New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "command" | Out-Null
                Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\01App\command" -Name "(default)" -Value "C:\Program Files\ZKTool\ZKTool.exe"

        # LogitechOMM
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "02LogitechOMM" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "Icon" -Value "C:\Program Files\ZKTool\Apps\LogitechOMM.exe,0"
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "MUIVerb" -Value "Logitech OMM"
            New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "command" | Out-Null
                Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM\command" -Name "(default)" -Value "C:\Program Files\ZKTool\Apps\LogitechOMM.exe"

        # Bufferbloat Tweaks
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "03BufferbloatFixed" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03BufferbloatFixed" -Name "Icon" -Value "inetcpl.cpl,20"
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03BufferbloatFixed" -Name "MUIVerb" -Value "Bufferbloat Fixed"
            New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03BufferbloatFixed" -Name "command" | Out-Null
                Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\03BufferbloatFixed\command" -Name "(default)" -Value 'powershell Start-Process powershell -WindowStyle Hidden -Verb RunAs {netsh int tcp set global autotuninglevel=disabled;netsh int ipv4 set subinterface Ethernet mtu=850 store=persistent;Disable-NetAdapter -Name Ethernet -Confirm:$False;Enable-NetAdapter -Name Ethernet -Confirm:$False}'
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "04BufferbloatDefault" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04BufferbloatDefault" -Name "Icon" -Value "inetcpl.cpl,21"
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04BufferbloatDefault" -Name "MUIVerb" -Value "Bufferbloat Default"
            New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04BufferbloatDefault" -Name "command" | Out-Null
                Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\04BufferbloatDefault\command" -Name "(default)" -Value 'powershell Start-Process powershell -WindowStyle Hidden -Verb RunAs {netsh int tcp set global autotuninglevel=normal;netsh int ipv4 set subinterface Ethernet mtu=1500 store=persistent;Disable-NetAdapter -Name Ethernet -Confirm:$False;Enable-NetAdapter -Name Ethernet -Confirm:$False}'
        
        # Clean Standby List Memory
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "05EmptyStandbyList" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05EmptyStandbyList" -Name "Icon" -Value "SHELL32.dll,12"
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05EmptyStandbyList" -Name "MUIVerb" -Value "Clear RAM"
            New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05EmptyStandbyList" -Name "command" | Out-Null
                Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05EmptyStandbyList\command" -Name "(default)" -Value "C:\Program Files\ZKTool\Apps\EmptyStandbyList.exe"

        # Clan Files
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "06CleanFiles" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\06CleanFiles" -Name "Icon" -Value "SHELL32.dll,32"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\06CleanFiles" -Name "MUIVerb" -Value "Clean Files"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\06CleanFiles" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\06CleanFiles\command" -Name "(default)" -Value "C:\Program Files\ZKTool\Apps\CleanFiles.exe"
        $TB10.ForeColor = $DefaultForeColor
    } 
    if ($TB11.Image -eq $ActiveButtonColor) { # VisualFX Fix
        $StatusBox.Text = "| Ajustando Animaciones De Windows...`r`n" + $StatusBox.Text
        $TB11.ForeColor = $LabelColor
        #Custom Setting
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
        # Animaciones En La Barra De Tareas ON
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
        # Animar Las Ventanas Al Minimizar Y Maximizar ON
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 1
        # Guardar Vistas De Miniaturas De La Barra De Tareas OFF
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AlwaysHibernateThumbnails" -Type DWord -Value 0
        # Habilitar Peek OFF
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
        # Mostrar El Contenido De La Ventana Mientras Se Arrastra ON
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Value 1
        # Mostrar El Rectangulo De Seleccion Translucido ON
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
        # Mostrar Vistas En Miniatura En Lugar De Iconos ON
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -Type DWord -Value 0
        # Suavizar Bordes Para Las Fuentes De Pantalla ON
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothing" -Value 2
        # Usar Sombras En Las Etiquetas... OFF
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
        # Animar Los Controles Y Elementos Dentro De Las Ventanas ON
        # Atenuar Los Elementos Despues De Hacer Click OFF
        # Atenuar O Deslizar La Informacion... OFF
        # Atenuar O Deslizar Los Menus En La Vista OFF
        # Deslizar Los Cuadros Combinados Al Abrirlos OFF
        # Desplazamiento Suave De Los Cuadros De Lista OFF
        # Mostrar Sombra Bajo El Puntero Del Mouse OFF
        # Mostrar Sombras Bajo Las Ventanas ON
        $MaskValue = "90,12,07,80,12,01,00,00"
        $MaskValueToHex = $MaskValue.Split(',') | % { "0x$_"}
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]]$MaskValueToHex)
        $TB11.ForeColor = $DefaultForeColor
    }  
    if ($MTB1.Image -eq $ActiveButtonColorBig) { # Activate Windows Pro
        $StatusBox.Text = "| Activando Windows Pro...`r`n" + $StatusBox.Text
        $MTB1.ForeColor = $LabelColorBig
        cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
        cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /skms kms.digiboy.ir
        cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ato
        $MTB1.ForeColor = $DefaultForeColorBig
    }
    if ($MTB2.Image -eq $ActiveButtonColor) { # Install Visual C++
        $StatusBox.Text = "| Instalando Todas Las Versiones De Visual C++...`r`n" + $StatusBox.Text
        $MTB2.ForeColor = $LabelColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2005.x64 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2005.x86 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2008.x64 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2008.x86 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2010.x64 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2010.x86 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2012.x64 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2012.x86 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2013.x64 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2013.x86 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2015+.x64 | Out-File $LogPath -Encoding UTF8 -Append
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2015+.x86 | Out-File $LogPath -Encoding UTF8 -Append
        $MTB2.ForeColor = $DefaultForeColor
    }  
    if ($MTB3.Image -eq $ActiveButtonColor) { # Install TaskbarX
        $StatusBox.Text = "| Instalando TaskbarX...`r`n" + $StatusBox.Text
        $MTB3.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/TaskbarX.zip", $ToPath+"\Apps\TaskbarX.zip")
        Expand-Archive -Path ($ToPath+"\Apps\TaskbarX.zip") -DestinationPath 'C:\Program Files\TaskbarX' -Force
        Copy-Item -Path 'C:\Program Files\TaskbarX\TaskbarX Configurator.lnk' -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force
        Start-Process "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\TaskbarX Configurator.lnk"
        $MTB3.ForeColor = $DefaultForeColor
    }  
    if ($MTB4.Image -eq $ActiveButtonColor) { # Install FFMPEG
        $StatusBox.Text = "| Instalando FFMPEG... `r`n" + $StatusBox.Text
        $MTB4.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/HEVC.appx", $ToPath+"\Apps\HEVC.appx")
        $Download.DownloadFile($FromPath+"/Apps/HEIF.appx", $ToPath+"\Apps\HEIF.appx")
        &{$ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\HEVC.appx"); Add-AppxPackage ($ToPath+"\Apps\HEIF.appx")}
        $Download.DownloadFile($FromPath+"/Apps/ffmpeg.exe", "$env:ProgramFiles\ZKTool\Apps\ffmpeg.exe")
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\" -Name "Compress" | Out-Null
        New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "command" | Out-Null
        Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "Icon" -Value "C:\Program Files\ZKTool\Apps\ffmpeg.exe,0"
        Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\command\" -Name "(default)" -Value 'cmd.exe /c echo | set /p = %1| clip | exit && "C:\Program Files\ZKTool\Apps\ffmpeg.exe"'
        Add-MpPreference -ExclusionPath "$env:ProgramFiles\ZKTool\Apps\ffmpeg.exe"
        $MTB4.ForeColor = $DefaultForeColor
    }  
    if ($MTB5.Image -eq $ActiveButtonColor) { # Windows Terminal Fix
        $StatusBox.Text = "| Aplicando Ajustes A Windows Terminal...`r`n" + $StatusBox.Text
        $MTB5.ForeColor = $LabelColor
        if (!(Test-Path -Path $env:userprofile\AppData\Local\Microsoft\Windows\Fonts\SourceCodePro*)) {
            $Download.DownloadFile($FromPath+"/Configs/FontSourceCodePro.zip", $ToPath+"\Configs\FontSourceCodePro.zip")
            Expand-Archive -Path ($ToPath+"\Configs\FontSourceCodePro.zip") -DestinationPath ($ToPath+"\Configs\FontSourceCodePro") -Force
            Start-Process ($ToPath+"\Configs\FontSourceCodePro\Install.exe")
            Wait-Process -Name "Install"
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.PowerShell | Out-File $LogPath -Encoding UTF8 -Append
        }
        $Download.DownloadFile($FromPath+"/Configs/WindowsTerminalFix.zip", $ToPath+"\Configs\WindowsTerminalFix.zip")
        Remove-Item -Path $env:userprofile\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
        Expand-Archive -Path ($ToPath+"\Configs\WindowsTerminalFix.zip") -DestinationPath $env:userprofile\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force
        $MTB5.ForeColor = $DefaultForeColor 
    }  
    if ($MTB6.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "| Void...`r`n" + $StatusBox.Text
        $MTB6.ForeColor = $LabelColor
        $MTB6.ForeColor = $DefaultForeColor
    }  
    if ($MTB7.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "| Void...`r`n" + $StatusBox.Text
        $MTB7.ForeColor = $LabelColor
        $MTB7.ForeColor = $DefaultForeColor
    }    
    if ($MTB9.Image -eq $ActiveButtonColor) { # Autoruns
        $StatusBox.Text = "| Abriendo Autoruns...`r`n" + $StatusBox.Text
        $MTB9.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/Autoruns.exe", $ToPath+"\Apps\Autoruns.exe")
        Start-Process ($ToPath+"\Apps\Autoruns.exe")
        $MTB9.ForeColor = $DefaultForeColor
    }
    if ($MTB10.Image -eq $ActiveButtonColor) { # Unpin All Apps
        $StatusBox.Text = "| Desanclando Todas Las Aplicaciones...`r`n" + $StatusBox.Text
        $MTB10.ForeColor = $LabelColor
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "Favorites" -Type Binary -Value ([byte[]](255))
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "FavoritesResolve" -ErrorAction SilentlyContinue
        $Download.DownloadFile($FromPath+"/Configs/start.bin", $ToPath+"\Configs\start.bin")
        Copy-Item -Path ($ToPath+"\Configs\start.bin") -Destination "$env:userprofile\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState" -Force
        $MTB10.ForeColor = $DefaultForeColor
    }
    if ($MTB11.Image -eq $ActiveButtonColor) { # Remove Realtek
        $StatusBox.Text = "| Quitando Realtek Audio Service...`r`n" + $StatusBox.Text
        $MTB11.ForeColor = $LabelColor
        pwsh.exe -command {sc stop Audiosrv} | Out-File $LogPath -Encoding UTF8 -Append
        pwsh.exe -command {sc stop RtkAudioUniversalService} | Out-File $LogPath -Encoding UTF8 -Append
        taskkill.exe /f /im RtkAudUService64.exe | Out-File $LogPath -Encoding UTF8 -Append
        pwsh.exe -command {sc delete RtkAudioUniversalService} | Out-File $LogPath -Encoding UTF8 -Append
        pwsh.exe -command {sc start Audiosrv} | Out-File $LogPath -Encoding UTF8 -Append
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "RtkAudUService"
        Get-AppxPackage -All "RealtekSemiconductorCorp.RealtekAudioControl" | Remove-AppxPackage
        $MTB11.ForeColor = $DefaultForeColor
    }
    if ($MTB12.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "| Instalando Void...`r`n" + $StatusBox.Text
        $MTB12.ForeColor = $LabelColor
        $MTB12.ForeColor = $DefaultForeColor
    }
    if ($MTB13.Image -eq $ActiveButtonColor) { # Set PageFile Size
        $RamCapacity = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1mb
        if ($RamCapacity -le 17000) {
            #$RamCapacity = $RamCapacity/2
            $StatusBox.Text = "| Estableciendo El Tamaño Del Archivo De Paginacion En $RamCapacity MB...`r`n" + $StatusBox.Text
            $MTB13.ForeColor = $LabelColor
            $PageFile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
            $PageFile.AutomaticManagedPagefile = $false
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "c:\pagefile.sys $RamCapacity $RamCapacity"
            $MTB13.ForeColor = $DefaultForeColor
        }else {
            $StatusBox.Text = "| La Cantidad De Memoria RAM Es Superior A Los 16GB, No Se Realizara Ningun Cambio...`r`n" + $StatusBox.Text
        }
    }
    if ($MTB14.Image -eq $ActiveButtonColor) { # MSI Afterburner Config
        $StatusBox.Text = "| Configurando MSI Afterbuner...`r`n" + $StatusBox.Text
        $MTB14.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Configs/MSIAfterburner.zip", $ToPath+"\Configs\MSIAfterburner.zip")
        Expand-Archive -Path ($ToPath+"\Configs\MSIAfterburner.zip") -DestinationPath ($ToPath+"\Configs\MSIAfterburner") -Force
        Move-Item -Path ($ToPath+"\Configs\MSIAfterburner\MSIAfterburner Settings\Profiles\*") -Destination 'C:\Program Files (x86)\MSI Afterburner\Profiles' -Force
        if (Test-Path -Path 'C:\Program Files (x86)\RivaTuner Statistics Server') {
            Move-Item -Path ($ToPath+"\Configs\MSIAfterburner\RivaTuner Settings\Profiles\*") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\Profiles' -Force
            Move-Item -Path ($ToPath+"\Configs\MSIAfterburner\RivaTuner Settings\Config") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\ProfileTemplates' -Force
        }
        $MTB14.ForeColor = $DefaultForeColor
    }
    if ($MTB15.Image -eq $ActiveButtonColor) { # Adobe Cleaner
        $StatusBox.Text = "| Eliminando Procesos De Adobe...`r`n" + $StatusBox.Text
        $MTB15.ForeColor = $LabelColor
        Rename-Item -Path "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exe" "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exeX"
        Rename-Item -Path "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exeX"
        Rename-Item -Path "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe" "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exeX"
        Rename-Item -Path "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exe" "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exeX"

        $MTB15.ForeColor = $DefaultForeColor
    }
    if ($MTB16.Image -eq $ActiveButtonColor) { # AMD Undervolt Pack
        $StatusBox.Text = "| Descargando AMD Undervolt Pack...`r`n" + $StatusBox.Text
        $MTB16.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/AMDUndervoltPack.zip", $ToPath+"\Apps\AMDUndervoltPack.zip")
        Expand-Archive -Path ($ToPath+"\Apps\AMDUndervoltPack.zip") -DestinationPath ($ToPath+"\Apps\AMD Undervolt Pack") -Force
        Move-Item -Path ($ToPath+"\Apps\AMD Undervolt Pack\AMD Undervolt") -Destination 'C:\Program Files\'
        $DesktopPath = Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Desktop" | Select-Object -ExpandProperty Desktop
        Move-Item -Path ($ToPath+"\Apps\AMD Undervolt Pack\CPU Undervolt.lnk") -Destination $DesktopPath
        Move-Item -Path ($ToPath+"\Apps\AMD Undervolt Pack\Prime95") -Destination $DesktopPath
        Move-Item -Path ($ToPath+"\Apps\AMD Undervolt Pack\CPUZ.exe") -Destination $DesktopPath
        Move-Item -Path ($ToPath+"\Apps\AMD Undervolt Pack\PBO2 Tuner.lnk") -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
        $MTB16.ForeColor = $DefaultForeColor
    }
    if ($HB1.Image -eq $ActiveButtonColor) { # Game Settings
        $StatusBox.Text = "| Abriendo Game Settings...`r`n" + $StatusBox.Text
        $HB1.ForeColor = $LabelColor
        iex ((New-Object System.Net.WebClient).DownloadString(($FromPath+"/Scripts/GameSettings.ps1")))
        $HB1.ForeColor = $DefaultForeColor
    } 
    if ($HB2.Image -eq $ActiveButtonColor) { # Experimental
        $StatusBox.Text = "| Experimental Tweaks...`r`n" + $StatusBox.Text
        $HB2.ForeColor = $LabelColor

        # Nvidia Drivers
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" -Name "EnableGR535" -Type DWord -Value 0
        $Download.DownloadFile($FromPath+"/Apps/ProfileInspector.exe", $ToPath+"\Apps\ProfileInspector.exe")
        $Download.DownloadFile($FromPath+"/Configs/NvidiaProfilesExperimental.nip", $ToPath+"\Configs\NvidiaProfilesExperimental.nip")
        Start-Process ($ToPath+"\Apps\ProfileInspector.exe")($ToPath+"\Configs\NvidiaProfilesExperimental.nip")
        Remove-Item -Path "C:\Windows\System32\drivers\NVIDIA Corporation" -Recurse | Out-File $LogPath -Encoding UTF8 -Append
        Get-ChildItem -Path "C:\Windows\System32\DriverStore\FileRepository\" -Recurse | Where-Object {$_.Name -eq "NvTelemetry64.dll"} | Remove-Item | Out-File $LogPath -Encoding UTF8 -Append

        # Input Lag
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "DoubleClickSpeed" -Value 200
        Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value 0
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\" -Name "Parameters" | Out-Null
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" -Name "MouseDataQueueSize" -Type DWord -Value 20
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" -Name "KeyboardDataQueueSize" -Type DWord -Value 20
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name "Win32PrioritySeparation" -Type DWord -Value 42
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\" -Name "csrss.exe" | Out-Null
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\" -Name "PerfOptions" | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" -Name "CpuPriorityClass" -Type DWord -Value 4
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" -Name "IoPriority" -Type DWord -Value 3
        $HB2.ForeColor = $DefaultForeColor
    }   
    if ($HB3.Image -eq $ActiveButtonColor) { # Context Menu Handler
        $StatusBox.Text = "| Abriendo Context Menu Handler...`r`n" + $StatusBox.Text
        $HB3.ForeColor = $LabelColor
        iex ((New-Object System.Net.WebClient).DownloadString(($FromPath+"/Scripts/ContextMenuHandler.ps1")))
        $HB3.ForeColor = $DefaultForeColor
    }   
    if ($HB4.Image -eq $ActiveButtonColor) { # Software RL
        $StatusBox.Text = "| Instalando Software RL...`r`n" + $StatusBox.Text
        $HB4.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/RLSoftware.exe", $ToPath+"\Apps\RLSoftware.exe")
        Start-Process ($ToPath+"\Apps\RLSoftware.exe")
        $HB4.ForeColor = $DefaultForeColor
    }   
    if ($HB5.Image -eq $ActiveButtonColor) { # RGB Fusion
        $StatusBox.Text = "| Instalando RGB Fusion...`r`n" + $StatusBox.Text
        $HB5.ForeColor = $LabelColor
        Start-Process Powershell {
            $host.UI.RawUI.WindowTitle = 'RGB Fusion'
            $file = 'https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/RGBFusion.exe'
            $filepath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\RGBFusion.exe'
            Write-Host "Descargando RGB Fusion..."
            (New-Object Net.WebClient).DownloadFile($file, $filepath)
            Start-Process $filepath
        }
        $HB5.ForeColor = $DefaultButtonColor
    }   
    if ($HB6.Image -eq $ActiveButtonColor) { # Z390 Lan Drivers
        $StatusBox.Text = "| Instalando Z390 Lan Drivers...`r`n" + $StatusBox.Text
        $HB6.ForeColor = $LabelColor
        $Download.DownloadFile($FromPath+"/Apps/LanDrivers.exe", $ToPath+"\Apps\LanDrivers.exe")
        Start-Process ($ToPath+"\Apps\LanDrivers.exe")
        $HB6.ForeColor = $DefaultForeColor
    }
    if ($MTB8.Image -eq $ActiveButtonColor) { # Static IP + DNS
        $StatusBox.Text = "| Abriendo Selector De IPs...`r`n" + $StatusBox.Text
        $MTB8.ForeColor = $LabelColor
        iex ((New-Object System.Net.WebClient).DownloadString(($FromPath+"/Scripts/ChooseIp.ps1")))
        $MTB8.ForeColor = $DefaultForeColor
    }

    $LabelColor = [System.Drawing.ColorTranslator]::FromHtml("#26FFB3")

    $Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB16,
    $MSB17,$LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB1,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11,$MTB1,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$MTB12,
    $MTB13,$MTB14,$MTB15,$MTB16,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9)
    foreach ($Button in $Buttons) {
        if ($Button.Image -eq $ActiveButtonColor) {
                $Button.Image = $DefaultButtonColor
                $Button.ForeColor = $LabelColor
        }
        if ($Button.Image -eq $ActiveButtonColorBig) {
            $Button.Image = $DefaultButtonColorBig
            $Button.ForeColor = $LabelColor
        }
    }

    $StatusBox.Text = "| Comprobando Instalaciones...`r`n" + $StatusBox.Text

    $Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB11,$SB12,$MSB1,$MSB5,$MSB6,$MSB9,$MSB10,$MSB11,$MSB12,$LB1,$LB2,$LB3,$LB5,$LB7,$LB8)
    foreach ($Button in $Buttons) {
        if ($Button.ForeColor -eq $LabelColor) {
            $WingetListCheck = Winget List $Button.Text | Select-String -Pattern $Button.Text | ForEach {$_.matches} | Select-Object -ExpandProperty Value
            if (!($WingetListCheck -eq $Button.Text)) {
                $Button.ForeColor = "Red"
            }
        }
    }

    $StartScript.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "SSDefault.png"))
    $StartScript.ForeColor = $LabelColor

    $StatusBox.Text = "| Script Finalizado`r`n" + $StatusBox.Text

    if ($TB1.ForeColor -eq $LabelColor) {
        $MessageBox = [System.Windows.Forms.MessageBox]::Show("El equipo requiere reiniciarse para aplicar los cambios`r`nReiniciar equipo ahora?", "Reiniciar equipo", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information)
        if ($MessageBox -ne [System.Windows.Forms.DialogResult]::No) {
            $StatusBox.Text = "| Reiniciando El Equipo En 5 Segundos...`r`n" + $StatusBox.Text
            Start-Sleep 5
            Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse
            Restart-Computer
        } else {} 
    }
})

$Form.Add_Closing({
    Start-Process Powershell -WindowStyle Hidden {
        Start-Sleep 2
        Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse
    }
})

[void]$Form.ShowDialog()