function Update-Status {
    Param (
        $Value
    )
    $Hash.Status.Dispatcher.Invoke("Normal",[action]{$Hash.Status.Text = ($Value + "...")})
}

function Install-Font {
    $Hash.Download.DownloadFile("https://github.com/Zarckash/ZKTool/raw/main/Resources/Fonts.zip", "$env:temp\ZKTool\Files\Fonts.zip")
    Expand-Archive -Path "$env:temp\ZKTool\Files\Fonts.zip" -DestinationPath "$env:temp\ZKTool\Files\Fonts" -Force

    $ExistingFonts = Get-ChildItem -Path "C:\Windows\Fonts" | ForEach-Object { $_.Name }
    $CSharpCode = @'
using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Runtime.InteropServices;

namespace FontResource
{
    public class AddRemoveFonts
    {
        [DllImport("gdi32.dll")]
        static extern int AddFontResource(string lpFilename);

        public static int AddFont(string fontFilePath) {
            try 
            {
                return AddFontResource(fontFilePath);
            }
            catch
            {
                return 0;
            }
        }
    }
}
'@

    Add-Type $CSharpCode

    $FontFileTypes = @{}
    $FontFileTypes.Add(".ttf", " (TrueType)")
    $FontFileTypes.Add(".otf", " (OpenType)")
    $FontRegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

    Get-ChildItem "$env:temp\ZKTool\Files\Fonts" | ForEach-Object {
        $Path = Join-Path "C:\Windows\Fonts" $_.Name
        if (!($ExistingFonts.Contains($_.Name))) {

            Copy-Item -Path $_.FullName -Destination $Path
    
            $FileDir = split-path $Path
            $FileName = split-path $Path -leaf
            $FileExt = (Get-Item $Path).extension
            $FileBaseName = $FileName -replace ($FileExt , "")
                
            $Shell = new-object -com Shell.application
            $MyFolder = $Shell.Namespace($FileDir)
            $FileObj = $MyFolder.Items().Item($FileName)
            $FontName = $MyFolder.GetDetailsOf($FileObj, 21)
                
            if ($FontName -eq "") { $FontName = $FileBaseName }
                
            [FontResource.AddRemoveFonts]::AddFont($Path) | Out-Null
            Set-ItemProperty -Path "$($FontRegistryPath)" -Name "$($FontName)$($FontFileTypes.Item($FileExt))" -Value "$($FileName)"
        }
    }
}

function Reset-IconCache {
    ie4uinit.exe -show
    taskkill /f /im explorer.exe | Out-Null
    Remove-Item -Path "$env:localappdata\IconCache.db" -Force
    Remove-Item -Path "$env:localappdata\Microsoft\Windows\Explorer\iconcache*" -Force
    explorer.exe

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    Set-ItemProperty -Path "HKCR:\Directory\Background\shell\ZKTool\" -Name "Icon" -Value "C:\Program Files\ZKTool\ZKTool.exe,0" -Force
}