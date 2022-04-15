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
$BackGroundColor = [System.Drawing.ColorTranslator]::FromHtml("#272E3D")
$TextColor = [System.Drawing.ColorTranslator]::FromHtml("#99FFFD")
$ButtonColor = [System.Drawing.ColorTranslator]::FromHtml("#3A3D45")
$ProcessingColor = [System.Drawing.ColorTranslator]::FromHtml("#DC4995")

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "ZKTool"
$Form.StartPosition              = "Manual"
$Form.Location                   = New-Object System.Drawing.Point(605, 190)
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

$Location                        = 233 # Sets Each Panel Location

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
$SB1.Width                       = 215
$SB1.Height                      = 35
$SB1.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB1.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB1.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB1)
$Position += 37

# GeForce Experience
$SB2                             = New-Object System.Windows.Forms.Button
$SB2.Text                        = "GeForce Experience"
$SB2.Width                       = 215
$SB2.Height                      = 35
$SB2.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB2.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB2.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB2)
$Position += 37

# NanaZip
$SB3                             = New-Object System.Windows.Forms.Button
$SB3.Text                        = "NanaZip"
$SB3.Width                       = 215
$SB3.Height                      = 35
$SB3.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB3.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB3.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB3)
$Position += 37

# Discord
$SB4                             = New-Object System.Windows.Forms.Button
$SB4.Text                        = "Discord"
$SB4.Width                       = 215
$SB4.Height                      = 35
$SB4.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB4.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB4.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB4)
$Position += 37

# HW Monitor
$SB5                             = New-Object System.Windows.Forms.Button
$SB5.Text                        = "HW Monitor"
$SB5.Width                       = 215
$SB5.Height                      = 35
$SB5.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB5.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB5.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB5)
$Position += 37

# MSI Afterburner
$SB6                             = New-Object System.Windows.Forms.Button
$SB6.Text                        = "MSI Afterburner"
$SB6.Width                       = 215
$SB6.Height                      = 35
$SB6.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB6.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB6.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB6)
$Position += 37

# Corsair iCue
$SB7                             = New-Object System.Windows.Forms.Button
$SB7.Text                        = "Corsair iCue"
$SB7.Width                       = 215
$SB7.Height                      = 35
$SB7.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB7.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB7.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB7)
$Position += 37

# Logitech GHUB
$SB8                             = New-Object System.Windows.Forms.Button
$SB8.Text                        = "Logitech G HUB"
$SB8.Width                       = 215
$SB8.Height                      = 35
$SB8.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB8.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB8.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB8)
$Position += 37

# Razer Synapse
$SB9                             = New-Object System.Windows.Forms.Button
$SB9.Text                        = "Razer Synapse"
$SB9.Width                       = 215
$SB9.Height                      = 35
$SB9.Location                    = New-Object System.Drawing.Point(10,$Position)
$SB9.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB9.BackColor                   = $ButtonColor
$SPanel.Controls.Add($SB9)
$Position += 37

# uTorrent Web
$SB10                            = New-Object System.Windows.Forms.Button
$SB10.Text                       = "uTorrent Web"
$SB10.Width                      = 215
$SB10.Height                     = 35
$SB10.Location                   = New-Object System.Drawing.Point(10,$Position)
$SB10.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB10.BackColor                  = $ButtonColor
$SPanel.Controls.Add($SB10)
$Position += 37

# Libre Office
$SB11                            = New-Object System.Windows.Forms.Button
$SB11.Text                       = "Libre Office"
$SB11.Width                      = 215
$SB11.Height                     = 35
$SB11.Location                   = New-Object System.Drawing.Point(10,$Position)
$SB11.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$SB11.BackColor                  = $ButtonColor
$SPanel.Controls.Add($SB11)
$Position += 37

# More Software Button
$MoreS                           = New-Object System.Windows.Forms.Button
$MoreS.Text                      = "Mostrar Mas"
$MoreS.Width                     = 215
$MoreS.Height                    = 35
$MoreS.Location                  = New-Object System.Drawing.Point(10,$Position)
$MoreS.Font                      = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MoreS.BackColor                 = $ButtonColor
$SPanel.Controls.Add($MoreS)
$Position = 10


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
$MSB1                            = New-Object system.Windows.Forms.Button
$MSB1.Text                       = "Streamlabs OBS"
$MSB1.Width                      = 215
$MSB1.Height                     = 35
$MSB1.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB1.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB1.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB1)
$Position += 37

# Photoshop Portable
$MSB2                            = New-Object system.Windows.Forms.Button
$MSB2.Text                       = "Photoshop Portable"
$MSB2.Width                      = 215
$MSB2.Height                     = 35
$MSB2.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB2.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB2.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB2)
$Position += 37

# Premiere Portable
$MSB3                            = New-Object system.Windows.Forms.Button
$MSB3.Text                       = "Premiere Portable"
$MSB3.Width                      = 215
$MSB3.Height                     = 35
$MSB3.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB3.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB3.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB3)
$Position += 37

# Spotify
$MSB4                            = New-Object system.Windows.Forms.Button
$MSB4.Text                       = "Spotify"
$MSB4.Width                      = 215
$MSB4.Height                     = 35
$MSB4.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB4.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB4.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB4)
$Position += 37

# Netflix
$MSB5                            = New-Object system.Windows.Forms.Button
$MSB5.Text                       = "Netflix"
$MSB5.Width                      = 215
$MSB5.Height                     = 35
$MSB5.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB5.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB5.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB5)
$Position += 37

# Prime Video
$MSB6                            = New-Object system.Windows.Forms.Button
$MSB6.Text                       = "Prime Video"
$MSB6.Width                      = 215
$MSB6.Height                     = 35
$MSB6.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB6.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB6.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB6)
$Position += 37

# VLC Media Player
$MSB7                            = New-Object system.Windows.Forms.Button
$MSB7.Text                       = "VLC Media Player"
$MSB7.Width                      = 215
$MSB7.Height                     = 35
$MSB7.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB7.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB7.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB7)
$Position += 37

# GitHub Desktop
$MSB8                            = New-Object system.Windows.Forms.Button
$MSB8.Text                       = "GitHub Desktop"
$MSB8.Width                      = 215
$MSB8.Height                     = 35
$MSB8.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB8.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB8.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB8)
$Position += 37

# Megasync
$MSB9                            = New-Object System.Windows.Forms.Button
$MSB9.Text                       = "Megasync"
$MSB9.Width                      = 215
$MSB9.Height                     = 35
$MSB9.Location                   = New-Object System.Drawing.Point(10,$Position)
$MSB9.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB9.BackColor                  = $ButtonColor
$MSPanel.Controls.Add($MSB9)
$Position += 37

