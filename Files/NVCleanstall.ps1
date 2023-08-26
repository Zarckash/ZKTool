$ErrorActionPreference = 'Continue'
$Host.UI.RawUI.WindowTitle = 'Nvidia Drivers Installer'

function Write-TypeHost ([string]$s = '',[string]$TextColor = 'DarkCyan') {
    $s -split '' | ForEach-Object {
        Write-Host $_ -NoNewline -ForegroundColor $TextColor
        Start-Sleep -Milliseconds 15
    }
    Start-Sleep -Milliseconds 15
    Write-Host `n
}

$TempPath = "$env:temp\ZKTool\Files"

# Downloading Latest Nvidia Driver
Write-TypeHost "Descargando Ultimos Drivers De Nvidia..."

$Uri = "https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/AjaxDriverService.php?func=DriverManualLookup&psid=120&pfid=929&osID=57&languageCode=1033&isWHQL=1&dch=1&sort1=0&numberOfResults=1"
$WebRequest = (Invoke-WebRequest -Uri $Uri -Method GET -UseBasicParsing).Content | ConvertFrom-Json
$DriverVersion = $WebRequest.IDS.downloadInfo.Version

$Url = "https://us.download.nvidia.com/Windows/$DriverVersion/$DriverVersion-desktop-win10-win11-64bit-international-dch-whql.exe"
(New-Object System.Net.WebClient).DownloadFile($Url,"$TempPath\Driver.exe")

# Installing 7-Zip
Write-TypeHost "Instalando 7-Zip..."
(New-Object System.Net.WebClient).DownloadFile("https://www.7-zip.org/a/7z2301-x64.exe","$TempPath\7Zip.exe")
Start-Process "$TempPath\7Zip.exe" /S

# Extracting Drivers
Write-TypeHost "Extrayendo Drivers..."
New-Item -Path "$TempPath\NVCleanstall" -ItemType Directory -Force | Out-Null

$FilesToExtract = "Display.Driver GFExperience NVI2 EULA.txt ListDevices.txt setup.cfg setup.exe"
$DriverPath = "$TempPath\Driver.exe"
$ExtractPath = "$TempPath\NVCleanstall"

Start-Process "C:\Program Files\7-Zip\7z.exe" -NoNewWindow -ArgumentList "x -bso0 -bsp1 -bse1 -aoa $DriverPath $FilesToExtract -o$ExtractPath"

# Cleaning Driver Files
Write-TypeHost "Eliminando Archivos De Driver..."
$GFEPath = "$TempPath\NVCleanstall\GFExperience"
$ExcludeList = @('PrivacyPolicy','locales','EULA.html','EULA.txt','FunctionalConsent_*')
Get-ChildItem $GFEPath -Exclude $ExcludeList | ForEach-Object {
    Remove-Item $_ -Recurse -Force
}

# Disabling HDCP
Write-TypeHost "Desactivando HDCP..."
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
if (Test-Path "$RegPath\0000") {
    Set-ItemProperty -Path "$RegPath\0000" -Name "RMHdcpKeyglobZero" -Type DWord -Value 1
}elseif (Test-Path "$RegPath\0002") {
    Set-ItemProperty -Path "$RegPath\0002" -Name "RMHdcpKeyglobZero" -Type DWord -Value 1
}

# Installing Drivers
Write-TypeHost "Instalando Drivers..."
Start-Process "$TempPath\NVCleanstall\setup.exe" -WorkingDirectory "$TempPath\NVCleanstall" -ArgumentList "-clean -s"

# Uninstalling 7-Zip
Write-TypeHost "Desinstalando 7Zip..."
Start-Process "C:\Program Files\7-Zip\Uninstall.exe" /S

Pause