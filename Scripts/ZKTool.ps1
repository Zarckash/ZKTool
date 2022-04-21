Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Configs\ -ItemType Directory | Out-Null
New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Apps\ -ItemType Directory | Out-Null
New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\Downloads -ItemType Directory | Out-Null
Iwr "https://github.com/Zarckash/ZKTool/raw/main/Configs/ZKLogo.ico" -OutFile "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\ZKLogo.ico" | Out-Null

$FormTextColor = [System.Drawing.ColorTranslator]::FromHtml("#F1F1F1")
$SelectedTextColor = [System.Drawing.ColorTranslator]::FromHtml("#000000")
$TextColor = [System.Drawing.ColorTranslator]::FromHtml("#99FFFD")
$ButtonColor = [System.Drawing.ColorTranslator]::FromHtml("#3A3D45")
$ProcessingColor = [System.Drawing.ColorTranslator]::FromHtml("#DC4995")

$Location = 233 # Sets Each Panel Location
$XRes = Get-WmiObject -Class "Win32_VideoController" | Select-Object -ExpandProperty "CurrentHorizontalResolution" # Resolucion Horizontal
$YRes = Get-WmiObject -Class "Win32_VideoController" | Select-Object -ExpandProperty "CurrentVerticalResolution" # Resolucion Vertical
$FormXLocation = ($XRes / 2) - (($Location*3) / 2)
$FormYLocation = ($YRes / 2) - (602 / 2) - 70

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 779)
$Form.Text                       = "ZKTool"
$Form.StartPosition              = "Manual"
$Form.Location                   = New-Object System.Drawing.Point($FormXLocation, $FormYLocation)
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
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon("$env:userprofile\AppData\Local\Temp\ZKTool\Configs\ZKLogo.ico")


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
$SLabel.ForeColor                = $TextColor
$Form.Controls.Add($SLabel)

# Software Panel
$SPanel                          = New-Object System.Windows.Forms.Panel
$SPanel.Height                   = 455
$SPanel.Width                    = 233
$SPanel.Location                 = New-Object System.Drawing.Point(($Location*0),44)
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

# HW Monitor
$SB5                             = New-Object System.Windows.Forms.Button
$SB5.Text                        = "HW Monitor"

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

# Libre Office
$SB11                            = New-Object System.Windows.Forms.Button
$SB11.Text                       = "Libre Office"

# More Software Button
$MoreS                           = New-Object System.Windows.Forms.Button
$MoreS.Text                      = "Mostrar Mas"

$Position = 10
$Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$MoreS)
foreach ($Button in $Buttons) {
    $SPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=37
}


            ##################################
            ######### MORE  SOFTWARE #########
            ##################################


# More Software Panel
$MSPanel                         = New-Object system.Windows.Forms.Panel
$MSPanel.Height                  = 455
$MSPanel.Width                   = 233
$MSPanel.Location                = New-Object System.Drawing.Point(($Location*0),44)
$Position                        = 10

# Streamlabs OBS
$MSB1                            = New-Object System.Windows.Forms.Button
$MSB1.Text                       = "Streamlabs OBS"

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

# Megasync
$MSB9                            = New-Object System.Windows.Forms.Button
$MSB9.Text                       = "Megasync"

# Void
$MSB10                           = New-Object System.Windows.Forms.Button
$MSB10.Text                      = "Void"

# Void
$MSB11                           = New-Object System.Windows.Forms.Button
$MSB11.Text                      = "Void"

# Void
$MSB12                           = New-Object System.Windows.Forms.Button
$MSB12.Text                      = "Void"

