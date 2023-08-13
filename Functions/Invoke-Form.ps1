function Invoke-Form {
    param (
        [array]$Forms
    )
    
    foreach ($Form in $Forms) {
        $FormsPath = "$GitHubPath/SubForms/" + $FormsList.$Form.Path
        Write-UserOutput -Message ($FormsList.$Form.Output + $FormsList.$Form.Name)
        Invoke-Expression ($Download.DownloadString($FormsPath))
    }
}