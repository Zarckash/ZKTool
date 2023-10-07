function Get-TextBox {
    $App.IPValues = @("IPBoxValue1","IPBoxValue2","IPBoxValue3","IPBoxValue4")
    $App.DNS1Values = @("DNSBox1Value1","DNSBox1Value2","DNSBox1Value3","DNSBox1Value4")
    $App.DNS2Values = @("DNSBox2Value1","DNSBox2Value2","DNSBox2Value3","DNSBox2Value4")


    $App.IPValues | ForEach-Object {
        if ($App.$_.Text -like "[0-9]*") {
            $App.CustomIP += $App.$_.Text + "."
        }
    }
    $App.CustomIP = $App.CustomIP.Substring(0,$App.CustomIP.Length - 1)

    $App.DNS1Values | ForEach-Object {
        if ($App.$_.Text -like "[0-9]*") {
            $App.CustomDNS1 += $App.$_.Text + "."
        }
    }
    $App.CustomDNS1 = $App.CustomDNS1.Substring(0,$App.CustomDNS1.Length - 1)

    $App.DNS2Values | ForEach-Object {
        if ($App.$_.Text -like "[0-9]*") {
            $App.CustomDNS2 += $App.$_.Text + "."
        }
    }
    $App.CustomDNS2 = $App.CustomDNS2.Substring(0,$App.CustomDNS2.Length - 1)
}