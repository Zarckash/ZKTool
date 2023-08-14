function Write-UserOutput {
    param (
        [string]$Message,
        [string]$Progress,
        [switch]$DisableType
    )

    $Message = $Message + "..."
    $MaxLength = 66 - $Progress.Length - 3
    $AddSpaces = ""
    $AddSpacesDynamic = ""

    $Message.Length..$MaxLength | ForEach-Object {
        $AddSpaces += " "
    }

    0..$Message.Length | ForEach-Object {
        $AddSpacesDynamic += " "
    }

    if ($DisableType.IsPresent -and ($Progress.Length -gt 0)) {
        $StatusBox.Text = "| $Message" + $AddSpaces + $Progress
        
    }
    elseif ($DisableType.IsPresent) {
        $StatusBox.Text = "| $Message..."
    }
    elseif ((!($DisableType.IsPresent)) -and ($Progress.Length -gt 0)) {
        $i = $Message.Length
        $MessageChar = ""
        $Message -split '' | ForEach-Object {
            $MessageChar += $_
            $AddSpacesDynamic = $AddSpacesDynamic.Substring(0,$i)
            $StatusBox.Text = "| " + $MessageChar + $AddSpacesDynamic + $AddSpaces + $Progress
            Start-Sleep -Milliseconds 20
            $i--
        }
    }
    else {
        $MessageChar = ""
        $Message -split '' | ForEach-Object {
            $MessageChar += $_
            $StatusBox.Text = "| " + $MessageChar
            Start-Sleep -Milliseconds 20
        }
    }
}