function Write-UserOutput {
    param (
        [string]$Message,
        [string]$Progress,
        [int]$Delay
    )

    $Message += "..."
    $MaxLength = 52 - $Progress.Length
    $AddSpaces = ""

    $Message.Length..($MaxLength - 1) | ForEach-Object {
        $AddSpaces += " "
    }

    if ($Progress.Length -gt 0) {
        $Message += $AddSpaces + $Progress
    }
    
    Update-GUI OutputBox Text $Message
    $Message | Out-File ($App.LogFolder +  "UserOutput.log") -Encoding UTF8 -Append

    if ($Delay -gt 0) {
        Start-Sleep $Delay
    }
}