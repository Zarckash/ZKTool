function Write-UserOutput {
    param (
        [string]$Message,
        [string]$Progress
    )

    $Message = $Message + "..."
    $MaxLength = 66 - $Progress.Length - 3

    if ($Progress.Length -gt 0) {
        $AddSpaces = ""
        $Message.Length..$MaxLength | ForEach-Object {
            $AddSpaces += " "
        }

        $AddSpacesDynamic = ""
        0..$Message.Length | ForEach-Object {
            $AddSpacesDynamic += " "
        }

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

    Start-Sleep -Milliseconds 500
}