# Valorant
$MSB10                           = New-Object System.Windows.Forms.Button
$MSB10.Text                      = "Valorant"
$MSB10.Width                     = 215
$MSB10.Height                    = 35
$MSB10.Location                  = New-Object System.Drawing.Point(10,$Position)
$MSB10.Font                      = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB10.BackColor                 = $ButtonColor
$MSPanel.Controls.Add($MSB10)
$Position += 37

# League of Legends
$MSB11                           = New-Object System.Windows.Forms.Button
$MSB11.Text                      = "League of Legends"
$MSB11.Width                     = 215
$MSB11.Height                    = 35
$MSB11.Location                  = New-Object System.Drawing.Point(10,$Position)
$MSB11.Font                      = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB11.BackColor                 = $ButtonColor
$MSPanel.Controls.Add($MSB11)
$Position += 37

# Escape From Tarkov
$MSB12                           = New-Object System.Windows.Forms.Button
$MSB12.Text                      = "Escape From Tarkov"
$MSB12.Width                     = 215
$MSB12.Height                    = 35
$MSB12.Location                  = New-Object System.Drawing.Point(10,$Position)
$MSB12.Font                      = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MSB12.BackColor                 = $ButtonColor
$MSPanel.Controls.Add($MSB12)
$Position = 10


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
$LB1.Width                       = 215
$LB1.Height                      = 35
$LB1.Location                    = New-Object System.Drawing.Point(10,$Position)
$LB1.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$LB1.BackColor                   = $ButtonColor
$LPanel.Controls.Add($LB1)
$Position += 37

# EA Desktop
$LB2                             = New-Object System.Windows.Forms.Button
$LB2.Text                        = "EA Desktop"
$LB2.Width                       = 215
$LB2.Height                      = 35
$LB2.Location                    = New-Object System.Drawing.Point(10,$Position)
$LB2.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$LB2.BackColor                   = $ButtonColor
$LPanel.Controls.Add($LB2)
$Position += 37

# Ubisoft Connect
$LB3                             = New-Object System.Windows.Forms.Button
$LB3.Text                        = "Ubisoft Connect"
$LB3.Width                       = 215
$LB3.Height                      = 35
$LB3.Location                    = New-Object System.Drawing.Point(10,$Position)
$LB3.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$LB3.BackColor                   = $ButtonColor
$LPanel.Controls.Add($LB3)
$Position += 37

# Battle.Net
$LB4                             = New-Object System.Windows.Forms.Button
$LB4.Text                        = "Battle.Net"
$LB4.Width                       = 215
$LB4.Height                      = 35
$LB4.Location                    = New-Object System.Drawing.Point(10,$Position)
$LB4.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$LB4.BackColor                   = $ButtonColor
$LPanel.Controls.Add($LB4)
$Position += 37

# GOG Galaxy
$LB5                             = New-Object System.Windows.Forms.Button
$LB5.Text                        = "GOG Galaxy"
$LB5.Width                       = 215
$LB5.Height                      = 35
$LB5.Location                    = New-Object System.Drawing.Point(10,$Position)
$LB5.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$LB5.BackColor                   = $ButtonColor
$LPanel.Controls.Add($LB5)
$Position += 37

# Rockstar Games
$LB6                             = New-Object System.Windows.Forms.Button
$LB6.Text                        = "Rockstar Games"
$LB6.Width                       = 215
$LB6.Height                      = 35
$LB6.Location                    = New-Object System.Drawing.Point(10,$Position)
$LB6.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$LB6.BackColor                   = $ButtonColor
$LPanel.Controls.Add($LB6)
$Position += 37

# Epic Games
$LB7                             = New-Object System.Windows.Forms.Button
$LB7.Text                        = "Epic Games"
$LB7.Width                       = 215
$LB7.Height                      = 35
$LB7.Location                    = New-Object System.Drawing.Point(10,$Position)
$LB7.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$LB7.BackColor                   = $ButtonColor
$LPanel.Controls.Add($LB7)
$Position += 37

# Xbox App
$LB8                             = New-Object System.Windows.Forms.Button
$LB8.Text                        = "Xbox App"
$LB8.Width                       = 215
$LB8.Height                      = 35
$LB8.Location                    = New-Object System.Drawing.Point(10,$Position)
$LB8.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$LB8.BackColor                   = $ButtonColor
$LPanel.Controls.Add($LB8)
$Position = 10


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
$TB1.Width                       = 215
$TB1.Height                      = 72
$TB1.Location                    = New-Object System.Drawing.Point(10,$Position)
$TB1.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB1.BackColor                   = $ButtonColor
$TPanel.Controls.Add($TB1)
$Position += 37*2

# Extra Tweaks
$TB2                             = New-Object System.Windows.Forms.Button
$TB2.Text                        = "Extra Tweaks"
$TB2.Width                       = 215
$TB2.Height                      = 35
$TB2.Location                    = New-Object System.Drawing.Point(10,$Position)
$TB2.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB2.BackColor                   = $ButtonColor
$TPanel.Controls.Add($TB2)
$Position += 37

# Nvidia Settings
$TB3                             = New-Object System.Windows.Forms.Button
$TB3.Text                        = "Nvidia Settings"
$TB3.Width                       = 215
$TB3.Height                      = 35
$TB3.Location                    = New-Object System.Drawing.Point(10,$Position)
$TB3.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB3.BackColor                   = $ButtonColor
$TPanel.Controls.Add($TB3)
$Position += 37

# Reduce Icons Spacing
$TB4                             = New-Object System.Windows.Forms.Button
$TB4.Text                        = "Reduce Icons Spacing"
$TB4.Width                       = 215
$TB4.Height                      = 35
$TB4.Location                    = New-Object System.Drawing.Point(10,$Position)
$TB4.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB4.BackColor                   = $ButtonColor
$TPanel.Controls.Add($TB4)
$Position += 37

# Hide Shortcut Arrows
$TB6                             = New-Object System.Windows.Forms.Button
$TB6.Text                        = "Hide Shortcut Arrows"
$TB6.Width                       = 215
$TB6.Height                      = 35
$TB6.Location                    = New-Object System.Drawing.Point(10,$Position)
$TB6.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB6.BackColor                   = $ButtonColor
$TPanel.Controls.Add($TB6)
$Position += 37

# Set Modern Cursor
$TB7                             = New-Object System.Windows.Forms.Button
$TB7.Text                        = "Set Modern Cursor"
$TB7.Width                       = 215
$TB7.Height                      = 35
$TB7.Location                    = New-Object System.Drawing.Point(10,$Position)
$TB7.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB7.BackColor                   = $ButtonColor
$TPanel.Controls.Add($TB7)
$Position += 37

# Disable Cortana
$TB8                             = New-Object System.Windows.Forms.Button
$TB8.Text                        = "Disable Cortana"
$TB8.Width                       = 215
$TB8.Height                      = 35
$TB8.Location                    = New-Object System.Drawing.Point(10,$Position)
$TB8.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB8.BackColor                   = $ButtonColor
$TPanel.Controls.Add($TB8)
$Position += 37

