Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

Remove-Item $env:userprofile\AppData\Local\Temp\1ZKTool.log | Out-Null
$LogPath  = "$env:userprofile\AppData\Local\Temp\1ZKTool.log"

New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Configs\ -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Apps\ -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
New-Item $env:userprofile\AppData\Local\Temp\ZKTool\Scripts\ -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
Invoke-WebRequest "https://github.com/Zarckash/ZKTool/raw/main/Configs/Images.zip" -OutFile "$env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images.zip" | Out-File $LogPath -Encoding UTF8 -Append
Expand-Archive -Path $env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images.zip -DestinationPath $env:userprofile\AppData\Local\Temp\ZKTool\Configs\Images\ -Force

$AppVersion = 2.5

# Update To Last Version
try {
    Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" | Out-Null        #
}                                                                                                                                           # Crea DisplayVersion
catch {                                                                                                                                     # en caso de que no exista
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" -Value $AppVersion     #
}

if (!((Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion") -eq $AppVersion)) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" -Value $AppVersion
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'ZKTool Updater'
        Write-Host "Actualizando ZKTool App..."
        Start-Sleep 2
        Start-Process Powershell -WindowStyle Hidden {Invoke-Expression (Invoke-WebRequest -useb "https://rb.gy/8shezm")}
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
$Form.AutoSize                   = $True
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

$Buttons = @('SB1','SB2','SB3','SB4','SB5','SB6','SB7','SB8','SB9','SB10','SB11','SB12','MSB1','MSB2','MSB3','MSB4','MSB5','MSB6','MSB7','MSB8','MSB9','MSB10','MSB11','MSB12','MSB13','MSB14','MSB15','MSB16',
'MSB17','LB1','LB2','LB3','LB4','LB5','LB6','LB7','LB8','TB1','TB2','TB3','TB4','TB5','TB6','TB7','TB8','TB9','TB10','TB11','MTB1','MTB2','MTB3','MTB4','MTB5','MTB6','MTB7','MTB8','MTB9','MTB10','MTB11','MTB12',
'MTB13','MTB14','MTB15','MTB16','HB1','HB2','HB3','HB4','HB5','HB6')

foreach ($Button in $Buttons) {
    Get-Variable -Name $Button | Remove-Variable
}

$Buttons | ForEach-Object {
    $NewButton          = New-Object System.Windows.Forms.Button
    New-Variable "$_" $NewButton
}

$SB1.Text                        = "Google Chrome"
$SB2.Text                        = "GeForce Experience"
$SB3.Text                        = "Discord"
$SB4.Text                        = "Spotify"
$SB5.Text                        = "HWMonitor"
$SB6.Text                        = "MSI Afterburner"
$SB7.Text                        = "Corsair iCue"
$SB8.Text                        = "Logitech OMM"
$SB9.Text                        = "Razer Synapse"
$SB10.Text                       = "uTorrent Web"
$SB11.Text                       = "NanaZip"
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

$MSB1.Text                       = "OBS Studio"
$MSB2.Text                       = "Adobe Photoshop"
$MSB3.Text                       = "Adobe Premiere"
$MSB4.Text                       = "Adobe After Effects"
$MSB5.Text                       = "Netflix"
$MSB6.Text                       = "Prime Video"
$MSB7.Text                       = "VLC Media Player"
$MSB8.Text                       = "Rufus"
$MSB9.Text                       = "WinRAR"
$MSB10.Text                      = "MegaSync"
$MSB11.Text                      = "LibreOffice"
$MSB12.Text                      = "GitHub Desktop"
$MSB13.Text                      = "AMD Adrenalin"
$MSB14.Text                      = "Void"
$MSB15.Text                      = "Tarkov Launcher"
$MSB16.Text                      = "League of Legends"
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

$LB1.Text                        = "Steam"
$LB2.Text                        = "EA App"
$LB3.Text                        = "Ubisoft Connect"
$LB4.Text                        = "Battle.Net"
$LB5.Text                        = "GOG Galaxy"
$LB6.Text                        = "Rockstar Games"
$LB7.Text                        = "Epic Games Launcher"
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

$TB1.Text                        = "Optimization Tweaks"
$TB2.Text                        = "Cleaning Tweaks"
$TB3.Text                        = "Nvidia Settings"
$TB4.Text                        = "Reduce Icons Spacing"
$TB5.Text                        = "Hide Shortcut Arrows"
$TB6.Text                        = "Set Fluent Cursor"
$TB7.Text                        = "Disable Cortana"
$TB8.Text                        = "Remove OneDrive"
$TB9.Text                        = "Remove Xbox Game Bar"
$TB10.Text                       = "Tweaks In Context Menu"
$TB11.Text                       = "VisualFX Fix"

$Position = 40*2+10
$Buttons = @($TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11)
foreach ($Button in $Buttons) {    
    $TPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=40
}
$TB1.Location                    = New-Object System.Drawing.Point(10,10)
$TPanel.Controls.Add($TB1)


            ##################################
            ########## MORE  TWEAKS ##########
            ##################################


# More Tweaks Panel
$MTPanel                         = New-Object System.Windows.Forms.Panel
$MTPanel.Height                  = 491 + 195 + 9
$MTPanel.Width                   = $PanelSize - 3
$MTPanel.BackgroundImage         = [System.Drawing.Image]::FromFile(($ImageFolder + "MSMTPanelBg.png"))
$MTPanel.Location                = New-Object System.Drawing.Point(($PanelSize*3),49)

$MTB1.Text                       = "Activate Windows Pro"
$MTB2.Text                       = "Visual C Runtimes"
$MTB3.Text                       = "Enable MSI Mode"
$MTB4.Text                       = "FFMPEG"
$MTB5.Text                       = "Windows Terminal Fix"
$MTB6.Text                       = "Void"
$MTB7.Text                       = "Void"
$MTB8.Text                       = "Network Config"
$MTB9.Text                       = "Autoruns"
$MTB10.Text                      = "Void"
$MTB11.Text                      = "Void"
$MTB12.Text                      = "Void"
$MTB13.Text                      = "Void"
$MTB14.Text                      = "Void"
$MTB15.Text                      = "Adobe Cleaner"
$MTB16.Text                      = "AMD Undervolt Pack"

$Position = 40*2+10
$Buttons = @($MTB2,$MTB3,$MTB4,$MTB5,$MTB8,$MTB9,$MTB15,$MTB16)
foreach ($Button in $Buttons) {
    $MTPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(10,$Position)
    $Position+=40
}
$MTB1.Location                   = New-Object System.Drawing.Point(10,10)
$MTPanel.Controls.Add($MTB1)


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

$HB1.Text                        = "Game Settings"
$HB1.Location                    = New-Object System.Drawing.Point(10,$Position)

$HB2.Text                        = "Dark Theme"
$HB2.Location                    = New-Object System.Drawing.Point(240,$Position)

$HB3.Text                        = "Context Menu Handler"
$HB3.Location                    = New-Object System.Drawing.Point(470,$Position)

$Position += 49

$HB4.Text                        = "MSI Afterburner Settings"
$HB4.Location                    = New-Object System.Drawing.Point(10,$Position)

$HB5.Text                        = "Remove Realtek"
$HB5.Location                    = New-Object System.Drawing.Point(240,$Position)

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

$FromPath = "https://github.com/Zarckash/ZKTool/raw/main"     # GitHub Downloads URL
$ToPath   = "$env:userprofile\AppData\Local\Temp\ZKTool"      # Folder Structure Path
$LogPath  = "$env:userprofile\AppData\Local\Temp\1ZKTool.log" # Script Log Path
$AppPath  = "$env:ProgramFiles\ZKTool"                        # App Path
$Download = New-Object net.webclient

function GoogleChrome {
    $StatusBox.Text = "| Instalando Google Chrome..."
    $SB1.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Google.Chrome | Out-File $LogPath -Encoding UTF8 -Append
    $SB1.ForeColor = $DefaultForeColor
}

function GeForceExperience {
    $StatusBox.Text = "| Instalando GeForce Experience..."
    $SB1.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Nvidia.GeForceExperience | Out-File $LogPath -Encoding UTF8 -Append
    $SB1.ForeColor = $DefaultForeColor
}

function Discord {
    $StatusBox.Text = "| Instalando Discord..."
    $SB3.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Discord.Discord | Out-File $LogPath -Encoding UTF8 -Append
    $SB3.ForeColor = $DefaultForeColor
}

function Spotify {
    $StatusBox.Text = "| Instalando Spotify..."
    $SB4.ForeColor = LabelColor
    $Download.DownloadFile($FromPath+"/Apps/Spotify.ps1", $ToPath+"\Apps\Spotify.ps1")
    Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\Spotify.ps1 ; exit"
    $SB4.ForeColor = $DefaultForeColor
}

function HWMonitor {
    $StatusBox.Text = "| Instalando HWMonitor..."
    $SB5.ForeColor = LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id CPUID.HWMonitor | Out-File $LogPath -Encoding UTF8 -Append
    $SB5.ForeColor = $DefaultForeColor
}

function MSIAfterburner {
    $StatusBox.Text = "| Instalando MSI Afterburner..."
    $SB6.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/MSIAfterburner.zip", $ToPath+"\Apps\MSIAfterburner.zip")
    Expand-Archive -Path ($ToPath+"\Apps\MSIAfterburner.zip") -DestinationPath ($ToPath+"\Apps\MSIAfterburner") -Force
    Copy-Item -Path ($ToPath+"\Apps\MSIAfterburner\MSIAfterburner.lnk") -Destination "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" -Force
    Start-Process ($ToPath+"\Apps\MSIAfterburner\MSIAfterburner.exe")
    $SB6.ForeColor = $DefaultForeColor
}

function CorsairiCue {
    $StatusBox.Text = "| Instalando Corsair iCue..."
    $SB7.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Corsair.iCUE.4 | Out-File $LogPath -Encoding UTF8 -Append
    $SB7.ForeColor = $DefaultForeColor
}

function LogitechOMM {
    $StatusBox.Text = "| Iniciando Logitech Onboard Memory Manager..."
    $SB8.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/LogitechOMM.exe", $ToPath+"\Apps\LogitechOMM.exe")
    Start-Process ($ToPath+"\Apps\LogitechOMM.exe")
    $SB8.ForeColor = $DefaultForeColor
}

function RazerSynapse {
    $StatusBox.Text = "| Instalando Razer Synapse..."
    $SB9.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/RazerSynapse.exe", $ToPath+"\Apps\RazerSynapse.exe")
    Start-Process ($ToPath+"\Apps\RazerSynapse.exe")
    $SB9.ForeColor = $DefaultForeColor
}

function uTorrentWeb {
    $StatusBox.Text = "| Instalando uTorrent Web..."
    $SB10.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/uTorrentWeb.exe", $ToPath+"\Apps\uTorrentWeb.exe")
    Start-Process ($ToPath+"\Apps\uTorrentWeb.exe")
    $SB10.ForeColor = $DefaultForeColor
}

function NanaZip {
    $StatusBox.Text = "| Instalando NanaZip..."
    $SB11.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id M2Team.NanaZip | Out-File $LogPath -Encoding UTF8 -Append
    $SB11.ForeColor = $DefaultForeColor
}

function VisualStudioCode {
    $StatusBox.Text = "| Instalando Visual Studio Code..."
    $SB11.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VisualStudioCode | Out-File $LogPath -Encoding UTF8 -Append
    $SB12.ForeColor = $DefaultForeColor
}

function OBSStudio {
    $StatusBox.Text = "| Instalando OBS Studio..."
    $MSB1.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id OBSProject.OBSStudio | Out-File $LogPath -Encoding UTF8 -Append
    $MSB1.ForeColor = $DefaultForeColor
}

function AdobePhotoshop {
    $StatusBox.Text = "| Instalando Adobe Photoshop..."
    $MSB2.ForeColor = $LabelColor
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'Adobe Photoshop'
        $File = 'http://zktoolip.ddns.net/files/AdobePhotoshop.iso'
        $FilePath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\AdobePhotoshop.iso'
        Write-Host 'Descargando Adobe Photoshop...'
        if (Test-Path -Path 'H:\Apache24\htdocs\files\AdobePhotoshop.iso') {
            Write-Host 'Copiando Archivos...'
            $Destination = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\'
            Copy-Item -Path 'H:\Apache24\htdocs\files\AdobePhotoshop.iso' -Destination $Destination
        } else {
            (New-Object Net.WebClient).DownloadFile($File, $FilePath)
        }
        $AdobePath = Mount-DiskImage $Filepath | Get-DiskImage | Get-Volume
        $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
        Start-Process $AdobeInstall
    }
    $MSB2.ForeColor = $DefaultForeColor
}

function AdobePremiere {
    $StatusBox.Text = "| Instalando Adobe Premiere..."
    $MSB3.ForeColor = $LabelColor
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'Adobe Premiere'
        $File = 'http://zktoolip.ddns.net/files/AdobePremiere.iso'
        $FilePath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\AdobePremiere.iso'
        Write-Host 'Descargando Adobe Premiere...'
        if (Test-Path -Path 'H:\Apache24\htdocs\files\AdobePremiere.iso') {
            Write-Host 'Copiando Archivos...'
            $Destination = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\'
            Copy-Item -Path 'H:\Apache24\htdocs\files\AdobePremiere.iso' -Destination $Destination
        } else {
            (New-Object Net.WebClient).DownloadFile($File, $FilePath)
        }
        $AdobePath = Mount-DiskImage $filepath | Get-DiskImage | Get-Volume
        $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
        Start-Process $AdobeInstall
    }
    $MSB3.ForeColor = $DefaultForeColor
}

function AdobeAfterEffects {
    $StatusBox.Text = "| Instalando Adobe After Effects..."
    $MSB4.ForeColor = $LabelColor
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'Adobe After Effects'
        $File = 'http://zktoolip.ddns.net/files/AdobeAfterEffects.iso'
        $FilePath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\AdobeAfterEffects.iso'
        Write-Host 'Descargando Adobe After Effects...'
        if (Test-Path -Path "H:\Apache24\htdocs\files\AdobeAfterEffects.iso") {
            Write-Host 'Copiando Archivos...'
            $Destination = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\'
            Copy-Item -Path 'H:\Apache24\htdocs\files\AdobeAfterEffects.iso' -Destination $Destination
        } else {
            (New-Object Net.WebClient).DownloadFile($File, $FilePath)
        }
        $AdobePath = Mount-DiskImage $filepath | Get-DiskImage | Get-Volume
        $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
        Start-Process $AdobeInstall
    }
    $MSB4.ForeColor = $DefaultForeColor
}

