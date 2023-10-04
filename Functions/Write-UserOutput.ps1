function Write-UserOutput {
    param (
        [string]$Message,
        [string]$Progress
    )

    $Message += "..."
    $MaxLength = 52 - $Progress.Length
    $AddSpaces = ""

    $Message.Length..($MaxLength - 1) | ForEach-Object {
        $AddSpaces += " "
    }

    if ($Progress.Length -eq 0) {
        Update-GUI OutputBox Text $Message
        $Message | Out-File ($App.LogFolder +  "UserOutput.log") -Encoding UTF8 -Append
        
    }
    else {
        Update-GUI OutputBox Text ($Message + $AddSpaces + $Progress)
        ($Message + $AddSpaces + $Progress) | Out-File ($App.LogFolder +  "UserOutput.log") -Encoding UTF8 -Append
    }

}