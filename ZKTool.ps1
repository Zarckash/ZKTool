Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'
$WarningPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Checking For Updates
$AppVersion = 3.5
try {
    Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" | Out-Null        #
}                                                                                                                                           # Crea DisplayVersion
catch {                                                                                                                                     # en caso de que no exista
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" -Value $AppVersion     #
}
finally {
    if (!((Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion") -eq $AppVersion)) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "DisplayVersion" -Value $AppVersion
        Start-Process Powershell {
            Invoke-Expression (Invoke-WebRequest -useb 'https://raw.githubusercontent.com/Zarckash/ZKTool/main/Initialize.ps1')
        }
        exit
    }
}
              
# Defining Variables
$Download    = New-Object System.Net.WebClient                      # Download Method
$GitHubPath  = "https://github.com/Zarckash/ZKTool/raw/main"        # GitHub Downloads URL
$TempPath    = "$env:temp\ZKTool"                                   # Folder Structure Path
$LogFolder   = "$env:temp\ZKToolLogs"                               # Script Logs Path
$LogPath     = "$LogFolder\ZKTool.log"                              # Script Main Log Path
$ZKToolPath  = "$env:ProgramFiles\ZKTool"                           # ZKTool App Path

# Cleaning Last Log File
Remove-Item $LogFolder -Recurse | Out-Null

# Creating Folders
New-Item $LogFolder -ItemType Directory | Out-Null
New-Item "$TempPath\Files" -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
New-Item "$TempPath\Functions" -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
New-Item "$TempPath\Resources" -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append

# Color Variables
$ImagesFolder          = "$TempPath\Resources\Images"
$FormBackColor         = [System.Drawing.ColorTranslator]::FromHtml("#202020") # Black
$PanelBackColor        = [System.Drawing.ColorTranslator]::FromHtml("#2B2B2B") # Black Light
$AccentColor           = [System.Drawing.ColorTranslator]::FromHtml("#ACA5F3") # Purple
$DefaultForeColor      = [System.Drawing.ColorTranslator]::FromHtml("#FFFFFF") # White

# Defining Lists
$AppsList    = $Download.DownloadString("$GitHubPath/Resources/Apps.json")  | ConvertFrom-Json
$FormsList   = $Download.DownloadString("$GitHubPath/Resources/Forms.json") | ConvertFrom-Json

$Download.DownloadFile("$GitHubPath/Resources/Images.zip", "$TempPath\Resources\Images.zip")
Expand-Archive -Path "$TempPath\Resources\Images.zip" -DestinationPath "$TempPath\Resources\Images\" -Force

# Downloading Functions
$Download.DownloadFile("$GitHubPath/Functions/Install-App.ps1","$TempPath\Functions\Install-App.ps1")
$Download.DownloadFile("$GitHubPath/Functions/Invoke-Form.ps1","$TempPath\Functions\Invoke-Form.ps1")
$Download.DownloadFile("$GitHubPath/Functions/Move-Form.ps1","$TempPath\Functions\Move-Form.ps1")
$Download.DownloadFile("$GitHubPath/Functions/Write-UserOutput.ps1","$TempPath\Functions\Write-UserOutput.ps1")

# Dot Sourcing Functions
. "$TempPath\Functions\Install-App.ps1"
. "$TempPath\Functions\Invoke-Form.ps1"
. "$TempPath\Functions\Move-Form.ps1"
. "$TempPath\Functions\Write-UserOutput.ps1"

$FormSize = "1138,773"

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 779)
$Form.Text                       = "ZKTool"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.FormBorderStyle            = "None"
$Form.Size                       = $FormSize
$Form.ForeColor                  = $DefaultForeColor
$Form.Icon                       = [System.Drawing.Icon]::ExtractAssociatedIcon("$ImagesFolder\ZKLogo.ico")
$Form.BackColor                  = "LimeGreen"
$Form.TransparencyKey            = "LimeGreen"

$FormPanel                       = New-Object System.Windows.Forms.Panel
$FormPanel.Size                  = $FormSize
$FormPanel.Location              = "0,0"
$FormPanel.BackgroundImage       = [System.Drawing.Image]::FromFile("$ImagesFolder\ZKToolBg.png")
$Form.Controls.Add($FormPanel)

$CloseFormPanel                  = New-Object System.Windows.Forms.Panel
$CloseFormPanel.Size             = "109,37"
$CloseFormPanel.Location         = "1029,0"
$CloseFormPanel.BackgroundImage  = [System.Drawing.Image]::FromFile("$ImagesFolder\FormClosePanelBg.png")
$FormPanel.Controls.Add($CloseFormPanel)

# Close Form Button
$CloseButton                     = New-Object System.Windows.Forms.Button
$CloseButton.Location            = "72,3"
$CloseButton.Size                = "34,34"
$CloseButton.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\CloseButton.png")
$CloseFormPanel.Controls.Add($CloseButton)

$CloseButton.Add_MouseEnter({
    $CloseFormPanel.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\FormClosePanelBgClose.png")
})

$CloseButton.Add_MouseLeave({
    $CloseFormPanel.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\FormClosePanelBg.png")
})

$CloseButton.Add_Click({
    $Form.Close()
})

# Maximize Form Button
$MaximizeButton                     = New-Object System.Windows.Forms.Button
$MaximizeButton.Location            = "36,1"
$MaximizeButton.Size                = "36,36"
$MaximizeButton.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\MaximizeButton.png")
$CloseFormPanel.Controls.Add($MaximizeButton)

# Minimize Form Button
$MinimizeButton                     = New-Object System.Windows.Forms.Button
$MinimizeButton.Location            = "0,1"
$MinimizeButton.Size                = "36,36"
$MinimizeButton.BackgroundImage     = [System.Drawing.Image]::FromFile("$ImagesFolder\MinimizeButton.png")
$CloseFormPanel.Controls.Add($MinimizeButton)

$MinimizeButton.Add_Click({
    $Form.WindowState = 1
})

$Buttons = @($MinimizeButton,$MaximizeButton,$CloseButton)
foreach ($Button in $Buttons) {
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.BackColor = $PanelBackColor
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
}

$MinimizeButton.FlatAppearance.MouseOverBackColor = [System.Drawing.ColorTranslator]::FromHtml("#3C3C3C")
$CloseButton.FlatAppearance.MouseOverBackColor = [System.Drawing.ColorTranslator]::FromHtml("#C42B1C")
$CloseButton.FlatAppearance.MouseDownBackColor = [System.Drawing.ColorTranslator]::FromHtml("#C42B1C")



            ##################################
            ############ SOFTWARE ############
            ##################################


# Software Label
$SLabel                          = New-Object System.Windows.Forms.Label
$SLabel.Text                     = "S O F T W A R E"
$SLabel.Size                     = "411,34"
$SLabel.Location                 = "31,1"
$SLabel.Font                     = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$SLabel.BackColor                = $PanelBackColor
$SLabel.ForeColor                = $AccentColor
$SLabel.TextAlign                = [System.Drawing.ContentAlignment]::MiddleCenter
$FormPanel.Controls.Add($SLabel)

# Software Panel
$SPanel                          = New-Object System.Windows.Forms.Panel
$SPanel.Size                     = "220,509"
$SPanel.Location                 = "233,46"
$SPanel.BackColor                = $FormBackColor
$SPanel.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\STPanelBg.png")
$FormPanel.Controls.Add($SPanel)

$Position  = 10 # Sets Each Button Position

$Buttons = @('SB1','SB2','SB3','SB4','SB5','SB6','SB7','SB8','SB9','SB10','SB11','SB12','MSB1','MSB2','MSB3','MSB4','MSB5','MSB6','MSB7','MSB8','MSB9','MSB10','MSB11','MSB12','MSB13','MSB14','MSB15','MSB16',
'MSB17','LB1','LB2','LB3','LB4','LB5','LB6','LB7','LB8','TB1','TB2','TB3','TB4','TB5','TB6','TB7','TB8','TB9','TB10','TB11','MTB1','MTB2','MTB3','MTB4','MTB5','MTB6','MTB7','MTB8','MTB9','MTB10','MTB11','MTB12',
'MTB13','MTB14','MTB15','MTB16','HB1','HB2','HB3','HB4','HB5','HB6','HB7','HB8','HB9')

foreach ($Button in $Buttons) {
    Get-Variable -Name $Button | Remove-Variable
}

$Buttons | ForEach-Object {
    $NewButton = New-Object System.Windows.Forms.Button
    New-Variable "$_" $NewButton
}

$SB1.Text   = "Google Chrome"
$SB2.Text   = "GeForce Experience"
$SB3.Text   = "Discord"
$SB4.Text   = "Spotify"
$SB5.Text   = "HWMonitor"
$SB6.Text   = "MSI Afterburner"
$SB7.Text   = "Corsair iCue"
$SB8.Text   = "Logitech OMM"
$SB9.Text   = "Razer Synapse"
$SB10.Text  = "uTorrent Web"
$SB11.Text  = "NanaZip"
$SB12.Text  = "Visual Studio Code"

$Position = 6
$Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12)
foreach ($Button in $Buttons) {
    $SPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(6,$Position)
    $Position+=42
}


            ##################################
            ######### MORE  SOFTWARE #########
            ##################################