function Netflix {
    $StatusBox.Text = "| Instalando Netflix..."
    $MSB5.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/Netflix.appx", $ToPath+"\Apps\Netflix.appx")
    &{ $ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\Netflix.appx") }
    $MSB5.ForeColor = $DefaultForeColor
}

function PrimeVideo {
    $StatusBox.Text = "| Instalando Prime Video..."
    $MSB6.ForeColor = $LabelColor
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'Amazon Prime Video'
        $file = 'https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/PrimeVideo.appx'
        $filepath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\PrimeVideo.appx'
        Write-Host 'Descargando Amazon Prime Video...'
        (New-Object Net.WebClient).DownloadFile($file, $filepath)
        Add-AppxPackage $filepath
    }
    $MSB6.ForeColor = $DefaultForeColor
}

function VLCMediaPlayer {
    $StatusBox.Text = "| Instalando VLC Media Player..."
    $MSB7.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/VLCMediaPlayer.exe", $ToPath+"\Apps\VLCMediaPlayer.exe")
    Start-Process ($ToPath+"\Apps\VLCMediaPlayer.exe")
    $MSB7.ForeColor = $DefaultForeColor
}

function Rufus {
    $StatusBox.Text = "| Iniciando Rufus..."
    $MSB8.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/Rufus.exe", $ToPath+"\Apps\Rufus.exe")
    Start-Process ($ToPath+"\Apps\Rufus.exe")
    Start-Sleep 2
    Remove-Item -Path .\rufus.com
    $MSB8.ForeColor = $DefaultForeColor
}

