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
    Move-Item "$HOME\$Leaf\desktop.ini" $Path -Force
    Move-Item "$HOME\$Leaf\*" $Path -Force
    Remove-Item $HOME\$Leaf -Recurse -Force
}



$SelectedDisk = $App.($App.SelectedDisk + "Label")

$App.FoldersToMove | ForEach-Object {
    Write-UserOutput "Moviendo carpeta de usuario"
    Update-GUI $_ Foreground $App.AccentColor
    Update-GUI $App.SelectedDisk Foreground $App.AccentColor
    $Path = "$SelectedDisk" + ":\Users\$env:username\" + ($_ -replace "Folder","")
    Set-KnownFolderPath -KnownFolder ($_ -replace "Folder","") -Path $Path
}

if ($App.SelectAllFolders.BorderThickness -eq 1.5) {
    Update-GUI SelectAllFolders BorderThickness 0
    Update-GUI SelectAllFolders Content "Seleccionar todo"
}

