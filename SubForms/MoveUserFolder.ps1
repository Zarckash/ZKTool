Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$FormSize = "555,202"

$Form                            = New-Object System.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050, 700)
$Form.Text                       = "Move User Folder"
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
$FormPanel.BackgroundImage       = [System.Drawing.Image]::FromFile("$ImagesFolder\MoveUserFolderBg.png")
$Form.Controls.Add($FormPanel)

$FormClosePanel                  = New-Object System.Windows.Forms.Panel
$FormClosePanel.Size             = "109,37"
$FormClosePanel.Location         = "612,0"
$FormClosePanel.BackgroundImage  = [System.Drawing.Image]::FromFile("$ImagesFolder\FormClosePanelBg.png")

$FormPanel.Controls.Add($FormClosePanel)

$CloseFormPanel                  = New-Object System.Windows.Forms.Panel
$CloseFormPanel.Size             = "109,37"
$CloseFormPanel.Location         = "446,0"
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

# Title Label
$TitleLabel                      = New-Object System.Windows.Forms.Label
$TitleLabel.Text                 = "M O V E    U S E R    FOLDER"
$TitleLabel.Size                 = "500,36"
$TitleLabel.Location             = "31,1"
$TitleLabel.Font                 = New-Object System.Drawing.Font('Segoe UI Semibold',15)
$TitleLabel.ForeColor            = $AccentColor
$TitleLabel.BackColor            = $PanelBackColor
$TitleLabel.TextAlign            = [System.Drawing.ContentAlignment]::MiddleCenter
$FormPanel.Controls.Add($TitleLabel)

Move-Form -SelectedLabel $TitleLabel

$CheckBoxes = @('SelectAll','Desktop','Downloads','Documents','Pictures','Videos','Music')

foreach ($CheckBox in $CheckBoxes) {
    Get-Variable -Name $CheckBox | Remove-Variable
}

$CheckBoxes | ForEach-Object {
    $NewCheckBox = New-Object System.Windows.Forms.CheckBox
    $NewCheckBox.Width = 105
    $NewCheckBox.Height = 25
    $NewCheckBox.Font = New-Object System.Drawing.Font('Segoe UI',13)
    $NewCheckBox.BackColor = $FormBackColor
    $FormPanel.Controls.Add($NewCheckBox)
    New-Variable "$_" $NewCheckBox
}

$SelectAll.Text  = 'Todo'
$Desktop.Text    = 'Escritorio'
$Downloads.Text  = 'Descargas'
$Documents.Text  = 'Documentos'
$Pictures.Text   = 'Imágenes'
$Videos.Text     = 'Vídeos'
$Music.Text      = 'Música'

$CheckBoxes = @($SelectAll,$Desktop,$Downloads,$Documents,$Pictures)

$Position = 7
foreach ($CheckBox in $CheckBoxes) {
    $CheckBox.Location = New-Object System.Drawing.Point($Position,50)
    $Position += 105
}
$Documents.Width = 130
$Pictures.Width = 101
$Pictures.Location = New-Object System.Drawing.Point(453,50)

$Position = 7
$CheckBoxes = @($Videos,$Music)
foreach ($CheckBox in $CheckBoxes) {
    $CheckBox.Location = New-Object System.Drawing.Point($Position,77)
    $Position += 105
}

$Drives = @(Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty "Root" | Where-Object {$_.Length -eq 3} | ForEach-Object {$_.Substring(0,1)})

foreach ($Drive in $Drives) {
    Get-Variable -Name $Drive | Remove-Variable
}


$Disks = @('Disk1','Disk2','Disk3','Disk4','Disk5')

foreach ($Disk in $Disks) {
    Get-Variable -Name $Disk | Remove-Variable
}

$Position = 7
$i = 1
$Drives | ForEach-Object {
    $NewRadioButton = New-Object System.Windows.Forms.RadioButton
    $NewRadioButton.Text = ("Disco $_" + ":")
    $NewRadioButton.Width = 105
    $NewRadioButton.Height = 25
    $NewRadioButton.Font = New-Object System.Drawing.Font('Segoe UI',13)
    $NewRadioButton.Location = New-Object System.Drawing.Point($Position,118)
    $NewRadioButton.BackColor = $FormBackColor
    $Position += 105
    $FormPanel.Controls.Add($NewRadioButton)
    New-Variable "Disk$i" $NewRadioButton
    $i++
}

# Buttons Panel
$ButtonsPanel                    = New-Object System.Windows.Forms.Panel
$ButtonsPanel.height             = 45
$ButtonsPanel.width              = 255 - 2
$ButtonsPanel.location           = New-Object System.Drawing.Point(153,154)
$ButtonsPanel.BackColor          = $PanelBackColor
$FormPanel.Controls.Add($ButtonsPanel)

# Cancel Button
$Cancel                          = New-Object System.Windows.Forms.Button
$Cancel.text                     = "Cancelar"
$Cancel.width                    = 117
$Cancel.height                   = 35
$Cancel.location                 = New-Object System.Drawing.Point(5,5)
$Cancel.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\CancelAcceptButton.png")
$ButtonsPanel.Controls.Add($Cancel)

# Accept Button
$Accept                          = New-Object System.Windows.Forms.Button
$Accept.text                     = "Aceptar"
$Accept.width                    = 117
$Accept.height                   = 35
$Accept.location                 = New-Object System.Drawing.Point(128,5)
$Accept.BackgroundImage          = [System.Drawing.Image]::FromFile("$ImagesFolder\CancelAcceptButton.png")
$Accept.ForeColor                = $AccentColor
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
        $this.Image = [System.Drawing.Image]::FromFile("$ImagesFolder\HoverCancelAcceptButton.png")
    })

    $Button.Add_MouseLeave({
        $this.Image = $None
    })
}

$CheckBoxes = @($Desktop,$Downloads,$Documents,$Pictures,$Videos,$Music)
$SelectAll.Add_Click({
    if ($SelectAll.Checked -eq $true) {
        foreach ($CheckBox in $CheckBoxes) {
            $CheckBox.Checked = $true
        }
    } else {
        foreach ($CheckBox in $CheckBoxes) {
            $CheckBox.Checked = $false
        }
    }
})

function Set-KnownFolderPath {
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

    $DrivesVariables = @($Disk1,$Disk2,$Disk3,$Disk4,$Disk5)
    $CheckBoxes      = @($Desktop,$Downloads,$Documents,$Pictures,$Videos,$Music)
    $CheckBoxNames   = @('Desktop','Downloads','Documents','Pictures','Videos','Music')

    $i = 0
    foreach ($Disk in $DrivesVariables) {
        if ($Disk.Checked -eq $true) {
            $SelectedDisk = $Drives[$i]
        }
        $i++
    }

    $i = 0
    foreach ($CheckBox in $CheckBoxes) {
        if ($CheckBox.Checked -eq $true) {
            $Path = "$SelectedDisk" + ":\Users\$env:username\" + $CheckBoxNames[$i]
            Set-KnownFolderPath -KnownFolder $CheckBoxNames[$i] -Path $Path
        }
        $i++
    }

    Start-Sleep 1
    $Form.Close()
})

$Form.Add_Closing({
    $MTB10.Image = $DefaultButtonColor
    $MTB10.ForeColor = $AccentColor
})

[void]$Form.ShowDialog()