# Uninstall OneDrive
$TB9                             = New-Object System.Windows.Forms.Button
$TB9.Text                        = "Uninstall OneDrive"
$TB9.Width                       = 215
$TB9.Height                      = 35
$TB9.Location                    = New-Object System.Drawing.Point(10,$Position)
$TB9.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB9.BackColor                   = $ButtonColor
$TPanel.Controls.Add($TB9)
$Position += 37

# Uninstall Xbox Game Bar
$TB10                            = New-Object System.Windows.Forms.Button
$TB10.Text                       = "Uninstall Xbox Game Bar"
$TB10.Width                      = 215
$TB10.Height                     = 35
$TB10.Location                   = New-Object System.Drawing.Point(10,$Position)
$TB10.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB10.BackColor                  = $ButtonColor
$TPanel.Controls.Add($TB10)
$Position += 37

# Ram Cleaner (ISLC)
$TB11                            = New-Object System.Windows.Forms.Button
$TB11.Text                       = "Ram Cleaner (ISLC)"
$TB11.Width                      = 215
$TB11.Height                     = 35
$TB11.Location                   = New-Object System.Drawing.Point(10,$Position)
$TB11.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$TB11.BackColor                  = $ButtonColor
$TPanel.Controls.Add($TB11)
$Position += 37

# More Tweaks Button
$MoreT                           = New-Object System.Windows.Forms.Button
$MoreT.Text                      = "Mostrar Mas"
$MoreT.Width                     = 215
$MoreT.Height                    = 35
$MoreT.Location                  = New-Object System.Drawing.Point(10,$Position)
$MoreT.Font                      = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MoreT.BackColor                 = $ButtonColor
$TPanel.Controls.Add($MoreT)
$Position = 10


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
$MTB1.Width                      = 215
$MTB1.Height                     = 72
$MTB1.Location                   = New-Object System.Drawing.Point(10,$Position)
$MTB1.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB1.BackColor                  = $ButtonColor
$MTPanel.Controls.Add($MTB1)
$Position += 37*2

# Install Visual C++
$MTB2                            = New-Object System.Windows.Forms.Button
$MTB2.Text                       = "Install Visual C++"
$MTB2.Width                      = 215
$MTB2.Height                     = 35
$MTB2.Location                   = New-Object System.Drawing.Point(10,$Position)
$MTB2.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB2.BackColor                  = $ButtonColor
$MTPanel.Controls.Add($MTB2)
$Position += 37

# Install TaskbarX
$MTB3                           = New-Object System.Windows.Forms.Button
$MTB3.Text                      = "Install TaskbarX"
$MTB3.Width                     = 215
$MTB3.Height                    = 35
$MTB3.Location                  = New-Object System.Drawing.Point(10,$Position)
$MTB3.Font                      = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB3.BackColor                 = $ButtonColor
$MTPanel.Controls.Add($MTB3)
$Position += 37

# Video Extensions
$MTB4                           = New-Object System.Windows.Forms.Button
$MTB4.Text                      = "Install Video Extensions"
$MTB4.Width                     = 215
$MTB4.Height                    = 35
$MTB4.Location                  = New-Object System.Drawing.Point(10,$Position)
$MTB4.Font                      = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB4.BackColor                 = $ButtonColor
$MTPanel.Controls.Add($MTB4)
$Position += 37

# Windows Terminal Fix
$MTB5                            = New-Object System.Windows.Forms.Button
$MTB5.Text                       = "Windows Terminal Fix"
$MTB5.Width                      = 215
$MTB5.Height                     = 35
$MTB5.Location                   = New-Object System.Drawing.Point(10,$Position)
$MTB5.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB5.BackColor                  = $ButtonColor
$MTPanel.Controls.Add($MTB5)
$Position += 37

# Power Plan
$MTB6                            = New-Object System.Windows.Forms.Button
$MTB6.Text                       = "Power Plan"
$MTB6.Width                      = 215
$MTB6.Height                     = 35
$MTB6.Location                   = New-Object System.Drawing.Point(10,$Position)
$MTB6.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB6.BackColor                  = $ButtonColor
$MTPanel.Controls.Add($MTB6)
$Position += 37

# Performance Counters
$MTB7                            = New-Object System.Windows.Forms.Button
$MTB7.Text                       = "Performance Counters"
$MTB7.Width                      = 215
$MTB7.Height                     = 35
$MTB7.Location                   = New-Object System.Drawing.Point(10,$Position)
$MTB7.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB7.BackColor                  = $ButtonColor
$MTPanel.Controls.Add($MTB7)
$Position += 37

# Static IP + DNS
$MTB8                            = New-Object System.Windows.Forms.Button
$MTB8.Text                       = "Static IP + DNS"
$MTB8.Width                      = 215
$MTB8.Height                     = 35
$MTB8.Location                   = New-Object System.Drawing.Point(10,$Position)
$MTB8.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB8.BackColor                  = $ButtonColor
$MTPanel.Controls.Add($MTB8)
$Position += 37

# Autoruns
$MTB9                            = New-Object System.Windows.Forms.Button
$MTB9.Text                       = "Autoruns"
$MTB9.Width                      = 215
$MTB9.Height                     = 35
$MTB9.Location                   = New-Object System.Drawing.Point(10,$Position)
$MTB9.Font                       = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB9.BackColor                  = $ButtonColor
$MTPanel.Controls.Add($MTB9)
$Position += 37

# VisualFX Fix
$MTB10                           = New-Object System.Windows.Forms.Button
$MTB10.Text                      = "VisualFX Fix"
$MTB10.Width                     = 215
$MTB10.Height                    = 35
$MTB10.Location                  = New-Object System.Drawing.Point(10,$Position)
$MTB10.Font                      = New-Object System.Drawing.Font('Ubuntu Mono',12)
$MTB10.BackColor                 = $ButtonColor
$MTPanel.Controls.Add($MTB10)
$Position += 37


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
$StatusBox.ForeColor             = $TextColor
$StatusBox.ReadOnly              = $true
$StatusBox.Text                  = "|Ready"
$Form.Controls.Add($StatusBox)


            ##################################
            ########## HIDDEN PANEL ##########
            ##################################


# Hidden Panel
$HPanel                          = New-Object System.Windows.Forms.Panel
$HPanel.Height                   = 131
$HPanel.Width                    = 699
$HPanel.Location                 = New-Object System.Drawing.Point(($Location*0),500)

# Hidden Panel Separator
$HBP                             = New-Object System.Windows.Forms.Button
$HBP.Width                       = 679
$HBP.Height                      = 10
$HBP.Location                    = New-Object System.Drawing.Point(10,5)
$HBP.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HBP.BackColor                   = $TextColor
$HBP.Enabled                     = $False
$HPanel.Controls.Add($HBP)

