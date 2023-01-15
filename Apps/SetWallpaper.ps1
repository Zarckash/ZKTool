Iwr "https://github.com/Zarckash/ZKTool/raw/main/Configs/BlackWindows11.jpg" -OutFile "$env:userprofile\BlackWindows11.jpg" | Out-Null

Function Set-WallPaper {

param (
    [parameter(Mandatory=$True)]
    # Provide path to image
    [string]$Path
)
 
Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;
  
public class Params
{ 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo (Int32 uAction, 
                                                   Int32 uParam, 
                                                   String lpvParam, 
                                                   Int32 fuWinIni);
}
"@ 
  
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
  
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
  
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Path, $fWinIni)
}

Set-WallPaper -Path "$env:userprofile\BlackWindows11.jpg"