$Position = 10
$Buttons = @($MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9)
foreach ($Button in $Buttons) {
    $MSPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=37
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
$LLabel.Location                 = New-Object System.Drawing.Point(252,13)
$LLabel.Font                     = New-Object System.Drawing.Font('Berserker',16)
$LLabel.ForeColor                = $textcolor
$Form.Controls.Add($LLabel)

# Launchers Panel
$LPanel                          = New-Object System.Windows.Forms.Panel
$LPanel.Height                   = 310
$LPanel.Width                    = 233
$LPanel.Location                 = New-Object System.Drawing.Point($Location,44)
$Form.Controls.Add($LPanel)

# Steam
$LB1                             = New-Object System.Windows.Forms.Button
$LB1.Text                        = "Steam"

# EA Desktop
$LB2                             = New-Object System.Windows.Forms.Button
$LB2.Text                        = "EA Desktop"

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

# Epic Games
$LB7                             = New-Object System.Windows.Forms.Button
$LB7.Text                        = "Epic Games"

# Xbox App
$LB8                             = New-Object System.Windows.Forms.Button
$LB8.Text                        = "Xbox App"

$Position = 10
$Buttons = @($LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8)
foreach ($Button in $Buttons) {
    $LPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=37
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
$TLabel.Location                 = New-Object System.Drawing.Point(520,13)
$TLabel.Font                     = New-Object System.Drawing.Font('Berserker',16)
$TLabel.ForeColor                = $textcolor
$Form.Controls.Add($TLabel)

# Tweaks Panel
$TPanel                          = New-Object System.Windows.Forms.Panel
$TPanel.Height                   = 455
$TPanel.Width                    = 233
$TPanel.Location                 = New-Object System.Drawing.Point(($Location*2),44)
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

# More Tweaks Button
$MoreT                           = New-Object System.Windows.Forms.Button
$MoreT.Text                      = "Mostrar Mas"

$Position = 37*2+10
$Buttons = @($TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$MoreT)
foreach ($Button in $Buttons) {    
    $TPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=37
}


            ##################################
            ########## MORE  TWEAKS ##########
            ##################################


# More Tweaks Panel
$MTPanel                         = New-Object System.Windows.Forms.Panel
$MTPanel.Height                  = 455
$MTPanel.Width                   = 233
$MTPanel.Location                = New-Object System.Drawing.Point(($Location*3),44)

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

# Video Extensions
$MTB4                            = New-Object System.Windows.Forms.Button
$MTB4.Text                       = "Install Video Extensions"

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

# VisualFX Fix
$MTB10                           = New-Object System.Windows.Forms.Button
$MTB10.Text                      = "VisualFX Fix"

# Void
$MTB11                           = New-Object System.Windows.Forms.Button
$MTB11.Text                      = "Void"

$Position = 37*2+10
$Buttons = @($MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10)
foreach ($Button in $Buttons) {
    $MTPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=37
}


            ##################################
            ########## PICTURE  BOX ##########
            ##################################


# PictureBox
$LogoBox                         = New-Object System.Windows.Forms.PictureBox
$LogoBox.Width                   = 233
$LogoBox.Height                  = 125
$LogoBox.Location                = New-Object System.Drawing.Point($Location,364)
$LogoBox.imageLocation           = "https://raw.githubusercontent.com/Zarckash/ZKTool/main/Configs/ZKLogo.png"
$LogoBox.SizeMode                = "Zoom"
$Form.Controls.Add($LogoBox)


            ##################################
            ########## START SCRIPT ##########
            ##################################


# Start Script Panel
$SSPanel                         = New-Object System.Windows.Forms.Panel
$SSPanel.Height                  = 48
$SSPanel.Width                   = 699
$SSPanel.Location                = New-Object System.Drawing.Point(($Location*0),500)
$Form.Controls.Add($SSPanel)

# Start Script Button
$StartScript                     = New-Object System.Windows.Forms.Button
$StartScript.Text                = "I N I C I A R    S C R I P T"
$StartScript.Width               = 681
$StartScript.Height              = 45
$StartScript.Location            = New-Object System.Drawing.Point(10,0)
$StartScript.Font                = New-Object System.Drawing.Font('Ubuntu Mono',18)
$StartScript.BackColor           = $ButtonColor
$StartScript.ForeColor           = $TextColor
$SSPanel.Controls.Add($StartScript)


            ##################################
            ######### STATUS TEXTBOX #########
            ##################################


# Status TextBox
$StatusBox                       = New-Object System.Windows.Forms.TextBox
$StatusBox.multiline             = $true
$StatusBox.Width                 = 679
$StatusBox.Height                = 45
$StatusBox.Location              = New-Object System.Drawing.Point(($Location*0+11),549)
$StatusBox.Font                  = New-Object System.Drawing.Font('Ubuntu Mono',12)
$StatusBox.BackColor             = $ButtonColor
$StatusBox.ForeColor             = $FormTextColor
$StatusBox.ReadOnly              = $true
$StatusBox.Text                  = "|Ready"
$Form.Controls.Add($StatusBox)


            ##################################
            ######## HIDDEN  SOFTWARE ########
            ##################################


# Hidden Software Panel
$HSPanel                         = New-Object System.Windows.Forms.Panel
$HSPanel.Height                  = 131
$HSPanel.Width                   = 233
$HSPanel.Location                = New-Object System.Drawing.Point(($Location*0),500)

# Hidden Software Separator
$HSS                             = New-Object System.Windows.Forms.Button
$HSS.Width                       = 216
$HSS.Height                      = 11
$HSS.Location                    = New-Object System.Drawing.Point(10,3)
$HSS.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HSS.BackColor                   = $TextColor
$HSS.Enabled                     = $False
$HSPanel.Controls.Add($HSS)

# Valorant
$HSB1                            = New-Object System.Windows.Forms.Button
$HSB1.Text                       = "Valorant"

# League of Legends
$HSB2                            = New-Object System.Windows.Forms.Button
$HSB2.Text                       = "League of Legends"

# Escape From Tarkov
$HSB3                            = New-Object System.Windows.Forms.Button
$HSB3.Text                       = "Escape From Tarkov"

$Position = 20
$Buttons = @($HSB1,$HSB2,$HSB3)
foreach ($Button in $Buttons) {
    $HSPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=37
}


            ##################################
            ########## HIDDEN PANEL ##########
            ##################################


# Hidden Panel
$HPanel                          = New-Object System.Windows.Forms.Panel
$HPanel.Height                   = 131
$HPanel.Width                    = 699
$HPanel.Location                 = New-Object System.Drawing.Point(($Location*0),500)

# Hidden Panel Separator
$HPS                             = New-Object System.Windows.Forms.Button
$HPS.Width                       = 681
$HPS.Height                      = 11
$HPS.Location                    = New-Object System.Drawing.Point(10,3)
$HPS.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HPS.BackColor                   = $ProcessingColor
$HPS.Enabled                     = $False
$HPanel.Controls.Add($HPS)

$Position = 20
# Rufus
$HB1                             = New-Object System.Windows.Forms.Button
$HB1.Text                        = "Rufus"
$HB1.Location                    = New-Object System.Drawing.Point(10,$Position)

# MSI Afterburner Config
$HB2                             = New-Object System.Windows.Forms.Button
$HB2.Text                        = "Msi Afterburner Config"
$HB2.Location                    = New-Object System.Drawing.Point(243,$Position)

# Discord Second Screen
$HB3                             = New-Object System.Windows.Forms.Button
$HB3.Text                        = "Discord Second Screen"
$HB3.Location                    = New-Object System.Drawing.Point(476,$Position)
$Position += 37

# Software RL
$HB4                             = New-Object System.Windows.Forms.Button
$HB4.Text                        = "Software RL"
$HB4.Location                    = New-Object System.Drawing.Point(10,$Position)

# RGB Fusion
$HB5                             = New-Object System.Windows.Forms.Button
$HB5.Text                        = "RGB Fusion"
$HB5.Location                    = New-Object System.Drawing.Point(243,$Position)

# JDK 17
$HB6                             = New-Object System.Windows.Forms.Button
$HB6.Text                        = "JDK 17"
$HB6.Location                    = New-Object System.Drawing.Point(476,$Position)
$Position += 37

# Eclipse IDE
$HB7                             = New-Object System.Windows.Forms.Button
$HB7.Text                        = "Eclipse IDE"
$HB7.Location                    = New-Object System.Drawing.Point(10,$Position)

# Visual Studio Code
$HB8                             = New-Object System.Windows.Forms.Button
$HB8.Text                        = "Visual Studio Code"
$HB8.Location                    = New-Object System.Drawing.Point(243,$Position)

# Game Settings
$HB9                             = New-Object System.Windows.Forms.Button
$HB9.Text                        = "Game Settings"
$HB9.Location                    = New-Object System.Drawing.Point(476,$Position)

$Buttons = @($HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9)
foreach ($Button in $Buttons) {$HPanel.Controls.Add($Button)}


            ##################################
            ######### HIDDEN  TWEAKS #########
            ##################################


# Hidden Tweaks Panel
$HTPanel                         = New-Object System.Windows.Forms.Panel
$HTPanel.Height                  = 131
$HTPanel.Width                   = 233
$HTPanel.Location                = New-Object System.Drawing.Point(($Location*3),500)

# Hidden Tweaks Separator
$HTS                             = New-Object System.Windows.Forms.Button
$HTS.Width                       = 216
$HTS.Height                      = 11
$HTS.Location                    = New-Object System.Drawing.Point(10,3)
$HTS.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HTS.BackColor                   = $TextColor
$HTS.Enabled                     = $False
$HTPanel.Controls.Add($HTS)

# Unpin All Apps
$HTB1                            = New-Object System.Windows.Forms.Button
$HTB1.Text                       = "Unpin All Apps"

# Void
$HTB2                            = New-Object System.Windows.Forms.Button
$HTB2.Text                       = "Void"

# Void
$HTB3                            = New-Object System.Windows.Forms.Button
$HTB3.Text                       = "Void"

$Position = 20
$Buttons = @($HTB1)
foreach ($Button in $Buttons) {
    $HTPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=37
}

            ##################################
            ######### PADDING BOTTOM #########
            ##################################


# Padding Bottom Panel
$PaddingPanel                    = New-Object System.Windows.Forms.Panel
$PaddingPanel.Height             = 8
$PaddingPanel.Width              = 695
$PaddingPanel.Location           = New-Object System.Drawing.Point(($Location*0),594)
$Form.Controls.Add($PaddingPanel)

$Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$MoreS,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,
$LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB1,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$MoreT,$MTB1,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,
$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$HSB1,$HSB2,$HSB3,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9,$HTB1,$HTB2,$HTB3)
foreach ($Button in $Buttons) {
    $Button.Width                = 215
    $Button.Height               = 35
    $Button.Font                 = New-Object System.Drawing.Font('Ubuntu Mono',12)
    $Button.BackColor            = $ButtonColor
}

$TB1.Height                      = 72
$MTB1.Height                     = 72

$SB1.Add_Click({
    if ($SB1.BackColor -eq $ButtonColor) {
        $SB1.BackColor = $TextColor
        $SB1.ForeColor = $SelectedTextColor
    }else {
        $SB1.BackColor = $ButtonColor
        $SB1.ForeColor = $FormTextColor
    }
})

$SB2.Add_Click({
    if ($SB2.BackColor -eq $ButtonColor) {
        $SB2.BackColor = $TextColor
        $SB2.ForeColor = $SelectedTextColor
    }else {
        $SB2.BackColor = $ButtonColor
        $SB2.ForeColor = $FormTextColor
    }
})

$SB3.Add_Click({
    if ($SB3.BackColor -eq $ButtonColor) {
        $SB3.BackColor = $TextColor
        $SB3.ForeColor = $SelectedTextColor
    }else {
        $SB3.BackColor = $ButtonColor
        $SB3.ForeColor = $FormTextColor
    }
})

$SB4.Add_Click({
    if ($SB4.BackColor -eq $ButtonColor) {
        $SB4.BackColor = $TextColor
        $SB4.ForeColor = $SelectedTextColor
    }else {
        $SB4.BackColor = $ButtonColor
        $SB4.ForeColor = $FormTextColor
    }
})

$SB5.Add_Click({
    if ($SB5.BackColor -eq $ButtonColor) {
        $SB5.BackColor = $TextColor
        $SB5.ForeColor = $SelectedTextColor
    }else {
        $SB5.BackColor = $ButtonColor
        $SB5.ForeColor = $FormTextColor
    }
})

$SB6.Add_Click({
    if ($SB6.BackColor -eq $ButtonColor) {
        $SB6.BackColor = $TextColor
        $SB6.ForeColor = $SelectedTextColor
    }else {
        $SB6.BackColor = $ButtonColor
        $SB6.ForeColor = $FormTextColor
    }
})

$SB7.Add_Click({
    if ($SB7.BackColor -eq $ButtonColor) {
        $SB7.BackColor = $TextColor
        $SB7.ForeColor = $SelectedTextColor
    }else {
        $SB7.BackColor = $ButtonColor
        $SB7.ForeColor = $FormTextColor
    }
})

$SB8.Add_Click({
    if ($SB8.BackColor -eq $ButtonColor) {
        $SB8.BackColor = $TextColor
        $SB8.ForeColor = $SelectedTextColor
    }else {
        $SB8.BackColor = $ButtonColor
        $SB8.ForeColor = $FormTextColor
    }
})

$SB9.Add_Click({
    if ($SB9.BackColor -eq $ButtonColor) {
        $SB9.BackColor = $TextColor
        $SB9.ForeColor = $SelectedTextColor
    }else {
        $SB9.BackColor = $ButtonColor
        $SB9.ForeColor = $FormTextColor
    }
})

$SB10.Add_Click({
    if ($SB10.BackColor -eq $ButtonColor) {
        $SB10.BackColor = $TextColor
        $SB10.ForeColor = $SelectedTextColor
    }else {
        $SB10.BackColor = $ButtonColor
        $SB10.ForeColor = $FormTextColor
    }
})

$SB11.Add_Click({
    if ($SB11.BackColor -eq $ButtonColor) {
        $SB11.BackColor = $TextColor
        $SB11.ForeColor = $SelectedTextColor
    }else {
        $SB11.BackColor = $ButtonColor
        $SB11.ForeColor = $FormTextColor
    }
})

$MoreS.Add_Click({
        if ($MoreS.BackColor -eq $ButtonColor) {
            $MoreS.BackColor = $TextColor
            $MoreS.ForeColor = $SelectedTextColor
            $Form.Controls.Add($MSPanel)
            $MSPanel.Width = 233
            $Form.Location                   = New-Object System.Drawing.Point(($FormXLocation -233), $FormYLocation)
            $SLabel.Location                 = New-Object System.Drawing.Point((25+$Location/2),13)
            $SPanel.Location                 = New-Object System.Drawing.Point(($Location),44)
            $LLabel.Location                 = New-Object System.Drawing.Point((252+$Location),13)
            $LPanel.Location                 = New-Object System.Drawing.Point(($Location*2),44)
            $TLabel.Location                 = New-Object System.Drawing.Point((520+$Location),13)
            $TPanel.Location                 = New-Object System.Drawing.Point(($Location*3),44)
            $LogoBox.Location                = New-Object System.Drawing.Point(($Location*2),364)
            $HPanel.Location                 = New-Object System.Drawing.Point(($Location),500)
            $HTPanel.Location                = New-Object System.Drawing.Point(($Location*4),500)
            $SSPanel.Width                  += $Location
            $StartScript.Width              += $Location
            $StatusBox.Width                += $Location
        }

        if ($MoreT.BackColor -eq $TextColor) {
            $MTPanel.Location                = New-Object System.Drawing.Point(($Location*4),44)
            $TLabel.Location                 = New-Object System.Drawing.Point((520+$Location+($Location/2)),13)
        }

        if ($HPS.BackColor -eq $TextColor) {
            $Form.Controls.Add($HSPanel)
        }
})

$MSB1.Add_Click({
    if ($MSB1.BackColor -eq $ButtonColor) {
        $MSB1.BackColor = $TextColor
        $MSB1.ForeColor = $SelectedTextColor
    }else {
        $MSB1.BackColor = $ButtonColor
        $MSB1.ForeColor = $FormTextColor
    }
})

$MSB2.Add_Click({
    if ($MSB2.BackColor -eq $ButtonColor) {
        $MSB2.BackColor = $TextColor
        $MSB2.ForeColor = $SelectedTextColor
    }else {
        $MSB2.BackColor = $ButtonColor
        $MSB2.ForeColor = $FormTextColor
    }
})

$MSB3.Add_Click({
    if ($MSB3.BackColor -eq $ButtonColor) {
        $MSB3.BackColor = $TextColor
        $MSB3.ForeColor = $SelectedTextColor
    }else {
        $MSB3.BackColor = $ButtonColor
        $MSB3.ForeColor = $FormTextColor
    }
})

$MSB4.Add_Click({
    if ($MSB4.BackColor -eq $ButtonColor) {
        $MSB4.BackColor = $TextColor
        $MSB4.ForeColor = $SelectedTextColor
    }else {
        $MSB4.BackColor = $ButtonColor
        $MSB4.ForeColor = $FormTextColor
    }
})

$MSB5.Add_Click({
    if ($MSB5.BackColor -eq $ButtonColor) {
        $MSB5.BackColor = $TextColor
        $MSB5.ForeColor = $SelectedTextColor
    }else {
        $MSB5.BackColor = $ButtonColor
        $MSB5.ForeColor = $FormTextColor
    }
})

$MSB6.Add_Click({
    if ($MSB6.BackColor -eq $ButtonColor) {
        $MSB6.BackColor = $TextColor
        $MSB6.ForeColor = $SelectedTextColor
    }else {
        $MSB6.BackColor = $ButtonColor
        $MSB6.ForeColor = $FormTextColor
    }
})

$MSB7.Add_Click({
    if ($MSB7.BackColor -eq $ButtonColor) {
        $MSB7.BackColor = $TextColor
        $MSB7.ForeColor = $SelectedTextColor
    }else {
        $MSB7.BackColor = $ButtonColor
        $MSB7.ForeColor = $FormTextColor
    }
})

$MSB8.Add_Click({
    if ($MSB8.BackColor -eq $ButtonColor) {
        $MSB8.BackColor = $TextColor
        $MSB8.ForeColor = $SelectedTextColor
    }else {
        $MSB8.BackColor = $ButtonColor
        $MSB8.ForeColor = $FormTextColor
    }
})

$MSB9.Add_Click({
    if ($MSB9.BackColor -eq $ButtonColor) {
        $MSB9.BackColor = $TextColor
        $MSB9.ForeColor = $SelectedTextColor
    }else {
        $MSB9.BackColor = $ButtonColor
        $MSB9.ForeColor = $FormTextColor
    }
})

$MSB10.Add_Click({
    if ($MSB10.BackColor -eq $ButtonColor) {
        $MSB10.BackColor = $TextColor
        $MSB10.ForeColor = $SelectedTextColor
    }else {
        $MSB10.BackColor = $ButtonColor
        $MSB10.ForeColor = $FormTextColor
    }
})

$MSB11.Add_Click({
    if ($MSB11.BackColor -eq $ButtonColor) {
        $MSB11.BackColor = $TextColor
        $MSB11.ForeColor = $SelectedTextColor
    }else {
        $MSB11.BackColor = $ButtonColor
        $MSB11.ForeColor = $FormTextColor
    }
})

$MSB12.Add_Click({
    if ($MSB12.BackColor -eq $ButtonColor) {
        $MSB12.BackColor = $TextColor
        $MSB12.ForeColor = $SelectedTextColor
    }else {
        $MSB12.BackColor = $ButtonColor
        $MSB12.ForeColor = $FormTextColor
    }
})

$LB1.Add_Click({
    if ($LB1.BackColor -eq $ButtonColor) {
        $LB1.BackColor = $TextColor
        $LB1.ForeColor = $SelectedTextColor
    }else {
        $LB1.BackColor = $ButtonColor
        $LB1.ForeColor = $FormTextColor
    }
})

$LB2.Add_Click({
    if ($LB2.BackColor -eq $ButtonColor) {
        $LB2.BackColor = $TextColor
        $LB2.ForeColor = $SelectedTextColor
    }else {
        $LB2.BackColor = $ButtonColor
        $LB2.ForeColor = $FormTextColor
    }
})

$LB3.Add_Click({
    if ($LB3.BackColor -eq $ButtonColor) {
        $LB3.BackColor = $TextColor
        $LB3.ForeColor = $SelectedTextColor
    }else {
        $LB3.BackColor = $ButtonColor
        $LB3.ForeColor = $FormTextColor
    }
})

$LB4.Add_Click({
    if ($LB4.BackColor -eq $ButtonColor) {
        $LB4.BackColor = $TextColor
        $LB4.ForeColor = $SelectedTextColor
    }else {
        $LB4.BackColor = $ButtonColor
        $LB4.ForeColor = $FormTextColor
    }
})

$LB5.Add_Click({
    if ($LB5.BackColor -eq $ButtonColor) {
        $LB5.BackColor = $TextColor
        $LB5.ForeColor = $SelectedTextColor
    }else {
        $LB5.BackColor = $ButtonColor
        $LB5.ForeColor = $FormTextColor
    }
})

$LB6.Add_Click({
    if ($LB6.BackColor -eq $ButtonColor) {
        $LB6.BackColor = $TextColor
        $LB6.ForeColor = $SelectedTextColor
    }else {
        $LB6.BackColor = $ButtonColor
        $LB6.ForeColor = $FormTextColor
    }
})

$LB7.Add_Click({
    if ($LB7.BackColor -eq $ButtonColor) {
        $LB7.BackColor = $TextColor
        $LB7.ForeColor = $SelectedTextColor
    }else {
        $LB7.BackColor = $ButtonColor
        $LB7.ForeColor = $FormTextColor
    }
})

$LB8.Add_Click({
    if ($LB8.BackColor -eq $ButtonColor) {
        $LB8.BackColor = $TextColor
        $LB8.ForeColor = $SelectedTextColor
    }else {
        $LB8.BackColor = $ButtonColor
        $LB8.ForeColor = $FormTextColor
    }
})

$TLabel.Add_Click({
    Iwr "https://github.com/Zarckash/ZKTool/raw/main/Configs/Info.txt" -OutFile "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Info.txt"
    Start-Process "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Info.txt"
})

$TB1.Add_Click({
    if ($TB1.BackColor -eq $ButtonColor) {
        $TB1.BackColor = $TextColor
        $TB1.ForeColor = $SelectedTextColor
    }else {
        $TB1.BackColor = $ButtonColor
        $TB1.ForeColor = $FormTextColor
    }
})

$TB2.Add_Click({
    if ($TB2.BackColor -eq $ButtonColor) {
        $TB2.BackColor = $TextColor
        $TB2.ForeColor = $SelectedTextColor
    }else {
        $TB2.BackColor = $ButtonColor
        $TB2.ForeColor = $FormTextColor
    }
})

$TB3.Add_Click({
    if ($TB3.BackColor -eq $ButtonColor) {
        $TB3.BackColor = $TextColor
        $TB3.ForeColor = $SelectedTextColor
    }else {
        $TB3.BackColor = $ButtonColor
        $TB3.ForeColor = $FormTextColor
    }
})

$TB4.Add_Click({
    if ($TB4.BackColor -eq $ButtonColor) {
        $TB4.BackColor = $TextColor
        $TB4.ForeColor = $SelectedTextColor
    }else {
        $TB4.BackColor = $ButtonColor
        $TB4.ForeColor = $FormTextColor
    }
})

$TB5.Add_Click({
    if ($TB5.BackColor -eq $ButtonColor) {
        $TB5.BackColor = $TextColor
        $TB5.ForeColor = $SelectedTextColor
    }else {
        $TB5.BackColor = $ButtonColor
        $TB5.ForeColor = $FormTextColor
    }
})

$TB6.Add_Click({
    if ($TB6.BackColor -eq $ButtonColor) {
        $TB6.BackColor = $TextColor
        $TB6.ForeColor = $SelectedTextColor
    }else {
        $TB6.BackColor = $ButtonColor
        $TB6.ForeColor = $FormTextColor
    }
})

$TB7.Add_Click({
    if ($TB7.BackColor -eq $ButtonColor) {
        $TB7.BackColor = $TextColor
        $TB7.ForeColor = $SelectedTextColor
    }else {
        $TB7.BackColor = $ButtonColor
        $TB7.ForeColor = $FormTextColor
    }
})

$TB8.Add_Click({
    if ($TB8.BackColor -eq $ButtonColor) {
        $TB8.BackColor = $TextColor
        $TB8.ForeColor = $SelectedTextColor
    }else {
        $TB8.BackColor = $ButtonColor
        $TB8.ForeColor = $FormTextColor
    }
})

$TB9.Add_Click({
    if ($TB9.BackColor -eq $ButtonColor) {
        $TB9.BackColor = $TextColor
        $TB9.ForeColor = $SelectedTextColor
    }else {
        $TB9.BackColor = $ButtonColor
        $TB9.ForeColor = $FormTextColor
    }
})

$TB10.Add_Click({
    if ($TB10.BackColor -eq $ButtonColor) {
        $TB10.BackColor = $TextColor
        $TB10.ForeColor = $SelectedTextColor
    }else {
        $TB10.BackColor = $ButtonColor
        $TB10.ForeColor = $FormTextColor
    }
})

$MoreT.Add_Click({
    if ($MoreT.BackColor -eq $ButtonColor) {
    $MoreT.BackColor = $TextColor
    $MoreT.ForeColor = $SelectedTextColor
    $Form.Controls.Add($MTPanel)
    $TLabel.Location                 = New-Object System.Drawing.Point((520+$Location/2),13)
    $SSPanel.Width                  += $Location
    $StartScript.Width              += $Location
    $StatusBox.Width                += $Location
    }

    if ($MoreS.BackColor -eq $TextColor) {
        $TLabel.Location                 = New-Object System.Drawing.Point((520+$Location+($Location/2)),13)
        $MTPanel.Location                = New-Object System.Drawing.Point(($Location*4),44)
    }

    if ($HPS.BackColor -eq $TextColor) {
        $Form.Controls.Add($HTPanel)
    }
})

$MTB1.Add_Click({
    if ($MTB1.BackColor -eq $ButtonColor) {
        $MTB1.BackColor = $TextColor
        $MTB1.ForeColor = $SelectedTextColor
    }else {
        $MTB1.BackColor = $ButtonColor
        $MTB1.ForeColor = $FormTextColor
    }
})

$MTB2.Add_Click({
    if ($MTB2.BackColor -eq $ButtonColor) {
        $MTB2.BackColor = $TextColor
        $MTB2.ForeColor = $SelectedTextColor
    }else {
        $MTB2.BackColor = $ButtonColor
        $MTB2.ForeColor = $FormTextColor
    }
})

$MTB3.Add_Click({
    if ($MTB3.BackColor -eq $ButtonColor) {
        $MTB3.BackColor = $TextColor
        $MTB3.ForeColor = $SelectedTextColor
    }else {
        $MTB3.BackColor = $ButtonColor
        $MTB3.ForeColor = $FormTextColor
    }
})

$MTB4.Add_Click({
    if ($MTB4.BackColor -eq $ButtonColor) {
        $MTB4.BackColor = $TextColor
        $MTB4.ForeColor = $SelectedTextColor
    }else {
        $MTB4.BackColor = $ButtonColor
        $MTB4.ForeColor = $FormTextColor
    }
})

$MTB5.Add_Click({
    if ($MTB5.BackColor -eq $ButtonColor) {
        $MTB5.BackColor = $TextColor
        $MTB5.ForeColor = $SelectedTextColor
    }else {
        $MTB5.BackColor = $ButtonColor
        $MTB5.ForeColor = $FormTextColor
    }
})

$MTB6.Add_Click({
    if ($MTB6.BackColor -eq $ButtonColor) {
        $MTB6.BackColor = $TextColor
        $MTB6.ForeColor = $SelectedTextColor
    }else {
        $MTB6.BackColor = $ButtonColor
        $MTB6.ForeColor = $FormTextColor
    }
})

$MTB7.Add_Click({
    if ($MTB7.BackColor -eq $ButtonColor) {
        $MTB7.BackColor = $TextColor
        $MTB7.ForeColor = $SelectedTextColor
    }else {
        $MTB7.BackColor = $ButtonColor
        $MTB7.ForeColor = $FormTextColor
    }
})

$MTB8.Add_Click({
    if ($MTB8.BackColor -eq $ButtonColor) {
        $MTB8.BackColor = $TextColor
        $MTB8.ForeColor = $SelectedTextColor
    }else {
        $MTB8.BackColor = $ButtonColor
        $MTB8.ForeColor = $FormTextColor
    }
})

$MTB9.Add_Click({
    if ($MTB9.BackColor -eq $ButtonColor) {
        $MTB9.BackColor = $TextColor
        $MTB9.ForeColor = $SelectedTextColor
    }else {
        $MTB9.BackColor = $ButtonColor
        $MTB9.ForeColor = $FormTextColor
    }
})

$MTB10.Add_Click({
    if ($MTB10.BackColor -eq $ButtonColor) {
        $MTB10.BackColor = $TextColor
        $MTB10.ForeColor = $SelectedTextColor
    }else {
        $MTB10.BackColor = $ButtonColor
        $MTB10.ForeColor = $FormTextColor
    }
})

$LogoBox.Add_Click({
    $Form.Controls.Add($HPanel)
    $SSPanel.Location                = New-Object System.Drawing.Point(($Location*0),(500+135))
    $StatusBox.Location              = New-Object System.Drawing.Point(($Location*0+11),(549+135))
    $PaddingPanel.Location           = New-Object System.Drawing.Point(($Location*0),(594+135))
    $HPS.BackColor                   = $TextColor

    if ($MoreS.BackColor -eq $TextColor) {
        $Form.Controls.Add($HSPanel)
    }

    if ($MoreT.BackColor -eq $TextColor) {
        $Form.Controls.Add($HTPanel)
    }
})

$HSB1.Add_Click({
    if ($HSB1.BackColor -eq $ButtonColor) {
        $HSB1.BackColor = $TextColor
        $HSB1.ForeColor = $SelectedTextColor
    }else {
        $HSB1.BackColor = $ButtonColor
        $HSB1.ForeColor = $FormTextColor
    }
})

$HSB2.Add_Click({
    if ($HSB2.BackColor -eq $ButtonColor) {
        $HSB2.BackColor = $TextColor
        $HSB2.ForeColor = $SelectedTextColor
    }else {
        $HSB2.BackColor = $ButtonColor
        $HSB2.ForeColor = $FormTextColor
    }
})

$HSB3.Add_Click({
    if ($HSB3.BackColor -eq $ButtonColor) {
        $HSB3.BackColor = $TextColor
        $HSB3.ForeColor = $SelectedTextColor
    }else {
        $HSB3.BackColor = $ButtonColor
        $HSB3.ForeColor = $FormTextColor
    }
})

$HB1.Add_Click({
    if ($HB1.BackColor -eq $ButtonColor) {
        $HB1.BackColor = $TextColor
        $HB1.ForeColor = $SelectedTextColor
    }else {
        $HB1.BackColor = $ButtonColor
        $HB1.ForeColor = $FormTextColor
    }
})

$HB2.Add_Click({
    if ($HB2.BackColor -eq $ButtonColor) {
        $HB2.BackColor = $TextColor
        $HB2.ForeColor = $SelectedTextColor
    }else {
        $HB2.BackColor = $ButtonColor
        $HB2.ForeColor = $FormTextColor
    }
})

$HB3.Add_Click({
    if ($HB3.BackColor -eq $ButtonColor) {
        $HB3.BackColor = $TextColor
        $HB3.ForeColor = $SelectedTextColor
    }else {
        $HB3.BackColor = $ButtonColor
        $HB3.ForeColor = $FormTextColor
    }
})

$HB4.Add_Click({
    if ($HB4.BackColor -eq $ButtonColor) {
        $HB4.BackColor = $TextColor
        $HB4.ForeColor = $SelectedTextColor
    }else {
        $HB4.BackColor = $ButtonColor
        $HB4.ForeColor = $FormTextColor
    }
})

$HB5.Add_Click({
    if ($HB5.BackColor -eq $ButtonColor) {
        $HB5.BackColor = $TextColor
        $HB5.ForeColor = $SelectedTextColor
    }else {
        $HB5.BackColor = $ButtonColor
        $HB5.ForeColor = $FormTextColor
    }
})

$HB6.Add_Click({
    if ($HB6.BackColor -eq $ButtonColor) {
        $HB6.BackColor = $TextColor
        $HB6.ForeColor = $SelectedTextColor
    }else {
        $HB6.BackColor = $ButtonColor
        $HB6.ForeColor = $FormTextColor
    }
})

$HB7.Add_Click({
    if ($HB7.BackColor -eq $ButtonColor) {
        $HB7.BackColor = $TextColor
        $HB7.ForeColor = $SelectedTextColor
    }else {
        $HB7.BackColor = $ButtonColor
        $HB7.ForeColor = $FormTextColor
    }
})

$HB8.Add_Click({
    if ($HB8.BackColor -eq $ButtonColor) {
        $HB8.BackColor = $TextColor
        $HB8.ForeColor = $SelectedTextColor
    }else {
        $HB8.BackColor = $ButtonColor
        $HB8.ForeColor = $FormTextColor
    }
})

$HB9.Add_Click({
    if ($HB9.BackColor -eq $ButtonColor) {
        $HB9.BackColor = $TextColor
        $HB9.ForeColor = $SelectedTextColor
    }else {
        $HB9.BackColor = $ButtonColor
        $HB9.ForeColor = $FormTextColor
    }
})

$HTB1.Add_Click({
    if ($HTB1.BackColor -eq $ButtonColor) {
        $HTB1.BackColor = $TextColor
        $HTB1.ForeColor = $SelectedTextColor
    }else {
        $HTB1.BackColor = $ButtonColor
        $HTB1.ForeColor = $FormTextColor
    }
})

$HTB2.Add_Click({
    if ($HTB2.BackColor -eq $ButtonColor) {
        $HTB2.BackColor = $TextColor
        $HTB2.ForeColor = $SelectedTextColor
    }else {
        $HTB2.BackColor = $ButtonColor
        $HTB2.ForeColor = $FormTextColor
    }
})

$HTB3.Add_Click({
    if ($HTB3.BackColor -eq $ButtonColor) {
        $HTB3.BackColor = $TextColor
        $HTB3.ForeColor = $SelectedTextColor
    }else {
        $HTB3.BackColor = $ButtonColor
        $HTB3.ForeColor = $FormTextColor
    }
})

$StartScript.Add_Click({
    $StatusBox.Text = "|Iniciando Script...`r`n" + $StatusBox.Text

    $StartScript.BackColor = $TextColor
    $StartScript.ForeColor = $SelectedTextColor

    $FromPath = "https://github.com/Zarckash/ZKTool/raw/main" # GitHub Downloads URL
    $ToPath   = "$env:userprofile\AppData\Local\Temp\ZKTool"  # Folder Structure Path
    $Download = New-Object net.webclient

    if ($SB1.BackColor -eq $TextColor) { # Google Chrome
        $StatusBox.Text = "|Instalando Google Chrome...`r`n" + $StatusBox.Text
        $SB1.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Google.Chrome | Out-Null
        $SB1.BackColor = $TextColor
    }
    if ($SB2.BackColor -eq $TextColor) { # GeForce Experience
        $StatusBox.Text = "|Instalando GeForce Experience...`r`n" + $StatusBox.Text
        $SB2.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Nvidia.GeForceExperience | Out-Null
        $SB2.BackColor = $TextColor
    }
    if ($SB3.BackColor -eq $TextColor) { # NanaZip
        $StatusBox.Text = "|Instalando NanaZip...`r`n" + $StatusBox.Text
        $SB3.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id M2Team.NanaZip | Out-Null
        $SB3.BackColor = $TextColor
    }
    if ($SB4.BackColor -eq $TextColor) { # Discord
        $StatusBox.Text = "|Instalando Discord...`r`n" + $StatusBox.Text
        $SB4.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Discord.Discord | Out-Null
        $SB4.BackColor = $TextColor
    }
    if ($SB5.BackColor -eq $TextColor) { # HWMonitor
        $StatusBox.Text = "|Instalando HWMonitor...`r`n" + $StatusBox.Text
        $SB5.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id CPUID.HWMonitor | Out-Null
        $SB5.BackColor = $TextColor
    }
    if ($SB6.BackColor -eq $TextColor) { # MSI Afterburner
        $StatusBox.Text = "|Instalando MSI Afterburner...`r`n" + $StatusBox.Text
        $SB6.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/MSIAfterburner.zip", $ToPath+"\Apps\MSIAfterburner.zip")
        Expand-Archive -Path ($ToPath+"\Apps\MSIAfterburner.zip") -DestinationPath ($ToPath+"\Apps\MSIAfterburner") -Force
        Copy-Item -Path ($ToPath+"\Apps\MSIAfterburner\MSIAfterburner.lnk") -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force
        Start-Process ($ToPath+"\Apps\MSIAfterburner\MSIAfterburner.exe")
        $SB6.BackColor = $TextColor
    }
    if ($SB7.BackColor -eq $TextColor) { # Corsair iCue
        $StatusBox.Text = "|Instalando Corsair iCue...`r`n" + $StatusBox.Text
        $SB7.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Corsair.iCUE.4 | Out-Null
        $SB7.BackColor = $TextColor
    }
    if ($SB8.BackColor -eq $TextColor) { # Logitech G HUB
        $StatusBox.Text = "|Instalando Logitech G HUB...`r`n" + $StatusBox.Text
        $SB8.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Logitech.GHUB | Out-Null
        $SB8.BackColor = $TextColor
    }
    if ($SB9.BackColor -eq $TextColor) { # Razer Synapse
        $StatusBox.Text = "|Instalando Razer Synapse...`r`n" + $StatusBox.Text
        $SB9.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/RazerSynapse.exe", $ToPath+"\Apps\RazerSynapse.exe")
        Start-Process ($ToPath+"\Apps\RazerSynapse.exe")
        $SB9.BackColor = $TextColor
    }
    if ($SB10.BackColor -eq $TextColor) { # uTorrent Web
        $StatusBox.Text = "|Instalando uTorrent Web...`r`n" + $StatusBox.Text
        $SB10.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/uTorrentWeb.exe", $ToPath+"\Apps\uTorrentWeb.exe")
        Start-Process ($ToPath+"\Apps\uTorrentWeb.exe")
        $SB10.BackColor = $TextColor
    }
    if ($SB11.BackColor -eq $TextColor) { # Libre Office
        $StatusBox.Text = "|Instalando Libre Office...`r`n" + $StatusBox.Text
        $SB11.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id TheDocumentFoundation.LibreOffice | Out-Null
        $SB11.BackColor = $TextColor
    }
    if ($MoreS.BackColor -eq $TextColor) { # More Software Bracket
        if ($MSB1.BackColor -eq $TextColor) { # Streamlabs OBS
            $StatusBox.Text = "|Instalando Streamlabs OBS...`r`n" + $StatusBox.Text
            $MSB1.BackColor = $ProcessingColor
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Streamlabs.StreamlabsOBS | Out-Null
            $MSB1.BackColor = $TextColor
        }
        if ($MSB2.BackColor -eq $TextColor) { # Photoshop Portable
            $StatusBox.Text = "|Instalando Adobe Photoshop...`r`n" + $StatusBox.Text
            $MSB2.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Scripts/Downloads/Photoshop.ps1", $ToPath+"\Scripts\Downloads\Photoshop.ps1")
            Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\Downloads\Photoshop.ps1 ; exit"
            $MSB2.BackColor = $TextColor
        }
        if ($MSB3.BackColor -eq $TextColor) { # Premiere Portable
            $StatusBox.Text = "|Instalando Adobe Premiere...`r`n" + $StatusBox.Text
            $MSB3.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Scripts/Downloads/Premiere.ps1", $ToPath+"\Scripts\Downloads\Premiere.ps1")
            Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\Downloads\Premiere.ps1 ; exit"
            $MSB3.BackColor = $TextColor
        }
        if ($MSB4.BackColor -eq $TextColor) { # Spotify
            $StatusBox.Text = "|Instalando Spotify...`r`n" + $StatusBox.Text
            $MSB4.BackColor = $ProcessingColor
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Spotify.Spotify | Out-Null
            $MSB4.BackColor = $TextColor
        }
        if ($MSB5.BackColor -eq $TextColor) { # Netflix
            $StatusBox.Text = "|Instalando Netflix...`r`n" + $StatusBox.Text
            $MSB5.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Apps/Netflix.appx", $ToPath+"\Apps\Netflix.appx")
            &{ $ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\Netflix.appx") }
            $MSB5.BackColor = $TextColor
        }
        if ($MSB6.BackColor -eq $TextColor) { # Prime Video
            $StatusBox.Text = "|Instalando Prime Video...`r`n" + $StatusBox.Text
            $MSB6.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Scripts/Downloads/DownloadPrimeVideo.ps1", $ToPath+"\Scripts\Downloads\DownloadPrimeVideo.ps1")
            Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\Downloads\DownloadPrimeVideo.ps1 ; exit"
            $MSB6.BackColor = $TextColor
        }
        if ($MSB7.BackColor -eq $TextColor) { # VLC Media Player
            $StatusBox.Text = "|Instalando VLC Media Player...`r`n" + $StatusBox.Text
            $MSB7.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Apps/VLCMediaPlayer.exe", $ToPath+"\Apps\VLCMediaPlayer.exe")
            Start-Process ($ToPath+"\Apps\VLCMediaPlayer.exe")
            $MSB7.BackColor = $TextColor
        }
        if ($MSB8.BackColor -eq $TextColor) { # GitHub Desktop
            $StatusBox.Text = "|Instalando GitHub Desktop...`r`n" + $StatusBox.Text
            $MSB8.BackColor = $ProcessingColor
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id GitHub.GitHubDesktop | Out-Null
            $MSB8.BackColor = $TextColor
        }
        if ($MSB9.BackColor -eq $TextColor) { # MegaSync
            $StatusBox.Text = "|Instalando MegaSync...`r`n" + $StatusBox.Text
            $MSB9.BackColor = $ProcessingColor
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Mega.MEGASync | Out-Null
            $MSB9.BackColor = $TextColor
        }
        if ($MSB10.BackColor -eq $TextColor) { # Void
            $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
            $MSB10.BackColor = $ProcessingColor
            $MSB10.BackColor = $TextColor
        }
        if ($MSB11.BackColor -eq $TextColor) { # Void
            $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
            $MSB11.BackColor = $ProcessingColor
            $MSB11.BackColor = $TextColor
        }
        if ($MSB12.BackColor -eq $TextColor) { # Void
            $StatusBox.Text = "|Instalando Void...`r`n" + $StatusBox.Text
            $MSB12.BackColor = $ProcessingColor
            $MSB12.BackColor = $TextColor
        }
    }
    if ($LB1.BackColor -eq $TextColor) { # Steam
        $StatusBox.Text = "|Instalando Steam...`r`n" + $StatusBox.Text
        $LB1.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Valve.Steam | Out-Null
        $LB1.BackColor = $TextColor
    }
    if ($LB2.BackColor -eq $TextColor) { # EA Desktop
        $StatusBox.Text = "|Instalando EA Desktop...`r`n" + $StatusBox.Text
        $LB2.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id ElectronicArts.EADesktop | Out-Null
        $LB2.BackColor = $TextColor
    }
    if ($LB3.BackColor -eq $TextColor) { # Ubisoft Connect
        $StatusBox.Text = "|Instalando Ubisoft Connect...`r`n" + $StatusBox.Text
        $LB3.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Ubisoft.Connect | Out-Null
        $LB3.BackColor = $TextColor
    }
    if ($LB4.BackColor -eq $TextColor) { # Battle.Net
        $StatusBox.Text = "|Instalando Battle.Net...`r`n" + $StatusBox.Text
        $LB4.BackColor = $ProcessingColor
        $tempfile = "https://www.battle.net/D$Download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live&id=undefined"
        $Download.DownloadFile($tempfile, $ToPath+"\Apps\BattleNet.exe")
        Start-Process ($ToPath+"\Apps\BattleNet.exe")
        $LB4.BackColor = $TextColor
    }
    if ($LB5.BackColor -eq $TextColor) { # GOG Galaxy
        $StatusBox.Text = "|Instalando GOG Galaxy...`r`n" + $StatusBox.Text
        $LB5.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id GOG.Galaxy | Out-Null
        $LB5.BackColor = $TextColor
    }
    if ($LB6.BackColor -eq $TextColor) { # Rockstar Games Launcher
        $StatusBox.Text = "|Instalando Rockstar Games Launcher...`r`n" + $StatusBox.Text
        $LB6.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/RockstarGamesLauncher.exe", $ToPath+"\Apps\RockstarGamesLauncher.exe")
        Start-Process ($ToPath+"\Apps\RockstarGamesLauncher.exe")
        $LB6.BackColor = $TextColor
    }
    if ($LB7.BackColor -eq $TextColor) { # Epic Games Launcher
        $StatusBox.Text = "|Instalando Epic Games Launcher...`r`n" + $StatusBox.Text
        $LB7.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id EpicGames.EpicGamesLauncher | Out-Null
        $LB7.BackColor = $TextColor
    }
    if ($LB8.BackColor -eq $TextColor) { # Xbox App
        $StatusBox.Text = "|Instalando Xbox App...`r`n" + $StatusBox.Text
        $LB8.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/XboxApp.appx", $ToPath+"\Apps\XboxApp.appx")
        &{$ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\XboxApp.appx")} 
        $LB8.BackColor = $TextColor
    }
    if ($TB1.BackColor -eq $TextColor) { # Essential Tweaks
        $StatusBox.Text = "|AJUSTES ESENCIALES`r`n`r`n" + $StatusBox.Text
        $TB1.BackColor = $ProcessingColor

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
    
        # Disable Mouse Acceleration
        $StatusBox.Text = "|Desactivando Aceleracion Del Raton...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0
        
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
        "BcastDVRUserService_48486de"                  # Disables GameDVR and Broadcast   is used for Game Recordings and Live Broadcasts
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
        Get-AppxPackage -All -Name *Disney* | Remove-AppxPackage
        }
        $TB1.BackColor = $TextColor
    }
    if ($TB2.BackColor -eq $TextColor) { # Extra Tweaks
        $StatusBox.Text = "|Aplicando Extra Tweaks...`r`n`r`n" + $StatusBox.Text
        $TB2.BackColor = $ProcessingColor
    
        # RAM Cleaning And Lots Of Optimizations
        $Download.DownloadFile($FromPath+"/Apps/PowerRun.exe", $ToPath+"\Apps\PowerRun.exe")
        $Download.DownloadFile($FromPath+"/Apps/RamCleaner.reg", $ToPath+"\Apps\RamCleaner.reg")
        Start-Process ($ToPath+"\Apps\PowerRun.exe") "%%PowerRunDir%%\RamCleaner.reg"

        # Reduce svchost Process Amount
        $RamCapacity = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1kb
        if ($RamCapacity -ige 16777216) {
            Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $RamCapacity
        }

        # Keep Windows From Creating DumpStack.log File
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "EnableLogFile" -Type DWord -Value 0
    
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
    
        # Hide Chat Button
        $StatusBox.Text = "|Ocultando Boton De Chats...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0

        # Set Desktop Icons Size To Small
        $StatusBox.Text = "|Reduciendo El Tamaño De Los Iconos Del Escritorio...`r`n" + $StatusBox.Text
        taskkill /f /im explorer.exe
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop" -Name "IconSize" -Type DWord -Value 32
        explorer.exe
    
        # Set Dark Theme
        $StatusBox.Text = "|Estableciendo Modo Oscuro...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
    
        # Hide Recent Files And Folders In Explorer
        $StatusBox.Text = "|Ocultando Archivos Y Carpetas Recientes De  Acceso Rapido...`r`n" + $StatusBox.Text
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
        DISM /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0
        }
        $TB2.BackColor = $TextColor
    } 
    if ($TB3.BackColor -eq $TextColor) { # Nvidia Settings
        $StatusBox.Text = "|Aplicando Ajustes Al Panel De Control De Nvidia...`r`n" + $StatusBox.Text
        $TB3.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/ProfileInspector.exe", $ToPath+"\Apps\ProfileInspector.exe")
        $Download.DownloadFile($FromPath+"/Configs/NvidiaProfiles.nip", $ToPath+"\Configs\NvidiaProfiles.nip")
        Start-Process ($ToPath+"\Apps\ProfileInspector.exe")($ToPath+"\Configs\NvidiaProfiles.nip")
        $TB3.BackColor = $TextColor
    } 
    if ($TB4.BackColor -eq $TextColor) { # Reduce Icons Spacing
        $StatusBox.Text = "|Reduciendo Espacio Entre Iconos...`r`n" + $StatusBox.Text
        $TB4.BackColor = $ProcessingColor
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "IconSpacing" -Value -900
        $TB4.BackColor = $TextColor
    } 
    if ($TB5.BackColor -eq $TextColor) { # Hide Shortcut Arrows
        $StatusBox.Text = "|Ocultando Flechas De Acceso Directo...`r`n" + $StatusBox.Text
        $TB5.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Configs/Blank.ico", $ToPath+"\Configs\Blank.ico")
        Unblock-File ($ToPath+"\Configs\Blank.ico")
        Copy-Item -Path ($ToPath+"\Configs\Blank.ico") -Destination "C:\Windows\System32" -Force
        $Download.DownloadFile($FromPath+"/Apps/BlankShortcut.reg", $ToPath+"\Apps\BlankShortcut.reg")
        regedit /s ($ToPath+"\Apps\BlankShortcut.reg")
        $TB5.BackColor = $TextColor
    } 
    if ($TB6.BackColor -eq $TextColor) { # Set Modern Cursor
        $StatusBox.Text = "|Estableciendo Cursor Personalizado...`r`n" + $StatusBox.Text
        $TB6.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Configs/ModernCursor.zip", $ToPath+"\Configs\ModernCursor.zip")
        Expand-Archive -Path ($ToPath+"\Configs\ModernCursor.zip") -DestinationPath 'C:\Windows\Cursors\Modern Cursor' -Force
        $Download.DownloadFile($FromPath+"/Apps/ModernCursor.reg", $ToPath+"\Apps\ModernCursor.reg")
        regedit /s $env:userprofile\AppData\Local\Temp\ZKTool\Apps\ModernCursor.reg
        $TB6.BackColor = $TextColor
    } 
    if ($TB7.BackColor -eq $TextColor) { # Disable Cortana
        $StatusBox.Text = "|Deshabilitando Cortana...`r`n" + $StatusBox.Text
        $TB7.BackColor = $ProcessingColor
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
        $TB7.BackColor = $TextColor
    } 
    if ($TB8.BackColor -eq $TextColor) { # Uninstall OneDrive
        $StatusBox.Text = "|Desinstalando One Drive...`r`n" + $StatusBox.Text
        $TB8.BackColor = $ProcessingColor
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
        $TB8.BackColor = $TextColor
    } 
    if ($TB9.BackColor -eq $TextColor) { # Uninstall Xbox Game Bar
        $StatusBox.Text = "|Desinstalando Xbox Game Bar...`r`n" + $StatusBox.Text
        $TB9.BackColor = $ProcessingColor
        Get-AppxPackage "Microsoft.XboxGamingOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage 
        Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage 
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
        $TB9.BackColor = $TextColor
    } 
    if ($TB10.BackColor -eq $TextColor) { # Ram Cleaner (ISLC)
        $StatusBox.Text = "|Instalando Inteligent Standby List Cleaner (ISLC)...`r`n" + $StatusBox.Text
        $TB10.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/ISLC.zip", $ToPath+"\Apps\ISLC.zip")
        Expand-Archive -Path ($ToPath+"\Apps\ISLC.zip") -DestinationPath 'C:\Program Files\ISLC' -Force
        Move-Item -Path 'C:\Program Files\ISLC\ISLC Intelligent Standby List Cleaner.lnk' -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
        Start-Process "C:\Program Files\ISLC\Intelligent standby list cleaner ISLC.exe"
        $TB10.BackColor = $TextColor
    } 
    if ($MoreT.BackColor -eq $TextColor) { # More Tweaks Bracket
        if ($MTB1.BackColor -eq $TextColor) { # Activate Windows Pro Edition
            $StatusBox.Text = "|Activando Windows Pro Edition...`r`n" + $StatusBox.Text
            $MTB1.BackColor = $ProcessingColor
            cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
            cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /skms kms.digiboy.ir
            cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ato
            $MTB1.BackColor = $TextColor
        }
        if ($MTB2.BackColor -eq $TextColor) { # Install Visual C++
            $StatusBox.Text = "|Instalando Todas Las Versiones De Visual C++...`r`n" + $StatusBox.Text
            $MTB2.BackColor = $ProcessingColor
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
            $MTB2.BackColor = $TextColor
        }  
        if ($MTB3.BackColor -eq $TextColor) { # Install TaskbarX
            $StatusBox.Text = "|Instalando TaskbarX...`r`n" + $StatusBox.Text
            $MTB3.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Apps/TaskbarX.zip", $ToPath+"\Apps\TaskbarX.zip")
            Expand-Archive -Path ($ToPath+"\Apps\TaskbarX.zip") -DestinationPath 'C:\Program Files\TaskbarX' -Force
            Copy-Item -Path 'C:\Program Files\TaskbarX\TaskbarX Configurator.lnk' -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force
            Start-Process "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\TaskbarX Configurator.lnk"
            $MTB3.BackColor = $TextColor
        }  
        if ($MTB4.BackColor -eq $TextColor) { # Install Video Extensions
            $StatusBox.Text = "Instalando Extensiones De Video HEVC Y HEIF... `r`n" + $StatusBox.Text
            $MTB4.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Apps/HEVC.appx", $ToPath+"\Apps\HEVC.appx")
            $Download.DownloadFile($FromPath+"/Apps/HEIF.appx", $ToPath+"\Apps\HEIF.appx")
            &{$ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\HEVC.appx"); Add-AppxPackage ($ToPath+"\Apps\HEIF.appx")}
            $MTB4.BackColor = $TextColor
        }  
        if ($MTB5.BackColor -eq $TextColor) { # Windows Terminal Fix
            $StatusBox.Text = "|Aplicando Ajustes A Windows Terminal...`r`n" + $StatusBox.Text
            $MTB5.BackColor = $ProcessingColor
            if (!(Test-Path -Path $env:userprofile\AppData\Local\Microsoft\Windows\Fonts\SourceCodePro*)) {
                $Download.DownloadFile($FromPath+"/Configs/FontSourceCodePro.zip", $ToPath+"\Configs\FontSourceCodePro.zip")
                Expand-Archive -Path ($ToPath+"\ZKTool\Configs\FontSourceCodePro.zip") -DestinationPath ($ToPath+"\ZKTool\Configs\FontSourceCodePro") -Force
                Start-Process ($ToPath+"\ZKTool\Configs\FontSourceCodePro\Install.exe")
                Wait-Process -Name "Install"
            }
            $Download.DownloadFile($FromPath+"/Configs/WindowsTerminalFix.zip", $ToPath+"\Configs\WindowsTerminalFix.zip")
            Expand-Archive -Path ($ToPath+"\Configs\WindowsTerminalFix.zip") -DestinationPath $env:userprofile\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force
            $MTB5.BackColor = $TextColor 
        }  
        if ($MTB6.BackColor -eq $TextColor) { # Extreme Power Plan
            $StatusBox.Text = "|Activando Highest Performance Power Plan...`r`n" + $StatusBox.Text
            $MTB6.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Apps/HighestPerformance.pow", $ToPath+"\Apps\HighestPerformance.pow")
            $Download.DownloadFile($FromPath+"/Apps/PowerPlan.cmd", $ToPath+"\Apps\PowerPlan.cmd")
            Start-Process ($ToPath+"\Apps\PowerPlan.cmd")
            Start-Sleep 5
            powercfg /X monitor-timeout-ac 15
            powercfg /X monitor-timeout-dc 15
            powercfg /X standby-timeout-ac 0
            powercfg /X standby-timeout-dc 0
            $MTB6.BackColor = $TextColor
        }  
        if ($MTB7.BackColor -eq $TextColor) { # Performance Counters
            $StatusBox.Text = "|Reconstruyendo Contadores De Rendimiento...`r`n" + $StatusBox.Text
            $MTB7.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Apps/PerformanceCounters.cmd", $ToPath+"\Apps\PerformanceCounters.cmd")
            Start-Process ($ToPath+"\ZKTool\Apps\PerformanceCounters.cmd")
            $MTB7.BackColor = $TextColor
        }  
        if ($MTB8.BackColor -eq $TextColor) { # Static IP + DNS
            $StatusBox.Text = "|Abriendo Selector De IPs...`r`n" + $StatusBox.Text
            $MTB8.BackColor = $ProcessingColor
            iex ((New-Object System.Net.WebClient).DownloadString(($FromPath+"/Scripts/ChooseIp.ps1")))
            $MTB8.BackColor = $TextColor
        }  
        if ($MTB9.BackColor -eq $TextColor) { # Autoruns
            $StatusBox.Text = "|Abriendo Autoruns...`r`n" + $StatusBox.Text
            $MTB9.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Apps/Autoruns.exe", $ToPath+"\Apps\Autoruns.exe")
            Start-Process ($ToPath+"\Apps\Autoruns.exe")
            $MTB9.BackColor = $TextColor
        }  
        if ($MTB10.BackColor -eq $TextColor) { # VisualFX Fix
            $StatusBox.Text = "|Ajustando Animaciones De Windows...`r`n" + $StatusBox.Text
            $MTB10.BackColor = $ProcessingColor
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
            
            
            $MTB10.BackColor = $TextColor
        }   
        if ($MTB11.BackColor -eq $TextColor) { # Void
            $StatusBox.Text = "|Void...`r`n" + $StatusBox.Text
            $MTB11.BackColor = $ProcessingColor
            $MTB11.BackColor = $TextColor
        } 
    }
    if ($HSB1.BackColor -eq $TextColor) { # Valorant
        $StatusBox.Text = "|Instalando Valorant...`r`n" + $StatusBox.Text
        $HSB1.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Scripts/Downloads/Valorant.ps1", $ToPath+"\Scripts\Downloads\Valorant.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\Downloads\Valorant.ps1 ; exit" 
        $HSB1.BackColor = $TextColor
    }
    if ($HSB2.BackColor -eq $TextColor) { # League of Legends
        $StatusBox.Text = "|Instalando League of Legends...`r`n" + $StatusBox.Text
        $HSB2.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RiotGames.LeagueOfLegends.EUW | Out-Null
        $HSB2.BackColor = $TextColor
    }
    if ($HSB3.BackColor -eq $TextColor) { # Escape From Tarkov
        $StatusBox.Text = "|Instalando Escape From Tarkov...`r`n" + $StatusBox.Text
        $HSB3.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Scripts/Downloads/Tarkov.ps1", $ToPath+"\Scripts\Downloads\Tarkov.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\Downloads\Tarkov.ps1 ; exit"
        $HSB3.BackColor = $TextColor
    }
    if ($HB1.BackColor -eq $TextColor) { # Rufus
        $StatusBox.Text = "|Iniciando Rufus...`r`n" + $StatusBox.Text
        $HB1.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/Rufus.exe", $ToPath+"\Apps\Rufus.exe")
        Start-Process ($ToPath+"\Apps\Rufus.exe")
        $HB1.BackColor = $TextColor
    } 
    if ($HB2.BackColor -eq $TextColor) { # MSI Afterburner Config
        $StatusBox.Text = "|Configurando MSI Afterburner...`r`n" + $StatusBox.Text
        $HB2.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Configs/Profiles.zip", $ToPath+"\Configs\Profiles.zip")
        Expand-Archive -Path ($ToPath+"\Configs\Profiles.zip") -DestinationPath 'C:\Program Files (x86)\MSI Afterburner\Profiles' -Force
        $HB2.BackColor = $TextColor
    }   
    if ($HB3.BackColor -eq $TextColor) { # Discord Second Screen
        $StatusBox.Text = "|Configurando Discord En El Monitor Derecho...`r`n" + $StatusBox.Text
        $HB3.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Configs/settings.json", $ToPath+"\Configs\settings.json")
        Copy-Item -Path ($ToPath+"\Configs\settings.json") -DestinationPath "$env:userprofile\AppData\Roaming\discord" -Force
        $HB3.BackColor = $TextColor
    }   
    if ($HB4.BackColor -eq $TextColor) { # Software RL
        $StatusBox.Text = "|Instalando Software RL...`r`n" + $StatusBox.Text
        $HB4.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/RLSoftware.exe", $ToPath+"\Apps\RLSoftware.exe")
        Start-Process ($ToPath+"\Apps\RLSoftware.exe")
        $HB4.BackColor = $TextColor
    }   
    if ($HB5.BackColor -eq $TextColor) { # RGB Fusion
        $StatusBox.Text = "|Instalando RGB Fusion...`r`n" + $StatusBox.Text
        $HB5.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Scripts/Downloads/RGBFusion.ps1", $ToPath+"\Scripts\Downloads\RGBFusion.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\FORMATEO\Scripts\Downloads\RGBFusion.ps1 ; exit"
        $HB5.BackColor = $TextColor
    }   
    if ($HB6.BackColor -eq $TextColor) { # JDK 17
        $StatusBox.Text = "|Instalando JDK 17...`r`n" + $StatusBox.Text
        $HB6.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Scripts/Downloads/JDK17.ps1", $ToPath+"\Scripts\Downloads\JDK17.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\FORMATEO\Scripts\Downloads\JDK17.ps1 ; exit"
        $HB6.BackColor = $TextColor
    }   
    if ($HB7.BackColor -eq $TextColor) { # Eclipse IDE
        $StatusBox.Text = "|Instalando Eclipse IDE...`r`n" + $StatusBox.Text
        $HB7.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Scripts/Downloads/Eclipse.ps1", $ToPath+"\Scripts\Downloads\Eclipse.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\FORMATEO\Scripts\Downloads\Eclipse.ps1 ; exit"
        $HB7.BackColor = $TextColor
    }   
    if ($HB8.BackColor -eq $TextColor) { # Visual Studio Code
        $StatusBox.Text = "|Instalando Visual Studio Code...`r`n" + $StatusBox.Text
        $HB8.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VisualStudioCode | Out-Null
        $HB8.BackColor = $TextColor
    }   
    if ($HB9.BackColor -eq $TextColor) { # Game Settings
        $StatusBox.Text = "|Abriendo Game Settings Options...`r`n" + $StatusBox.Text
        $HB9.BackColor = $ProcessingColor
        Iex (Iwr ($FromPath+"/Scripts/GameSettings.ps1"))
        $HB9.BackColor = $TextColor
    }
    if ($HTB1.BackColor -eq $TextColor) { # Unpin All Apps
        $StatusBox.Text = "|Desanclando Todas Las Aplicaciones...`r`n" + $StatusBox.Text
        $HTB1.BackColor = $ProcessingColor
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "Favorites" -Type Binary -Value ([byte[]](255))
        Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "FavoritesResolve" -ErrorAction SilentlyContinue
        $Download.DownloadFile($FromPath+"/Configs/start.bin", $ToPath+"\Configs\start.bin")
        Copy-Item -Path ($ToPath+"\Configs\start.bin") -Destination "$env:userprofile\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState" -Force
        $HTB1.BackColor = $TextColor
    }
    if ($HTB2.BackColor -eq $TextColor) {
        $StatusBox.Text = "|Void...`r`n" + $StatusBox.Text
        $HTB2.BackColor = $ProcessingColor
        $HTB2.BackColor = $TextColor
    }
    if ($HTB3.BackColor -eq $TextColor) {
        $StatusBox.Text = "|Void...`r`n" + $StatusBox.Text
        $HTB3.BackColor = $ProcessingColor
        $HTB3.BackColor = $TextColor
    }
       
    $StartScript.BackColor = $ButtonColor
    $StartScript.ForeColor = $TextColor

    $Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,
                $LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB1,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$MTB1,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,
                $MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$HSB1,$HSB2,$HSB3,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9,$HTB1,$HTB2,$HTB3)
    
    foreach ($Button in $Buttons) {
        if ($Button.BackColor -eq $TextColor) {
                $Button.BackColor = $ButtonColor
                $Button.ForeColor = $TextColor
        }
    }

    $StatusBox.Text = "|Ready`r`n|Script Finalizado`r`n" + $StatusBox.Text
})

$Form.Add_Closing({
    Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse
})

[void]$Form.ShowDialog()