$Position = 20

# Rufus
$HB1                             = New-Object System.Windows.Forms.Button
$HB1.Text                        = "Rufus"
$HB1.Width                       = 215
$HB1.Height                      = 35
$HB1.Location                    = New-Object System.Drawing.Point(10,$Position)
$HB1.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB1.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB1)

# MSI Afterburner Config
$HB2                             = New-Object System.Windows.Forms.Button
$HB2.Text                        = "Msi Afterburner Config"
$HB2.Width                       = 215
$HB2.Height                      = 35
$HB2.Location                    = New-Object System.Drawing.Point(243,$Position)
$HB2.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB2.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB2)

# Discord Second Screen
$HB3                             = New-Object System.Windows.Forms.Button
$HB3.Text                        = "Discord Second Screen"
$HB3.Width                       = 215
$HB3.Height                      = 35
$HB3.Location                    = New-Object System.Drawing.Point(476,$Position)
$HB3.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB3.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB3)

$Position += 37

# Software RL
$HB4                             = New-Object System.Windows.Forms.Button
$HB4.Text                        = "Software RL"
$HB4.Width                       = 215
$HB4.Height                      = 35
$HB4.Location                    = New-Object System.Drawing.Point(10,$Position)
$HB4.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB4.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB4)

# RGB Fusion
$HB5                             = New-Object System.Windows.Forms.Button
$HB5.Text                        = "RGB Fusion"
$HB5.Width                       = 215
$HB5.Height                      = 35
$HB5.Location                    = New-Object System.Drawing.Point(243,$Position)
$HB5.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB5.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB5)

# JDK 17
$HB6                             = New-Object System.Windows.Forms.Button
$HB6.Text                        = "JDK 17"
$HB6.Width                       = 215
$HB6.Height                      = 35
$HB6.Location                    = New-Object System.Drawing.Point(476,$Position)
$HB6.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB6.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB6)

$Position += 37

# Eclipse IDE
$HB7                             = New-Object System.Windows.Forms.Button
$HB7.Text                        = "Eclipse IDE"
$HB7.Width                       = 215
$HB7.Height                      = 35
$HB7.Location                    = New-Object System.Drawing.Point(10,$Position)
$HB7.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB7.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB7)

# Visual Studio Code
$HB8                             = New-Object System.Windows.Forms.Button
$HB8.Text                        = "Visual Studio Code"
$HB8.Width                       = 215
$HB8.Height                      = 35
$HB8.Location                    = New-Object System.Drawing.Point(243,$Position)
$HB8.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB8.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB8)

# Game Settings
$HB9                             = New-Object System.Windows.Forms.Button
$HB9.Text                        = "Game Settings"
$HB9.Width                       = 215
$HB9.Height                      = 35
$HB9.Location                    = New-Object System.Drawing.Point(476,$Position)
$HB9.Font                        = New-Object System.Drawing.Font('Ubuntu Mono',12)
$HB9.BackColor                   = $ButtonColor
$HPanel.Controls.Add($HB9)


            ##################################
            ######### PADDING BOTTOM #########
            ##################################

# Padding Bottom Panel
$PaddingPanel                    = New-Object System.Windows.Forms.Panel
$PaddingPanel.Height             = 8
$PaddingPanel.Width              = 695
$PaddingPanel.Location           = New-Object System.Drawing.Point(($Location*0),594)
$Form.Controls.Add($PaddingPanel)

$SB1.Add_Click({
    if ($SB1.BackColor -eq $ButtonColor) {
        $SB1.BackColor = $TextColor
        $SB1.ForeColor = $BackGroundColor
    }else {
        $SB1.BackColor = $ButtonColor
        $SB1.ForeColor = $FormTextColor
    }
})

$SB2.Add_Click({
    if ($SB2.BackColor -eq $ButtonColor) {
        $SB2.BackColor = $TextColor
        $SB2.ForeColor = $BackGroundColor
    }else {
        $SB2.BackColor = $ButtonColor
        $SB2.ForeColor = $FormTextColor
    }
})

$SB3.Add_Click({
    if ($SB3.BackColor -eq $ButtonColor) {
        $SB3.BackColor = $TextColor
        $SB3.ForeColor = $BackGroundColor
    }else {
        $SB3.BackColor = $ButtonColor
        $SB3.ForeColor = $FormTextColor
    }
})

$SB4.Add_Click({
    if ($SB4.BackColor -eq $ButtonColor) {
        $SB4.BackColor = $TextColor
        $SB4.ForeColor = $BackGroundColor
    }else {
        $SB4.BackColor = $ButtonColor
        $SB4.ForeColor = $FormTextColor
    }
})

$SB5.Add_Click({
    if ($SB5.BackColor -eq $ButtonColor) {
        $SB5.BackColor = $TextColor
        $SB5.ForeColor = $BackGroundColor
    }else {
        $SB5.BackColor = $ButtonColor
        $SB5.ForeColor = $FormTextColor
    }
})

$SB6.Add_Click({
    if ($SB6.BackColor -eq $ButtonColor) {
        $SB6.BackColor = $TextColor
        $SB6.ForeColor = $BackGroundColor
    }else {
        $SB6.BackColor = $ButtonColor
        $SB6.ForeColor = $FormTextColor
    }
})

$SB7.Add_Click({
    if ($SB7.BackColor -eq $ButtonColor) {
        $SB7.BackColor = $TextColor
        $SB7.ForeColor = $BackGroundColor
    }else {
        $SB7.BackColor = $ButtonColor
        $SB7.ForeColor = $FormTextColor
    }
})

$SB8.Add_Click({
    if ($SB8.BackColor -eq $ButtonColor) {
        $SB8.BackColor = $TextColor
        $SB8.ForeColor = $BackGroundColor
    }else {
        $SB8.BackColor = $ButtonColor
        $SB8.ForeColor = $FormTextColor
    }
})

$SB9.Add_Click({
    if ($SB9.BackColor -eq $ButtonColor) {
        $SB9.BackColor = $TextColor
        $SB9.ForeColor = $BackGroundColor
    }else {
        $SB9.BackColor = $ButtonColor
        $SB9.ForeColor = $FormTextColor
    }
})

$SB10.Add_Click({
    if ($SB10.BackColor -eq $ButtonColor) {
        $SB10.BackColor = $TextColor
        $SB10.ForeColor = $BackGroundColor
    }else {
        $SB10.BackColor = $ButtonColor
        $SB10.ForeColor = $FormTextColor
    }
})

$SB11.Add_Click({
    if ($SB11.BackColor -eq $ButtonColor) {
        $SB11.BackColor = $TextColor
        $SB11.ForeColor = $BackGroundColor
    }else {
        $SB11.BackColor = $ButtonColor
        $SB11.ForeColor = $FormTextColor
    }
})