function WinRAR {
    $StatusBox.Text = "| Instalando WinRAR..."
    $MSB9.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RARLab.WinRAR | Out-File $LogPath -Encoding UTF8 -Append
    $MSB9.ForeColor = $DefaultForeColor
}

function MegaSync {
    $StatusBox.Text = "| Instalando MegaSync..."
    $MSB10.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Mega.MEGASync | Out-File $LogPath -Encoding UTF8 -Append
    $MSB10.ForeColor = $DefaultForeColor
}

function LibreOffice {
    $StatusBox.Text = "| Instalando LibreOffice..."
    $MSB11.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id TheDocumentFoundation.LibreOffice | Out-File $LogPath -Encoding UTF8 -Append
    $MSB11.ForeColor = $DefaultForeColor
}

function GitHubDesktop {
    $StatusBox.Text = "| Instalando GitHub Desktop..."
    $MSB12.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id GitHub.GitHubDesktop | Out-File $LogPath -Encoding UTF8 -Append
    $MSB12.ForeColor = $DefaultForeColor
}

function AMDAdrenalin {
    $StatusBox.Text = "| Instalando AMD Adrenalin..."
    $MSB13.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/AMDAdrenalin.exe", $ToPath+"\Apps\AMDAdrenalin.exe")
    Start-Process ($ToPath+"\Apps\AMDAdrenalin.exe")
    $MSB13.ForeColor = $DefaultForeColor
}

function TarkovLauncher {
    $StatusBox.Text = "| Instalando Tarkov Launcher..."
    $MSB15.ForeColor = $LabelColor
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'Tarkov Launcher'
        $file = 'https://github.com/Zarckash/ZKTool/releases/download/BIGFILES/TarkovLauncher.exe'
        $filepath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Apps\TarkovLauncher.exe'
        Write-Host 'Descargando Tarkov Launcher...'
        (New-Object Net.WebClient).DownloadFile($file, $filepath)
        Start-Process $filepath
    }
    $MSB15.ForeColor = $DefaultForeColor
}

function LeagueofLegends {
    $StatusBox.Text = "| Instalando League of Legends..."
    $MSB16.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RiotGames.LeagueOfLegends.EUW | Out-File $LogPath -Encoding UTF8 -Append
    $MSB16.ForeColor = $DefaultForeColor
}

function Valorant {
    $StatusBox.Text = "| Instalando Valorant..."
    $MSB17.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id RiotGames.Valorant.EU | Out-File $LogPath -Encoding UTF8 -Append
    $MSB17.ForeColor = $DefaultForeColor
}

function Steam {
    $StatusBox.Text = "| Instalando Steam..."
    $LB1.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Valve.Steam | Out-File $LogPath -Encoding UTF8 -Append
    $LB1.ForeColor = $DefaultForeColor
}

function EAApp {
    $StatusBox.Text = "| Instalando EA Desktop..."
    $LB2.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id ElectronicArts.EADesktop | Out-File $LogPath -Encoding UTF8 -Append
    $LB2.ForeColor = $DefaultForeColor
}

function UbisoftConnect {
    $StatusBox.Text = "| Instalando Ubisoft Connect..."
    $LB3.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Ubisoft.Connect | Out-File $LogPath -Encoding UTF8 -Append
    $LB3.ForeColor = $DefaultForeColor
}

function Battle.Net {
    $StatusBox.Text = "| Instalando Battle.Net..."
    $LB4.ForeColor = $LabelColor
    $TempFile = "https://www.battle.net/download/getInstallerForGame?os=win&gameProgram=BATTLENET_APP&version=Live&id=undefined"
    $Download.DownloadFile($TempFile, $ToPath+"\Apps\BattleNet.exe")
    Start-Process ($ToPath+"\Apps\BattleNet.exe")
    $LB4.ForeColor = $DefaultForeColor
}

function GOGGalaxy {
    $StatusBox.Text = "| Instalando GOG Galaxy..."
    $LB5.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id GOG.Galaxy | Out-File $LogPath -Encoding UTF8 -Append
    $LB5.ForeColor = $DefaultForeColor
}

function RockstarGames {
    $StatusBox.Text = "| Instalando Rockstar Games Launcher..."
    $LB6.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/RockstarGamesLauncher.exe", $ToPath+"\Apps\RockstarGamesLauncher.exe")
    Start-Process ($ToPath+"\Apps\RockstarGamesLauncher.exe")
    $LB6.ForeColor = $DefaultForeColor
}

function EpicGamesLauncher {
    $StatusBox.Text = "| Instalando Epic Games Launcher..."
    $LB7.ForeColor = $LabelColor
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id EpicGames.EpicGamesLauncher | Out-File $LogPath -Encoding UTF8 -Append
    $LB7.ForeColor = $DefaultForeColor
}

