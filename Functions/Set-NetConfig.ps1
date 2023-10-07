function Set-NetConfig {
    $Script:IP = $null
    $Script:DNS1 = $null
    $Script:DNS2 = $null

    $Script:Interface = "Ethernet"
    $Script:Interfaces = Get-NetIPConfiguration | Select-Object -ExpandProperty InterfaceAlias
    if (($Interfaces.GetType()).IsArray) {
    $Interfaces | ForEach-Object {Disable-NetAdapter $_ -Confirm:$false}
    Enable-NetAdapter "Ethernet" -Confirm:$false
    }

    $Script:Gateway = Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop

    if (!($null -eq $App.SelectedIP)) {
        $Index = $App.SelectedIP -replace 'IP*', ''
        $IP = $App.FoundIPList[$Index - 1]
    }
    
    if (!($null -eq $App.SelectedDNS)) {
        switch ($App.SelectedDNS) {
            DNS1 {
                $DNS1 = "8.8.8.8"
                $DNS2 = "8.8.4.4"
            }
            DNS2 {
                $DNS1 = "1.1.1.1"
                $DNS2 = "1.1.1.1"
            }
            DNS3 {
                $DNS1 = $Gateway
                $DNS2 = $Gateway
            }
            Default {}
        }
    }

    if (!($null -eq $App.CustomIP)) {
        $IP = $App.CustomIP
    }

    if (!($null -eq $App.CustomDNS1)) {
        $DNS1 = $App.CustomDNS1
        $DNS2 = $App.CustomDNS2
    }



    if (!($null -eq $IP)) {
        Write-UserOutput "Estableciendo IP $IP"
        Remove-NetIPAddress -InterfaceAlias $Interface -Confirm:$false
        Remove-NetRoute -InterfaceAlias $Interface
        New-NetIPAddress -InterfaceAlias $Interface -AddressFamily IPv4 $IP -PrefixLength 24 -DefaultGateway $Gateway | Out-Null
    }

    if (!($null -eq $DNS1)) {
        Write-UserOutput "Estableciendo DNS $DNS1 y $DNS2"
        Set-DnsClientServerAddress -InterfaceAlias $Interface -ServerAddresses $DNS1, $DNS2
    }

    Set-NetConnectionProfile -NetworkCategory Private
    Disable-NetAdapter -Name $Interface -Confirm:$false
    Enable-NetAdapter -Name $Interface -Confirm:$false

    $App.SelectedIP = $null
    $App.SelectedDNS = $null
    $App.CustomIP = $null
    $App.CustomDNS1 = $null
    $App.CustomDNS2 = $null
    $App.IPValues | ForEach-Object {
        Update-GUI $_ Text $null
    }
    $App.DNS1Values | ForEach-Object {
        Update-GUI $_ Text $null
    }
    $App.DNS2Values | ForEach-Object {
        Update-GUI $_ Text $null
    }
}