$MoreS.Add_Click({
        if ($MoreS.BackColor -eq $ButtonColor) {
            $MoreS.BackColor = $TextColor
            $MoreS.ForeColor = $BackGroundColor
            $Form.Controls.Add($MSPanel)
            $MSPanel.Width = 233
            $Form.Location                   = New-Object System.Drawing.Point(372, 190)
            $SLabel.Location                 = New-Object System.Drawing.Point((25+$Location/2),13)
            $SPanel.Location                 = New-Object System.Drawing.Point(($Location),44)
            $LLabel.Location                 = New-Object System.Drawing.Point((252+$Location),13)
            $LPanel.Location                 = New-Object System.Drawing.Point(($Location*2),44)
            $TLabel.Location                 = New-Object System.Drawing.Point((520+$Location),13)
            $TPanel.Location                 = New-Object System.Drawing.Point(($Location*3),44)
            $LogoBox.Location                = New-Object System.Drawing.Point(($Location*2),364)
            $HPanel.Location                 = New-Object System.Drawing.Point(($Location),500)
            $SSPanel.Width                  += $Location
            $StartScript.Width              += $Location
            $StatusBox.Width                += $Location
        }

        if ($MoreT.BackColor -eq $TextColor) {
            $MTPanel.Location                = New-Object System.Drawing.Point(($Location*4),44)
            $TLabel.Location                 = New-Object System.Drawing.Point((520+$Location+($Location/2)),13)
        }
})

$MSB1.Add_Click({
    if ($MSB1.BackColor -eq $ButtonColor) {
        $MSB1.BackColor = $TextColor
        $MSB1.ForeColor = $BackGroundColor
    }else {
        $MSB1.BackColor = $ButtonColor
        $MSB1.ForeColor = $FormTextColor
    }
})

$MSB2.Add_Click({
    if ($MSB2.BackColor -eq $ButtonColor) {
        $MSB2.BackColor = $TextColor
        $MSB2.ForeColor = $BackGroundColor
    }else {
        $MSB2.BackColor = $ButtonColor
        $MSB2.ForeColor = $FormTextColor
    }
})

$MSB3.Add_Click({
    if ($MSB3.BackColor -eq $ButtonColor) {
        $MSB3.BackColor = $TextColor
        $MSB3.ForeColor = $BackGroundColor
    }else {
        $MSB3.BackColor = $ButtonColor
        $MSB3.ForeColor = $FormTextColor
    }
})

$MSB4.Add_Click({
    if ($MSB4.BackColor -eq $ButtonColor) {
        $MSB4.BackColor = $TextColor
        $MSB4.ForeColor = $BackGroundColor
    }else {
        $MSB4.BackColor = $ButtonColor
        $MSB4.ForeColor = $FormTextColor
    }
})

$MSB5.Add_Click({
    if ($MSB5.BackColor -eq $ButtonColor) {
        $MSB5.BackColor = $TextColor
        $MSB5.ForeColor = $BackGroundColor
    }else {
        $MSB5.BackColor = $ButtonColor
        $MSB5.ForeColor = $FormTextColor
    }
})

$MSB6.Add_Click({
    if ($MSB6.BackColor -eq $ButtonColor) {
        $MSB6.BackColor = $TextColor
        $MSB6.ForeColor = $BackGroundColor
    }else {
        $MSB6.BackColor = $ButtonColor
        $MSB6.ForeColor = $FormTextColor
    }
})

$MSB7.Add_Click({
    if ($MSB7.BackColor -eq $ButtonColor) {
        $MSB7.BackColor = $TextColor
        $MSB7.ForeColor = $BackGroundColor
    }else {
        $MSB7.BackColor = $ButtonColor
        $MSB7.ForeColor = $FormTextColor
    }
})

$MSB8.Add_Click({
    if ($MSB8.BackColor -eq $ButtonColor) {
        $MSB8.BackColor = $TextColor
        $MSB8.ForeColor = $BackGroundColor
    }else {
        $MSB8.BackColor = $ButtonColor
        $MSB8.ForeColor = $FormTextColor
    }
})

$MSB9.Add_Click({
    if ($MSB9.BackColor -eq $ButtonColor) {
        $MSB9.BackColor = $TextColor
        $MSB9.ForeColor = $BackGroundColor
    }else {
        $MSB9.BackColor = $ButtonColor
        $MSB9.ForeColor = $FormTextColor
    }
})

$MSB10.Add_Click({
    if ($MSB10.BackColor -eq $ButtonColor) {
        $MSB10.BackColor = $TextColor
        $MSB10.ForeColor = $BackGroundColor
    }else {
        $MSB10.BackColor = $ButtonColor
        $MSB10.ForeColor = $FormTextColor
    }
})

$MSB11.Add_Click({
    if ($MSB11.BackColor -eq $ButtonColor) {
        $MSB11.BackColor = $TextColor
        $MSB11.ForeColor = $BackGroundColor
    }else {
        $MSB11.BackColor = $ButtonColor
        $MSB11.ForeColor = $FormTextColor
    }
})

$MSB12.Add_Click({
    if ($MSB12.BackColor -eq $ButtonColor) {
        $MSB12.BackColor = $TextColor
        $MSB12.ForeColor = $BackGroundColor
    }else {
        $MSB12.BackColor = $ButtonColor
        $MSB12.ForeColor = $FormTextColor
    }
})

$LB1.Add_Click({
    if ($LB1.BackColor -eq $ButtonColor) {
        $LB1.BackColor = $TextColor
        $LB1.ForeColor = $BackGroundColor
    }else {
        $LB1.BackColor = $ButtonColor
        $LB1.ForeColor = $FormTextColor
    }
})

$LB2.Add_Click({
    if ($LB2.BackColor -eq $ButtonColor) {
        $LB2.BackColor = $TextColor
        $LB2.ForeColor = $BackGroundColor
    }else {
        $LB2.BackColor = $ButtonColor
        $LB2.ForeColor = $FormTextColor
    }
})

$LB3.Add_Click({
    if ($LB3.BackColor -eq $ButtonColor) {
        $LB3.BackColor = $TextColor
        $LB3.ForeColor = $BackGroundColor
    }else {
        $LB3.BackColor = $ButtonColor
        $LB3.ForeColor = $FormTextColor
    }
})

$LB4.Add_Click({
    if ($LB4.BackColor -eq $ButtonColor) {
        $LB4.BackColor = $TextColor
        $LB4.ForeColor = $BackGroundColor
    }else {
        $LB4.BackColor = $ButtonColor
        $LB4.ForeColor = $FormTextColor
    }
})

