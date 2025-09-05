function Get-WebFile {
    param (
        $WebUrl,
        $Path
    )

    try {
        $Download = (New-Object System.Net.WebClient).DownloadFile($WebUrl,$Path)   
    }
    catch {
        Write-UserOutput ("No se ha podido descargar " + (Split-Path $Path -Leaf))
    }
}