# More Software Panel
$MSPanel                         = New-Object system.Windows.Forms.Panel
$MSPanel.Size                    = "220,719"
$MSPanel.Location                = "7,46"
$MSPanel.BackColor               = $FormBackColor
$MSPanel.BackgroundImage         = [System.Drawing.Image]::FromFile("$ImagesFolder\MSMTPanelBg.png")
$FormPanel.Controls.Add($MSPanel)

$MSB1.Text   = "OBS Studio"
$MSB2.Text   = "Adobe Photoshop"
$MSB3.Text   = "Adobe Premiere"
$MSB4.Text   = "Adobe After Effects"
$MSB5.Text   = "Netflix"
$MSB6.Text   = "Prime Video"
$MSB7.Text   = "VLC Media Player"
$MSB8.Text   = "Rufus"
$MSB9.Text   = "WinRAR"
$MSB10.Text  = "MegaSync"
$MSB11.Text  = "LibreOffice"
$MSB12.Text  = "GitHub Desktop"
$MSB13.Text  = "Node JS"
$MSB14.Text  = "AMD Adrenalin"
$MSB15.Text  = "Tarkov Launcher"
$MSB16.Text  = "League of Legends"
$MSB17.Text  = "Valorant"

$Position = 6
$Buttons = @($MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB16,$MSB17)
foreach ($Button in $Buttons) {
    $MSPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(6,$Position)
    $Position+=42
}


            ##################################
            ########### LAUNCHERS ############
            ##################################


# Launchers Label
$LLabel                          = New-Object System.Windows.Forms.Label
$LLabel.Text                     = "L A U N C H E R S"
$LLabel.Size                     = "220,34"
$LLabel.Location                 = "459,1"
$LLabel.Font                     = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$LLabel.TextAlign                = [System.Drawing.ContentAlignment]::MiddleCenter
$LLabel.BackColor                = $PanelBackColor
$LLabel.ForeColor                = $AccentColor
$FormPanel.Controls.Add($LLabel)

# Launchers Panel
$LPanel                          = New-Object System.Windows.Forms.Panel
$LPanel.Size                     = "220,341"
$LPanel.Location                 = "459,46"
$LPanel.BackColor                = $FormBackColor
$LPanel.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\LPanelBg.png")
$FormPanel.Controls.Add($LPanel)

$LB1.Text  = "Steam"
$LB2.Text  = "EA App"
$LB3.Text  = "Ubisoft Connect"
$LB4.Text  = "Battle.Net"
$LB5.Text  = "GOG Galaxy"
$LB6.Text  = "Rockstar Games"
$LB7.Text  = "Epic Games Launcher"
$LB8.Text  = "Xbox"

$Position = 6
$Buttons = @($LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8)
foreach ($Button in $Buttons) {
    $LPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(6,$Position)
    $Position+=42
}


            ##################################
            ############# TWEAKS #############
            ##################################


# Tweaks Label
$TLabel                          = New-Object System.Windows.Forms.Label
$TLabel.Text                     = "T W E A K S"
$TLabel.Size                     = "440,34"
$TLabel.Location                 = "685,1"
$TLabel.Font                     = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$TLabel.TextAlign                = [System.Drawing.ContentAlignment]::MiddleCenter
$TLabel.BackColor                = $PanelBackColor
$TLabel.ForeColor                = $AccentColor
$FormPanel.Controls.Add($TLabel)

# Tweaks Panel
$TPanel                          = New-Object System.Windows.Forms.Panel
$TPanel.Size                     = "220,509"
$TPanel.Location                 = "685,46"
$TPanel.BackColor                = $FormBackColor
$TPanel.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\STPanelBg.png")
$FormPanel.Controls.Add($TPanel)

$TB1.Text   = "Optimization Tweaks"
$TB2.Text   = "Cleaning Tweaks"
$TB3.Text   = "Nvidia Settings"
$TB4.Text   = "Reduce Icons Spacing"
$TB5.Text   = "Hide Shortcut Icons"
$TB6.Text   = "Set Fluent Cursor"
$TB7.Text   = "Disable Cortana"
$TB8.Text   = "Remove OneDrive"
$TB9.Text   = "Remove Xbox Game Bar"
$TB10.Text  = "Tweaks In Context Menu"
$TB11.Text  = "VisualFX Fix"

$Position = 42*2+6
$Buttons = @($TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11)
foreach ($Button in $Buttons) {    
    $TPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(6,$Position)
    $Position+=42
}
$TB1.Location                    = New-Object System.Drawing.Point(6,6)
$TPanel.Controls.Add($TB1)


            ##################################
            ########## MORE  TWEAKS ##########
            ##################################


# More Tweaks Panel
$MTPanel                         = New-Object System.Windows.Forms.Panel
$MTPanel.Size                    = "220,719"
$MTPanel.Location                = "911,46"
$MTPanel.BackColor               = $FormBackColor
$MTPanel.BackgroundImage         = [System.Drawing.Image]::FromFile("$ImagesFolder\MSMTPanelBg.png")
$FormPanel.Controls.Add($MTPanel)

$MTB1.Text   = "Activate Windows Pro"
$MTB2.Text   = "Visual C Runtimes"
$MTB3.Text   = "Enable MSI Mode"
$MTB4.Text   = "FFMPEG"
$MTB5.Text   = "Windows Terminal Fix"
$MTB6.Text   = "Void"
$MTB7.Text   = "Void"
$MTB8.Text   = "Network Config"
$MTB9.Text   = "Autoruns"
$MTB10.Text  = "Void"
$MTB11.Text  = "Void"
$MTB12.Text  = "Void"
$MTB13.Text  = "Void"
$MTB14.Text  = "Void"
$MTB15.Text  = "Adobe Cleaner"
$MTB16.Text  = "AMD Undervolt Pack"

$Position = 42*2+6
$Buttons = @($MTB2,$MTB3,$MTB4,$MTB5,$MTB8,$MTB9,$MTB15,$MTB16)
foreach ($Button in $Buttons) {
    $MTPanel.Controls.Add($Button)
    $Button.Location             = New-Object System.Drawing.Point(6,$Position)
    $Position+=42
}
$MTB1.Location                   = New-Object System.Drawing.Point(6,6)
$MTPanel.Controls.Add($MTB1)


            ##################################
            ########## PICTURE  BOX ##########
            ##################################


# PictureBox
$LogoBox                         = New-Object System.Windows.Forms.PictureBox
$LogoBox.Size                    = "220,161"
$LogoBox.Location                = "459,394"
$LogoBox.BackColor               = $FormBackColor
$LogoBox.BackgroundImage         = [System.Drawing.Image]::FromFile("$ImagesFolder\PictureBox.png")
$FormPanel.Controls.Add($LogoBox)


            ##################################
            ########## START SCRIPT ##########
            ##################################