$LB5.Add_Click({
    if ($LB5.BackColor -eq $ButtonColor) {
        $LB5.BackColor = $TextColor
        $LB5.ForeColor = $BackGroundColor
    }else {
        $LB5.BackColor = $ButtonColor
        $LB5.ForeColor = $FormTextColor
    }
})

$LB6.Add_Click({
    if ($LB6.BackColor -eq $ButtonColor) {
        $LB6.BackColor = $TextColor
        $LB6.ForeColor = $BackGroundColor
    }else {
        $LB6.BackColor = $ButtonColor
        $LB6.ForeColor = $FormTextColor
    }
})

$LB7.Add_Click({
    if ($LB7.BackColor -eq $ButtonColor) {
        $LB7.BackColor = $TextColor
        $LB7.ForeColor = $BackGroundColor
    }else {
        $LB7.BackColor = $ButtonColor
        $LB7.ForeColor = $FormTextColor
    }
})

$LB8.Add_Click({
    if ($LB8.BackColor -eq $ButtonColor) {
        $LB8.BackColor = $TextColor
        $LB8.ForeColor = $BackGroundColor
    }else {
        $LB8.BackColor = $ButtonColor
        $LB8.ForeColor = $FormTextColor
    }
})

$TB1.Add_Click({
    if ($TB1.BackColor -eq $ButtonColor) {
        $TB1.BackColor = $TextColor
        $TB1.ForeColor = $BackGroundColor
    }else {
        $TB1.BackColor = $ButtonColor
        $TB1.ForeColor = $FormTextColor
    }
})

$TB2.Add_Click({
    if ($TB2.BackColor -eq $ButtonColor) {
        $TB2.BackColor = $TextColor
        $TB2.ForeColor = $BackGroundColor
    }else {
        $TB2.BackColor = $ButtonColor
        $TB2.ForeColor = $FormTextColor
    }
})

$TB3.Add_Click({
    if ($TB3.BackColor -eq $ButtonColor) {
        $TB3.BackColor = $TextColor
        $TB3.ForeColor = $BackGroundColor
    }else {
        $TB3.BackColor = $ButtonColor
        $TB3.ForeColor = $FormTextColor
    }
})

$TB4.Add_Click({
    if ($TB4.BackColor -eq $ButtonColor) {
        $TB4.BackColor = $TextColor
        $TB4.ForeColor = $BackGroundColor
    }else {
        $TB4.BackColor = $ButtonColor
        $TB4.ForeColor = $FormTextColor
    }
})

$TB5.Add_Click({
    if ($TB5.BackColor -eq $ButtonColor) {
        $TB5.BackColor = $TextColor
        $TB5.ForeColor = $BackGroundColor
    }else {
        $TB5.BackColor = $ButtonColor
        $TB5.ForeColor = $FormTextColor
    }
})

$TB6.Add_Click({
    if ($TB6.BackColor -eq $ButtonColor) {
        $TB6.BackColor = $TextColor
        $TB6.ForeColor = $BackGroundColor
    }else {
        $TB6.BackColor = $ButtonColor
        $TB6.ForeColor = $FormTextColor
    }
})

$TB7.Add_Click({
    if ($TB7.BackColor -eq $ButtonColor) {
        $TB7.BackColor = $TextColor
        $TB7.ForeColor = $BackGroundColor
    }else {
        $TB7.BackColor = $ButtonColor
        $TB7.ForeColor = $FormTextColor
    }
})

$TB8.Add_Click({
    if ($TB8.BackColor -eq $ButtonColor) {
        $TB8.BackColor = $TextColor
        $TB8.ForeColor = $BackGroundColor
    }else {
        $TB8.BackColor = $ButtonColor
        $TB8.ForeColor = $FormTextColor
    }
})

$TB9.Add_Click({
    if ($TB9.BackColor -eq $ButtonColor) {
        $TB9.BackColor = $TextColor
        $TB9.ForeColor = $BackGroundColor
    }else {
        $TB9.BackColor = $ButtonColor
        $TB9.ForeColor = $FormTextColor
    }
})

$TB10.Add_Click({
    if ($TB10.BackColor -eq $ButtonColor) {
        $TB10.BackColor = $TextColor
        $TB10.ForeColor = $BackGroundColor
    }else {
        $TB10.BackColor = $ButtonColor
        $TB10.ForeColor = $FormTextColor
    }
})

$TB11.Add_Click({
    if ($TB11.BackColor -eq $ButtonColor) {
        $TB11.BackColor = $TextColor
        $TB11.ForeColor = $BackGroundColor
    }else {
        $TB11.BackColor = $ButtonColor
        $TB11.ForeColor = $FormTextColor
    }
})

