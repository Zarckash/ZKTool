Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

if (!(Get-MpPreference | Select-Object -ExpandProperty ExclusionPath) -eq "C:\Windows\System32\ZKTool.exe") {
    Add-MpPreference -ExclusionPath "$env:windir\System32\ZKTool.exe"
}

New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Configs\ -ItemType Directory | Out-Null
New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Apps\ -ItemType Directory | Out-Null
New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\ -ItemType Directory | Out-Null
Iwr "https://github.com/Zarckash/ZKTool/raw/main/Configs/Images.zip" -OutFile "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images.zip" | Out-Null
Expand-Archive -Path $env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images.zip -DestinationPath $env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\

$LabelColor = [System.Drawing.ColorTranslator]::FromHtml("#00E6FF") 
$DefaultForeColor = [System.Drawing.ColorTranslator]::FromHtml("#F1F1F1")
$ActiveForeColor = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$DefaultButtonColor = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\DefaultButtonColor.png")
$ActiveButtonColor = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ActiveButtonColor.png")
$ProcessingButtonColor = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ProcessingButtonColor.png")
$ErrorButtonColor = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ErrorButtonColor.png")
$DefaultButtonColorBIG = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\DefaultButtonColorBIG.png")
$ActiveButtonColorBIG = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ActiveButtonColorBIG.png")
$ProcessingButtonColorBIG = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ProcessingButtonColorBIG.png")

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
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ZKLogo.ico")


            ##################################
            ############ SOFTWARE ############
            ##################################


# Software Label
$SLabel                          = New-Object System.Windows.Forms.Label
$SLabel.Text                     = "S O F T W A R E"
$SLabel.AutoSize                 = $true
$SLabel.Width                    = 215
$SLabel.Height                   = 25
$SLabel.Location                 = New-Object System.Drawing.Point(25,13)
$SLabel.Font                     = New-Object System.Drawing.Font('Berserker',16)
$SLabel.ForeColor                = $LabelColor
$Form.Controls.Add($SLabel)

# Software Panel
$SPanel                          = New-Object System.Windows.Forms.Panel
$SPanel.Height                   = 491
$SPanel.Width                    = $PanelSize
$SPanel.Location                 = New-Object System.Drawing.Point(($PanelSize*0),44)
$Form.Controls.Add($SPanel)

$Position                        = 10 # Sets Each Button Position

# Google Chrome
$SB1                             = New-Object System.Windows.Forms.Button
$SB1.Text                        = "Google Chrome"

# GeForce Experience
$SB2                             = New-Object System.Windows.Forms.Button
$SB2.Text                        = "GeForce Experience"

# NanaZip
$SB3                             = New-Object System.Windows.Forms.Button
$SB3.Text                        = "NanaZip"

# Discord
$SB4                             = New-Object System.Windows.Forms.Button
$SB4.Text                        = "Discord"

# HWMonitor
$SB5                             = New-Object System.Windows.Forms.Button
$SB5.Text                        = "HWMonitor"

# MSI Afterburner
$SB6                             = New-Object System.Windows.Forms.Button
$SB6.Text                        = "MSI Afterburner"

# Corsair iCue
$SB7                             = New-Object System.Windows.Forms.Button
$SB7.Text                        = "Corsair iCue"

# Logitech GHUB
$SB8                             = New-Object System.Windows.Forms.Button
$SB8.Text                        = "Logitech G HUB"

# Razer Synapse
$SB9                             = New-Object System.Windows.Forms.Button
$SB9.Text                        = "Razer Synapse"

# uTorrent Web
$SB10                            = New-Object System.Windows.Forms.Button
$SB10.Text                       = "uTorrent Web"

# LibreOffice
$SB11                            = New-Object System.Windows.Forms.Button
$SB11.Text                       = "LibreOffice"

# Megasync
$SB12                            = New-Object System.Windows.Forms.Button
$SB12.Text                       = "MegaSync"

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
$MSPanel.Height                  = 491 + 235
$MSPanel.Width                   = $PanelSize
$MSPanel.Location                = New-Object System.Drawing.Point(($PanelSize*0),44)

# StreamlabsOBS
$MSB1                            = New-Object System.Windows.Forms.Button
$MSB1.Text                       = "StreamlabsOBS"

# Photoshop Portable
$MSB2                            = New-Object System.Windows.Forms.Button
$MSB2.Text                       = "Photoshop Portable"

# Premiere Portable
$MSB3                            = New-Object System.Windows.Forms.Button
$MSB3.Text                       = "Premiere Portable"

# Spotify
$MSB4                            = New-Object System.Windows.Forms.Button
$MSB4.Text                       = "Spotify"

# Netflix
$MSB5                            = New-Object System.Windows.Forms.Button
$MSB5.Text                       = "Netflix"

# Prime Video
$MSB6                            = New-Object System.Windows.Forms.Button
$MSB6.Text                       = "Prime Video"

# VLC Media Player
$MSB7                            = New-Object System.Windows.Forms.Button
$MSB7.Text                       = "VLC Media Player"

# GitHub Desktop
$MSB8                            = New-Object System.Windows.Forms.Button
$MSB8.Text                       = "GitHub Desktop"

# WinRAR
$MSB9                            = New-Object System.Windows.Forms.Button
$MSB9.Text                       = "WinRAR"

# Void
$MSB10                           = New-Object System.Windows.Forms.Button
$MSB10.Text                      = "Void"

# Void
$MSB11                           = New-Object System.Windows.Forms.Button
$MSB11.Text                      = "Void"

# Void
$MSB12                           = New-Object System.Windows.Forms.Button
$MSB12.Text                      = "Void"

# Void
$MSB13                           = New-Object System.Windows.Forms.Button
$MSB13.Text                      = "Void"

# Void
$MSB14                           = New-Object System.Windows.Forms.Button
$MSB14.Text                      = "Void"

# Void
$MSB15                           = New-Object System.Windows.Forms.Button
$MSB15.Text                      = "Void"

# Valorant
$MSB16                           = New-Object System.Windows.Forms.Button
$MSB16.Text                      = "Valorant"

# League of Legends
$MSB17                           = New-Object System.Windows.Forms.Button
$MSB17.Text                      = "League of Legends"

# Escape From Tarkov
$MSB18                           = New-Object System.Windows.Forms.Button
$MSB18.Text                      = "Escape From Tarkov"

$Position = 10
$Buttons = @($MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB16,$MSB17,$MSB18)
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
$LLabel.AutoSize                 = $true
$LLabel.Width                    = 230
$LLabel.Height                   = 25
$LLabel.Location                 = New-Object System.Drawing.Point(245,13)
$LLabel.Font                     = New-Object System.Drawing.Font('Berserker',16)
$LLabel.ForeColor                = $LabelColor
$Form.Controls.Add($LLabel)

# Launchers Panel
$LPanel                          = New-Object System.Windows.Forms.Panel
$LPanel.Height                   = 344
$LPanel.Width                    = $PanelSize
$LPanel.Location                 = New-Object System.Drawing.Point($PanelSize,44)
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
$TLabel.AutoSize                 = $true
$TLabel.Width                    = 230
$TLabel.Height                   = 25
$TLabel.Location                 = New-Object System.Drawing.Point(510,13)
$TLabel.Font                     = New-Object System.Drawing.Font('Berserker',16)
$TLabel.ForeColor                = $LabelColor
$Form.Controls.Add($TLabel)

# Tweaks Panel
$TPanel                          = New-Object System.Windows.Forms.Panel
$TPanel.Height                   = 491
$TPanel.Width                    = $PanelSize - 2
$TPanel.Location                 = New-Object System.Drawing.Point(($PanelSize*2),44)
$Form.Controls.Add($TPanel)

# Essential Tweaks
$TB1                             = New-Object System.Windows.Forms.Button
$TB1.Text                        = "Essential Tweaks"
$TB1.Location                    = New-Object System.Drawing.Point(10,10)
$TPanel.Controls.Add($TB1)

# Extra Tweaks
$TB2                             = New-Object System.Windows.Forms.Button
$TB2.Text                        = "Extra Tweaks"

# Nvidia Settings
$TB3                             = New-Object System.Windows.Forms.Button
$TB3.Text                        = "Nvidia Settings"