function Xbox {
    $StatusBox.Text = "| Instalando Xbox App..."
    $LB8.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/XboxApp.appx", $ToPath+"\Apps\XboxApp.appx")
    &{$ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\XboxApp.appx")} 
    $LB8.ForeColor = $DefaultForeColor
}

function OptimizationTweaks {
    $StatusBox.Text = "| AJUSTES DE OPTIMIZACION`r`n"
    $TB1.ForeColor = $LabelColorBig

    # Create Restore Point
    $StatusBox.Text = "| Creando Punto De Restauracion..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -Type DWord -Value 0
    Enable-ComputerRestore -Drive "C:\"
    &{$ProgressPreference = 'SilentlyContinue'; Checkpoint-Computer -Description "Pre Optimizacion ZKTool" -RestorePointType "MODIFY_SETTINGS"} 
    
    # Disable UAC
    $StatusBox.Text = "| Desactivando UAC Para Administradores..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

    # Disable Device Set Up Suggestions
    $StatusBox.Text = "| Desactivando Sugerencias De Configuracion De Dispositivo..."
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\" -Name "UserProfileEngagement"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0
    
    # Disable Fast Boot
    $StatusBox.Text = "| Desactivando Fast Boot..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0

    # Enable Hardware Acceleration
    $StatusBox.Text = "| Activando Aceleracion De Hardware..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Type Dword -Value 2

    # Enable Borderless Optimizations
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\DirectX")) {
        New-Item -Path "HKCU:\Software\Microsoft" -Name "DirectX" | Out-File $LogPath -Encoding UTF8 -Append 
        New-Item -Path "HKCU:\Software\Microsoft\DirectX" -Name "GraphicsSettings" | Out-File $LogPath -Encoding UTF8 -Append
        New-Item -Path "HKCU:\Software\Microsoft\DirectX" -Name "UserGpuPreferences" | Out-File $LogPath -Encoding UTF8 -Append
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\GraphicsSettings" -Name "SwapEffectUpgradeCache" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences" -Name "DirectXUserGlobalSettings" -Value "SwapEffectUpgradeEnable=1;"

    # Set-PageFile Size
    $RamCapacity = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1mb
    if ($RamCapacity -le 17000) {
        $StatusBox.Text = "| Estableciendo El Tamaño Del Archivo De Paginacion En $RamCapacity MB..."
        $MTB13.ForeColor = $LabelColor
        $PageFile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
        $PageFile.AutomaticManagedPagefile = $false
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "c:\pagefile.sys $RamCapacity $RamCapacity"
        $MTB13.ForeColor = $DefaultForeColor
    }else {
        $StatusBox.Text = "| La Cantidad De Memoria RAM Es Superior A Los 16GB, No Se Realizara Ningun Cambio..."
    }

    # Energy Profile Settings
    $StatusBox.Text = "| Estableciendo Perfil De Alto Rendimiento..."
    powercfg.exe -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg /Change monitor-timeout-ac 15
    powercfg /Change standby-timeout-ac 0

    # Rebuild Performance Counters
    $StatusBox.Text = "| Reconstruyendo Contadores De Rendimiento..."
    lodctr /r

    # Install Timer Resolution Service
    $StatusBox.Text = "| Instalando Set Timer Resolution Service..."
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2013.x64 | Out-File $LogPath -Encoding UTF8 -Append
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2013.x86 | Out-File $LogPath -Encoding UTF8 -Append
    $Download.DownloadFile($FromPath+"/Apps/SetTimerResolutionService.exe", $ToPath+"\Apps\SetTimerResolutionService.exe")
    New-Item 'C:\Program Files\Set Timer Resolution Service\' -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
    Move-Item -Path ($ToPath+"\Apps\SetTimerResolutionService.exe") -Destination 'C:\Program Files\Set Timer Resolution Service\'
    Push-Location
    Set-Location -Path "C:\Program Files\Set Timer Resolution Service"
    .\SetTimerResolutionService.exe -install | Out-File $LogPath -Encoding UTF8 -Append
    Pop-Location

    # Windows Defender
    $StatusBox.Text = "| Aplicando Exclusiones A Windows Defender..."
    $ActiveDrives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty "Root" | Where-Object {$_.Length -eq 3}
    foreach ($Drive in $ActiveDrives) {
        if (Test-Path ($Drive + "Games")) {
            Add-MpPreference -ExclusionPath ($Drive + "Games")
        }
    }
    Add-MpPreference -ExclusionPath "C:\Program Files\Windows Defender"

    # Show File Extensions
    $StatusBox.Text = "| Activando Extensiones De Archivos..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0
    
    # Open File Explorer In This PC Page
    $StatusBox.Text = "| Estableciendo Abrir El Explorador De Archivos En La Pagina Este Equipo..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    # Reduce svchost Process Amount
    $StatusBox.Text = "| Reduciendo Los Procesos De Windows A La Mitad..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4294967295

    # Disable Mouse Acceleration
    $StatusBox.Text = "| Desactivando Aceleracion Del Raton..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0

    # Disable Keyboard Layout Shortcut
    $StatusBox.Text = "| Desactivando Cambio De Idioma Del Teclado..."
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Hotkey" -Value 3
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Language Hotkey" -Value 3
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Layout Hotkey" -Value 3
    
    # Disable Error Reporting
    $StatusBox.Text = "| Desactivando Informar De Errores"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null

    # 100% Wallpaper Quality
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Type DWord -Value 100
    
    # Network Optimizations
    $StatusBox.Text = "| Optimizando Registros De Red..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Type DWord -Value 4294967295

    # Performance Optimizations
    $StatusBox.Text = "| Optimizando Registros De Rendimiento..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -Value 2000
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 100
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -Value 5000
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoEndTasks" -Value 1
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LowLevelHooksTimeout" -Value 1000
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WaitToKillServiceTimeout" -Value 2000
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "UseNexusForGameBarEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseHoverTime" -Value 200
    Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "HungAppTimeout" -ErrorAction SilentlyContinue

    # Games Performance Optimizations
    $StatusBox.Text = "| Optimizando Registros De Juegos..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Affinity" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Background Only" -Type String -Value "False"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Clock Rate" -Type DWord -Value 10000
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Type DWord -Value 8
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Type DWord -Value 6
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Type String -Value "High"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "SFIO Priority" -Type String -Value "High"

    # Disable Full Screen Optimization For All Games
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Type DWord -Value 2
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_HonorUserFSEBehaviorMode" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Type DWord -Value 2
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_EFSEFeatureFlags" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DSEBehavior" -Type DWord -Value 2
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Type DWord -Value 0

    # Edge Settings
    $StatusBox.Text = "| Optimizando Edge..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "Edge" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "BackgroundModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "ShowDownloadsToolbarButton" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "SleepingTabsEnabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "StartupBoostEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "EfficiencyModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HubsSidebarEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "HideFirstRunExperience" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "PerformanceDetectorEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "QuickSearchShowMiniMenu" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "EdgeFollowEnabled" -Type DWord -Value 0
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "EdgeUpdate" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\EdgeUpdate" -Name "UpdateDefault" -Type DWord -Value 2
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\edgeupdate" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\edgeupdatem" -Name "Start" -Type DWord -Value 4

    # Chrome Settings
    $StatusBox.Text = "| Optimizando Chrome..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Google" -Name "Chrome" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BackgroundModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "HardwareAccelerationModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "StartupBoostEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\gupdate" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\gupdatem" -Name "Start" -Type DWord -Value 4

    # Force 100% Monitor Scaling
    $StatusBox.Text = "| Forzando 100% De Escala En Todos Los Monitores..."
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LogPixels" -Type DWord -Value 96
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Win8DpiScaling" -Type DWord -Value 96
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "AppliedDPI" -Type DWord -Value 96
    if (Test-Path "HKCU:\Control Panel\Desktop\PerMonitorSettings") {
        Remove-Item "HKCU:\Control Panel\Desktop\PerMonitorSettings" -Recurse -Force
    }

    # Disable VBS
    $StatusBox.Text = "| Desactivando Aislamiento Del Nucleo..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -Type DWord -Value 0

    # Disable Background Apps
    $StatusBox.Text = "| Desactivando Aplicaciones En Segundo Plano..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

    # Disable Power Throttling
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "PowerThrottling" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Type DWord -Value 1

    # Hide Keyboard Layout Icon
    $StatusBox.Text = "| Ocultando El Boton De Idioma Del Teclado..."
    Set-WinLanguageBarOption -UseLegacyLanguageBar
    New-Item -Path "HKCU:\Software\Microsoft\CTF\" -Name "LangBar" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ExtraIconsOnMinimized" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Label" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ShowStatus" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Transparency" -Type DWord -Value 255

    # Disable Telemetry
    $StatusBox.Text = "| Deshabilitando Telemetria..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-File $LogPath -Encoding UTF8 -Append

    # Disable Aplication Sugestions
    $StatusBox.Text = "| Deshabilitando Sugerencias De Aplicaciones..."
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
    $StatusBox.Text = "| Deshabilitando Historial De Actividad..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0

    # Disable Nearby Sharing
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "CdpSessionUserAuthzPolicy" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "RomeSdkChannelUserAuthzPolicy" -Type DWord -Value 0

    # Show TaskBar Only In Main Screen
    $StatusBox.Text = "| Desactivando Mostrar Barra De Tareas En Todos Los Monitores..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MMTaskbarEnabled" -Type DWord -Value 0

    # Show More Pinned Items In Start Menu
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -Type DWord -Value 1

    # Hide Recent Files In Start Menu
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocks" -Type DWord -Value 0

    # Hide Windows Files
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "EnableLogFile" -Type DWord -Value 0
    if (!(Test-Path -Path "C:\PerfLogs")) {
        New-Item "C:\PerfLogs" -ItemType Directory
    }
    (Get-Item "C:\PerfLogs").Attributes = 'Hidden'

    # Stop Microsoft Store From Updating Apps Automatically
    $StatusBox.Text = "| Desactivando Actualizaciones Automaticas De Microsoft Store..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "WindowsStore"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "AutoDownload" -Type DWord -Value 2

    # Hide TaskBar View Button
    $StatusBox.Text = "| Ocultando Boton Vista De Tareas..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

    # Hide Cortana Button
    $StatusBox.Text = "| Ocultando Boton De Cortana..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0

    # Hide Meet Now Button
    $StatusBox.Text = "| Ocultando Boton De Reunirse Ahora..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1

    # Hide Search Button
    $StatusBox.Text = "| Ocultando Boton De Busqueda..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

    # Disable Widgets
    $StatusBox.Text = "| Desactivando Widgets..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 0
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "Dsh"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Type DWord -Value 0

    # Disable Web Search
    $StatusBox.Text = "| Desactivando Busqueda En La Web Con Bing..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0

    # Hide Search Recomendations
    $StatusBox.Text = "| Desactivando Recomendaciones De Busqueda..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Type DWord -Value 0

    # Disable Microsoft Account In Windows Search
    $StatusBox.Text = "| Desactivando Cuenta De Microsoft En Windows Search..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Type DWord -Value 0
    
    # Hide Chat Button
    $StatusBox.Text = "| Ocultando Boton De Chats..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0

    # Set Dark Theme
    $StatusBox.Text = "| Estableciendo Modo Oscuro..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0

    # Hide Recent Files And Folders In Explorer
    $StatusBox.Text = "| Ocultando Archivos Y Carpetas Recientes De Acceso Rapido..."
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0

    # Clipboard History
    $StatusBox.Text = "| Activando El Historial Del Portapapeles..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Type DWord -Value 1

    # Change Computer Name
    $pcname = $env:username.ToUpper() + "-PC"
    $StatusBox.Text = "| Cambiando Nombre Del Equipo A " + $pcname + "..."
    Rename-Computer -NewName $pcname

    # Set Private Network
    $StatusBox.Text = "| Estableciendo Red Privada..."
    Set-NetConnectionProfile -NetworkCategory Private

    # Show File Operations Details
    $StatusBox.Text = "| Mostrando Detalles De Transferencias De Archivos..."
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
    $StatusBox.Text = "| Reduciendo El Tamaño De Los Iconos Del Escritorio..."
    taskkill /f /im explorer.exe
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop" -Name "IconSize" -Type DWord -Value 32
    explorer.exe

    # Disable Feedback
    $StatusBox.Text = "| Deshabilitando Feedback..."
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-File $LogPath -Encoding UTF8 -Append
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-File $LogPath -Encoding UTF8 -Append

    # Service Tweaks To Manual 
    $StatusBox.Text = "| Deshabilitando Servicios..."
    $Services = @(
        "ALG"                                          # Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
        "AJRouter"                                     # Needed for AllJoyn Router Service
        "BcastDVRUserService_48486de"                  # GameDVR and Broadcast is used for Game Recordings and Live Broadcasts
        "Browser"                                      # Let users browse and locate shared resources in neighboring computers
        "diagnosticshub.standardcollector.service"     # Microsoft (R) Diagnostics Hub Standard Collector Service
        "DiagTrack"                                    # Diagnostics Tracking Service
        "dmwappushservice"                             # WAP Push Message Routing Service
        "DPS"                                          # Diagnostic Policy Service (Detects and Troubleshoots Potential Problems)
        "edgeupdate"                                   # Edge Update Service
        "edgeupdatem"                                  # Another Update Service
        "Fax"                                          # Fax Service
        "fhsvc"                                        # Fax History
        "FontCache"                                    # Windows font cache
        "gupdate"                                      # Google Update
        "gupdatem"                                     # Another Google Update Service
        "iphlpsvc"                                     # ipv6(Most websites use ipv4 instead)
        "lfsvc"                                        # Geolocation Service
        "lmhosts"                                      # TCP/IP NetBIOS Helper
        "MapsBroker"                                   # Downloaded Maps Manager
        "MicrosoftEdgeElevationService"                # Another Edge Update Service
        "MSDTC"                                        # Distributed Transaction Coordinator
        "NahimicService"                               # Nahimic Service
        "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
        "PcaSvc"                                       # Program Compatibility Assistant Service
        "PerfHost"                                     # Remote users and 64-bit processes to query performance.
        "PhoneSvc"                                     # Phone Service(Manages the telephony state on the device)
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
        "SysMain"                                      # Analyses System Usage and Improves Performance
        "TrkWks"                                       # Distributed Link Tracking Client
        "WbioSrvc"                                     # Windows Biometric Service (required for Fingerprint reader / facial detection)
        "WerSvc"                                       # Windows error reporting
        "wisvc"                                        # Windows Insider program(Windows Insider will not work if Disabled)
        "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
        "WpcMonSvc"                                    # Parental Controls
        "WPDBusEnum"                                   # Portable Device Enumerator Service
        "XblAuthManager"                               # Xbox Live Auth Manager (Disabling Breaks Xbox Live Games)
        "XblGameSave"                                  # Xbox Live Game Save Service (Disabling Breaks Xbox Live Games)
        "XboxNetApiSvc"                                # Xbox Live Networking Service (Disabling Breaks Xbox Live Games)
        "XboxGipSvc"                                   # Xbox Accessory Management Service
        "HPAppHelperCap"
        "HPDiagsCap"
        "HPNetworkCap"
        "HPSysInfoCap"
        "HpTouchpointAnalyticsService"
        "HvHost"
        "vmicguestinterface"
        "vmicheartbeat"
        "vmickvpexchange"
        "vmicrdv"
        "vmicshutdown"
        "vmictimesync"
        "vmicvmsession"
    )
    foreach ($Service in $Services) {
        Get-Service -Name $Service -ErrorAction SilentlyContinue | Set-Service -StartupType Manual
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

function CleaningTweaks {
    $StatusBox.Text = "| Aplicando Cleaning Tweaks...`r`n"
    $TB2.ForeColor = $LabelColor

    # Uninstall Microsoft Bloatware
    $StatusBox.Text = "| Desinstalando Microsoft Bloatware..."
    $Bloat = @(
        "Microsoft.3DBuilder"
        "Microsoft.AppConnector"
        "Microsoft.BingFinance"
        "Microsoft.BingNews"
        "Microsoft.BingSports"
        "Microsoft.BingTranslator"
        "Microsoft.BingWeather"
        "Microsoft.CommsPhone"
        "Microsoft.ConnectivityStore"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Messaging"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftPowerBIForWindows"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.MicrosoftStickyNotes"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.Office.OneNote"
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.People"
        "Microsoft.Print3D"
        "Microsoft.Paint"
        "Microsoft.Wallet"
        "Microsoft.WindowsAlarms"
        "Microsoft.WindowsCamera"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsPhone"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.YourPhone"
        "MicrosoftWindows.Client.WebExperience"
        "MicrosoftTeams"
        "Microsoft.MSPaint"
        "Microsoft.MixedReality.Portal"
        "Clipchamp.Clipchamp"
        "Microsoft.PowerAutomateDesktop"
        "Microsoft.Todos"
        "Microsoft.ZuneMusic"
        "MicrosoftCorporationII.MicrosoftFamily"
        "Disney.37853FC22B2CE"
    )
    &{ $ProgressPreference = 'SilentlyContinue'
    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat | Remove-AppxPackage
    }
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
    $StatusBox.Text = "| Instalando .NET Framework 3.5..."
    Add-WindowsCapability -Online -Name NetFx3~~~~ -Source C:\sources\sxs | Out-File $LogPath -Encoding UTF8 -Append
    $StatusBox.Text = "| Desinstalando Servidor OpenSSH..."
    Get-WindowsPackage -Online | Where-Object PackageName -like *SSH* | Remove-WindowsPackage -Online -NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    $StatusBox.Text = "| Desinstalando Rostro De Windows Hello..."
    Get-WindowsPackage -Online | Where-Object PackageName -like *Hello-Face* | Remove-WindowsPackage -Online -NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    $StatusBox.Text = "| Desinstalando Grabacion De Acciones Del Usuario..."
    DISM /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    $StatusBox.Text = "| Desinstalando Modo De Internet Explorer..."
    DISM /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    $StatusBox.Text = "| Desinstalando WordPad..."
    DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    $StatusBox.Text = "| Desinstalando Windows Powershell ISE..."
    DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    $StatusBox.Text = "| Desinstalando Reconocedor Matematico..."
    DISM /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    }
    $TB2.ForeColor = $DefaultForeColor
}

Function NvidiaSettings {
    $StatusBox.Text = "| Aplicando Ajustes Al Panel De Control De Nvidia..."
    $TB3.ForeColor = $LabelColor
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" -Name "EnableGR535" -Type DWord -Value 0
    $Download.DownloadFile($FromPath+"/Apps/ProfileInspector.exe", $ToPath+"\Apps\ProfileInspector.exe")
    $Download.DownloadFile($FromPath+"/Configs/NvidiaProfiles.nip", $ToPath+"\Configs\NvidiaProfiles.nip")
    Start-Process ($ToPath+"\Apps\ProfileInspector.exe")($ToPath+"\Configs\NvidiaProfiles.nip")
    Set-ItemProperty -Path "HKCU:\Software\NVIDIA Corporation\NvTray" -Name "StartOnLogin" -Type DWord -Value 0
    Remove-Item -Path "C:\Windows\System32\drivers\NVIDIA Corporation" -Recurse | Out-File $LogPath -Encoding UTF8 -Append
    Get-ChildItem -Path "C:\Windows\System32\DriverStore\FileRepository\" -Recurse | Where-Object {$_.Name -eq "NvTelemetry64.dll"} | Remove-Item | Out-File $LogPath -Encoding UTF8 -Append
    $TB3.ForeColor = $DefaultForeColor
}

Function ReduceIconsSpacing {
    $StatusBox.Text = "| Reduciendo Espacio Entre Iconos..."
    $TB4.ForeColor = $LabelColor
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "IconSpacing" -Value -900
    $TB4.ForeColor = $DefaultForeColor
}

Function HideShortcutArrows {
    $StatusBox.Text = "| Ocultando Flechas De Acceso Directo..."
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

Function SetFluentCursor {
    $StatusBox.Text = "| Estableciendo Cursor Personalizado..."
    $TB6.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Configs/FluentCursor.zip", $ToPath+"\Configs\FluentCursor.zip")
    Expand-Archive -Path ($ToPath+"\Configs\FluentCursor.zip") -DestinationPath 'C:\Windows\Cursors\Fluent Cursor' -Force
    $Download.DownloadFile($FromPath+"/Apps/FluentCursor.reg", $ToPath+"\Apps\FluentCursor.reg")
    regedit /s $env:userprofile\AppData\Local\Temp\ZKTool\Apps\FluentCursor.reg
    $TB6.ForeColor = $DefaultForeColor
}

Function DisableCortana {
    $StatusBox.Text = "| Deshabilitando Cortana..."
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

Function RemoveOneDrive {
    $StatusBox.Text = "| Desinstalando One Drive..."
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

Function RemoveXboxGameBar {
    $StatusBox.Text = "| Desinstalando Xbox Game Bar..."
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

Function TweaksInContextMenu {
    $StatusBox.Text = "| Activando Tweaks En Context Menu..."
    $TB10.ForeColor = $LabelColor
    
    # Enable App Submenu
    $Download.DownloadFile($FromPath+"/Apps/ContextMenuTweaks.zip", $ToPath+"\Apps\ContextMenuTweaks.zip")
    Expand-Archive -Path ($ToPath+"\Apps\ContextMenuTweaks.zip") -DestinationPath ($AppPath + "\Apps") -Force
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

    # Bufferbloat
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "03BufferbloatFix" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03BufferbloatFix" -Name "Icon" -Value "inetcpl.cpl,20"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03BufferbloatFix" -Name "MUIVerb" -Value "Bufferbloat Enable"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03BufferbloatFix" -Name "command" | Out-Null
            Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\03BufferbloatFix\command" -Name "(default)" -Value "C:\Program Files\ZKTool\Apps\Bufferbloat.exe"
    
    # SteamBlock
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "04SteamBlock" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04SteamBlock" -Name "Icon" -Value "C:\Program Files (x86)\Steam\steam.exe,0"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04SteamBlock" -Name "MUIVerb" -Value "Disable Steam"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04SteamBlock" -Name "command" | Out-Null
            Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\04SteamBlock\command" -Name "(default)" -Value "C:\Program Files\ZKTool\Apps\BlockSteam.exe"
    
    # Clean Standby List Memory
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "05EmptyStandbyList" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05EmptyStandbyList" -Name "Icon" -Value "SHELL32.dll,12"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05EmptyStandbyList" -Name "MUIVerb" -Value "Clear RAM"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05EmptyStandbyList" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05EmptyStandbyList\command" -Name "(default)" -Value "C:\Program Files\ZKTool\Apps\EmptyStandbyList.exe"

    # Clean Files
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "06CleanFiles" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\06CleanFiles" -Name "Icon" -Value "SHELL32.dll,32"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\06CleanFiles" -Name "MUIVerb" -Value "Clean Files"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\06CleanFiles" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\06CleanFiles\command" -Name "(default)" -Value "C:\Program Files\ZKTool\Apps\CleanFiles.exe"
    $TB10.ForeColor = $DefaultForeColor
}

Function VisualFXFix {
    $StatusBox.Text = "| Ajustando Animaciones De Windows..."
    $TB11.ForeColor = $LabelColor
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AlwaysHibernateThumbnails" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothing" -Value 2
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
    $MaskValue = "90,12,07,80,12,01,00,00"
    $MaskValueToHex = $MaskValue.Split(',') | ForEach-Object { "0x$_"}
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]]$MaskValueToHex)
    $TB11.ForeColor = $DefaultForeColor
}

Function ActivateWindowsPro {
    $StatusBox.Text = "| Activando Windows Pro..."
    $MTB1.ForeColor = $LabelColorBig
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /skms kms.digiboy.ir
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ato
    $MTB1.ForeColor = $DefaultForeColorBig
}

Function VisualCRuntimes {
    $StatusBox.Text = "| Instalando Todas Las Versiones De Visual C++..."
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

function EnableMSIMode {
    $StatusBox.Text = "| Estableciendo GPU En Modo MSI..."
    $GPUIDS = @((wmic path win32_VideoController get PNPDeviceID | Select-Object -Skip 2 | Format-List | Out-String).Trim())
    foreach ($GPUID in $GPUIDS) {
        $GPUName = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID" -Name "DeviceDesc"
    }
    if (($GPUName -like "*GTX*") -or ($GPUName -like "*RTX*")) {
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID\Device Parameters\Interrupt Management" -Name "MessageSignaledInterruptProperties" | Out-File $LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" -Name "MSISupported" -Type DWord -Value 1
    }
}

Function FFMPEG {
    $StatusBox.Text = "| Instalando FFMPEG... "
    $MTB4.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/HEVC.appx", $ToPath+"\Apps\HEVC.appx")
    $Download.DownloadFile($FromPath+"/Apps/HEIF.appx", $ToPath+"\Apps\HEIF.appx")
    &{$ProgressPreference = 'SilentlyContinue'; Add-AppxPackage ($ToPath+"\Apps\HEVC.appx"); Add-AppxPackage ($ToPath+"\Apps\HEIF.appx")}
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Gyan.FFmpeg | Out-File $LogPath -Encoding UTF8 -Append
    $Download.DownloadFile($FromPath+"/Apps/ffmpeg.exe", "$env:ProgramFiles\ZKTool\Apps\ffmpeg.exe")
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\" -Name "Compress" | Out-Null
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "Icon" -Value "C:\Program Files\ZKTool\Apps\ffmpeg.exe,0"
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "Position" -Value "Bottom"
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\command\" -Name "(default)" -Value 'cmd.exe /c echo | set /p = %1| clip | exit && "C:\Program Files\ZKTool\Apps\ffmpeg.exe"'
    $MTB4.ForeColor = $DefaultForeColor
}

Function WindowsTerminalFix {
    $StatusBox.Text = "| Aplicando Ajustes A Windows Terminal..."
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

Function NetworkConfig {
    $StatusBox.Text = "| Abriendo Configuracion De Red..."
    $MTB8.ForeColor = $LabelColor
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString(($FromPath+"/Scripts/NetConfig.ps1")))
    $MTB8.ForeColor = $DefaultForeColor
}

Function Autoruns {
    $StatusBox.Text = "| Abriendo Autoruns..."
    $MTB9.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/Autoruns.exe", $ToPath+"\Apps\Autoruns.exe")
    Start-Process ($ToPath+"\Apps\Autoruns.exe")
    $MTB9.ForeColor = $DefaultForeColor
}

Function AdobeCleaner {
    $StatusBox.Text = "| Eliminando Procesos De Adobe..."
    $MTB15.ForeColor = $LabelColor
    Rename-Item -Path "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exe" "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exeX"
    Rename-Item -Path "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exeX"
    Rename-Item -Path "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe" "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exeX"
    Rename-Item -Path "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exe" "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exeX"
    $MTB15.ForeColor = $DefaultForeColor
}

Function AMDUndervoltPack {
    $StatusBox.Text = "| Descargando AMD Undervolt Pack..."
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

Function GameSettings {
    $StatusBox.Text = "| Abriendo Game Settings..."
    $HB1.ForeColor = $LabelColor
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString(($FromPath+"/Scripts/GameSettings.ps1")))
    $HB1.ForeColor = $DefaultForeColor
}

Function DarkTheme {
    $StatusBox.Text = "| Aplicando Tema Oscuro..."
    $HB2.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Configs/Media.zip", $ToPath+"\Configs\Media.zip")
    Expand-Archive -Path ($ToPath+"\Configs\Media.zip") -DestinationPath ("$env:ProgramFiles\ZKTool\Media") -Force
    $Download.DownloadFile($FromPath+"/Apps/SetWallpaper.ps1", $ToPath+"\Apps\SetWallpaper.ps1")
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion" -Name "PersonalizationCSP" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value "C:\Program Files\ZKTool\Media\BlackW11Wallpaper.jpg"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value "C:\Program Files\ZKTool\Media\BlackW11Wallpaper.jpg"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Type DWord -Value 1
    Start-Process powershell -ArgumentList "-noexit -windowstyle minimized -command powershell.exe -ExecutionPolicy Bypass $env:userprofile\AppData\Local\Temp\ZKTool\Apps\SetWallpaper.ps1 ; exit"

    # Accent Color
    $Download.DownloadFile($FromPath+"/Apps/DarkTheme.reg", $ToPath+"\Apps\DarkTheme.reg")
    regedit /s $env:userprofile\AppData\Local\Temp\ZKTool\Apps\DarkTheme.reg

    # Black Edge
    $ShortcutPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
    $IconLocation = "$env:ProgramFiles\ZKTool\Media\BlackEdge.ico"
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    # Black Explorer
    $ShortcutPath = "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
    $IconLocation = "$env:ProgramFiles\ZKTool\Media\BlackExplorer.ico"
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    # Black Spotify
    $ShortcutPath = "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Spotify.lnk"
    $IconLocation = "$env:ProgramFiles\ZKTool\Media\BlackSpotify.ico"
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    # Black Discord
    $ShortcutPath = "$env:userprofile\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"
    $IconLocation = "$env:ProgramFiles\ZKTool\Media\BlackDiscord.ico"
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()
    
    $HB2.ForeColor = $DefaultForeColor
}

Function ContextMenuHandler {
    $StatusBox.Text = "| Abriendo Context Menu Handler..."
    $HB3.ForeColor = $LabelColor
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString(($FromPath+"/Scripts/ContextMenuHandler.ps1")))
    $HB3.ForeColor = $DefaultForeColor
}

Function MSIAfterburnerSettings {
    $StatusBox.Text = "| Configurando MSI Afterbuner..."
    $MTB14.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Configs/MSIAfterburner.zip", $ToPath+"\Configs\MSIAfterburner.zip")
    Expand-Archive -Path ($ToPath+"\Configs\MSIAfterburner.zip") -DestinationPath ($ToPath+"\Configs\MSIAfterburner") -Force
    Move-Item -Path ($ToPath+"\Configs\MSIAfterburner\MSIAfterburner Settings\Profiles\*") -Destination 'C:\Program Files (x86)\MSI Afterburner\Profiles' -Force
    if (Test-Path -Path 'C:\Program Files (x86)\RivaTuner Statistics Server') {
        New-Item -Path 'C:\Program Files (x86)\RivaTuner Statistics Server\Profiles' -ItemType Directory | Out-Null
        Move-Item -Path ($ToPath+"\Configs\MSIAfterburner\RivaTuner Settings\Profiles\*") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\Profiles' -Force
        Move-Item -Path ($ToPath+"\Configs\MSIAfterburner\RivaTuner Settings\Config") -Destination 'C:\Program Files (x86)\RivaTuner Statistics Server\ProfileTemplates' -Force
    }
    $MTB14.ForeColor = $DefaultForeColor
}

Function RemoveRealtek {
    $StatusBox.Text = "| Quitando Realtek Audio Service..."
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

Function Z390LanDrivers {
    $StatusBox.Text = "| Instalando Z390 Lan Drivers..."
    $HB6.ForeColor = $LabelColor
    $Download.DownloadFile($FromPath+"/Apps/LanDrivers.zip", $ToPath+"\Apps\LanDrivers.zip")
    Expand-Archive -Path ($ToPath+"\Apps\LanDrivers.zip") -DestinationPath ($ToPath+"\Apps\LanDrivers") -Force
    pnputil /add-driver ($ToPath+"\Apps\LanDrivers\e1d68x64.inf") /install
    $OldDriver = Get-WMIObject win32_PnPSignedDriver | Where-Object DeviceName -eq "Intel(R) Ethernet Connection (7) I219-V" | Select-Object -ExpandProperty InfName
    pnputil /delete-driver $OldDriver /uninstall /force
    $HB6.ForeColor = $DefaultForeColor
}

$StartScript.Add_MouseEnter({
    $StartScript.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverSSButtonColor.png"))
})

$StartScript.Add_MouseLeave({
    $StartScript.Image = $SSNone
})

$StartScript.Add_Click({
    $StatusBox.Text = "| Iniciando Script..."
    $StartScript.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "SSProcessing.png"))
    $StartScript.ForeColor = "Black"
    Start-Sleep 1

    $Functions = @()

    $ActiveButtons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB16,
    $MSB17,$LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$MTB12,
    $MTB13,$MTB14,$MTB15,$MTB16,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6)

    foreach ($ActiveButton in $ActiveButtons) {
        if (($ActiveButton.Image -eq $ActiveButtonColor) -or ($ActiveButton.Image -eq $ActiveButtonColorBig)) {
            $Functions += ($ActiveButton.Text -replace " ","")
        }
    }

    foreach ($Function in $Functions) {& $Function}

    foreach ($ActiveButton in $ActiveButtons) {
        if ($ActiveButton.Image -eq $ActiveButtonColor) {
            $ActiveButton.Image = $DefaultButtonColor
            $ActiveButton.ForeColor = $LabelColor
        }
        if ($ActiveButton.Image -eq $ActiveButtonColorBig) {
            $ActiveButton.Image = $DefaultButtonColorBig
            $ActiveButton.ForeColor = $LabelColor
        }
    }

    $StatusBox.Text = "| Comprobando Instalaciones..."

    $Installations = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB11,$SB12,$MSB1,$MSB5,$MSB6,$MSB9,$MSB10,$MSB11,$MSB12,$LB1,$LB2,$LB3,$LB5,$LB7,$LB8)
    foreach ($Installation in $Installations) {
        if ($Installation.ForeColor -eq $LabelColor) {
            $WingetListCheck = Winget List $Installation.Text | Select-String -Pattern $Installation.Text | ForEach-Object {$_.matches} | Select-Object -ExpandProperty Value
            if (!($WingetListCheck -eq $Installation.Text)) {
                $Installation.ForeColor = "Red"
            }
        }
    }

    $StartScript.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "SSDefault.png"))
    $StartScript.ForeColor = $LabelColor
    $StatusBox.Text = "| Script Finalizado"

    if ($TB1.ForeColor -eq $LabelColor) {
        $MessageBox = [System.Windows.Forms.MessageBox]::Show("El equipo requiere reiniciarse para aplicar los cambios`r`nReiniciar equipo ahora?", "Reiniciar equipo", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information)
        if ($MessageBox -ne [System.Windows.Forms.DialogResult]::No) {
            $StatusBox.Text = "| Reiniciando El Equipo En 5 Segundos..."
            Start-Sleep 5
            Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse
            Restart-Computer
        }
    }
})

$Form.Add_Closing({
    Start-Process Powershell -WindowStyle Hidden {
        Start-Sleep 2
        Remove-Item -Path "$env:userprofile\AppData\Local\Temp\ZKTool" -Recurse
    }
})

[void]$Form.ShowDialog()