$MoreT.Add_Click({
    if ($MoreT.BackColor -eq $ButtonColor) {
    $MoreT.BackColor = $TextColor
    $MoreT.ForeColor = $BackGroundColor
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
})

$MTB1.Add_Click({
    if ($MTB1.BackColor -eq $ButtonColor) {
        $MTB1.BackColor = $TextColor
        $MTB1.ForeColor = $BackGroundColor
    }else {
        $MTB1.BackColor = $ButtonColor
        $MTB1.ForeColor = $FormTextColor
    }
})

$MTB2.Add_Click({
    if ($MTB2.BackColor -eq $ButtonColor) {
        $MTB2.BackColor = $TextColor
        $MTB2.ForeColor = $BackGroundColor
    }else {
        $MTB2.BackColor = $ButtonColor
        $MTB2.ForeColor = $FormTextColor
    }
})

$MTB3.Add_Click({
    if ($MTB3.BackColor -eq $ButtonColor) {
        $MTB3.BackColor = $TextColor
        $MTB3.ForeColor = $BackGroundColor
    }else {
        $MTB3.BackColor = $ButtonColor
        $MTB3.ForeColor = $FormTextColor
    }
})

$MTB4.Add_Click({
    if ($MTB4.BackColor -eq $ButtonColor) {
        $MTB4.BackColor = $TextColor
        $MTB4.ForeColor = $BackGroundColor
    }else {
        $MTB4.BackColor = $ButtonColor
        $MTB4.ForeColor = $FormTextColor
    }
})

$MTB5.Add_Click({
    if ($MTB5.BackColor -eq $ButtonColor) {
        $MTB5.BackColor = $TextColor
        $MTB5.ForeColor = $BackGroundColor
    }else {
        $MTB5.BackColor = $ButtonColor
        $MTB5.ForeColor = $FormTextColor
    }
})

$MTB6.Add_Click({
    if ($MTB6.BackColor -eq $ButtonColor) {
        $MTB6.BackColor = $TextColor
        $MTB6.ForeColor = $BackGroundColor
    }else {
        $MTB6.BackColor = $ButtonColor
        $MTB6.ForeColor = $FormTextColor
    }
})

$MTB7.Add_Click({
    if ($MTB7.BackColor -eq $ButtonColor) {
        $MTB7.BackColor = $TextColor
        $MTB7.ForeColor = $BackGroundColor
    }else {
        $MTB7.BackColor = $ButtonColor
        $MTB7.ForeColor = $FormTextColor
    }
})

$MTB8.Add_Click({
    if ($MTB8.BackColor -eq $ButtonColor) {
        $MTB8.BackColor = $TextColor
        $MTB8.ForeColor = $BackGroundColor
    }else {
        $MTB8.BackColor = $ButtonColor
        $MTB8.ForeColor = $FormTextColor
    }
})

$MTB9.Add_Click({
    if ($MTB9.BackColor -eq $ButtonColor) {
        $MTB9.BackColor = $TextColor
        $MTB9.ForeColor = $BackGroundColor
    }else {
        $MTB9.BackColor = $ButtonColor
        $MTB9.ForeColor = $FormTextColor
    }
})

$MTB10.Add_Click({
    if ($MTB10.BackColor -eq $ButtonColor) {
        $MTB10.BackColor = $TextColor
        $MTB10.ForeColor = $BackGroundColor
    }else {
        $MTB10.BackColor = $ButtonColor
        $MTB10.ForeColor = $FormTextColor
    }
})

$LogoBox.Add_Click({
    $Form.Controls.Add($HPanel)
    $SSPanel.Location                = New-Object System.Drawing.Point(($Location*0),(500+131))
    $StatusBox.Location              = New-Object System.Drawing.Point(($Location*0+11),(549+131))
    $PaddingPanel.Location           = New-Object System.Drawing.Point(($Location*0),(594+131))
})

$HB1.Add_Click({
    if ($HB1.BackColor -eq $ButtonColor) {
        $HB1.BackColor = $TextColor
        $HB1.ForeColor = $BackGroundColor
    }else {
        $HB1.BackColor = $ButtonColor
        $HB1.ForeColor = $FormTextColor
    }
})

$HB2.Add_Click({
    if ($HB2.BackColor -eq $ButtonColor) {
        $HB2.BackColor = $TextColor
        $HB2.ForeColor = $BackGroundColor
    }else {
        $HB2.BackColor = $ButtonColor
        $HB2.ForeColor = $FormTextColor
    }
})

$HB3.Add_Click({
    if ($HB3.BackColor -eq $ButtonColor) {
        $HB3.BackColor = $TextColor
        $HB3.ForeColor = $BackGroundColor
    }else {
        $HB3.BackColor = $ButtonColor
        $HB3.ForeColor = $FormTextColor
    }
})

$HB4.Add_Click({
    if ($HB4.BackColor -eq $ButtonColor) {
        $HB4.BackColor = $TextColor
        $HB4.ForeColor = $BackGroundColor
    }else {
        $HB4.BackColor = $ButtonColor
        $HB4.ForeColor = $FormTextColor
    }
})

$HB5.Add_Click({
    if ($HB5.BackColor -eq $ButtonColor) {
        $HB5.BackColor = $TextColor
        $HB5.ForeColor = $BackGroundColor
    }else {
        $HB5.BackColor = $ButtonColor
        $HB5.ForeColor = $FormTextColor
    }
})

$HB6.Add_Click({
    if ($HB6.BackColor -eq $ButtonColor) {
        $HB6.BackColor = $TextColor
        $HB6.ForeColor = $BackGroundColor
    }else {
        $HB6.BackColor = $ButtonColor
        $HB6.ForeColor = $FormTextColor
    }
})

$HB7.Add_Click({
    if ($HB7.BackColor -eq $ButtonColor) {
        $HB7.BackColor = $TextColor
        $HB7.ForeColor = $BackGroundColor
    }else {
        $HB7.BackColor = $ButtonColor
        $HB7.ForeColor = $FormTextColor
    }
})

$HB8.Add_Click({
    if ($HB8.BackColor -eq $ButtonColor) {
        $HB8.BackColor = $TextColor
        $HB8.ForeColor = $BackGroundColor
    }else {
        $HB8.BackColor = $ButtonColor
        $HB8.ForeColor = $FormTextColor
    }
})

$HB9.Add_Click({
    if ($HB9.BackColor -eq $ButtonColor) {
        $HB9.BackColor = $TextColor
        $HB9.ForeColor = $BackGroundColor
    }else {
        $HB9.BackColor = $ButtonColor
        $HB9.ForeColor = $FormTextColor
    }
})

$StartScript.Add_Click({
    $StatusBox.Text = "|Iniciando Script...`r`n" + $StatusBox.Text

    $StartScript.BackColor = $TextColor
    $StartScript.ForeColor = $BackGroundColor

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
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id LibreOffice.LibreOffice | Out-Null
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
        if ($MSB10.BackColor -eq $TextColor) { # Valorant
            $StatusBox.Text = "|Instalando Valorant...`r`n" + $StatusBox.Text
            $MSB10.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Scripts/Downloads/Valorant.ps1", $ToPath+"\Scripts\Downloads\Valorant.ps1")
            Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\Downloads\Valorant.ps1 ; exit" 
            $MSB10.BackColor = $TextColor
        }
        if ($MSB11.BackColor -eq $TextColor) { # League of Legends
            $StatusBox.Text = "|Instalando League of Legends...`r`n" + $StatusBox.Text
            $MSB11.BackColor = $ProcessingColor
            winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RiotGames.LeagueOfLegends.EUW | Out-Null
            $MSB11.BackColor = $TextColor
        }
        if ($MSB12.BackColor -eq $TextColor) { # Escape From Tarkov
            $StatusBox.Text = "|Instalando Escape From Tarkov Launcher...`r`n" + $StatusBox.Text
            $MSB12.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Scripts/Downloads/Tarkov.ps1", $ToPath+"\Scripts\Downloads\Tarkov.ps1")
            Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\Downloads\Tarkov.ps1 ; exit"
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
        Get-AppxPackage -All "Microsoft.3DBuilder" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.AppConnector" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.BingFinance" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.BingNews" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.BingSports" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.BingTranslator" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.BingWeather" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.CommsPhone" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.ConnectivityStore" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.GetHelp" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.Getstarted" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.Messaging" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.Microsoft3DViewer" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.MicrosoftPowerBIForWindows" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.MicrosoftStickyNotes" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.NetworkSpeedTest" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.Office.OneNote" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.Office.Sway" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.OneConnect" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.People" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.Print3D" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.Wallet" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.WindowsAlarms" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.WindowsCamera" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "microsoft.windowscommunicationsapps" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.WindowsFeedbackHub" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.WindowsMaps" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.WindowsPhone" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.WindowsSoundRecorder" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "Microsoft.YourPhone" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "MicrosoftWindows.Client.WebExperience" | Remove-AppxPackage -AllUsers
        Get-AppxPackage -All "MicrosoftTeams" | Remove-AppxPackage -AllUsers
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
    
        # Hide TaskBar View Button
        $StatusBox.Text = "|Ocultando Boton Vista De Tareas...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
    
        # Hide Cortana Button
        $StatusBox.Text = "|Ocultando Boton De Cortana...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
    
        # Hide Search Button
        $StatusBox.Text = "|Ocultando Boton De Busqueda...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
    
        # Hide Chat Button
        $StatusBox.Text = "|Ocultando Boton De Chats...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0
    
        # Set Dark Theme
        $StatusBox.Text = "|Estableciendo Modo Oscuro...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0
    
        # Hide Recent Files And Folders In Explorer
        $StatusBox.Text = "|Ocultando Archivos Y Carpetas Recientes De  Acceso Rapido...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0
    
        # Disable Transparency Effects
        $StatusBox.Text = "|Desactivando Efectos De Transparencia...`r`n" + $StatusBox.Text
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 0
    
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
    
        # Sounds Communications Do Nothing
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -Type DWord -Value 3
    
        # Hide Buttons From Power Button
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowSleepOption" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowLockOption" -Type DWord -Value 0
    
        # Alt Tab Open Windows Only
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Type DWord -Value 3
    
        # Uninstall Windows Optional Features
        $Download.DownloadFile($FromPath+"/Apps/RemoveOptionalFeatures.ps1", $ToPath+"\Apps\RemoveOptionalFeatures.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\RemoveOptionalFeatures.ps1 ; exit"
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
        $StatusBox.Text = "|Ocultando Flechas De Acceso Rapido...`r`n" + $StatusBox.Text
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
        Get-AppxPackage "Microsoft.XboxGamingOverlay" | Remove-AppxPackage -AllUsers
        Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage -AllUsers
        Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage -AllUsers
        Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage -AllUsers
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
            $StatusBox.text = "|Ajustando Animaciones De Windows...`r`n" + $StatusBox.text
            $MTB10.BackColor = $ProcessingColor
            $Download.DownloadFile($FromPath+"/Configs/VisualFX.png", $ToPath+"\Configs\VisualFX.png")
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 2
            Start-Process $env:windir\system32\systempropertiesperformance.exe
            Start-Process ($ToPath+"\Configs\VisualFX.png")
            $MTB10.BackColor = $TextColor
        }   
    }
    if ($HB1.BackColor -eq $TextColor) { # Rufus
        $StatusBox.text = "|Iniciando Rufus...`r`n" + $StatusBox.text
        $HB1.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/Rufus.exe", $ToPath+"\Apps\Rufus.exe")
        Start-Process ($ToPath+"\Apps\Rufus.exe")
        $HB1.BackColor = $TextColor
    } 
    if ($HB2.BackColor -eq $TextColor) { # MSI Afterburner Config
        $StatusBox.text = "|Configurando MSI Afterburner...`r`n" + $StatusBox.text
        $HB2.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Configs/Profiles.zip", $ToPath+"\Configs\Profiles.zip")
        Expand-Archive -Path ($ToPath+"\Configs\Profiles.zip") -DestinationPath 'C:\Program Files (x86)\MSI Afterburner\Profiles' -Force
        $HB2.BackColor = $TextColor
    }   
    if ($HB3.BackColor -eq $TextColor) { # Discord Second Screen
        $StatusBox.text = "|Configurando Discord En El Monitor Derecho...`r`n" + $StatusBox.text
        $HB3.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Configs/settings.json", $ToPath+"\Configs\settings.json")
        Copy-Item -Path ($ToPath+"\Configs\settings.json") -DestinationPath "$env:userprofile\AppData\Roaming\discord" -Force
        $HB3.BackColor = $TextColor
    }   
    if ($HB4.BackColor -eq $TextColor) { # Software RL
        $StatusBox.text = "|Instalando Software RL...`r`n" + $StatusBox.text
        $HB4.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Apps/RLSoftware.exe", $ToPath+"\Apps\RLSoftware.exe")
        Start-Process ($ToPath+"\Apps\RLSoftware.exe")
        $HB4.BackColor = $TextColor
    }   
    if ($HB5.BackColor -eq $TextColor) { # RGB Fusion
        $StatusBox.text = "|Instalando RGB Fusion...`r`n" + $StatusBox.text
        $HB5.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Scripts/Downloads/RGBFusion.ps1", $ToPath+"\Scripts\Downloads\RGBFusion.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\FORMATEO\Scripts\Downloads\RGBFusion.ps1 ; exit"
        $HB5.BackColor = $TextColor
    }   
    if ($HB6.BackColor -eq $TextColor) { # JDK 17
        $StatusBox.text = "|Instalando JDK 17...`r`n" + $StatusBox.text
        $HB6.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Scripts/Downloads/JDK17.ps1", $ToPath+"\Scripts\Downloads\JDK17.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\FORMATEO\Scripts\Downloads\JDK17.ps1 ; exit"
        $HB6.BackColor = $TextColor
    }   
    if ($HB7.BackColor -eq $TextColor) { # Eclipse IDE
        $StatusBox.text = "|Instalando Eclipse IDE...`r`n" + $StatusBox.text
        $HB7.BackColor = $ProcessingColor
        $Download.DownloadFile($FromPath+"/Scripts/Downloads/Eclipse.ps1", $ToPath+"\Scripts\Downloads\Eclipse.ps1")
        Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\FORMATEO\Scripts\Downloads\Eclipse.ps1 ; exit"
        $HB7.BackColor = $TextColor
    }   
    if ($HB8.BackColor -eq $TextColor) { # Visual Studio Code
        $StatusBox.text = "|Instalando Visual Studio Code...`r`n" + $StatusBox.text
        $HB8.BackColor = $ProcessingColor
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VisualStudioCode | Out-Null
        $HB8.BackColor = $TextColor
    }   
    if ($HB9.BackColor -eq $TextColor) { # Game Settings
        $StatusBox.text = "|Abriendo Game Settings Options...`r`n" + $StatusBox.text
        $HB9.BackColor = $ProcessingColor
        Iex (Iwr ($FromPath+"/Scripts/GameSettings.ps1"))
        $HB9.BackColor = $TextColor
    }   

    $StartScript.BackColor = $ButtonColor
    $StartScript.ForeColor = $TextColor

    $Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,
                $LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB1,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11,$MTB1,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,
                $MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9)
    
    foreach ($Button in $Buttons) {
        if ($Button.BackColor -eq $TextColor) {
                $Button.BackColor = $ButtonColor
                $Button.ForeColor = $ProcessingColor
        }
    }

    $StatusBox.Text = "|Ready`r`n|Script Finalizado`r`n" + $StatusBox.Text
})

$Form.Add_Closing({
    Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse
})

[void]$Form.ShowDialog()