function Spotify {
    Write-UserOutput "Instalando Spotify"
    $App.Download.DownloadFile(($App.GitHubFilesPath + "Spotify.ps1"), ($App.FilesPath + "Spotify.ps1"))
    Start-Process powershell -ArgumentList "-noexit -command powershell.exe -ExecutionPolicy Bypass $env:temp\ZKTool\Files\Spotify.ps1 ; exit"
}

function AdobePhotoshop {
    Write-UserOutput "Iniciando instalador de Adobe Photoshop"
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
}

function AdobePremiere {
    Write-UserOutput "Iniciando instalador de Adobe Premiere"
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
    Write-UserOutput "Iniciando instalador de Adobe After Effects"
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

function RegistryTweaks {
    $TB1.ForeColor = $AccentColorBig
    Write-UserOutput "Iniciando Optimización"

    # Create Restore Point
    Write-UserOutput "Creando punto de restauración"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -Type DWord -Value 0
    Enable-ComputerRestore -Drive "C:\"
    Checkpoint-Computer -Description "Pre Optimización ZKTool" -RestorePointType "MODIFY_SETTINGS"
    
    # Disable UAC
    Write-UserOutput "Desactivando UAC para Administradores"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Type DWord -Value 0

    # Disable Device Set Up Suggestions
    Write-UserOutput "Desactivando sugerencias de configuración de dispositivo"
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\" -Name "UserProfileEngagement"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0
    
    # Disable Fast Boot
    Write-UserOutput "Desactivando Fast Boot"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0

    # Enable Hardware Acceleration
    Write-UserOutput "Activando aceleración de hardware"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Type Dword -Value 2

    # Enable Borderless Optimizations
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\DirectX")) {
        New-Item -Path "HKCU:\Software\Microsoft" -Name "DirectX" | Out-File $App.LogPath -Encoding UTF8 -Append 
        New-Item -Path "HKCU:\Software\Microsoft\DirectX" -Name "GraphicsSettings" | Out-File $App.LogPath -Encoding UTF8 -Append
        New-Item -Path "HKCU:\Software\Microsoft\DirectX" -Name "UserGpuPreferences" | Out-File $App.LogPath -Encoding UTF8 -Append
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\GraphicsSettings" -Name "SwapEffectUpgradeCache" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\DirectX\UserGpuPreferences" -Name "DirectXUserGlobalSettings" -Value "SwapEffectUpgradeEnable=1;"

    # Set-PageFile Size
    Write-UserOutput "Comprobando Cantidad De RAM"
    $RamCapacity = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum /1gb
    if ($RamCapacity -le 16) {
        Write-UserOutput "Estableciendo El Tamaño Del Archivo De Paginación En $RamCapacity GB"
        $PageFile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
        $PageFile.AutomaticManagedPagefile = $false
        $RamCapacity = $RamCapacity*1024
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
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2010.x64 | Out-File $App.LogPath -Encoding UTF8 -Append
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.VCRedist.2010.x86 | Out-File $App.LogPath -Encoding UTF8 -Append
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".exe/SetTimerResolutionService.exe"), ($App.FilesPath + "SetTimerResolutionService.exe"))
    New-Item 'C:\Program Files\Set Timer Resolution Service\' -ItemType Directory | Out-File $App.LogPath -Encoding UTF8 -Append
    Move-Item -Path ("$TempPath\Files\SetTimerResolutionService.exe") -Destination 'C:\Program Files\Set Timer Resolution Service\'
    Push-Location
    Set-Location -Path "C:\Program Files\Set Timer Resolution Service"
    Start-Sleep 3
    .\SetTimerResolutionService.exe -install | Out-File $App.LogPath -Encoding UTF8 -Append
    Pop-Location

    # Install Bitsum Power Plan
    Write-Output "Instalando Bitsum Power Plan"
    $App.Download.DownloadFile(($App.GitHubFilesPath + "BitsumPowerPlan.pow"), ($App.FilesPath + "BitsumPowerPlan.pow"))
    powercfg -import ($App.FilesPath + "BitsumPowerPlan.pow") 77777777-7777-7777-7777-777777777777 | Out-File $App.LogPath -Encoding UTF8 -Append
    powercfg -SETACTIVE "77777777-7777-7777-7777-777777777777"
    powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c # Remove High Performance Profile
    powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a # Remove Power Saver Profile
    powercfg -h off
    powercfg -change monitor-timeout-ac 15
    powercfg -change standby-timeout-ac 0

    # Windows Defender Exclusions
    Write-UserOutput "Añadiendo exclusiones a Windows Defender"
    $ActiveDrives = Get-Volume | Where-Object {(($_.DriveType -eq "Fixed") -and ($_.DriveLetter -like "?") -and ($_.FileSystemLabel -notlike ""))} | Select-Object -ExpandProperty DriveLetter | ForEach-Object {$_ + ":\"}
    $ActiveDrives | ForEach-Object {
        if (Test-Path ($_ + "Games")) {
            Add-MpPreference -ExclusionPath ($_ + "Games")
            Add-MpPreference -ExclusionProcess ($_ + "Games\*")
        }
    }
    Add-MpPreference -ExclusionPath "$env:ProgramFiles\Windows Defender"
    Add-MpPreference -ExclusionPath "$env:windir\security\database"
    Add-MpPreference -ExclusionPath "$env:windir\SoftwareDistribution\DataStore"
    Add-MpPreference -ExclusionPath "$env:temp\NVIDIA Corporation\NV_Cache"

    # Show File Extensions
    Write-UserOutput "Activando Extensiones De Archivos"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

    # File Association Fix
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".exe/SetUserFTA.exe"), ($App.FilesPath + "SetUserFTA.exe"))
    Push-Location
    Set-Location $App.FilesPath
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
    Write-UserOutput "Estableciendo abrir Explorador en `"Este Equipo`""
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    # Hide gallery in File explorer
    Write-UserOutput "Ocultando galería en el Explorador de archivos"
    New-Item -Path "HKCU:\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Force | Out-File $LogPath
    Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Name "System.IsPinnedToNameSpaceTree" -Type DWord -Value 0
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Name "(default)" -Value "{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}"

    # Reduce svchost Process Amount
    Write-UserOutput "Reduciendo los procesos de Windows a la mitad"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value 4294967295

    # Disable Mouse Acceleration
    Write-UserOutput "Desactivando aceleración del ratón"
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0

    # Disable Keyboard Layout Shortcut
    Write-UserOutput "Desactivando cambio de idioma del teclado"
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Hotkey" -Value 3
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Language Hotkey" -Value 3
    Set-ItemProperty -Path "HKCU:\Keyboard Layout\Toggle" -Name "Layout Hotkey" -Value 3
    
    # Disable Error Reporting
    Write-UserOutput "Desactivando informar de errores"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null

    # 100% Wallpaper Quality
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Type DWord -Value 100
    
    # Network Optimizations
    Write-UserOutput "Optimizando registros de Red"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Type DWord -Value 4294967295
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Type DWord -Value 0

    # Performance Optimizations
    Write-UserOutput "Optimizando registros de rendimiento"
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
    Write-UserOutput "Optimizando registros de juegos"
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
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "Edge" | Out-File $App.LogPath -Encoding UTF8 -Append
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
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "EdgeUpdate" | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\EdgeUpdate" -Name "UpdateDefault" -Type DWord -Value 2
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\edgeupdate" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\edgeupdatem" -Name "Start" -Type DWord -Value 4
    Disable-ScheduledTask -TaskName 'MicrosoftEdgeUpdateTaskMachineCore*' | Out-File $App.LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName 'MicrosoftEdgeUpdateTaskMachineUA*' | Out-File $App.LogPath -Encoding UTF8 -Append

    # Chrome Settings
    Write-UserOutput "Optimizando Chrome"
    New-Item -Path "HKLM:\SOFTWARE\Policies\Google" -Name "Chrome" | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BackgroundModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "HardwareAccelerationModeEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "StartupBoostEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\gupdate" -Name "Start" -Type DWord -Value 4
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\gupdatem" -Name "Start" -Type DWord -Value 4

    # Disable VBS
    Write-UserOutput "Desactivando aislamiento del núcleo"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -Type DWord -Value 0

    # Disable Background Apps
    Write-UserOutput "Desactivando aplicaciones en segundo plano"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Type DWord -Value 1

    # Disable Power Throttling
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power" -Name "PowerThrottling" | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Type DWord -Value 1

    # Hide Keyboard Layout Icon
    Write-UserOutput "Ocultando el botón ee idioma del teclado"
    Set-WinLanguageBarOption -UseLegacyLanguageBar
    New-Item -Path "HKCU:\Software\Microsoft\CTF\" -Name "LangBar" | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ExtraIconsOnMinimized" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Label" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "ShowStatus" -Type DWord -Value 3
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\CTF\LangBar" -Name "Transparency" -Type DWord -Value 255

    # Disable Telemetry
    Write-UserOutput "Deshabilitando telemetría de Windows"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-File $App.LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-File $App.LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-File $App.LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-File $App.LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-File $App.LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-File $App.LogPath -Encoding UTF8 -Append

    # Disable Aplication Sugestions
    Write-UserOutput "Deshabilitando sugerencias de aplicaciones"
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
    Write-UserOutput "Deshabilitando historial de actividad"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0

    # Disable Nearby Sharing
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "CdpSessionUserAuthzPolicy" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CDP" -Name "RomeSdkChannelUserAuthzPolicy" -Type DWord -Value 0

    # Show TaskBar Only In Main Screen
    Write-UserOutput "Estableciendo barra de tareas en monitor principal"
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
    Write-UserOutput "Desactivando actualizaciones de Microsoft Store"
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "WindowsStore"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" -Name "AutoDownload" -Type DWord -Value 2

    # Hide TaskBar View Button
    Write-UserOutput "Ocultando botón vista de tareas"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

    # Hide Meet Now Button
    Write-UserOutput "Ocultando botón de Reunirse Ahora"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Value 1

    # Hide Search Button
    Write-UserOutput "Ocultando botón de búsqueda"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

    # Disable Widgets
    Write-UserOutput "Desactivando Widgets"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Type DWord -Value 0
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\" -Name "Dsh"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Type DWord -Value 0

    # Disable Web Search
    Write-UserOutput "Desactivando búsqueda en la web con Bing"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0

    # Hide Search Recomendations
    Write-UserOutput "Desactivando recomendaciones de búsqueda"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Type DWord -Value 0

    # Disable Microsoft Account In Windows Search
    Write-UserOutput "Desactivando cuenta de Microsoft en Windows Search"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Type DWord -Value 0
    
    # Hide Chat Button
    Write-UserOutput "Ocultando botón de chats"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Type DWord -Value 0

    # Set Dark Theme
    Write-UserOutput "Estableciendo modo oscuro"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0

    # Hide Recent Files And Folders In Explorer
    Write-UserOutput "Ocultando recientes de Acceso Rápido"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0

    # Clipboard History
    Write-UserOutput "Activando el historial del portapapeles"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Type DWord -Value 1

    # Change Computer Name
    $PCName = $env:username.ToUpper() + "-PC"
    Write-UserOutput "Cambiando nombre del equipo a $PCName"
    Rename-Computer -NewName $PCName

    # Set Private Network
    Write-UserOutput "Estableciendo Red Privada"
    Set-NetConnectionProfile -NetworkCategory Private

    # Show File Operations Details
    Write-UserOutput "Mostrando detalles de transferencias de archivos"
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "OperationStatusManager" | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1

    # Sounds Communications Do Nothing
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -Type DWord -Value 3

    # Hide Buttons From Power Button
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "FlyoutMenuSettings" | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowSleepOption" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowLockOption" -Type DWord -Value 0

    # Alt Tab Open Windows Only
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Type DWord -Value 3

    # Set Desktop Icons Size To Small
    Write-UserOutput "Reduciendo el tamaño de los iconos del Escritorio"
    taskkill /f /im explorer.exe
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop" -Name "IconSize" -Type DWord -Value 32
    explorer.exe

    # Disable Feedback
    Write-UserOutput "Deshabilitando Feedback"
    If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-File $App.LogPath -Encoding UTF8 -Append
    }
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-File $App.LogPath -Encoding UTF8 -Append
    Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-File $App.LogPath -Encoding UTF8 -Append

    # Service Tweaks To Manual 
    Write-UserOutput "Deshabilitando servicios de Windows"
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
}

function NvidiaSettings {
    Write-UserOutput "Importando ajustes del Panel de Control de Nvidia"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" -Name "EnableGR535" -Type DWord -Value 0
    $App.Download.DownloadFile(($App.GitHubFilesPath + "/.exe/ProfileInspector.exe"), ($App.FilesPath + "ProfileInspector.exe"))
    $App.Download.DownloadFile(($App.GitHubFilesPath + "NvidiaProfiles.nip"), ($App.FilesPath + "NvidiaProfiles.nip"))
    & ($App.FilesPath + "ProfileInspector.exe") -SilentImport ($App.FilesPath + "NvidiaProfiles.nip")
    Set-ItemProperty -Path "HKCU:\Software\NVIDIA Corporation\NvTray" -Name "StartOnLogin" -Type DWord -Value 0
    Remove-Item -Path "C:\Windows\System32\drivers\NVIDIA Corporation" -Recurse -Force | Out-File $App.LogPath -Encoding UTF8 -Append
    Get-ChildItem -Path "C:\Windows\System32\DriverStore\FileRepository\" -Recurse | Where-Object {$_.Name -eq "NvTelemetry64.dll"} | Remove-Item -Force | Out-File $App.LogPath -Encoding UTF8 -Append
}

function UninstallXboxGameBar {
    Write-UserOutput "Desinstalando Xbox Game Bar"
    Get-AppxPackage "Microsoft.XboxGamingOverlay" | Remove-AppxPackage 
    Get-AppxPackage "Microsoft.XboxGameOverlay" | Remove-AppxPackage 
    Get-AppxPackage "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage 
    Get-AppxPackage "Microsoft.Xbox.TCUI" | Remove-AppxPackage
    Get-AppxPackage "Microsoft.GamingApp" | Remove-AppxPackage
    Get-AppxPackage "Microsoft.GamingServices" | Remove-AppxPackage
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Type DWord -Value 0
}

function EnableMSIMode {
    Write-UserOutput "Activando modo MSI en GPU"
    $GPUID = (Get-PnpDevice -Class Display).InstanceId
    $GPUName = Get-ItemPropertyValue -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID" -Name "DeviceDesc"
    
    if (($GPUName -like "*GTX*") -or ($GPUName -like "*RTX*")) {
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID\Device Parameters\Interrupt Management" -Name "MessageSignaledInterruptProperties" | Out-File $App.LogPath -Encoding UTF8 -Append
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\$GPUID\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" -Name "MSISupported" -Type DWord -Value 1
    }
}

function UninstallBloat {
    Write-UserOutput "Limpiando aplicaciones de Windows innecesarias"

    # Uninstall Microsoft Bloatware
    Write-UserOutput "Desinstalando aplicaciones de Microsoft"
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
        "Microsoft.549981C3F5F10"
    )
    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat | Remove-AppxPackage
    }

    # Clean "New" In Context Menu
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-File $App.LogPath -Encoding UTF8 -Append
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
    Write-UserOutput "Desinstalando Servidor OpenSSH"
    Get-WindowsPackage -Online | Where-Object PackageName -like *SSH* | Remove-WindowsPackage -Online -NoRestart | Out-File $App.LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Rostro De Windows Hello"
    Get-WindowsPackage -Online | Where-Object PackageName -like *Hello-Face* | Remove-WindowsPackage -Online -NoRestart | Out-File $App.LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Grabación De Acciones Del Usuario"
    DISM /Online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 /NoRestart | Out-File $App.LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Modo De Internet Explorer"
    DISM /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /NoRestart | Out-File $App.LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando WordPad"
    DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0 /NoRestart | Out-File $App.LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Windows Powershell ISE"
    DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0 /NoRestart | Out-File $App.LogPath -Encoding UTF8 -Append
    Write-UserOutput "Desinstalando Reconocedor Matemático"
    DISM /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0 /NoRestart | Out-File $App.LogPath -Encoding UTF8 -Append
}

function UninstallOneDrive {
    Write-UserOutput "Desinstalando OneDrive"
    Stop-Process -Name "OneDrive"
    Start-Sleep -s 2
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    If (!(Test-Path $onedrive)) {
        $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
    Start-Sleep -s 2
    Stop-Process -Name "explorer"
    Start-Sleep -s 2
    Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
    Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
    Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-File $App.LogPath -Encoding UTF8 -Append
    Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse
    Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse
    Get-AppxPackage Microsoft.OneDriveSync | Remove-AppxPackage
}

function AdobeCleaner {
    Write-UserOutput "Eliminando procesos de Adobe"
    Rename-Item -Path "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exe" "C:\Program Files (x86)\Adobe\Adobe Sync\CoreSync\CoreSync.exeX"
    Rename-Item -Path "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exeX"
    Rename-Item -Path "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exe" "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\ADS\Adobe Desktop Service.exeX"
    Rename-Item -Path "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exe" "C:\Program Files\Common Files\Adobe\Creative Cloud Libraries\CCLibrary.exeX"
}

function RealtekCleaner {
    Write-UserOutput "Eliminando Realtek Audio Service"
    pwsh -command {sc stop Audiosrv} | Out-File $App.LogPath -Encoding UTF8 -Append
    pwsh -command {sc stop RtkAudioUniversalService} | Out-File $App.LogPath -Encoding UTF8 -Append
    taskkill.exe /f /im RtkAudUService64.exe | Out-File $App.LogPath -Encoding UTF8 -Append
    pwsh -command {sc delete RtkAudioUniversalService} | Out-File $App.LogPath -Encoding UTF8 -Append
    pwsh -command {sc start Audiosrv} | Out-File $App.LogPath -Encoding UTF8 -Append
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "RtkAudUService"
    Get-AppxPackage -All "RealtekSemiconductorCorp.RealtekAudioControl" | Remove-AppxPackage
}

function ReduceIconsSpacing {
    Write-UserOutput "Reduciendo espacio entre iconos en el Escritorio"
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "IconSpacing" -Value -900
}

function HideShortcutIcons {
    Write-UserOutput "Ocultando flechas de acceso directo"
    $App.Download.DownloadFile(($App.GitHubFilesPath + "Blank.ico"), ($App.FilesPath + "Blank.ico"))
    Unblock-File ($App.FilesPath + "Blank.ico")
    Copy-Item -Path ($App.FilesPath + "Blank.ico") -Destination "C:\Windows\System32" -Force
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCR:\IE.AssocFile.URL" -Name "IsShortcut" -Value ""
    Set-ItemProperty -Path "HKCR:\InternetShortcut" -Name "IsShortcut" -Value ""
    Set-ItemProperty -Path "HKCR:\lnkfile" -Name "IsShortcut" -Value ""
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" -Name "Shell Icons" | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" -Name "29" -Value "%windir%\System32\Blank.ico"
}

function SetW11Cursor {
    Write-UserOutput "Estableciendo cursor de Windows 11"
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/FluentCursor.zip"), ($App.FilesPath + "FluentCursor.zip"))
    Expand-Archive -Path ($App.FilesPath + "FluentCursor.zip") -DestinationPath 'C:\Windows\Cursors\Fluent Cursor' -Force
    $App.Download.DownloadFile(($App.GitHubFilesPath + "FluentCursor.reg"), ($App.FilesPath + "FluentCursor.reg"))
    regedit /s ($App.FilesPath + "FluentCursor.reg")
}

function TweaksInContextMenu {
    Write-UserOutput "Activando tweaks en el menú contextual"
    
    # Enable App Submenu
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/ContextMenuTweaks.zip"), ($App.FilesPath + "ContextMenuTweaks.zip"))
    Expand-Archive -Path ($App.FilesPath + "ContextMenuTweaks.zip") -DestinationPath ($App.ZKToolPath + "Apps") -Force
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Subcommands" -Value ""
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "shell" | Out-Null
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "01App" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "Icon" -Value ($App.ZKToolPath + "\ZKTool.exe,0")
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "MUIVerb" -Value "App"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\01App" -Name "command" | Out-Null
            Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\01App\command" -Name "(default)" -Value ($App.ZKToolPath + "ZKTool.exe")

    # LogitechOMM
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "02LogitechOMM" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "Icon" -Value ($App.ZKToolPath + "Apps\LogitechOMM.exe,0")
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "MUIVerb" -Value "Logitech OMM"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\02LogitechOMM\command" -Name "(default)" -Value ($App.ZKToolPath + "Apps\LogitechOMM.exe")
    
    # SteamBlock
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "03SteamBlock" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03SteamBlock" -Name "Icon" -Value "C:\Program Files (x86)\Steam\steam.exe,0"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03SteamBlock" -Name "MUIVerb" -Value "Disable Steam"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\03SteamBlock" -Name "command" | Out-Null
            Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\03SteamBlock\command" -Name "(default)" -Value ($App.ZKToolPath + "Apps\BlockSteam.exe")
    
    # Clean Standby List Memory
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "04EmptyStandbyList" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04EmptyStandbyList" -Name "Icon" -Value "SHELL32.dll,12"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04EmptyStandbyList" -Name "MUIVerb" -Value "Clear RAM"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04EmptyStandbyList" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\04EmptyStandbyList\command" -Name "(default)" -Value ($App.ZKToolPath + "Apps\EmptyStandbyList.exe")

    # Clean Files
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "05CleanFiles" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05CleanFiles" -Name "Icon" -Value "SHELL32.dll,32"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05CleanFiles" -Name "MUIVerb" -Value "Clean Files"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05CleanFiles" -Name "command" | Out-Null
            Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\05CleanFiles\command" -Name "(default)" -Value ($App.ZKToolPath + "Apps\CleanFiles.exe")

    # Bufferbloat
    New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell" -Name "99BufferbloatFix" | Out-Null
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\99BufferbloatFix" -Name "Icon" -Value "inetcpl.cpl,21"
        Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\shell\99BufferbloatFix" -Name "MUIVerb" -Value "Bufferbloat Fix Disabled"
        New-Item -Path "HKCR:\Directory\Background\shell\ZKTool\shell\99BufferbloatFix" -Name "command" | Out-Null
            Set-ItemProperty "HKCR:\Directory\Background\shell\ZKTool\shell\99BufferbloatFix\command" -Name "(default)" -Value ($App.ZKToolPath + "Apps\Bufferbloat.exe")
}

function WindowsTerminalAppearance {
    Write-UserOutput "Cambiando apariencia de Windows Terminal"
    $PWSH = 'Microsoft.Powershell'
    if (!($PWSH -eq (Winget list $PWSH | Select-String -Pattern $PWSH | ForEach-Object {$_.Matches} | Select-Object -ExpandProperty Value))) {
        winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Microsoft.PowerShell  | Out-File $App.LogPath -Encoding UTF8 -Append
    }
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/WindowsTerminalSettings.zip"), ($App.FilesPath + "WindowsTerminalSettings.zip"))
    Remove-Item -Path $env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Force
    Expand-Archive -Path ($App.FilesPath + "WindowsTerminalSettings.zip") -DestinationPath $env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -Force
}

function WindowsAnimations {
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
}

function ActivateWindowsPro {
    Write-UserOutput "Activando Windows Pro"
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /skms kms.digiboy.ir
    cscript.exe //nologo "$env:windir\system32\slmgr.vbs" /ato
}

function AMDUndervoltPack {
    Write-UserOutput "Descargando Pack de undervolt de AMD"
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/AMDUndervoltPack.zip"), ($App.FilesPath + "AMDUndervoltPack.zip"))
    Expand-Archive -Path ($App.FilesPath + "AMDUndervoltPack.zip") -DestinationPath ($App.FilesPath + "AMD Undervolt Pack") -Force
    Move-Item -Path ($App.FilesPath + "AMD Undervolt Pack\AMD Undervolt") -Destination 'C:\Program Files\'
    $DesktopPath = (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Desktop") + "\AMD Undervolt"
    New-Item -Path $DesktopPath -ItemType Directory -Force | Out-Null
    Move-Item -Path ($App.FilesPath + "AMD Undervolt Pack\CPU Undervolt.lnk") -Destination $DesktopPath
    Move-Item -Path ($App.FilesPath + "AMD Undervolt Pack\Prime95") -Destination $DesktopPath
    Move-Item -Path ($App.FilesPath + "AMD Undervolt Pack\CPUZ.exe") -Destination $DesktopPath
    Move-Item -Path ($App.FilesPath + "AMD Undervolt Pack\PBO2 Tuner.lnk") -Destination "$env:appdata\Microsoft\Windows\Start Menu\Programs"
}

function DisableDefender {
    $DesktopPath = (Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Desktop")
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/DisableDefender.zip"), ($App.FilesPath + "DisableDefender.zip"))
    Expand-Archive -Path ($App.FilesPath + "DisableDefender.zip") -DestinationPath $DesktopPath -Force
    msconfig.exe
}

function NVCleanstall {
    Write-UserOutput "Abriendo NVCleanstall"
    $App.Download.DownloadFile(($App.GitHubFilesPath + "NVCleanstall.ps1"), ($App.FilesPath + "NVCleanstall.ps1"))
    Start-Process powershell -ArgumentList "-noexit -command powershell.exe -ExecutionPolicy Bypass $env:temp\ZKTool\Files\NVCleanstall.ps1 ; exit"
}

function Z390LanDrivers {
    Write-UserOutput "Instalando drivers de Red para Z390"
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/LanDrivers.zip"), ($App.FilesPath + "LanDrivers.zip"))
    Expand-Archive -Path ($App.FilesPath + "LanDrivers.zip") -DestinationPath ($App.FilesPath + "LanDrivers") -Force
    pnputil /add-driver ($App.FilesPath + "LanDrivers\e1d68x64.inf") /install
    $OldDriver = Get-WMIObject win32_PnPSignedDriver | Where-Object DeviceName -eq "Intel(R) Ethernet Connection (7) I219-V" | Select-Object -ExpandProperty InfName
    pnputil /delete-driver $OldDriver /uninstall /force
}

function CustomDarkTheme {
    Write-UserOutput "Aplicando tema oscuro personalizado"

    taskkill /f /im explorer.exe

    $App.Download.DownloadFile(($App.GitHubFilesPath + ".zip/Media.zip"), ($App.FilesPath + "Media.zip"))
    Expand-Archive -Path ($App.FilesPath + "Media.zip") -DestinationPath ($App.ZKToolPath + "\Media") -Force

    $App.Download.DownloadFile(($App.GitHubFilesPath + "Set-Wallpaper.ps1"), ($App.FilesPath + "Set-Wallpaper.ps1"))
    . ($App.FilesPath + "Set-Wallpaper.ps1")

    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion" -Name "PersonalizationCSP" | Out-File $App.LogPath -Encoding UTF8 -Append
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImagePath" -Value ($App.ZKToolPath + "Media\BlackW11Wallpaper.jpg")
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageUrl" -Value ($App.ZKToolPath + "Media\BlackW11Wallpaper.jpg")
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Name "LockScreenImageStatus" -Type DWord -Value 1

    Set-Wallpaper -Path ($App.ZKToolPath + "Media\BlackW11Wallpaper.jpg")

    # Accent Color
    $MainColor    = "FF,FF,FF,00," # Main Color
    $SecondColor  = "AC,A0,F7,00," # Second Color
    $TaskManagerH = "93,82,F4,00," # Task Manager High Usage Color 9382F4
    $TaskManagerT = "DA,D5,F3,00," # Task Manager Tiles Color
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
    $IconLocation = ($App.ZKToolPath + "\Media\BlackEdge.ico")
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()
    Copy-Item -Path $IconLocation -Destination "$env:userprofile\AppData\Local\Microsoft\Edge\User Data\Default\Edge Profile.ico" -Force

    # Black Explorer
    $ShortcutPath = "$env:appdata\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
    $IconLocation = ($App.ZKToolPath + "\Media\BlackExplorer.ico")
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    # Black Spotify
    $ShortcutPath = "$env:appdata\Microsoft\Windows\Start Menu\Programs\Spotify.lnk"
    $IconLocation = ($App.ZKToolPath + "\Media\BlackSpotify.ico")
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    # Black Discord
    $ShortcutPath = "$env:appdata\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"
    $IconLocation = ($App.ZKToolPath + "\Media\BlackDiscord.ico")
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    # Black BattleNet
    $ShortcutPath = "$env:appdata\Microsoft\Windows\Start Menu\Programs\Battle.net\Battle.net.lnk"
    $IconLocation = ($App.ZKToolPath + "\Media\BlackBattleNet.ico")
    $Shell = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $Shell.CreateShortcut($ShortcutPath)
    $Shortcut.IconLocation = "$IconLocation, 0"
    $Shortcut.Save()

    explorer.exe
}

function InstallFFMPEG {
    Write-UserOutput "Instalando FFMPEG"
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".appx/HEVC.appx"), ($App.FilesPath + "HEVC.appx"))
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".appx/HEIF.appx"), ($App.FilesPath + "HEIF.appx"))
    Add-AppxPackage ($App.FilesPath + "HEVC.appx")
    Add-AppxPackage ($App.FilesPath + "HEIF.appx")
    winget install -h --force --accept-package-agreements --accept-source-agreements -e --id Gyan.FFmpeg | Out-File $App.LogPath -Encoding UTF8 -Append
    if (!(Test-Path ($App.ZKToolPath + "Apps"))) {
        New-Item -Path ($App.ZKToolPath + "Apps") -ItemType Directory | Out-File $App.LogPath -Encoding UTF8 -Append
    }
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".exe/Compress.exe"), ($App.ZKToolPath + "Apps\Compress.exe"))
    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\" -Name "Compress" | Out-Null
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "Icon" -Value ($App.ZKToolPath + "Apps\Compress.exe,0")
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\" -Name "Position" -Value "Bottom"
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Compress\command\" -Name "(default)" -Value 'cmd.exe /c echo | set /p = %1| clip | exit && "C:\Program Files\ZKTool\Apps\Compress.exe"'
    $App.Download.DownloadFile(($App.GitHubFilesPath + ".exe/Trim.exe"), ($App.ZKToolPath + "\Apps\Trim.exe"))
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\" -Name "Trim" | Out-Null
    New-Item -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Trim\" -Name "command" | Out-Null
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Trim\" -Name "Icon" -Value ($App.ZKToolPath + "Apps\Trim.exe,0")
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Trim\" -Name "Position" -Value "Bottom"
    Set-ItemProperty -Path "HKCR:\AppXk0g4vb8gvt7b93tg50ybcy892pge6jmt\Shell\Trim\command\" -Name "(default)" -Value 'cmd.exe /c echo | set /p = %1| clip | exit && "C:\Program Files\ZKTool\Apps\Trim.exe"'
}

function RAMFIX {
    Write-UserOutput "Comprobando Cantidad De RAM"
    $RamCapacity = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum /1gb
    if ($RamCapacity -le 16) {
        Write-UserOutput "Estableciendo El Tamaño Del Archivo De Paginación En $RamCapacity GB"
        $PageFile = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
        $PageFile.AutomaticManagedPagefile = $false
        $RamCapacity = $RamCapacity*1024
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "PagingFiles" -Value "c:\pagefile.sys $RamCapacity $RamCapacity"
    }else {
        Write-UserOutput "La Cantidad De RAM Supera Los 16GB, No Se Realizará Ningún Cambio"
    } 
}