# Start Script Panel
$SSPanel                         = New-Object System.Windows.Forms.Panel
$SSPanel.Size                    = "672,77"
$SSPanel.Location                = "233,688"
$SSPanel.BackColor               = $FormBackColor
$SSPanel.BackgroundImage         = [System.Drawing.Image]::FromFile("$ImagesFolder\SSPanelBg.png")
$FormPanel.Controls.Add($SSPanel)

# Start Script Button
$StartScript                     = New-Object System.Windows.Forms.Button
$StartScript.Text                = "I N I C I A R    S C R I P T"
$StartScript.Size                = "660,40" 
$StartScript.Location            = "6,6"
$StartScript.Font                = New-Object System.Drawing.Font('Segoe UI Semibold',20)
$StartScript.BackColor           = $PanelBackColor
$StartScript.ForeColor           = $AccentColor
$StartScript.FlatStyle           = "Flat"
$StartScript.FlatAppearance.BorderSize = 0
$StartScript.FlatAppearance.MouseOverBackColor = $PanelBackColor
$StartScript.FlatAppearance.MouseDownBackColor = $PanelBackColor
$SSPanel.Controls.Add($StartScript)

# StatusBox
$StatusBox                       = New-Object System.Windows.Forms.Label
$StatusBox.Text                  = "| Ready"
$StatusBox.Size                  = "660,30"
$StatusBox.Location              = "6,50"
$StatusBox.Font                  = New-Object System.Drawing.Font('Lucida Console',12)
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
$HPanel.Size                     = "672,119"
$HPanel.Location                 = "233,562"
$HPanel.BackColor                = $FormBackColor
$HPanel.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\HPanelBg.png")
$FormPanel.Controls.Add($HPanel)

$HB1.Text      = "Settings"
$HB1.Location  = "6,6"

$HB2.Text      = "Move User Folder"
$HB2.Location  = "6,42"

$HB3.Text      = "Context Menu Handler"
$HB3.Location  = "6,78"

$HB4.Text      = "NVCleanstall"
$HB4.Location  = "232,6"

$HB5.Text      = "Remove Realtek"
$HB5.Location  = "232,42"

$HB6.Text      = "Z390 Lan Drivers"
$HB6.Location  = "232,78"

$HB7.Text      = "Dark Theme"
$HB7.Location  = "458,6"

$HB8.Text      = ""
$HB8.Location  = "458,42"

$HB9.Text      = ""
$HB9.Location  = "458,78"

$Buttons = @($HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7)
foreach ($Button in $Buttons) {
    $HPanel.Controls.Add($Button)
}

# Images Variables
$ActiveButtonColor     = [System.Drawing.Image]::FromFile("$ImagesFolder\ActiveButtonColor.png")
$HoverButtonColor      = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverButtonColor.png")
$ActiveButtonColorBig  = [System.Drawing.Image]::FromFile("$ImagesFolder\ActiveButtonColorBig.png")
$HoverButtonColorBig   = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverButtonColorBig.png")

Move-Form -SelectedLabel @($SLabel,$LLabel,$TLabel)

$Buttons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB16,
$MSB17,$LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$MTB12,
$MTB13,$MTB14,$MTB15,$MTB16,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9)
foreach ($Button in $Buttons) {
    $Button.Size                 = "208,35"
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.TextAlign            = [System.Drawing.ContentAlignment]::MiddleLeft
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.BackColor = $PanelBackColor
    $Button.BackgroundImage = $DefaultButtonColor

    $Button.Add_MouseEnter({
        if ($this.BackgroundImage -eq $DefaultButtonColor) {
            $this.BackgroundImage = $HoverButtonColor
        }
    })

    $Button.Add_MouseLeave({
        if ($this.BackgroundImage -eq $HoverButtonColor) {
            $this.BackgroundImage = $DefaultButtonColor
        }
    })

    $Button.Add_Click({
        if ($this.BackgroundImage -eq $HoverButtonColor) {
            $this.BackgroundImage = $ActiveButtonColor
        }else{
            $this.BackgroundImage = $DefaultButtonColor
        }
    })
}

$Buttons = @($TB1,$MTB1)
foreach ($Button in $Buttons) {
    $Button.Size                 = "208,77"
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.TextAlign            = [System.Drawing.ContentAlignment]::MiddleLeft
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.BackColor = $PanelBackColor
    $Button.BackgroundImage = $DefaultButtonColorBig

    $Button.Add_Click({
        if ($this.BackgroundImage -eq $HoverButtonColorBig) {
            $this.BackgroundImage = $ActiveButtonColorBig
        }else {
            $this.BackgroundImage = $DefaultButtonColorBig
        }
    })

    $Button.Add_MouseEnter({
        if ($this.BackgroundImage -eq $DefaultButtonColorBig) {
            $this.BackgroundImage = $HoverButtonColorBig
        }
    })

    $Button.Add_MouseLeave({
        if ($this.BackgroundImage -eq $HoverButtonColorBig) {
            $this.BackgroundImage = $DefaultButtonColorBig
        }
    })
}


function Spotify {
    $SB4.ForeColor = $AccentColor
    Write-UserOutput "Instalando Spotify"
    $Download.DownloadFile("$GitHubPath/Files/Spotify.ps1", "$TempPath\Files\Spotify.ps1")
    Start-Process powershell -ArgumentList "-noexit -command powershell.exe -ExecutionPolicy Bypass $env:temp\ZKTool\Files\Spotify.ps1 ; exit"
    $SB4.ForeColor = $DefaultForeColor
}

function AdobePhotoshop {
    $MSB2.ForeColor = $AccentColor
    Write-UserOutput "Instalando Adobe Photoshop"
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'Adobe Photoshop'
        $File = 'http://zktool.ddns.net/files/AdobePhotoshop.iso'
        $FilePath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Files\AdobePhotoshop.iso'
        Write-Host 'Descargando Adobe Photoshop...'
        (New-Object Net.WebClient).DownloadFile($File, $FilePath)
        $AdobePath = Mount-DiskImage $FilePath | Get-DiskImage | Get-Volume
        $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
        Start-Process $AdobeInstall
    }
    $MSB2.ForeColor = $DefaultForeColor
}

function AdobePremiere {
    $MSB3.ForeColor = $AccentColor
    Write-UserOutput "Instalando Adobe Premiere"
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'Adobe Premiere'
        $File = 'http://zktool.ddns.net/files/AdobePremiere.iso'
        $FilePath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Files\AdobePremiere.iso'
        Write-Host 'Descargando Adobe Premiere...'
        (New-Object Net.WebClient).DownloadFile($File, $FilePath)
        $AdobePath = Mount-DiskImage $FilePath | Get-DiskImage | Get-Volume
        $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
        Start-Process $AdobeInstall
    }
    $MSB3.ForeColor = $DefaultForeColor
}

function AdobeAfterEffects {
    $MSB4.ForeColor = $AccentColor
    Write-UserOutput "Instalando Adobe After Effects"
    Start-Process Powershell {
        $host.UI.RawUI.WindowTitle = 'Adobe After Effects'
        $File = 'http://zktool.ddns.net/files/AdobeAfterEffects.iso'
        $FilePath = $env:userprofile + '\AppData\Local\Temp\ZKTool\Files\AdobeAfterEffects.iso'
        Write-Host 'Descargando Adobe After Effects...'
        (New-Object Net.WebClient).DownloadFile($File, $FilePath)
        $AdobePath = Mount-DiskImage $FilePath | Get-DiskImage | Get-Volume
        $AdobeInstall = '{0}:\autoplay.exe' -f $AdobePath.DriveLetter
        Start-Process $AdobeInstall
    }
    $MSB4.ForeColor = $DefaultForeColor
}

