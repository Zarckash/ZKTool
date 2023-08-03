Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

# Run Script As Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Move User Folder"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $False
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

# Title Label
$TitleLabel                      = New-Object System.Windows.Forms.Label
$TitleLabel.Text                 = "M O V E    U S E R    FOLDER"
$TitleLabel.Width                = 550
$TitleLabel.Height               = 38
$TitleLabel.Location             = New-Object System.Drawing.Point(5,5)
$TitleLabel.Font                 = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$TitleLabel.ForeColor            = $LabelColor
$TitleLabel.TextAlign            = [System.Drawing.ContentAlignment]::MiddleCenter
$TitleLabel.BackgroundImage      = [System.Drawing.Image]::FromFile(($ImageFolder + "LabelMUFBg.png"))
$Form.Controls.Add($TitleLabel)

$CheckBoxes = @('SelectAll','Desktop','Downloads','Documents','Pictures','Videos','Music')

foreach ($CheckBox in $CheckBoxes) {
    Get-Variable -Name $CheckBox | Remove-Variable
}

$CheckBoxes | ForEach-Object {
    $NewCheckBox = New-Object System.Windows.Forms.CheckBox
    $NewCheckBox.Width = 105
    $NewCheckBox.Height = 25
    $NewCheckBox.Font = New-Object System.Drawing.Font('Segoe UI',13)
    $Form.Controls.Add($NewCheckBox)
    New-Variable "$_" $NewCheckBox
}

$SelectAll.Text = 'Todo'
$Desktop.Text = 'Escritorio'
$Downloads.Text = 'Descargas'
$Documents.Text = 'Documentos'
$Pictures.Text = 'Imágenes'
$Videos.Text = 'Vídeos'
$Music.Text = 'Música'

$CheckBoxes = @($SelectAll,$Desktop,$Downloads,$Documents,$Pictures)

$Position = 10
foreach ($CheckBox in $CheckBoxes) {
    $CheckBox.Location = New-Object System.Drawing.Point($Position,50)
    $Position += 105
}
$Documents.Width = 130
$Pictures.Width = 101
$Pictures.Location = New-Object System.Drawing.Point(455,50)

$Position = 10
$CheckBoxes = @($Videos,$Music)
foreach ($CheckBox in $CheckBoxes) {
    $CheckBox.Location = New-Object System.Drawing.Point($Position,77)
    $Position += 105
}

$Drives = @(Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty "Root" | Where-Object {$_.Length -eq 3} | ForEach-Object {$_.Substring(0,1)})

foreach ($Drive in $Drives) {
    Get-Variable -Name $Drive | Remove-Variable
}

$Position = 10
$Drives | ForEach-Object {
    $NewRadioButton = New-Object System.Windows.Forms.RadioButton
    $NewRadioButton.Text = ("Disco $_" + ":")
    $NewRadioButton.Width = 105
    $NewRadioButton.Height = 25
    $NewRadioButton.Font = New-Object System.Drawing.Font('Segoe UI',13)
    $NewRadioButton.Location = New-Object System.Drawing.Point($Position,120)
    $Position += 105
    $Form.Controls.Add($NewRadioButton)
    New-Variable "$_" $NewRadioButton
}

# Buttons Panel
$ButtonsPanel                    = New-Object System.Windows.Forms.Panel
$ButtonsPanel.height             = 45
$ButtonsPanel.width              = 255 - 2
$ButtonsPanel.location           = New-Object System.Drawing.Point(153,155)
$Form.Controls.Add($ButtonsPanel)

# Cancel Button
$Cancel                          = New-Object System.Windows.Forms.Button
$Cancel.text                     = "Cancelar"
$Cancel.width                    = 117
$Cancel.height                   = 35
$Cancel.location                 = New-Object System.Drawing.Point(5,5)
$Cancel.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "CancelAcceptButton.png"))
$ButtonsPanel.Controls.Add($Cancel)

# Accept Button
$Accept                          = New-Object System.Windows.Forms.Button
$Accept.text                     = "Aceptar"
$Accept.width                    = 117
$Accept.height                   = 35
$Accept.location                 = New-Object System.Drawing.Point(128,5)
$Accept.BackgroundImage          = [System.Drawing.Image]::FromFile(($ImageFolder + "CancelAcceptButton.png"))
$Accept.ForeColor                = $LabelColor
$ButtonsPanel.Controls.Add($Accept)