# Reduce Icons Spacing
$TB4                             = New-Object System.Windows.Forms.Button
$TB4.Text                        = "Reduce Icons Spacing"

# Hide Shortcut Arrows
$TB5                             = New-Object System.Windows.Forms.Button
$TB5.Text                        = "Hide Shortcut Arrows"

# Set Modern Cursor
$TB6                             = New-Object System.Windows.Forms.Button
$TB6.Text                        = "Set Modern Cursor"

# Disable Cortana
$TB7                             = New-Object System.Windows.Forms.Button
$TB7.Text                        = "Disable Cortana"

# Uninstall OneDrive
$TB8                             = New-Object System.Windows.Forms.Button
$TB8.Text                        = "Uninstall OneDrive"

# Uninstall Xbox Game Bar
$TB9                             = New-Object System.Windows.Forms.Button
$TB9.Text                        = "Uninstall Xbox Game Bar"

# Ram Cleaner (ISLC)
$TB10                            = New-Object System.Windows.Forms.Button
$TB10.Text                       = "Ram Cleaner (ISLC)"

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
$MTPanel.Height                  = 491 + 235
$MTPanel.Width                   = $PanelSize - 2
$MTPanel.Location                = New-Object System.Drawing.Point(($PanelSize*3),44)

# Activate Windows PRO
$MTB1                            = New-Object System.Windows.Forms.Button
$MTB1.Text                       = "Activate Windows Pro Edition"
$MTB1.Location                   = New-Object System.Drawing.Point(10,10)
$MTPanel.Controls.Add($MTB1)

# Install Visual C++
$MTB2                            = New-Object System.Windows.Forms.Button
$MTB2.Text                       = "Install Visual C++"

# Install TaskbarX
$MTB3                            = New-Object System.Windows.Forms.Button
$MTB3.Text                       = "Install TaskbarX"

# Install HEVC + HEIF
$MTB4                            = New-Object System.Windows.Forms.Button
$MTB4.Text                       = "Install HEVC + HEIF"

# Windows Terminal Fix
$MTB5                            = New-Object System.Windows.Forms.Button
$MTB5.Text                       = "Windows Terminal Fix"

# Power Plan
$MTB6                            = New-Object System.Windows.Forms.Button
$MTB6.Text                       = "Power Plan"

# Performance Counters
$MTB7                            = New-Object System.Windows.Forms.Button
$MTB7.Text                       = "Performance Counters"

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

# Link Shell Extension
$MTB12                           = New-Object System.Windows.Forms.Button
$MTB12.Text                      = "Link Shell Extension"

# Increase PageFile Size
$MTB13                           = New-Object System.Windows.Forms.Button
$MTB13.Text                      = "Increase PageFile Size"

# Z390 Lan Drivers
$MTB14                           = New-Object System.Windows.Forms.Button
$MTB14.Text                      = "Z390 Lan Drivers"

# Void
$MTB15                           = New-Object System.Windows.Forms.Button
$MTB15.Text                      = "Void"

# Void
$MTB16                           = New-Object System.Windows.Forms.Button
$MTB16.Text                      = "Void"

# Void
$MTB17                           = New-Object System.Windows.Forms.Button
$MTB17.Text                      = "Void"

$Position = 40*2+10
$Buttons = @($MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$MTB12,$MTB13,$MTB14)
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
$LogoBox.Height                  = 125
$LogoBox.Location                = New-Object System.Drawing.Point($PanelSize,390)
$LogoBox.imageLocation           = "https://raw.githubusercontent.com/Zarckash/ZKTool/main/Configs/ZKLogo.png"
$LogoBox.SizeMode                = "Zoom"
$Form.Controls.Add($LogoBox)


            ##################################
            ########## START SCRIPT ##########
            ##################################


# Start Script Panel
$SSPanel                         = New-Object System.Windows.Forms.Panel
$SSPanel.Height                  = 50
$SSPanel.Width                   = $PanelSize*3 - 2
$SSPanel.Location                = New-Object System.Drawing.Point(($PanelSize*0),535)
$Form.Controls.Add($SSPanel)

# Start Script Button
$StartScript                     = New-Object System.Windows.Forms.Button
$StartScript.Text                = "I N I C I A R    S C R I P T"
$StartScript.Width               = 670
$StartScript.Height              = 50
$StartScript.Location            = New-Object System.Drawing.Point(10,0)
$StartScript.Font                = New-Object System.Drawing.Font('Ubuntu Mono',18)
$StartScript.BackColor           = $DefaultButtonColor
$StartScript.ForeColor           = $LabelColor
$StartScript.FlatStyle           = "Flat"
$StartScript.Image               = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\SSDefault.png")
$StartScript.FlatAppearance.BorderSize = 0
$SSPanel.Controls.Add($StartScript)


            ##################################
            ######### STATUS TEXTBOX #########
            ##################################


# Status TextBox
$StatusBox                       = New-Object System.Windows.Forms.TextBox
$StatusBox.multiline             = $true
$StatusBox.Width                 = 669
$StatusBox.Height                = 45
$StatusBox.Location              = New-Object System.Drawing.Point(($PanelSize*0+11),594)
$StatusBox.Font                  = New-Object System.Drawing.Font('Ubuntu Mono',12)
$StatusBox.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#3E434F")
$StatusBox.ForeColor             = $DefaultForeColor
$StatusBox.ReadOnly              = $true
$StatusBox.Text                  = "|Ready"
$Form.Controls.Add($StatusBox)


            ##################################
            ########## HIDDEN PANEL ##########
            ##################################


# Hidden Panel
$HPanel                          = New-Object System.Windows.Forms.Panel
$HPanel.Height                   = 146
$HPanel.Width                    = $PanelSize*3 - 2
$HPanel.Location                 = New-Object System.Drawing.Point(($PanelSize),515)

$Position = 20
# Rufus
$HB1                             = New-Object System.Windows.Forms.Button
$HB1.Text                        = "Rufus"
$HB1.Location                    = New-Object System.Drawing.Point(10,$Position)

# MSI Afterburner Config
$HB2                             = New-Object System.Windows.Forms.Button
$HB2.Text                        = "MSI Afterburner Config"
$HB2.Location                    = New-Object System.Drawing.Point(238,$Position)

# Wallpaper Engine Tweak
$HB3                             = New-Object System.Windows.Forms.Button
$HB3.Text                        = "Wallpaper Engine Tweak"
$HB3.Location                    = New-Object System.Drawing.Point(471,$Position)
$Position += 40

# Software RL
$HB4                             = New-Object System.Windows.Forms.Button
$HB4.Text                        = "Software RL"
$HB4.Location                    = New-Object System.Drawing.Point(10,$Position)

# RGB Fusion
$HB5                             = New-Object System.Windows.Forms.Button
$HB5.Text                        = "RGB Fusion"
$HB5.Location                    = New-Object System.Drawing.Point(237,$Position)

# JDK 17
$HB6                             = New-Object System.Windows.Forms.Button
$HB6.Text                        = "JDK 17"
$HB6.Location                    = New-Object System.Drawing.Point(471,$Position)
$Position += 40

# Eclipse IDE
$HB7                             = New-Object System.Windows.Forms.Button
$HB7.Text                        = "Eclipse IDE"
$HB7.Location                    = New-Object System.Drawing.Point(10,$Position)

# Visual Studio Code
$HB8                             = New-Object System.Windows.Forms.Button
$HB8.Text                        = "Visual Studio Code"
$HB8.Location                    = New-Object System.Drawing.Point(238,$Position)

# Game Settings
$HB9                             = New-Object System.Windows.Forms.Button
$HB9.Text                        = "Game Settings"
$HB9.Location                    = New-Object System.Drawing.Point(471,$Position)

$Buttons = @($HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9)
foreach ($Button in $Buttons) {$HPanel.Controls.Add($Button)}


            ##################################
            ######### PADDING BOTTOM #########
            ##################################


# Padding Bottom Panel
$PaddingPanel                    = New-Object System.Windows.Forms.Panel
$PaddingPanel.Height             = 8
$PaddingPanel.Width              = $PanelSize
$PaddingPanel.Location           = New-Object System.Drawing.Point(($PanelSize),639)
$Form.Controls.Add($PaddingPanel)


$Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB16,
$MSB17,$MSB18,$LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$MTB12,
$MTB13,$MTB14,$MTB15,$MTB16,$MTB17,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9)
foreach ($Button in $Buttons) {
    $Button.Width                = 210
    $Button.Height               = 35
    $Button.Font                 = New-Object System.Drawing.Font('Ubuntu Mono',12)
    $Button.FlatStyle = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.Image = $DefaultButtonColor

    $Button.Add_MouseEnter({
        if ($this.Image -eq $DefaultButtonColor) {
            $this.Image = $ProcessingButtonColor
        }
    })

    $Button.Add_MouseLeave({
        if ($this.Image -eq $ProcessingButtonColor) {
            $this.Image = $DefaultButtonColor
        }
    })

    $Button.Add_Click({
        if ($this.Image -eq $ProcessingButtonColor) {
            $this.Image = $ActiveButtonColor
            $this.ForeColor = $ActiveForeColor
        }else{
            $this.Image = $DefaultButtonColor
            $this.ForeColor = $DefaultForeColor
        }
    })
}


$Buttons = @($TB1,$MTB1)
foreach ($Button in $Buttons) {
    $Button.Width                = 210
    $Button.Height               = 75
    $Button.Font                 = New-Object System.Drawing.Font('Ubuntu Mono',12)
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.Image = $DefaultButtonColorBIG

    $Button.Add_Click({
        if ($this.Image -eq $ProcessingButtonColorBIG) {
            $this.Image = $ActiveButtonColorBIG
            $this.ForeColor = $ActiveForeColor
        }else {
            $this.Image = $DefaultButtonColorBIG
            $this.ForeColor = $DefaultForeColor
        }
    })

    $Button.Add_MouseEnter({
        if ($this.Image -eq $DefaultButtonColorBIG) {
            $this.Image = $ProcessingButtonColorBIG
        }
    })

    $Button.Add_MouseLeave({
        if ($this.Image -eq $ProcessingButtonColorBIG) {
            $this.Image = $DefaultButtonColorBIG
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
        $SLabel.Left            += $PanelSize / 2
        $SPanel.Left            += $PanelSize
        $LLabel.Left            += $PanelSize
        $LPanel.Left            += $PanelSize
        $TLabel.Left            += $PanelSize + $PanelSize / 2
        $TPanel.Left            += $PanelSize
        $LogoBox.Left           += $PanelSize
        $SSPanel.Left           += $PanelSize
        $SSPanel.Top            += 120
        $StatusBox.Left         += $PanelSize
        $StatusBox.Top          += 120
        $PaddingPanel.Top       += 120
        $MTPanel.Left           += $PanelSize
        $Form.Controls.AddRange(@($MSPanel,$MTPanel,$HPanel))
    }
})

$StartScript.Add_MouseEnter({
    $StartScript.Image = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\SSProcessing.png")
})

$StartScript.Add_MouseLeave({
    $StartScript.Image = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\SSDefault.png")
})

$StartScript.Add_Click({
    $StatusBox.Text = "|Iniciando Script...`r`n" + $StatusBox.Text

    $StartScript.Image = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\SSProcessing.png")

    $FromPath = "https://github.com/Zarckash/ZKTool/raw/main" # GitHub Downloads URL
    $ToPath   = "$env:userprofile\AppData\Local\Temp\ZKTool"  # Folder Structure Path
    $Download = New-Object net.webclient

    if ($SB1.Image -eq $ActiveButtonColor) { # Google Chrome
        $StatusBox.Text = "|Instalando Google Chrome...`r`n" + $StatusBox.Text
        $SB1.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Google.Chrome | Out-Null
        $SB1.Image = $ActiveButtonColor
    }
    if ($SB2.Image -eq $ActiveButtonColor) { # GeForce Experience
        $StatusBox.Text = "|Instalando GeForce Experience...`r`n" + $StatusBox.Text
        $SB2.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Nvidia.GeForceExperience | Out-Null
        $SB2.Image = $ActiveButtonColor
    }
    if ($SB3.Image -eq $ActiveButtonColor) { # NanaZip
        $StatusBox.Text = "|Instalando NanaZip...`r`n" + $StatusBox.Text
        $SB3.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id M2Team.NanaZip | Out-Null
        $SB3.Image = $ActiveButtonColor
    }
    if ($SB4.Image -eq $ActiveButtonColor) { # Discord
        $StatusBox.Text = "|Instalando Discord...`r`n" + $StatusBox.Text
        $SB4.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Discord.Discord | Out-Null
        $SB4.Image = $ActiveButtonColor
    }
    if ($SB5.Image -eq $ActiveButtonColor) { # HWMonitor
        $StatusBox.Text = "|Instalando HWMonitor...`r`n" + $StatusBox.Text
        $SB5.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id CPUID.HWMonitor | Out-Null
        $SB5.Image = $ActiveButtonColor
    }
    if ($SB6.Image -eq $ActiveButtonColor) { # MSI Afterburner
        $StatusBox.Text = "|Instalando MSI Afterburner...`r`n" + $StatusBox.Text
        $SB6.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/MSIAfterburner.zip", $ToPath+"\Apps\MSIAfterburner.zip")
        Expand-Archive -Path ($ToPath+"\Apps\MSIAfterburner.zip") -DestinationPath ($ToPath+"\Apps\MSIAfterburner") -Force
        Copy-Item -Path ($ToPath+"\Apps\MSIAfterburner\MSIAfterburner.lnk") -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force
        Start-Process ($ToPath+"\Apps\MSIAfterburner\MSIAfterburner.exe")
        $SB6.Image = $ActiveButtonColor
    }
    if ($SB7.Image -eq $ActiveButtonColor) { # Corsair iCue
        $StatusBox.Text = "|Instalando Corsair iCue...`r`n" + $StatusBox.Text
        $SB7.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Corsair.iCUE.4 | Out-Null
        $SB7.Image = $ActiveButtonColor
    }
    if ($SB8.Image -eq $ActiveButtonColor) { # Logitech G HUB
        $StatusBox.Text = "|Instalando Logitech G HUB...`r`n" + $StatusBox.Text
        $SB8.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Logitech.GHUB | Out-Null
        $SB8.Image = $ActiveButtonColor
    }
    if ($SB9.Image -eq $ActiveButtonColor) { # Razer Synapse
        $StatusBox.Text = "|Instalando Razer Synapse...`r`n" + $StatusBox.Text
        $SB9.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/RazerSynapse.exe", $ToPath+"\Apps\RazerSynapse.exe")
        Start-Process ($ToPath+"\Apps\RazerSynapse.exe")
        $SB9.Image = $ActiveButtonColor
    }
    if ($SB10.Image -eq $ActiveButtonColor) { # uTorrent Web
        $StatusBox.Text = "|Instalando uTorrent Web...`r`n" + $StatusBox.Text
        $SB10.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/uTorrentWeb.exe", $ToPath+"\Apps\uTorrentWeb.exe")
        Start-Process ($ToPath+"\Apps\uTorrentWeb.exe")
        $SB10.Image = $ActiveButtonColor
    }
    if ($SB11.Image -eq $ActiveButtonColor) { # Libre Office
        $StatusBox.Text = "|Instalando Libre Office...`r`n" + $StatusBox.Text
        $SB11.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id TheDocumentFoundation.LibreOffice | Out-Null
        $SB11.Image = $ActiveButtonColor
    }
    if ($SB12.Image -eq $ActiveButtonColor) { # MegaSync
        $StatusBox.Text = "|Instalando Libre Office...`r`n" + $StatusBox.Text
        $SB11.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Mega.MEGASync | Out-Null
        $SB12.Image = $ActiveButtonColor
    }
    if ($MSB1.Image -eq $ActiveButtonColor) { # Streamlabs OBS
        $StatusBox.Text = "|Instalando Streamlabs OBS...`r`n" + $StatusBox.Text
        $MSB1.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Streamlabs.StreamlabsOBS | Out-Null
        $MSB1.Image = $ActiveButtonColor
    }
    if ($MSB2.Image -eq $ActiveButtonColor) { # Photoshop Portable
        $StatusBox.Text = "|Instalando Adobe Photoshop...`r`n" + $StatusBox.Text
        $MSB2.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/Photoshop.ps1", $ToPath+"\Apps\Photoshop.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\Photoshop.ps1 ; exit"
        $MSB2.Image = $ActiveButtonColor
    }
    if ($MSB3.Image -eq $ActiveButtonColor) { # Premiere Portable
        $StatusBox.Text = "|Instalando Adobe Premiere...`r`n" + $StatusBox.Text
        $MSB3.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/Premiere.ps1", $ToPath+"\Apps\Premiere.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\Premiere.ps1 ; exit"
        $MSB3.Image = $ActiveButtonColor
    }
    if ($MSB4.Image -eq $ActiveButtonColor) { # Spotify
        $StatusBox.Text = "|Instalando Spotify...`r`n" + $StatusBox.Text
        $MSB4.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Spotify.Spotify | Out-Null
        $MSB4.Image = $ActiveButtonColor
    }
    if ($MSB5.Image -eq $ActiveButtonColor) { # Netflix
        $StatusBox.Text = "|Instalando Netflix...`r`n" + $StatusBox.Text
        $MSB5.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/Netflix.appx", $ToPath+"\Apps\Netflix.appx")
        &{ $ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\Netflix.appx") }
        $MSB5.Image = $ActiveButtonColor
    }
    if ($MSB6.Image -eq $ActiveButtonColor) { # Prime Video
        $StatusBox.Text = "|Instalando Prime Video...`r`n" + $StatusBox.Text
        $MSB6.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/DownloadPrimeVideo.ps1", $ToPath+"\Apps\DownloadPrimeVideo.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\DownloadPrimeVideo.ps1 ; exit"
        $MSB6.Image = $ActiveButtonColor
    }
    if ($MSB7.Image -eq $ActiveButtonColor) { # VLC Media Player
        $StatusBox.Text = "|Instalando VLC Media Player...`r`n" + $StatusBox.Text
        $MSB7.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/VLCMediaPlayer.exe", $ToPath+"\Apps\VLCMediaPlayer.exe")
        Start-Process ($ToPath+"\Apps\VLCMediaPlayer.exe")
        $MSB7.Image = $ActiveButtonColor
    }
    if ($MSB8.Image -eq $ActiveButtonColor) { # GitHub Desktop
        $StatusBox.Text = "|Instalando GitHub Desktop...`r`n" + $StatusBox.Text
        $MSB8.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id GitHub.GitHubDesktop | Out-Null
        $MSB8.Image = $ActiveButtonColor
    }
    if ($MSB9.Image -eq $ActiveButtonColor) { # WinRAR
        $StatusBox.Text = "|Instalando WinRAR...`r`n" + $StatusBox.Text
        $MSB9.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RARLab.WinRAR | Out-Null
        $MSB9.Image = $ActiveButtonColor
    }
    if ($MSB10.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
        $MSB10.Image = $ProcessingButtonColor
        $MSB10.Image = $ActiveButtonColor
    }
    if ($MSB11.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
        $MSB11.Image = $ProcessingButtonColor
        $MSB11.Image = $ActiveButtonColor
    }
    if ($MSB12.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
        $MSB12.Image = $ProcessingButtonColor
        $MSB12.Image = $ActiveButtonColor
    }
    if ($MSB13.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
        $MSB13.Image = $ProcessingButtonColor
        $MSB13.Image = $ActiveButtonColor
    }
    if ($MSB14.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
        $MSB14.Image = $ProcessingButtonColor
        $MSB14.Image = $ActiveButtonColor
    }
    if ($MSB15.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
        $MSB15.Image = $ProcessingButtonColor
        $MSB15.Image = $ActiveButtonColor
    }
    if ($MSB16.Image -eq $ActiveButtonColor) { # Valorant
        $StatusBox.Text = "|Instalando Valorant...`r`n" + $StatusBox.Text
        $MSB16.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/Valorant.ps1", $ToPath+"\Apps\Valorant.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\Valorant.ps1 ; exit" 
        $MSB16.Image = $ActiveButtonColor
    }
    if ($MSB17.Image -eq $ActiveButtonColor) { # League of Legends
        $StatusBox.Text = "|Instalando League of Legends...`r`n" + $StatusBox.Text
        $MSB17.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RiotGames.LeagueOfLegends.EUW | Out-Null
        $MSB17.Image = $ActiveButtonColor
    }
    if ($MSB18.Image -eq $ActiveButtonColor) { # Escape From Tarkov
        $StatusBox.Text = "|Instalando Escape From Tarkov...`r`n" + $StatusBox.Text
        $MSB18.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/Tarkov.ps1", $ToPath+"\Apps\Tarkov.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\Tarkov.ps1 ; exit"
        $MSB18.Image = $ActiveButtonColor
    }
    if ($LB1.Image -eq $ActiveButtonColor) { # Steam
        $StatusBox.Text = "|Instalando Steam...`r`n" + $StatusBox.Text
        $LB1.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Valve.Steam | Out-Null
        $LB1.Image = $ActiveButtonColor
    }
    if ($LB2.Image -eq $ActiveButtonColor) { # EA Desktop
        $StatusBox.Text = "|Instalando EA Desktop...`r`n" + $StatusBox.Text
        $LB2.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id ElectronicArts.EADesktop | Out-Null
        $LB2.Image = $ActiveButtonColor
    }
    if ($LB3.Image -eq $ActiveButtonColor) { # Ubisoft Connect
        $StatusBox.Text = "|Instalando Ubisoft Connect...`r`n" + $StatusBox.Text
        $LB3.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Ubisoft.Connect | Out-Null
        $LB3.Image = $ActiveButtonColor
    }
    if ($LB4.Image -eq $ActiveButtonColor) { # Battle.Net
        $StatusBox.Text = "|Instalando Battle.Net...`r`n" + $StatusBox.Text
        $LB4.Image = $ProcessingButtonColor
        $TempFile = "https://www.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live&id=undefined"
        $Download.DownloadFile($TempFile, $ToPath+"\Apps\BattleNet.exe")
        Start-Process ($ToPath+"\Apps\BattleNet.exe")
        $LB4.Image = $ActiveButtonColor
    }
    if ($LB5.Image -eq $ActiveButtonColor) { # GOG Galaxy
        $StatusBox.Text = "|Instalando GOG Galaxy...`r`n" + $StatusBox.Text
        $LB5.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id GOG.Galaxy | Out-Null
        $LB5.Image = $ActiveButtonColor
    }
    if ($LB6.Image -eq $ActiveButtonColor) { # Rockstar Games Launcher
        $StatusBox.Text = "|Instalando Rockstar Games Launcher...`r`n" + $StatusBox.Text
        $LB6.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/RockstarGamesLauncher.exe", $ToPath+"\Apps\RockstarGamesLauncher.exe")
        Start-Process ($ToPath+"\Apps\RockstarGamesLauncher.exe")
        $LB6.Image = $ActiveButtonColor
    }
    if ($LB7.Image -eq $ActiveButtonColor) { # Epic Games Launcher
        $StatusBox.Text = "|Instalando Epic Games Launcher...`r`n" + $StatusBox.Text
        $LB7.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id EpicGames.EpicGamesLauncher | Out-Null
        $LB7.Image = $ActiveButtonColor
    }
    if ($LB8.Image -eq $ActiveButtonColor) { # Xbox App
        $StatusBox.Text = "|Instalando Xbox App...`r`n" + $StatusBox.Text
        $LB8.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/XboxApp.appx", $ToPath+"\Apps\XboxApp.appx")
        &{$ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\XboxApp.appx")} 
        $LB8.Image = $ActiveButtonColor
    }
    if ($TB1.Image -eq $ActiveButtonColorBIG) { # Essential Tweaks
        $StatusBox.Text = "|AJUSTES ESENCIALES`r`n`r`n" + $StatusBox.Text
        $TB1.Image = $ProcessingButtonColorBIG

        # Create Restore Point
        $StatusBox.Text = "|Creando Punto De Restauracion...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -Type DWord -Value 0
        Enable-ComputerRestore -Drive "C:\"
        Checkpoint-Computer -Description "Pre Optimizacion" -RestorePointType "MODIFY_SETTINGS"
        
        # Disable UAC
        $StatusBox.Text = "|Desactivando UAC...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0
        
        # Disable Fast Boot
        $StatusBox.Text = "|Desactivando Fast Boot...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0
    
        # Enable Hardware Acceleration
        $StatusBox.Text = "|Activando Aceleracion De Hardware...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Type Dword -Value 2

        # Enable Borderless Optimizations
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\GraphicsSettings" -Name "SwapEffectUpgradeCache" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences" -Name "DirectXUserGlobalSettings" -Value "SwapEffectUpgradeEnable=1;1"

        # Set High Performance Profile
        $StatusBox.Text = "|Estableciendo Perfil De Alto Rendimiento...`r`n" + $StatusBox.Text
        powercfg.exe -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
        
        # Set Sleep Timeout Timer
        $StatusBox.Text = "|Estableciendo Sleep Timeout...`r`n" + $StatusBox.Text
        powercfg /X monitor-timeout-ac 15
        powercfg /X monitor-timeout-dc 15
        powercfg /X standby-timeout-ac 0
        powercfg /X standby-timeout-dc 0
    
        # Show File Extensions
        $StatusBox.Text = "|Activando Extensiones De Archivos...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0
        
        # Open File Explorer In This PC Page
        $StatusBox.Text = "|Estableciendo Abrir El Explorador De Archivos En  La Pagina Este Equipo...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

        # Reduce svchost Process Amount
        $RamCapacity = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1kb
        if ($RamCapacity -ige 16777216) {
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $RamCapacity
        }
    
        # Disable Mouse Acceleration
        $StatusBox.Text = "|Desactivando Aceleracion Del Raton...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0

        # Disable Keyboard Layout Shortcut
        $StatusBox.Text = "|Desactivando Cambio De Idioma Del Teclado...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Hotkey" -Value 3
        Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Language Hotkey" -Value 3
        Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Layout Hotkey" -Value 3
        
        # GPU Optimizations
        $StatusBox.Text = "|Optimizando Registros De GPU...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Type DWord -Value 268435455
    
        # Disable Background Apps
        $StatusBox.Text = "|Desactivando Aplicaciones En Segundo Plano...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

        # Hide Keyboard Layout Icon
        $StatusBox.Text = "|Ocultando El Boton De Idioma Del Teclado...`r`n" + $StatusBox.Text
        Set-WinLanguageBarOption -UseLegacyLanguageBar
        New-Item -Path "HKCU:\Software\Microsoft\CTF\" -Name "LangBar" | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ExtraIconsOnMinimized" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Label" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ShowStatus" -Type DWord -Value 3
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Transparency" -Type DWord -Value 255
    
        # Disable Telemetry
        $StatusBox.Text = "|Deshabilitando Telemetria...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
    
        # Disable Aplication Sugestions
        $StatusBox.Text = "|Deshabilitando Sugerencias De Aplicaciones...`r`n" + $StatusBox.Text
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
        $StatusBox.Text = "|Deshabilitando Historial De Actividad...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0

        # Disable Nearby Sharing
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "CdpSessionUserAuthzPolicy" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "RomeSdkChannelUserAuthzPolicy" -Type DWord -Value 0
    
        # Disable Feedback
        $StatusBox.Text = "|Deshabilitando Feedback...`r`n" + $StatusBox.Text
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
    
        # Service Tweaks To Manual 
        $StatusBox.Text = "|Deshabilitando Servicios...`r`n" + $StatusBox.Text
        $services = @(
        "diagnosticshub.standardcollector.service"     # Microsoft (R) Diagnostics Hub Standard Collector Service
        "DiagTrack"                                    # Diagnostics Tracking Service
        "dmwappushservice"                             # WAP Push Message Routing Service (see known issues)
        "lfsvc"                                        # Geolocation Service
        "MapsBroker"                                   # Downloaded Maps Manager
        "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
        "RemoteAccess"                                 # Routing and Remote Access
        "RemoteRegistry"                               # Remote Registry
        "SharedAccess"                                 # Internet Connection Sharing (ICS)
        "TrkWks"                                       # Distributed Link Tracking Client
        "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
        "WerSvc"                                       # Ddisables windows error reporting
        "Fax"                                          # Disables fax
        "fhsvc"                                        # Disables fax histroy
        "gupdate"                                      # Disables google update
        "gupdatem"                                     # Disables another google update
        "stisvc"                                       # Disables Windows Image Acquisition (WIA)
        "AJRouter"                                     # Disables (needed for AllJoyn Router Service)
        "MSDTC"                                        # Disables Distributed Transaction Coordinator
        "WpcMonSvc"                                    # Disables Parental Controls
        "PhoneSvc"                                     # Disables Phone Service(Manages the telephony state on the device)
        "PcaSvc"                                       # Disables Program Compatibility Assistant Service
        "SysMain"                                      # Disables sysmain
        "lmhosts"                                      # Disables TCP/IP NetBIOS Helper
        "wisvc"                                        # Disables Windows Insider program(Windows Insider will not work)
        "SCardSvr"                                     # Disables Windows smart card
        "EntAppSvc"                                    # Disables enterprise application management.
        "Browser"                                      # Disables computer browser
        "edgeupdate"                                   # Disables one of edge update service  
        "MicrosoftEdgeElevationService"                # Disables one of edge  service 
        "edgeupdatem"                                  # Disables another one of update service (disables edgeupdatem)                          
        "PerfHost"                                     # Disables remote users and 64-bit processes to query performance .
        "BcastDVRUserService_48486de"                  # Disables GameDVR and Broadcast is used for Game Recordings and Live Broadcasts
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
    
        # Uninstall Microsoft Bloatware
        $StatusBox.Text = "|Desinstalando Microsoft Bloatware...`r`n" + $StatusBox.Text
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
        Get-AppxPackage -All -Name *Disney* | Remove-AppxPackage
        }
        $TB1.Image = $ActiveButtonColorBIG
    }
    if ($TB2.Image -eq $ActiveButtonColor) { # Extra Tweaks
        $StatusBox.Text = "|Aplicando Extra Tweaks...`r`n`r`n" + $StatusBox.Text
        $TB2.Image = $ProcessingButtonColor
    
        # RAM Cleaning And Lots Of Optimizations
        $Download.DownloadFile($FromPath+"/Apps/PowerRun.exe", $ToPath+"\Apps\PowerRun.exe")
        $Download.DownloadFile($FromPath+"/Apps/RamCleaner.reg", $ToPath+"\Apps\RamCleaner.reg")
        Start-Process ($ToPath+"\Apps\PowerRun.exe") "%%PowerRunDir%%\RamCleaner.reg"

        # Show TaskBar Only In Main Screen
        $StatusBox.Text = "|Desactivando Mostrar Barra De Tareas En Todos Los Monitores...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MMTaskbarEnabled" -Type DWord -Value 0

        # Show More Pinned Items In Start Menu
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -Type DWord -Value 1

        # Keep Windows From Creating DumpStack.log File
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "EnableLogFile" -Type DWord -Value 0

        # Stop Microsoft Store From Updating Apps Automatically
        $StatusBox.Text = "|Desactivando Actualizaciones Automaticas De Microsoft Store...`r`n" + $StatusBox.Text
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "WindowsStore"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "AutoDownload" -Type DWord -Value 2
    
        # Hide TaskBar View Button
        $StatusBox.Text = "|Ocultando Boton Vista De Tareas...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    
        # Hide Cortana Button
        $StatusBox.Text = "|Ocultando Boton De Cortana...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0

        # Hide Meet Now Button
        $StatusBox.Text = "|Ocultando Boton De Reunirse Ahora...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1
    
        # Hide Search Button
        $StatusBox.Text = "|Ocultando Boton De Busqueda...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

        # Hide Search Recomendations
        Set-ItemProperty -Path "HKCU:\\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Type DWord -Value 0
        
        # Hide Chat Button
        $StatusBox.Text = "|Ocultando Boton De Chats...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0

        # Set Desktop Icons Size To Small
        $StatusBox.Text = "|Reduciendo El Tama??o De Los Iconos Del Escritorio...`r`n" + $StatusBox.Text
        taskkill /f /im explorer.exe
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop" -Name "IconSize" -Type DWord -Value 32
        explorer.exe
    
        # Set Dark Theme
        $StatusBox.Text = "|Estableciendo Modo Oscuro...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
    
        # Hide Recent Files And Folders In Explorer
        $StatusBox.Text = "|Ocultando Archivos Y Carpetas Recientes De Acceso Rapido...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0
    
        # Clipboard History
        $StatusBox.Text = "|Activando El Historial Del Portapapeles...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Type DWord -Value 1
    
        # Change Computer Name
        $pcname = $env:username.ToUpper() + "-PC"
        $StatusBox.Text = "|Cambiando Nombre Del Equipo A " + $pcname + "...`r`n" + $StatusBox.Text
        Rename-Computer -NewName $pcname
    
        # Set Private Network
        $StatusBox.Text = "|Estableciendo Red Privada...`r`n" + $StatusBox.Text
        Set-NetConnectionProfile -NetworkCategory Private
    
        # Show File Operations Details
        $StatusBox.Text = "|Mostrando Detalles De Transferencias De Archivos...`r`n" + $StatusBox.Text
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "OperationStatusManager" | Out-Null
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1

        # Clean "New" In Context Menu
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        # Texto OpenDocument
        Remove-ItemProperty -Path "HKCR:\.odt\LibreOffice.WriterDocument.1\ShellNew" -Name "FileName"
        # Hoja De Calculo OpenDocument
        Remove-ItemProperty -Path "HKCR:\.ods\LibreOffice.CalcDocument.1\ShellNew" -Name "FileName"
        # Presentacion OpenDocument
        Remove-ItemProperty -Path "HKCR:\.odp\LibreOffice.ImpressDocument.1\ShellNew" -Name "FileName"
        # Dibujo OpenDocument
        Remove-ItemProperty -Path "HKCR:\.odg\LibreOffice.DrawDocument.1\ShellNew" -Name "FileName"
        # Carpeta Comprimida En Zip
        Remove-ItemProperty -Path "HKCR:\.zip\CompressedFolder\ShellNew" -Name "Data"
        Remove-ItemProperty -Path "HKCR:\.zip\CompressedFolder\ShellNew" -Name "ItemName"
    
        # Sounds Communications Do Nothing
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -Type DWord -Value 3
    
        # Hide Buttons From Power Button
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "FlyoutMenuSettings" | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowSleepOption" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowLockOption" -Type DWord -Value 0
    
        # Alt Tab Open Windows Only
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Type DWord -Value 3
    
        # Uninstall Windows Optional Features
        &{ $ProgressPreference = 'SilentlyContinue'
        $StatusBox.Text = "|Desinstalando Servidor OpenSSH...`r`n" + $StatusBox.Text
        Get-WindowsPackage -Online | Where PackageName -like *SSH* | Remove-WindowsPackage -Online -NoRestart | Out-Null
        $StatusBox.Text = "|Desinstalando Rostro De Windows Hello...`r`n" + $StatusBox.Text
        Get-WindowsPackage -Online | Where PackageName -like *Hello-Face* | Remove-WindowsPackage -Online -NoRestart | Out-Null
        $StatusBox.Text = "|Desinstalando Grabacion De Acciones Del Usuario...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 /NoRestart | Out-Null
        $StatusBox.Text = "|Desinstalando Modo De Internet Explorer...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /NoRestart | Out-Null
        $StatusBox.Text = "|Desinstalando WordPad...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0 /NoRestart | Out-Null
        $StatusBox.Text = "|Desinstalando Windows Powershell ISE...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0 /NoRestart | Out-Null
        $StatusBox.Text = "|Desinstalando Reconocedor Matematico...`r`n" + $StatusBox.Text
        DISM /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0 /NoRestart | Out-Null
        }
        $TB2.Image = $ActiveButtonColor
    } 
    if ($TB3.Image -eq $ActiveButtonColor) { # Nvidia Settings
        $StatusBox.Text = "|Aplicando Ajustes Al Panel De Control De Nvidia...`r`n" + $StatusBox.Text
        $TB3.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/ProfileInspector.exe", $ToPath+"\Apps\ProfileInspector.exe")
        $Download.DownloadFile($FromPath+"/Configs/NvidiaProfiles.nip", $ToPath+"\Configs\NvidiaProfiles.nip")
        Start-Process ($ToPath+"\Apps\ProfileInspector.exe")($ToPath+"\Configs\NvidiaProfiles.nip")
        $TB3.Image = $ActiveButtonColor
    } 
    if ($TB4.Image -eq $ActiveButtonColor) { # Reduce Icons Spacing
        $StatusBox.Text = "|Reduciendo Espacio Entre Iconos...`r`n" + $StatusBox.Text
        $TB4.Image = $ProcessingButtonColor
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "IconSpacing" -Value -900
        $TB4.Image = $ActiveButtonColor
    } 
    if ($TB5.Image -eq $ActiveButtonColor) { # Hide Shortcut Arrows
        $StatusBox.Text = "|Ocultando Flechas De Acceso Directo...`r`n" + $StatusBox.Text
        $TB5.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Configs/Blank.ico", $ToPath+"\Configs\Blank.ico")
        Unblock-File ($ToPath+"\Configs\Blank.ico")
        Copy-Item -Path ($ToPath+"\Configs\Blank.ico") -Destination "C:\Windows\System32" -Force
        $Download.DownloadFile($FromPath+"/Apps/BlankShortcut.reg", $ToPath+"\Apps\BlankShortcut.reg")
        regedit /s ($ToPath+"\Apps\BlankShortcut.reg")
        $TB5.Image = $ActiveButtonColor
    } 
    if ($TB6.Image -eq $ActiveButtonColor) { # Set Modern Cursor
        $StatusBox.Text = "|Estableciendo Cursor Personalizado...`r`n" + $StatusBox.Text
        $TB6.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Configs/ModernCursor.zip", $ToPath+"\Configs\ModernCursor.zip")
        Expand-Archive -Path ($ToPath+"\Configs\ModernCursor.zip") -DestinationPath 'C:\Windows\Cursors\Modern Cursor' -Force
        $Download.DownloadFile($FromPath+"/Apps/ModernCursor.reg", $ToPath+"\Apps\ModernCursor.reg")
        regedit /s $env:userprofile\AppData\Local\Temp\ZKTool\Apps\ModernCursor.reg
        $TB6.Image = $ActiveButtonColor
    } 
    if ($TB7.Image -eq $ActiveButtonColor) { # Disable Cortana
        $StatusBox.Text = "|Deshabilitando Cortana...`r`n" + $StatusBox.Text
        $TB7.Image = $ProcessingButtonColor
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
        $TB7.Image = $ActiveButtonColor
    } 
    if ($TB8.Image -eq $ActiveButtonColor) { # Uninstall OneDrive
        $StatusBox.Text = "|Desinstalando One Drive...`r`n" + $StatusBox.Text
        $TB8.Image = $ProcessingButtonColor
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
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        }
        Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
        &{ $ProgressPreference = 'SilentlyContinue'; Get-AppxPackage Microsoft.OneDriveSync | Remove-AppxPackage }
        $TB8.Image = $ActiveButtonColor
    } 
    if ($TB9.Image -eq $ActiveButtonColor) { # Uninstall Xbox Game Bar
        $StatusBox.Text = "|Desinstalando Xbox Game Bar...`r`n" + $StatusBox.Text
        $TB9.Image = $ProcessingButtonColor
        Get-AppxPackage "Microsoft.XboxGamingOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage
        Get-AppxPackage "Microsoft.GamingApp" | Remove-AppxPackage 
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
        $TB9.Image = $ActiveButtonColor
    } 
    if ($TB10.Image -eq $ActiveButtonColor) { # Ram Cleaner (ISLC)
        $StatusBox.Text = "|Instalando Inteligent Standby List Cleaner (ISLC)...`r`n" + $StatusBox.Text
        $TB10.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/ISLC.zip", $ToPath+"\Apps\ISLC.zip")
        Expand-Archive -Path ($ToPath+"\Apps\ISLC.zip") -DestinationPath 'C:\Program Files\ISLC' -Force
        Move-Item -Path 'C:\Program Files\ISLC\ISLC Intelligent Standby List Cleaner.lnk' -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
        Start-Process "C:\Program Files\ISLC\Intelligent standby list cleaner ISLC.exe"
        $TB10.Image = $ActiveButtonColor
    } 
    if ($TB11.Image -eq $ActiveButtonColor) { # VisualFX Fix
        $StatusBox.Text = "|Ajustando Animaciones De Windows...`r`n" + $StatusBox.Text
        $TB11.Image = $ProcessingButtonColor
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
        $TB11.Image = $ActiveButtonColor
    }  
    if ($MTB1.Image -eq $ActiveButtonColorBIG) { # Activate Windows Pro Edition
        $StatusBox.Text = "|Activando Windows Pro Edition...`r`n" + $StatusBox.Text
        $MTB1.Image = $ProcessingButtonColorBIG
        cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
        cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /skms kms.digiboy.ir
        cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ato
        $MTB1.Image = $ActiveButtonColorBIG
    }
    if ($MTB2.Image -eq $ActiveButtonColor) { # Install Visual C++
        $StatusBox.Text = "|Instalando Todas Las Versiones De Visual C++...`r`n" + $StatusBox.Text
        $MTB2.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2005Redist-x64 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2005Redist-x86 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2008Redist-x64 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2008Redist-x86 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2010Redist-x64 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2010Redist-x86 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2012Redist-x64 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2012Redist-x86 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2013Redist-x64 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2013Redist-x86 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2015-2022Redist-x64 | Out-Null
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VC++2015-2022Redist-x86 | Out-Null
        $MTB2.Image = $ActiveButtonColor
    }  
    if ($MTB3.Image -eq $ActiveButtonColor) { # Install TaskbarX
        $StatusBox.Text = "|Instalando TaskbarX...`r`n" + $StatusBox.Text
        $MTB3.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/TaskbarX.zip", $ToPath+"\Apps\TaskbarX.zip")
        Expand-Archive -Path ($ToPath+"\Apps\TaskbarX.zip") -DestinationPath 'C:\Program Files\TaskbarX' -Force
        Copy-Item -Path 'C:\Program Files\TaskbarX\TaskbarX Configurator.lnk' -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force
        Start-Process "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\TaskbarX Configurator.lnk"
        $MTB3.Image = $ActiveButtonColor
    }  
    if ($MTB4.Image -eq $ActiveButtonColor) { # Install HEVC + HEIF
        $StatusBox.Text = "|Instalando Extensiones De Video HEVC Y HEIF... `r`n" + $StatusBox.Text
        $MTB4.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/HEVC.appx", $ToPath+"\Apps\HEVC.appx")
        $Download.DownloadFile($FromPath+"/Apps/HEIF.appx", $ToPath+"\Apps\HEIF.appx")
        &{$ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\HEVC.appx"); Add-AppxPackage ($ToPath+"\Apps\HEIF.appx")}
        $MTB4.Image = $ActiveButtonColor
    }  
    if ($MTB5.Image -eq $ActiveButtonColor) { # Windows Terminal Fix
        $StatusBox.Text = "|Aplicando Ajustes A Windows Terminal...`r`n" + $StatusBox.Text
        $MTB5.Image = $ProcessingButtonColor
        if (!(Test-Path -Path $env:userprofile\AppData\Local\Microsoft\Windows\Fonts\SourceCodePro*)) {
            $Download.DownloadFile($FromPath+"/Configs/FontSourceCodePro.zip", $ToPath+"\Configs\FontSourceCodePro.zip")
            Expand-Archive -Path ($ToPath+"\Configs\FontSourceCodePro.zip") -DestinationPath ($ToPath+"\Configs\FontSourceCodePro") -Force
            Start-Process ($ToPath+"\Configs\FontSourceCodePro\Install.exe")
            Wait-Process -Name "Install"
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.PowerShell | Out-Null
        }
        $Download.DownloadFile($FromPath+"/Configs/WindowsTerminalFix.zip", $ToPath+"\Configs\WindowsTerminalFix.zip")
        Expand-Archive -Path ($ToPath+"\Configs\WindowsTerminalFix.zip") -DestinationPath $env:userprofile\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force
        $MTB5.Image = $ActiveButtonColor 
    }  
    if ($MTB6.Image -eq $ActiveButtonColor) { # Extreme Power Plan
        $StatusBox.Text = "|Activando Highest Performance Power Plan...`r`n" + $StatusBox.Text
        $MTB6.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/HighestPerformance.pow", $ToPath+"\Apps\HighestPerformance.pow")
        $Download.DownloadFile($FromPath+"/Apps/PowerPlan.cmd", $ToPath+"\Apps\PowerPlan.cmd")
        Start-Process ($ToPath+"\Apps\PowerPlan.cmd")
        Start-Sleep 5
        powercfg /X monitor-timeout-ac 15
        powercfg /X monitor-timeout-dc 15
        powercfg /X standby-timeout-ac 0
        powercfg /X standby-timeout-dc 0
        $MTB6.Image = $ActiveButtonColor
    }  
    if ($MTB7.Image -eq $ActiveButtonColor) { # Performance Counters
        $StatusBox.Text = "|Reconstruyendo Contadores De Rendimiento...`r`n" + $StatusBox.Text
        $MTB7.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/PerformanceCounters.cmd", $ToPath+"\Apps\PerformanceCounters.cmd")
        Start-Process ($ToPath+"\ZKTool\Apps\PerformanceCounters.cmd")
        $MTB7.Image = $ActiveButtonColor
    }    
    if ($MTB9.Image -eq $ActiveButtonColor) { # Autoruns
        $StatusBox.Text = "|Abriendo Autoruns...`r`n" + $StatusBox.Text
        $MTB9.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/Autoruns.exe", $ToPath+"\Apps\Autoruns.exe")
        Start-Process ($ToPath+"\Apps\Autoruns.exe")
        $MTB9.Image = $ActiveButtonColor
    }
    if ($MTB10.Image -eq $ActiveButtonColor) { # Unpin All Apps
        $StatusBox.Text = "|Desanclando Todas Las Aplicaciones...`r`n" + $StatusBox.Text
        $MTB10.Image = $ProcessingButtonColor
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "Favorites" -Type Binary -Value ([byte[]](255))
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "FavoritesResolve" -ErrorAction SilentlyContinue
        $Download.DownloadFile($FromPath+"/Configs/start.bin", $ToPath+"\Configs\start.bin")
        Copy-Item -Path ($ToPath+"\Configs\start.bin") -Destination "$env:userprofile\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState" -Force
        $MTB10.Image = $ActiveButtonColor
    }
    if ($MTB11.Image -eq $ActiveButtonColor) { # Remove Realtek
        $StatusBox.Text = "|Quitando Realtek Audio Service...`r`n" + $StatusBox.Text
        $MTB11.Image = $ProcessingButtonColor
        sc stop Audiosrv | pwsh
        sc stop RtkAudioUniversalService | pwsh
        taskkill /f /im RtkAudUService64.exe | Out-Null
        sc delete RtkAudioUniversalService | pwsh
        sc start Audiosrv | pwsh
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "RtkAudUService"
        $MTB11.Image = $ActiveButtonColor
    }
    if ($MTB12.Image -eq $ActiveButtonColor) { # Link Shell Extension
        $StatusBox.Text = "|Instalando Link Shell Extension...`r`n" + $StatusBox.Text
        $MTB12.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/LinkShellExtension.exe", $ToPath+"\Apps\LinkShellExtension.exe")
        "%userprofile%\AppData\Local\Temp\ZKTool\Apps\LinkShellExtension.exe /S /Language=English" | cmd
        $MTB12.Image = $ActiveButtonColor
    }
    if ($MTB13.Image -eq $ActiveButtonColor) { # Increase PageFile Size
        $RamCapacity = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1mb
        if ($RamCapacity -le 17000) {
            $RamCapacity += $RamCapacity/2
            $StatusBox.Text = "|Estableciendo El Tama??o Del Archivo De Paginacion En $RamCapacity MB...`r`n" + $StatusBox.Text
            $MTB13.Image = $ProcessingButtonColor
            $PageFile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
            $PageFile.AutomaticManagedPagefile = $false
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "c:\pagefile.sys $RamCapacity $RamCapacity"
            $MTB13.Image = $ActiveButtonColor
        }else {
            $StatusBox.Text = "|La Cantidad De Memoria RAM Es Superior A Los 16GB, No Se Realizara Ningun Cambio...`r`n" + $StatusBox.Text
        }
    }
    if ($MTB14.Image -eq $ActiveButtonColor) { # Z390 Lan Drivers
        $StatusBox.Text = "|Instalando Drivers De Red...`r`n" + $StatusBox.Text
        $MTB14.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/LanDrivers.exe", $ToPath+"\Apps\LanDrivers.exe")
        Start-Process ($ToPath+"\Apps\LanDrivers.exe")
        $MTB14.Image = $ActiveButtonColor
    }
    if ($MTB15.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Void...`r`n" + $StatusBox.Text
        $MTB15.Image = $ProcessingButtonColor
        $MTB15.Image = $ActiveButtonColor
    }
    if ($MTB16.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Void...`r`n" + $StatusBox.Text
        $MTB16.Image = $ProcessingButtonColor
        $MTB16.Image = $ActiveButtonColor
    }
    if ($MTB17.Image -eq $ActiveButtonColor) { # Void
        $StatusBox.Text = "|Void...`r`n" + $StatusBox.Text
        $MTB17.Image = $ProcessingButtonColor
        $MTB17.Image = $ActiveButtonColor
    }
    if ($HB1.Image -eq $ActiveButtonColor) { # Rufus
        $StatusBox.Text = "|Iniciando Rufus...`r`n" + $StatusBox.Text
        $HB1.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/Rufus.exe", $ToPath+"\Apps\Rufus.exe")
        Start-Process ($ToPath+"\Apps\Rufus.exe")
        $HB1.Image = $ActiveButtonColor
    } 
    if ($HB2.Image -eq $ActiveButtonColor) { # MSI Afterburner Config
        $StatusBox.Text = "|Configurando MSI Afterburner...`r`n" + $StatusBox.Text
        $HB2.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Configs/Profiles.zip", $ToPath+"\Configs\Profiles.zip")
        Expand-Archive -Path ($ToPath+"\Configs\Profiles.zip") -DestinationPath 'C:\Program Files (x86)\MSI Afterburner\Profiles' -Force
        $HB2.Image = $ActiveButtonColor
    }   
    if ($HB3.Image -eq $ActiveButtonColor) { # Wallpaper Engine Tweak
        $StatusBox.Text = "|Aplicando Configuracion De Wallpaper Engine...`r`n" + $StatusBox.Text
        $HB3.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/WallpaperEngine.zip", $ToPath+"\Apps\WallpaperEngine.zip")
        Expand-Archive -Path ($ToPath+"\Apps\WallpaperEngine.zip") -DestinationPath ($ToPath+"\Apps\WallpaperEngine") -Force
        Move-Item -Path ($ToPath+"\Apps\WallpaperEngine\NextWallpaper.exe") -Destination "$env:windir\System32\NextWallpaper.exe"
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        New-Item -Path "HKCR:\Directory\Background\shell\" -Name "Siguiente Wallpaper"
        New-Item -Path "HKCR:\Directory\Background\shell\Siguiente Wallpaper\" -Name "command"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\Siguiente Wallpaper\" -Name "Icon" -Value "NextWallpaper.exe,0"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\Siguiente Wallpaper\command\" -Name "(default)" -Value "NextWallpaper.exe"
        Move-Item -Path ($ToPath+"\Apps\WallpaperEngine\Wallpaper Engine.lnk") -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
        Set-ItemProperty -Path "HKCU:\Software\WallpaperEngine" -Name "hideTrayIcon" -Type DWord -Value 1
        Add-MpPreference -ExclusionPath "$env:windir\System32\NextWallpaper.exe"
        $HB3.Image = $ActiveButtonColor
    }   
    if ($HB4.Image -eq $ActiveButtonColor) { # Software RL
        $StatusBox.Text = "|Instalando Software RL...`r`n" + $StatusBox.Text
        $HB4.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/RLSoftware.exe", $ToPath+"\Apps\RLSoftware.exe")
        Start-Process ($ToPath+"\Apps\RLSoftware.exe")
        $HB4.Image = $ActiveButtonColor
    }   
    if ($HB5.Image -eq $ActiveButtonColor) { # RGB Fusion
        $StatusBox.Text = "|Instalando RGB Fusion...`r`n" + $StatusBox.Text
        $HB5.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/RGBFusion.ps1", $ToPath+"\Apps\RGBFusion.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\RGBFusion.ps1 ; exit"
        $HB5.Image = $ActiveButtonColor
    }   
    if ($HB6.Image -eq $ActiveButtonColor) { # JDK 17
        $StatusBox.Text = "|Instalando JDK 17...`r`n" + $StatusBox.Text
        $HB6.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/JDK17.ps1", $ToPath+"\Apps\JDK17.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\JDK17.ps1 ; exit"
        $HB6.Image = $ActiveButtonColor
    }   
    if ($HB7.Image -eq $ActiveButtonColor) { # Eclipse IDE
        $StatusBox.Text = "|Instalando Eclipse IDE...`r`n" + $StatusBox.Text
        $HB7.Image = $ProcessingButtonColor
        $Download.DownloadFile($FromPath+"/Apps/Eclipse.ps1", $ToPath+"\Apps\Eclipse.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\Eclipse.ps1 ; exit"
        $HB7.Image = $ActiveButtonColor
    }   
    if ($HB8.Image -eq $ActiveButtonColor) { # Visual Studio Code
        $StatusBox.Text = "|Instalando Visual Studio Code...`r`n" + $StatusBox.Text
        $HB8.Image = $ProcessingButtonColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VisualStudioCode | Out-Null
        $HB8.Image = $ActiveButtonColor
    }   
    if ($HB9.Image -eq $ActiveButtonColor) { # Game Settings
        $StatusBox.Text = "|Abriendo Game Settings Options...`r`n" + $StatusBox.Text
        $HB9.Image = $ProcessingButtonColor
        Iex (Iwr ($FromPath+"/Scripts/GameSettings.ps1"))
        $HB9.Image = $ActiveButtonColor
    }
    if ($MTB8.Image -eq $ActiveButtonColor) { # Static IP + DNS
        $StatusBox.Text = "|Abriendo Selector De IPs...`r`n" + $StatusBox.Text
        $MTB8.Image = $ProcessingButtonColor
        iex ((New-Object System.Net.WebClient).DownloadString(($FromPath+"/Scripts/ChooseIp.ps1")))
        $MTB8.Image = $ActiveButtonColor
    }

    $Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB16,
    $MSB17,$MSB18,$LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB1,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11,$MTB1,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$MTB12,
    $MTB13,$MTB14,$MTB15,$MTB16,$MTB17,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9)
    foreach ($Button in $Buttons) {
        if ($Button.Image -eq $ActiveButtonColor) {
                $Button.Image = $DefaultButtonColor
                $Button.ForeColor = $LabelColor
        }
        if ($Button.Image -eq $ActiveButtonColorBIG) {
            $Button.Image = $DefaultButtonColorBIG
            $Button.ForeColor = $LabelColor
        }
    }

    $StatusBox.Text = "|Comprobando Instalaciones...`r`n" + $StatusBox.Text

    $Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB11,$SB12,$MSB1,$MSB4,$MSB5,$MSB6,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB17,$LB1,$LB2,$LB3,$LB5,
    $LB7,$LB8,$HB5,$HB8)
    foreach ($Button in $Buttons) {
        if ($Button.ForeColor -eq $LabelColor) {
            $WingetListCheck = Winget List $Button.Text | Select-String -Pattern $Button.Text | ForEach {$_.matches} | Select-Object -ExpandProperty Value
            if (!($WingetListCheck -eq $Button.Text)) {
                $Button.ForeColor = "Red"
            }
        }
    }

    $StartScript.Image = [System.Drawing.Image]::FromFile("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\SSDefault.png")

    $StatusBox.Text = "|Ready`r`n|Script Finalizado`r`n" + $StatusBox.Text

    if ($TB1.ForeColor -eq $LabelColor) {
        $MessageBox = [System.Windows.Forms.MessageBox]::Show("El equipo requiere reiniciarse para aplicar los cambios`r`nReiniciar equipo ahora?", "Reiniciar equipo", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information)
        if ($MessageBox -ne [System.Windows.Forms.DialogResult]::No) {
            $StatusBox.Text = "|Reiniciando El Equipo En 5 Segundos...`r`n" + $StatusBox.Text
            Start-Sleep 5
            Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse
            Restart-Computer
        } else {} 
    }
})

$Form.Add_Closing({
    Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse
})

[void]$Form.ShowDialog()