function OptimizationTweaks {
    $TB1.ForeColor = $AccentColorBig
    Write-UserOutput "Iniciando Optimización"

    # Create Restore Point
    Write-UserOutput "Creando Punto De Restauración"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -Type DWord -Value 0
    Enable-ComputerRestore -Drive "C:\"
    Checkpoint-Computer -Description "Pre Optimización ZKTool" -RestorePointType "MODIFY_SETTINGS"

    # Monthly Optimization Entry
    Write-UserOutput "Creando Entrada De Fecha En Regedit"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ZKTool" -Name "LastOptimizationDate" -Value (Get-Date -Format "dd-MM-yyyy")
    
    # Disable UAC
    Write-UserOutput "Desactivando UAC Para Administradores"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

    # Disable Device Set Up Suggestions
    Write-UserOutput "Desactivando Sugerencias De Configuración De Dispositivo"
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\" -Name "UserProfileEngagement"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0
    
    # Disable Fast Boot
    Write-UserOutput "Desactivando Fast Boot"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0

    # Enable Hardware Acceleration
    Write-UserOutput "Activando Aceleración De Hardware"
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
    Write-UserOutput "Comprobando Cantidad De RAM"
    $RamCapacity = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1mb
    if ($RamCapacity -le 17000) {
        Write-UserOutput "Estableciendo El Tamaño Del Archivo De Paginación En $RamCapacity MB"
        $PageFile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
        $PageFile.AutomaticManagedPagefile = $false
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "c:\pagefile.sys $RamCapacity $RamCapacity"
    }else {
        Write-UserOutput "La Cantidad De RAM Supera Los 16GB, No Se Realizará Ningún Cambio"
    }

    # Rebuild Performance Counters
    Write-UserOutput "Reconstruyendo Contadores De Rendimiento"
    lodctr /r
    lodctr /r

    # Install Timer Resolution Service
    Write-UserOutput "Instalando Set Timer Resolution Service"
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2010.x64 | Out-File $LogPath -Encoding UTF8 -Append
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2010.x86 | Out-File $LogPath -Encoding UTF8 -Append
    $Download.DownloadFile("$GitHubPath/Files/.exe/SetTimerResolutionService.exe", "$TempPath\Files\SetTimerResolutionService.exe")
    New-Item 'C:\Program Files\Set Timer Resolution Service\' -ItemType Directory | Out-File $LogPath -Encoding UTF8 -Append
    Move-Item -Path ("$TempPath\Files\SetTimerResolutionService.exe") -Destination 'C:\Program Files\Set Timer Resolution Service\'
    Push-Location
    Set-Location -Path "C:\Program Files\Set Timer Resolution Service"
    Start-Sleep 3
    .\SetTimerResolutionService.exe -install | Out-File $LogPath -Encoding UTF8 -Append
    Pop-Location

    # Install Bitsum Power Plan
    Write-Output "Instalando Bitsum Power Plan"
    $Download.DownloadFile("$GitHubPath/Files/BitsumPowerPlan.pow", "$TempPath\Files\BitsumPowerPlan.pow")
    powercfg -import "$TempPath\Files\BitsumPowerPlan.pow" 77777777-7777-7777-7777-777777777777 | Out-File $LogPath -Encoding UTF8 -Append
    powercfg -SETACTIVE "77777777-7777-7777-7777-777777777777"
    powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c # Remove High Performance Profile
    powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a # Remove Power Saver Profile
    powercfg -h off
    powercfg -change monitor-timeout-ac 15
    powercfg -change standby-timeout-ac 0

    # Windows Defender Exclusions
    Write-UserOutput "Aplicando Exclusiones A Windows Defender"
    $ActiveDrives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty "Root" | Where-Object {$_.Length -eq 3}
    $ActiveDrives | ForEach-Object {
        if (Test-Path ($_ + "Games")) {Add-MpPreference -ExclusionPath ($_ + "Games")}
    }
    Add-MpPreference -ExclusionPath "$env:ProgramFiles\Windows Defender"
    Add-MpPreference -ExclusionPath "$env:windir\security\database"
    Add-MpPreference -ExclusionPath "$env:windir\SoftwareDistribution\DataStore"
    Add-MpPreference -ExclusionPath "$env:temp\NVIDIA Corporation\NV_Cache"

    # Show File Extensions
    Write-UserOutput "Activando Extensiones De Archivos"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

    # File Association Fix
    $Download.DownloadFile("$GitHubPath/Files/.exe/SetUserFTA.exe", "$TempPath\Files\SetUserFTA.exe")
    Push-Location
    Set-Location ("$TempPath\Files")
    $DefaultBrowser = .\SetUserFTA.exe get | Select-String -Pattern 'https' |  ForEach-Object { $_.Line.Substring(7,$_.Line.Length - 7) }
    .\SetUserFTA.exe del .url
    .\SetUserFTA.exe .url InternetShortcut
    .\SetUserFTA.exe .iso Windows.IsoFile
    .\SetUserFTA.exe .mp3 $DefaultBrowser
    .\SetUserFTA.exe .ogg $DefaultBrowser
    .\SetUserFTA.exe .wav $DefaultBrowser
    .\SetUserFTA.exe .aac $DefaultBrowser
    .\SetUserFTA.exe .flac $DefaultBrowser
    Pop-Location
    
    # Open File Explorer In This PC Page
    Write-UserOutput "Estableciendo Abrir El Explorador En La Página `"Este Equipo`""
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    # Reduce svchost Process Amount
    Write-UserOutput "Reduciendo Los Procesos De Windows A La Mitad"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4294967295

    # Disable Mouse Acceleration
    Write-UserOutput "Desactivando Aceleración Del Raton"
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0

    # Disable Keyboard Layout Shortcut
    Write-UserOutput "Desactivando Cambio De Idioma Del Teclado"
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Hotkey" -Value 3
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Language Hotkey" -Value 3
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Layout Hotkey" -Value 3
    
    # Disable Error Reporting
    Write-UserOutput "Desactivando Informar De Errores"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null

    # 100% Wallpaper Quality
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Type DWord -Value 100
    
    # Network Optimizations
    Write-UserOutput "Optimizando Registros De Red"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Type DWord -Value 4294967295
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Type DWord -Value 0

    # Performance Optimizations
    Write-UserOutput "Optimizando Registros De Rendimiento"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 0
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
    Write-UserOutput "Optimizando Registros De Juegos"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Affinity" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Background Only" -Type String -Value "False"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Clock Rate" -Type DWord -Value 10000
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Type DWord -Value 8
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Type DWord -Value 6
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Type String -Value "High"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "SFIO Priority" -Type String -Value "High"
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Type DWord -Value 2

    # Edge Settings
    Write-UserOutput "Optimizando Edge"
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
    Disable-ScheduledTask -TaskName 'MicrosoftEdgeUpdateTaskMachineCore*' | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName 'MicrosoftEdgeUpdateTaskMachineUA*' | Out-File $LogPath -Encoding UTF8 -Append

    # Chrome Settings
    Write-UserOutput "Optimizando Chrome"
    New-Item -Path "HKLM:\SOFTWARE\Policies\Google" -Name "Chrome" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BackgroundModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "HardwareAccelerationModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "StartupBoostEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\gupdate" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\gupdatem" -Name "Start" -Type DWord -Value 4

    # Force 100% Monitor Scaling
    Write-UserOutput "Forzando 100% De Escala En Todos Los Monitores"
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "LogPixels" -Type DWord -Value 96
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Win8DpiScaling" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "AppliedDPI" -Type DWord -Value 96
    if (Test-Path "HKCU:\Control Panel\Desktop\PerMonitorSettings") {
        Remove-Item "HKCU:\Control Panel\Desktop\PerMonitorSettings" -Recurse -Force
    }

    # Disable VBS
    Write-UserOutput "Desactivando Aislamiento Del Nucleo"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -Type DWord -Value 0

    # Disable Background Apps
    Write-UserOutput "Desactivando Aplicaciones En Segundo Plano"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

    # Disable Power Throttling
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "PowerThrottling" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Type DWord -Value 1

    # Hide Keyboard Layout Icon
    Write-UserOutput "Ocultando El Botón De Idioma Del Teclado"
    Set-WinLanguageBarOption -UseLegacyLanguageBar
    New-Item -Path "HKCU:\Software\Microsoft\CTF\" -Name "LangBar" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ExtraIconsOnMinimized" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Label" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ShowStatus" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Transparency" -Type DWord -Value 255

    # Disable Telemetry
    Write-UserOutput "Deshabilitando Telemetría"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-File $LogPath -Encoding UTF8 -Append

    # Disable Aplication Sugestions
    Write-UserOutput "Deshabilitando Sugerencias De Aplicaciones"
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
    Write-UserOutput "Deshabilitando Historial De Actividad"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0

    # Disable Nearby Sharing
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "CdpSessionUserAuthzPolicy" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "RomeSdkChannelUserAuthzPolicy" -Type DWord -Value 0

    # Show TaskBar Only In Main Screen
    Write-UserOutput "Desactivando Mostrar Barra De Tareas En Todos Los Monitores"
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
    if (!(Test-Path -Path "C:\Intel")) {
        New-Item "C:\Intel" -ItemType Directory
    }
    (Get-Item "C:\Intel").Attributes = 'Hidden'

    # Stop Microsoft Store From Updating Apps Automatically
    Write-UserOutput "Desactivando Actualizaciones Automáticas De Microsoft Store"
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "WindowsStore"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "AutoDownload" -Type DWord -Value 2

    # Hide TaskBar View Button
    Write-UserOutput "Ocultando Botón Vista De Tareas"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

    # Hide Cortana Button
    Write-UserOutput "Ocultando Botón De Cortana"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0

    # Hide Meet Now Button
    Write-UserOutput "Ocultando Botón De Reunirse Ahora"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1

    # Hide Search Button
    Write-UserOutput "Ocultando Botón De Busqueda"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

    # Disable Widgets
    Write-UserOutput "Desactivando Widgets"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 0
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "Dsh"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Type DWord -Value 0

    # Disable Web Search
    Write-UserOutput "Desactivando Búsqueda En La Web Con Bing"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0

    # Hide Search Recomendations
    Write-UserOutput "Desactivando Recomendaciones De Búsqueda"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Type DWord -Value 0

    # Disable Microsoft Account In Windows Search
    Write-UserOutput "Desactivando Cuenta De Microsoft En Windows Search"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Type DWord -Value 0
    
    # Hide Chat Button
    Write-UserOutput "Ocultando Botón De Chats"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0

    # Set Dark Theme
    Write-UserOutput "Estableciendo Modo Oscuro"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0

    # Hide Recent Files And Folders In Explorer
    Write-UserOutput "Ocultando Archivos Y Carpetas Recientes De Acceso Rápido"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0

    # Clipboard History
    Write-UserOutput "Activando El Historial Del Portapapeles"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Type DWord -Value 1

    # Change Computer Name
    $PCName = $env:username.ToUpper() + "-PC"
    Write-UserOutput "Cambiando Nombre Del Equipo A $PCName"
    Rename-Computer -NewName $PCName

    # Set Private Network
    Write-UserOutput "Estableciendo Red Privada"
    Set-NetConnectionProfile -NetworkCategory Private

    # Show File Operations Details
    Write-UserOutput "Mostrando Detalles De Transferencias De Archivos"
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
    Write-UserOutput "Reduciendo El Tamaño De Los Iconos Del Escritorio"
    taskkill /f /im explorer.exe
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop" -Name "IconSize" -Type DWord -Value 32
    explorer.exe

    # Disable Feedback
    Write-UserOutput "Deshabilitando Feedback"
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-File $LogPath -Encoding UTF8 -Append
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-File $LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-File $LogPath -Encoding UTF8 -Append

    # Service Tweaks To Manual 
    Write-UserOutput "Deshabilitando Servicios"
    $Services = @(
        "ALG"                                       # Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
        "AJRouter"                                  # Needed for AllJoyn Router Service
        "BcastDVRUserService_48486de"               # GameDVR and Broadcast is used for Game Recordings and Live Broadcasts
        "Browser"                                   # Let users browse and locate shared resources in neighboring computers
        "diagnosticshub.standardcollector.service"  # Microsoft (R) Diagnostics Hub Standard Collector Service
        "DiagTrack"                                 # Diagnostics Tracking Service
        "dmwappushservice"                          # WAP Push Message Routing Service
        "DPS"                                       # Diagnostic Policy Service (Detects and Troubleshoots Potential Problems)
        "edgeupdate"                                # Edge Update Service
        "edgeupdatem"                               # Another Update Service
        "Fax"                                       # Fax Service
        "fhsvc"                                     # Fax History
        "FontCache"                                 # Windows font cache
        "gupdate"                                   # Google Update
        "gupdatem"                                  # Another Google Update Service
        "iphlpsvc"                                  # ipv6(Most websites use ipv4 instead)
        "lfsvc"                                     # Geolocation Service
        "lmhosts"                                   # TCP/IP NetBIOS Helper
        "MapsBroker"                                # Downloaded Maps Manager
        "MicrosoftEdgeElevationService"             # Another Edge Update Service
        "MSDTC"                                     # Distributed Transaction Coordinator
        "NahimicService"                            # Nahimic Service
        "NetTcpPortSharing"                         # Net.Tcp Port Sharing Service
        "PcaSvc"                                    # Program Compatibility Assistant Service
        "PerfHost"                                  # Remote users and 64-bit processes to query performance.
        "PhoneSvc"                                  # Phone Service(Manages the telephony state on the device)
        "RemoteAccess"                              # Routing and Remote Access
        "RemoteRegistry"                            # Remote Registry
        "RetailDemo"                                # Demo Mode for Store Display
        "RtkBtManServ"                              # Realtek Bluetooth Device Manager Service
        "SCardSvr"                                  # Windows Smart Card Service
        "seclogon"                                  # Secondary Logon (Disables other credentials only password will work)
        "SEMgrSvc"                                  # Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
        "SharedAccess"                              # Internet Connection Sharing (ICS)
        "Spooler"                                   # Printing
        "stisvc"                                    # Windows Image Acquisition (WIA)
        "SysMain"                                   # Analyses System Usage and Improves Performance
        "TrkWks"                                    # Distributed Link Tracking Client
        "WbioSrvc"                                  # Windows Biometric Service (required for Fingerprint reader / facial detection)
        "WerSvc"                                    # Windows error reporting
        "wisvc"                                     # Windows Insider program(Windows Insider will not work if Disabled)
        "WMPNetworkSvc"                             # Windows Media Player Network Sharing Service
        "WpcMonSvc"                                 # Parental Controls
        "WPDBusEnum"                                # Portable Device Enumerator Service
        "XblAuthManager"                            # Xbox Live Auth Manager (Disabling Breaks Xbox Live Games)
        "XblGameSave"                               # Xbox Live Game Save Service (Disabling Breaks Xbox Live Games)
        "XboxNetApiSvc"                             # Xbox Live Networking Service (Disabling Breaks Xbox Live Games)
        "XboxGipSvc"                                # Xbox Accessory Management Service
        "tzautoupdate"                              # Automatically sets the system time zone
        "PimIndexMaintenanceSvc"                    # Disable Contacts in search    
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
    $TB2.ForeColor = $AccentColor
    Write-UserOutput "Aplicando Cleaning Tweaks"

    # Uninstall Microsoft Bloatware
    Write-UserOutput "Desinstalando Microsoft Bloatware"
    $Bloatware = @(
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
    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat | Remove-AppxPackage
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
    Write-UserOutput "Instalando .NET Framework 3.5 y 4.8"
    Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -All -NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    Enable-WindowsOptionalFeature -Online -FeatureName NetFx4-AdvSrvs -All -NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Servidor OpenSSH"
    Get-WindowsPackage -Online | Where-Object PackageName -like *SSH* | Remove-WindowsPackage -Online -NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Rostro De Windows Hello"
    Get-WindowsPackage -Online | Where-Object PackageName -like *Hello-Face* | Remove-WindowsPackage -Online -NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Grabación De Acciones Del Usuario"
    DISM /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Modo De Internet Explorer"
    DISM /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando WordPad"
    DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Windows Powershell ISE"
    DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Reconocedor Matemático"
    DISM /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0 /NoRestart | Out-File $LogPath -Encoding UTF8 -Append
    $TB2.ForeColor = $DefaultForeColor
}

function NvidiaSettings {
    $TB3.ForeColor = $AccentColor
    Write-UserOutput "Aplicando Ajustes Al Panel De Control De Nvidia"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" -Name "EnableGR535" -Type DWord -Value 0
    $Download.DownloadFile("$GitHubPath/Files/.exe/ProfileInspector.exe", "$TempPath\Files\ProfileInspector.exe")
    $Download.DownloadFile("$GitHubPath/Files/NvidiaProfiles.nip", "$TempPath\Files\NvidiaProfiles.nip")
    & ("$TempPath\Files\ProfileInspector.exe") -SilentImport ("$TempPath\Files\NvidiaProfiles.nip")
    Set-ItemProperty -Path "HKCU:\Software\NVIDIA Corporation\NvTray" -Name "StartOnLogin" -Type DWord -Value 0
    Remove-Item -Path "C:\Windows\System32\drivers\NVIDIA Corporation" -Recurse -Force | Out-File $LogPath -Encoding UTF8 -Append
    Get-ChildItem -Path "C:\Windows\System32\DriverStore\FileRepository\" -Recurse | Where-Object {$_.Name -eq "NvTelemetry64.dll"} | Remove-Item -Force | Out-File $LogPath -Encoding UTF8 -Append
    $TB3.ForeColor = $DefaultForeColor
}

function ReduceIconsSpacing {
    $TB4.ForeColor = $AccentColor
    Write-UserOutput "Reduciendo Espacio Entre Iconos"
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "IconSpacing" -Value -900
    $TB4.ForeColor = $DefaultForeColor
}

function HideShortcutIcons {
    $TB5.ForeColor = $AccentColor
    Write-UserOutput "Ocultando Flechas De Acceso Directo"
    $Download.DownloadFile("$GitHubPath/Files/Blank.ico", "$TempPath\Files\Blank.ico")
    Unblock-File ("$TempPath\Files\Blank.ico")
    Copy-Item -Path ("$TempPath\Files\Blank.ico") -Destination "C:\Windows\System32" -Force
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCR:\IE.AssocFile.URL" -Name "IsShortcut" -Value ""
    Set-ItemProperty -Path "HKCR:\InternetShortcut" -Name "IsShortcut" -Value ""
    Set-ItemProperty -Path "HKCR:\lnkfile" -Name "IsShortcut" -Value ""
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "Shell Icons" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" -Name "29" -Value "%windir%\System32\Blank.ico"
    $TB5.ForeColor = $DefaultForeColor
}

function SetFluentCursor {
    $TB6.ForeColor = $AccentColor
    Write-UserOutput "Estableciendo Cursor Personalizado"
    $Download.DownloadFile("$GitHubPath/Files/.zip/FluentCursor.zip", "$TempPath\Files\FluentCursor.zip")
    Expand-Archive -Path ("$TempPath\Files\FluentCursor.zip") -DestinationPath 'C:\Windows\Cursors\Fluent Cursor' -Force
    $Download.DownloadFile("$GitHubPath/Files/FluentCursor.reg", "$TempPath\Files\FluentCursor.reg")
    regedit /s $TempPath\Files\FluentCursor.reg
    $TB6.ForeColor = $DefaultForeColor
}

function DisableCortana {
    $TB7.ForeColor = $AccentColor
    Write-UserOutput "Deshabilitando Cortana"
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

function RemoveOneDrive {
    $TB8.ForeColor = $AccentColor
    Write-UserOutput "Desinstalando Xbox Game Bar"
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
    Get-AppxPackage Microsoft.OneDriveSync | Remove-AppxPackage
    $TB8.ForeColor = $DefaultForeColor
}

function RemoveXboxGameBar {
    $TB9.ForeColor = $AccentColor
    Write-UserOutput "Desinstalando Xbox Game Bar"
    Get-AppxPackage "Microsoft.XboxGamingOverlay" | Remove-AppxPackage 
    Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage 
    Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage 
    Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage
    Get-AppxPackage "Microsoft.GamingApp" | Remove-AppxPackage
    Get-AppxPackage "Microsoft.GamingServices" | Remove-AppxPackage
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
    $TB9.ForeColor = $DefaultForeColor
}

function TweaksInContextMenu {
    $TB10.ForeColor = $AccentColor
    Write-UserOutput "Activando Tweaks En Context Menu"
    
    # Enable App Submenu
    $Download.DownloadFile("$GitHubPath/Files/.zip/ContextMenuTweaks.zip", "$TempPath\Files\ContextMenuTweaks.zip")
    Expand-Archive -Path ("$TempPath\Files\ContextMenuTweaks.zip") -DestinationPath ("$ZKToolPath\Apps") -Force
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Subcommands" -Value ""
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "shell" | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "01App" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "Icon" -Value "$ZKToolPath\ZKTool.exe,0"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "MUIVerb" -Value "App"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "command" | Out-Null
            Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\01App\command" -Name "(default)" -Value "$ZKToolPath\ZKTool.exe"

    # LogitechOMM
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "02LogitechOMM" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "Icon" -Value "$ZKToolPath\Apps\LogitechOMM.exe,0"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "MUIVerb" -Value "Logitech OMM"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM\command" -Name "(default)" -Value "$ZKToolPath\Apps\LogitechOMM.exe"
    
    # SteamBlock
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "03SteamBlock" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03SteamBlock" -Name "Icon" -Value "C:\Program Files (x86)\Steam\steam.exe,0"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03SteamBlock" -Name "MUIVerb" -Value "Disable Steam"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03SteamBlock" -Name "command" | Out-Null
            Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\03SteamBlock\command" -Name "(default)" -Value "$ZKToolPath\Apps\BlockSteam.exe"
    
    # Clean Standby List Memory
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "04EmptyStandbyList" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04EmptyStandbyList" -Name "Icon" -Value "SHELL32.dll,12"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04EmptyStandbyList" -Name "MUIVerb" -Value "Clear RAM"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04EmptyStandbyList" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04EmptyStandbyList\command" -Name "(default)" -Value "$ZKToolPath\Apps\EmptyStandbyList.exe"

    # Clean Files
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "05CleanFiles" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05CleanFiles" -Name "Icon" -Value "SHELL32.dll,32"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05CleanFiles" -Name "MUIVerb" -Value "Clean Files"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05CleanFiles" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05CleanFiles\command" -Name "(default)" -Value "$ZKToolPath\Apps\CleanFiles.exe"

    # Bufferbloat
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "99BufferbloatFix" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\99BufferbloatFix" -Name "Icon" -Value "inetcpl.cpl,21"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\99BufferbloatFix" -Name "MUIVerb" -Value "Bufferbloat Fix Disabled"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\99BufferbloatFix" -Name "command" | Out-Null
            Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\99BufferbloatFix\command" -Name "(default)" -Value "$ZKToolPath\Apps\Bufferbloat.exe"
    $TB10.ForeColor = $DefaultForeColor
}

function VisualFXFix {
    $TB11.ForeColor = $AccentColor
    Write-UserOutput "Ajustando Animaciones De Windows"
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

function ActivateWindowsPro {
    $MTB1.ForeColor = $AccentColorBig
    Write-UserOutput "Activando Windows Pro"
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /skms kms.digiboy.ir
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ato
    $MTB1.ForeColor = $DefaultForeColorBig
}

function EnableMSIMode {
    $MTB3.ForeColor = $AccentColor
    Write-UserOutput "Estableciendo GPU En Modo MSI"
    $GPUID = (Get-PnpDevice -Class Display).InstanceId
    $GPUName = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID" -Name "DeviceDesc"
    
    if (($GPUName -like "*GTX*") -or ($GPUName -like "*RTX*")) {
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID\Device Parameters\Interrupt Management" -Name "MessageSignaledInterruptProperties" | Out-File $LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" -Name "MSISupported" -Type DWord -Value 1
    }
    $MTB3.ForeColor = $DefaultForeColor
}

function FFMPEG {
    $MTB4.ForeColor = $AccentColor
    Write-UserOutput "Instalando FFMPEG"
    $Download.DownloadFile("$GitHubPath/Files/.appx/HEVC.appx", "$TempPath\Files\HEVC.appx")
    $Download.DownloadFile("$GitHubPath/Files/.appx/HEIF.appx", "$TempPath\Files\HEIF.appx")
    Add-AppxPackage ("$TempPath\Files\HEVC.appx"); Add-AppxPackage ("$TempPath\Files\HEIF.appx")
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Gyan.FFmpeg | Out-File $LogPath -Encoding UTF8 -Append
    $Download.DownloadFile("$GitHubPath/Files/.exe/Compress.exe", "$ZKToolPath\Apps\Compress.exe")
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\" -Name "Compress" | Out-Null
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "Icon" -Value "$ZKToolPath\Apps\Compress.exe,0"
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "Position" -Value "Bottom"
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\command\" -Name "(default)" -Value 'cmd.exe /c echo | set /p = %1| clip | exit && "C:\Program Files\ZKTool\Apps\Compress.exe"'
    $Download.DownloadFile("$GitHubPath/Files/.exe/Trim.exe", "$ZKToolPath\Apps\Trim.exe")
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\" -Name "Trim" | Out-Null
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Trim\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Trim\" -Name "Icon" -Value "$ZKToolPath\Apps\Trim.exe,0"
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Trim\" -Name "Position" -Value "Bottom"
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Trim\command\" -Name "(default)" -Value 'cmd.exe /c echo | set /p = %1| clip | exit && "C:\Program Files\ZKTool\Apps\Trim.exe"'
    $MTB4.ForeColor = $DefaultForeColor
}

function WindowsTerminalFix {
    $MTB5.ForeColor = $AccentColor
    Write-UserOutput "Aplicando Ajustes A Windows Terminal"
    $PWSH = 'Microsoft.Powershell'
    if (!($PWSH -eq (Winget list $PWSH | Select-String -Pattern $PWSH | ForEach-Object {$_.Matches} | Select-Object -ExpandProperty Value))) {
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.PowerShell  | Out-File $LogPath -Encoding UTF8 -Append
    }
    $Download.DownloadFile("$GitHubPath/Files/.zip/WindowsTerminalSettings.zip", "$TempPath\Files\WindowsTerminalSettings.zip")
    Remove-Item -Path $env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Force
    Expand-Archive -Path ("$TempPath\Files\WindowsTerminalSettings.zip") -DestinationPath $env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force
    $MTB5.ForeColor = $DefaultForeColor
}

function AdobeCleaner {
    $MTB15.ForeColor = $AccentColor
    Write-UserOutput "Eliminando Procesos De Adobe"
    Rename-Item -Path "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exe" "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exeX"
    Rename-Item -Path "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exeX"
    Rename-Item -Path "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe" "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exeX"
    Rename-Item -Path "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exe" "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exeX"
    $MTB15.ForeColor = $DefaultForeColor
}

function AMDUndervoltPack {
    $MTB16.ForeColor = $AccentColor
    Write-UserOutput "Descargando AMD Undervolt Pack"
    $Download.DownloadFile("$GitHubPath/Files/.zip/AMDUndervoltPack.zip", "$TempPath\Files\AMDUndervoltPack.zip")
    Expand-Archive -Path ("$TempPath\Files\AMDUndervoltPack.zip") -DestinationPath ("$TempPath\Files\AMD Undervolt Pack") -Force
    Move-Item -Path ("$TempPath\Files\AMD Undervolt Pack\AMD Undervolt") -Destination 'C:\Program Files\'
    $DesktopPath = (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Desktop") + "\AMD Undervolt"
    New-Item -Path $DesktopPath -ItemType Directory -Force | Out-Null
    Move-Item -Path ("$TempPath\Files\AMD Undervolt Pack\CPU Undervolt.lnk") -Destination $DesktopPath
    Move-Item -Path ("$TempPath\Files\AMD Undervolt Pack\Prime95") -Destination $DesktopPath
    Move-Item -Path ("$TempPath\Files\AMD Undervolt Pack\CPUZ.exe") -Destination $DesktopPath
    Move-Item -Path ("$TempPath\Files\AMD Undervolt Pack\PBO2 Tuner.lnk") -Destination "$env:appdata\Microsoft\Windows\Start Menu\Programs"
    $MTB16.ForeColor = $DefaultForeColor
}

function DarkTheme {
    $HB7.ForeColor = $AccentColor

    Write-UserOutput "Aplicando Tema Oscuro"

    taskkill /f /im explorer.exe

    $Download.DownloadFile("$GitHubPath/Files/.zip/Media.zip", "$TempPath\Files\Media.zip")
    Expand-Archive -Path ("$TempPath\Files\Media.zip") -DestinationPath ("$ZKToolPath\Media") -Force

    $Download.DownloadFile("$GitHubPath/Functions/Set-Wallpaper.ps1", "$TempPath\Functions\Set-Wallpaper.ps1")
    . "$TempPath\Functions\Set-Wallpaper.ps1"
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion" -Name "PersonalizationCSP" | Out-File $LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value "$ZKToolPath\Media\BlackW11Wallpaper.jpg"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value "$ZKToolPath\Media\BlackW11Wallpaper.jpg"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Type DWord -Value 1
    Set-Wallpaper -Path "$ZKToolPath\Media\BlackW11Wallpaper.jpg"

    # Accent Color
    $MainColor    = "FF,FF,FF,00," # Main Color
    $SecondColor  = "AC,A0,F7,00," # Second Color
    $TaskManagerH = "AA,00,55,00," # Task Manager High Usage Color
    $TaskManagerT = "A5,A5,A5,00," # Task Manager Tiles Color
    $Color1       = "FF,00,00,00,"
    $Color2       = "FF,00,00,00"
    $MaskValue = $SecondColor + $MainColor + $MainColor + $SecondColor + $TaskManagerH + $TaskManagerT + $Color1 + $Color2
    $MaskValueToHex = $MaskValue.Split(',') | ForEach-Object { "0x$_"}
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette" -Type Binary -Value ([byte[]]$MaskValueToHex)

    # HighLight Color
    $SecondColorRGB = "172 160 247"
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "Hilight" -Value $SecondColorRGB
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "HotTrackingColor" -Value $SecondColorRGB
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "MenuHilight" -Value $SecondColorRGB

    # Black Edge
    $ShortcutPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"
    $IconLocation = "$ZKToolPath\Media\BlackEdge.ico"
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()
    Copy-Item -Path $IconLocation -Destination "$env:userprofile\AppData\Local\Microsoft\Edge\User Data\Default\Edge Profile.ico" -Force

    # Black Explorer
    $ShortcutPath = "$env:appdata\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
    $IconLocation = "$ZKToolPath\Media\BlackExplorer.ico"
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    # Black Spotify
    $ShortcutPath = "$env:appdata\Microsoft\Windows\Start Menu\Programs\Spotify.lnk"
    $IconLocation = "$ZKToolPath\Media\BlackSpotify.ico"
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    # Black Discord
    $ShortcutPath = "$env:appdata\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"
    $IconLocation = "$ZKToolPath\Media\BlackDiscord.ico"
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    explorer.exe
    
    $HB7.ForeColor = $DefaultForeColor
}

function NVCleanstall {
    $MTB14.ForeColor = $AccentColor
    $Download.DownloadFile("$GitHubPath/Files/NVCleanstall.ps1", "$TempPath\Files\NVCleanstall.ps1")
    Start-Process powershell -ArgumentList "-noexit -command powershell.exe -ExecutionPolicy Bypass $env:temp\ZKTool\Files\NVCleanstall.ps1 ; exit"
    $MTB14.ForeColor = $DefaultForeColor
}

function RemoveRealtek {
    $MTB11.ForeColor = $AccentColor
    Write-UserOutput "Quitando Realtek Audio Service"
    pwsh -command {sc stop Audiosrv} | Out-File $LogPath -Encoding UTF8 -Append
    pwsh -command {sc stop RtkAudioUniversalService} | Out-File $LogPath -Encoding UTF8 -Append
    taskkill.exe /f /im RtkAudUService64.exe | Out-File $LogPath -Encoding UTF8 -Append
    pwsh -command {sc delete RtkAudioUniversalService} | Out-File $LogPath -Encoding UTF8 -Append
    pwsh -command {sc start Audiosrv} | Out-File $LogPath -Encoding UTF8 -Append
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "RtkAudUService"
    Get-AppxPackage -All "RealtekSemiconductorCorp.RealtekAudioControl" | Remove-AppxPackage
    $MTB11.ForeColor = $DefaultForeColor
}

function Z390LanDrivers {
    $HB6.ForeColor = $AccentColor
    Write-UserOutput "Instalando Z390 Lan Drivers"
    $Download.DownloadFile("$GitHubPath/Files/.zip/LanDrivers.zip", "$TempPath\Files\LanDrivers.zip")
    Expand-Archive -Path ("$TempPath\Files\LanDrivers.zip") -DestinationPath ("$TempPath\Files\LanDrivers") -Force
    pnputil /add-driver ("$TempPath\Files\LanDrivers\e1d68x64.inf") /install
    $OldDriver = Get-WMIObject win32_PnPSignedDriver | Where-Object DeviceName -eq "Intel(R) Ethernet Connection (7) I219-V" | Select-Object -ExpandProperty InfName
    pnputil /delete-driver $OldDriver /uninstall /force
    $HB6.ForeColor = $DefaultForeColor
}

$StartScript.Add_MouseEnter({
    $StartScript.BackgroundImage = [System.Drawing.Image]::FromFile(("$ImagesFolder\HoverSSButtonColor.png"))
})

$StartScript.Add_MouseLeave({
    $StartScript.BackgroundImage = $SSNone
})

$StartScript.Add_Click({
    $StartScript.BackgroundImage = [System.Drawing.Image]::FromFile(("$ImagesFolder\SSProcessing.png"))
    $StartScript.ForeColor = "Black"
    Write-UserOutput "Iniciando Script"

    $AllButtons = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB8,$SB9,$SB10,$SB11,$SB12,$MSB1,$MSB2,$MSB3,$MSB4,$MSB5,$MSB6,$MSB7,$MSB8,$MSB9,$MSB10,$MSB11,$MSB12,$MSB13,$MSB14,$MSB15,$MSB16,
    $MSB17,$LB1,$LB2,$LB3,$LB4,$LB5,$LB6,$LB7,$LB8,$TB1,$TB2,$TB3,$TB4,$TB5,$TB6,$TB7,$TB8,$TB9,$TB10,$TB11,$MTB1,$MTB2,$MTB3,$MTB4,$MTB5,$MTB6,$MTB7,$MTB8,$MTB9,$MTB10,$MTB11,$MTB12,
    $MTB13,$MTB14,$MTB15,$MTB16,$HB1,$HB2,$HB3,$HB4,$HB5,$HB6,$HB7,$HB8,$HB9)

    $AppsToInstall   = @()
    $FormsToInvoke   = @()
    $FunctionsToRun  = @()

    foreach ($Button in $AllButtons) {
        if (($Button.BackgroundImage -eq $ActiveButtonColor) -or ($Button.BackgroundImage -eq $ActiveButtonColorBig)) {

            $ButtonName = $Button.Text -replace " ",""

            if (($AppsList.$ButtonName.Source -eq "Winget") -or ($AppsList.$ButtonName.Source -eq ".exe") -or ($AppsList.$ButtonName.Source -eq ".appx")) { # Checking App
                $AppsToInstall += $ButtonName
            }
            elseif($FormsList.psobject.properties.name | ForEach-Object {if($ButtonName -eq $_){$true}}) { # Checking Form
                $FormsToInvoke += $ButtonName
            }
            else { # Checking Functions
                $FunctionsToRun += $ButtonName
            }
        }
    }

    Install-App -Apps $AppsToInstall
    foreach ($Function in $FunctionsToRun) {& $Function}
    Invoke-Form -Forms $FormsToInvoke

    foreach ($Button in $AllButtons) {
        if ($Button.BackgroundImage -eq $ActiveButtonColor) {
            $Button.BackgroundImage = $DefaultButtonColor
            $Button.ForeColor = $AccentColor
        }
        elseif ($Button.BackgroundImage -eq $ActiveButtonColorBig) {
            $Button.BackgroundImage = $DefaultButtonColorBig
            $Button.ForeColor = $AccentColor
        }
    }

    # Checking Installed Apps With Winget
    $Installations = @($SB1,$SB2,$SB3,$SB4,$SB5,$SB6,$SB7,$SB11,$SB12,$MSB1,$MSB5,$MSB6,$MSB9,$MSB10,$MSB11,$MSB12,$LB1,$LB2,$LB3,$LB5,$LB7,$LB8)
    $InstallationsSelected = @()

    foreach ($Installation in $Installations) {
        if ($Installation.ForeColor -eq $AccentColor) {
            $InstallationsSelected += $Installation
        }
    }

    $i = 1
    foreach ($Installation in $InstallationsSelected) {
            Write-UserOutput -Message "Comprobando Instalaciones" -Progress ("$i de " + $InstallationsSelected.Count) -DisableType
            $WingetListCheck = Winget List $Installation.Text | Select-String -Pattern $Installation.Text | ForEach-Object {$_.matches} | Select-Object -ExpandProperty Value
            if (!($WingetListCheck -eq $Installation.Text)) {
                $Installation.ForeColor = "Red"
            }
            $i++
    }

    if ($MSB8.ForeColor -eq $AccentColor) {
        Remove-Item -Path .\rufus.com -Force
    }

    # Checking Restart
    if ($TB1.ForeColor -eq $AccentColor) {
        $StatusBox.Text = "| Reinicio Necesario"
        $MessageBox = [System.Windows.Forms.MessageBox]::Show("El equipo requiere reiniciarse para aplicar los cambios`r`nReiniciar equipo ahora?", "Reiniciar equipo", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information)
        if ($MessageBox -ne [System.Windows.Forms.DialogResult]::No) {
            Write-UserOutput "Reiniciando El Equipo En 5 Segundos"
            4..1 | ForEach-Object {
                $StatusBox.Text = "| Reiniciando El Equipo En $_ Segundos..."
                Start-Sleep 1
            }
            Remove-Item -Path "$env:temp\ZKTool" -Recurse -Force
            Restart-Computer
        }
    }

    $StartScript.BackgroundImage = [System.Drawing.Image]::FromFile("$ImagesFolder\SSDefault.png")
    $StartScript.ForeColor = $AccentColor
    $StatusBox.Text = "| Script Finalizado"
})

$Form.Add_Closing({
    Start-Process Powershell -WindowStyle Hidden {
        Start-Sleep 2
        Remove-Item -Path "$env:temp\ZKTool" -Recurse -Force
    }
})

[void]$Form.ShowDialog()