$Buttons = @($Cancel,$Accept)
foreach ($Button in $Buttons) {
    $Button.Font                 = New-Object System.Drawing.Font('Segoe UI',13)
    $Button.FlatStyle            = "Flat"
    $Button.FlatAppearance.BorderSize = 0
    $Button.FlatAppearance.MouseOverBackColor = $PanelBackColor
    $Button.FlatAppearance.MouseDownBackColor = $PanelBackColor
    $Button.BackColor = $PanelBackColor
    $Button.Image = $DefaultButtonColor

    $Button.Add_MouseEnter({
        $this.Image = [System.Drawing.Image]::FromFile(($ImageFolder + "HoverCancelAcceptButton.png"))
    })

    $Button.Add_MouseLeave({
        $this.Image = $None
    })
}

$CheckBoxes = @($Desktop,$Downloads,$Documents,$Pictures,$Videos,$Music)
$SelectAll.Add_Click({
    if ($SelectAll.Checked -eq $True) {
        foreach ($CheckBox in $CheckBoxes) {
            $CheckBox.Checked = $True
        }
    } else {
        foreach ($CheckBox in $CheckBoxes) {
            $CheckBox.Checked = $False
        }
    }
})

function SetKnownFolderPath {
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Desktop','Downloads','Documents','Pictures','Videos','Music')]
        [string]$KnownFolder,
            
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    
    # Define known folder GUIDs
    $KnownFolders = @{
        'Desktop'   = 'B4BFCC3A-DB2C-424C-B029-7FE99A87C641';
        'Downloads' = '374DE290-123F-4565-9164-39C4925E467B';
        'Documents' = 'FDD39AD0-238F-46AF-ADB4-6C85480369C7';
        'Pictures'  = '33E28130-4E1E-4676-835A-98395C3BC3BB';
        'Videos'    = '18989B1D-99B5-455B-841C-AB7C74E4DDFC';
        'Music'     = '4BD8D571-6D19-48D3-BE97-422220080E43';
    }
    
    # Define SHSetKnownFolderPath if it hasn't been defined already
    $Type1 = ([System.Management.Automation.PSTypeName]'KnownFolders').Type
    if (-not $Type1) {
        $Signature1 = @'
        [DllImport("shell32.dll")]
        public extern static int SHSetKnownFolderPath(ref Guid folderId, uint flags, IntPtr token, [MarshalAs(UnmanagedType.LPWStr)] string path); 
'@

        $Type1 = Add-Type -MemberDefinition $Signature1 -Name 'KnownFolders' -Namespace 'SHSetKnownFolderPath' -PassThru
    }

    $Type2 = ([System.Management.Automation.PSTypeName]'ChangeNotify').Type
    if (-not $Type2) {
        $Signature2 = @'
        [DllImport("Shell32.dll")]
        public static extern int SHChangeNotify(int eventId, int flags, IntPtr item1, IntPtr item2);
'@
        $Type2 = Add-Type -MemberDefinition $Signature2 -Name 'ChangeNotify' -Namespace 'SHChangeNotify' -PassThru
    }
    
    # Validate the path
    if (!(Test-Path $Path -PathType Container)) {
        New-Item -Path $Path -Type Directory -Force
    }

    # Call SHSetKnownFolderPath
    $Type1::SHSetKnownFolderPath([ref]$KnownFolders[$KnownFolder], 0, 0, $Path)
    attrib +r $Path
    $Type2::SHChangeNotify(0x8000000, 0x1000, 0, 0)

    $Leaf = Split-Path -Path "$Path" -Leaf
    Move-Item "$HOME\$Leaf\*" $Path
    Remove-Item $HOME\$Leaf -Recurse -Force
}

# Cancel Button
$Cancel.Add_Click({
    $Form.Close()
})

# Accept Button
$Accept.Add_Click({
    $Accept.BackColor = $ProcessingColor
    $StatusBox.Text = "| Moviendo Carpetas De Usuario..."

    $DrivesVariables = @()
    $CheckBoxes      = @($Desktop,$Downloads,$Documents,$Pictures,$Videos,$Music)
    $CheckBoxNames   = @('Desktop','Downloads','Documents','Pictures','Videos','Music')

    $Drives | ForEach-Object {$DrivesVariables += ("$" + $_)}

    foreach ($Disk in $DrivesVariables) {
        foreach ($Drive in $Drives) {
            if ($Disk.Checked -ne $True) {
                $SelectedDisk = $Drive
            }
        }
    }

    $i = 0
    foreach ($CheckBox in $CheckBoxes) {
        if ($CheckBox.Checked -eq $True) {
            $Path = "$SelectedDisk" + ":\Users\$env:username\" + $CheckBoxNames[$i]
            SetKnownFolderPath -KnownFolder $CheckBoxNames[$i] -Path $Path
        }
        $i++
    }

    Start-Sleep 1
    $Form.Close()
})

$Form.Add_Closing({
    $MTB10.Image = $DefaultButtonColor
    $MTB10.ForeColor = $LabelColor
})

[void]$Form.ShowDialog()