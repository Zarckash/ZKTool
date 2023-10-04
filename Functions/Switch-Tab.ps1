$App.NavItemsList = @('Apps','Tweaks','Extra','Configs','UserFolders','NetConfig')
$App.DisksList = @('Disk1','Disk2','Disk3','Disk4','Disk5','Disk6')

$App.Apps.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible
})

$App.Tweaks.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible
})

$App.Extra.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible
})

$App.Configs.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible
})

$App.UserFolders.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible

    if ($App.Disk1.Visibility -ne "Visible") {
        $NewRunspace = [RunspaceFactory]::CreateRunspace()
        $NewRunspace.ApartmentState = "STA"
        $NewRunspace.ThreadOptions = "ReuseThread"          
        $NewRunspace.Open()
        $NewRunspace.SessionStateProxy.SetVariable("App", $App)
        $Logic = [PowerShell]::Create().AddScript({
            . ($App.FunctionsPath + "Update-GUI.ps1")
            $GetDisk = Get-Volume | Where-Object {(($_.DriveType -eq "Fixed") -and ($_.DriveLetter -like "?") -and ($_.FileSystemLabel -notlike ""))} | Select-Object DriveLetter,FileSystemLabel | Sort-Object -Property DriveLetter
            1..$GetDisk.Count | ForEach-Object {
                $App.("Disk$_" + "Label") = $GetDisk[$_ - 1].DriveLetter
                Update-GUI ("Disk$_" + "Text") Text ($GetDisk[$_ - 1].FileSystemLabel + " (" + $GetDisk[$_ - 1].DriveLetter + ":)")
                Update-GUI ("Disk$_") Visibility Visible
            }
        })
        $Logic.Runspace = $NewRunspace
        $Logic.BeginInvoke() | Out-Null
    }
})

$App.NetConfig.Add_Click({
    $App.NavItemsList | ForEach-Object {
        Update-GUI $_ Background Transparent
        Update-GUI ($_ + "Border") Opacity 0
        Update-GUI ($_ + "ContentGrid") Visibility Collapsed
    }
    $this.Background = $App.HoverButtonColor
    Update-GUI ($this.Name + "Border") Opacity 1
    Update-GUI ($this.Name + "ContentGrid") Visibility Visible
})