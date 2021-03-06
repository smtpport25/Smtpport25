function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $NetworkAdapterName,

        [parameter(Mandatory = $true)]
        [ValidateSet("IPV4","IPV6")]
        [System.String]
        $Protocol,

        [parameter(Mandatory = $true)]
        [ValidateSet("Enable","Disable")]
        [System.String]
        $status
    )
  
    $checksum = Get-NetAdapterChecksumOffload | ?{$_.name -eq $NetworkAdapterName}

    if($status -eq "Enable")
    {

    if($Protocol -eq "IPV4") {
        if($checksum.IpIPv4Enabled -eq "RxTxEnabled" -and $checksum.TcpIPv4Enabled -eq "RxTxEnabled" -and $checksum.UdpIPv4Enabled -eq "RxTxEnabled") {
             $returnstatus = $true
        }
        else {
            $returnstatus = $false
        }
    }
    elseif($Protocol -eq "IPV6") {
        if($checksum.TcpIPv6Enabled -eq "RxTxEnabled" -and $checksum.UdpIPv6Enabled -eq "RxTxEnabled") {
            $returnstatus = $true
        }
        else {
           $returnstatus = $false
        }
     } 
     
}elseif($status -eq "Disable")
    {

    if($Protocol -eq "IPV4") {
        if($checksum.IpIPv4Enabled -eq "RxTxEnabled" -or $checksum.TcpIPv4Enabled -eq "RxTxEnabled" -or $checksum.UdpIPv4Enabled -eq "RxTxEnabled") {
            $returnstatus = $False
        }
        else {
            $returnstatus = $True
        }
    }
    elseif($Protocol -eq "IPV6") {
        if($checksum.TcpIPv6Enabled -eq "RxTxEnabled" -or $checksum.UdpIPv6Enabled -eq "RxTxEnabled") {
            $returnstatus = $false
      }
      else {
           $returnstatus = $True
       }
     }
}
    
    $returnValue = @{
    NetworkAdapterName = $NetworkAdapterName
    Protocol = $Protocol
    status = $returnstatus
    }
    $returnValue
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $NetworkAdapterName,

        [parameter(Mandatory = $true)]
        [ValidateSet("IPV4","IPV6")]
        [System.String]
        $Protocol,

        [parameter(Mandatory = $true)]
        [ValidateSet("Enable","Disable")]
        [System.String]
        $status
    )
    $checksum = Get-NetAdapterChecksumOffload | ?{$_.name -eq $NetworkAdapterName}

    if($status -eq "Enable")   {

    if($Protocol -eq "IPV4") {
                  
        Set-NetAdapterChecksumOffload -name $NetworkAdapterName -IpIPv4Enabled "RxTxEnabled" -TcpIPv4Enabled "RxTxEnabled" -UdpIPv4Enabled -eq "RxTxEnabled"
        } 
    elseif($Protocol -eq "IPV6") {
            Set-NetAdapterChecksumOffload -name $NetworkAdapterName -TcpIPv6Enabled "RxTxEnabled" -UdpIPv6Enabled "RxTxEnabled"
        
     } 
     
    }elseif($status -eq "Disable"){

    if($Protocol -eq "IPV4") {
                  
            Set-NetAdapterChecksumOffload -name $NetworkAdapterName -IpIPv4Enabled "Disabled" -TcpIPv4Enabled "Disabled" -UdpIPv4Enabled -eq "Disabled"
        } 
    elseif($Protocol -eq "IPV6") {
            Set-NetAdapterChecksumOffload -name $NetworkAdapterName -TcpIPv6Enabled "Disabled" -UdpIPv6Enabled "Disabled"
        
     } 
    
}



}





function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $NetworkAdapterName,

        [parameter(Mandatory = $true)]
        [ValidateSet("IPV4","IPV6")]
        [System.String]
        $Protocol,

        [parameter(Mandatory = $true)]
        [ValidateSet("Enable","Disable")]
        [System.String]
        $status
    )

   $checksum = Get-NetAdapterChecksumOffload | ?{$_.name -eq $NetworkAdapterName}

    if($status -eq "Enable")
    {

    if($Protocol -eq "IPV4") {
        if($checksum.IpIPv4Enabled -eq "RxTxEnabled" -and $checksum.TcpIPv4Enabled -eq "RxTxEnabled" -and $checksum.UdpIPv4Enabled -eq "RxTxEnabled") {
             $returnstatus = $true
        }
        else {
            $returnstatus = $false
        }
    }
    elseif($Protocol -eq "IPV6") {
        if($checksum.TcpIPv6Enabled -eq "RxTxEnabled" -and $checksum.UdpIPv6Enabled -eq "RxTxEnabled") {
            $returnstatus = $true
        }
        else {
           $returnstatus = $false
        }
     } 
     
}elseif($status -eq "Disable")
    {

    if($Protocol -eq "IPV4") {
        if($checksum.IpIPv4Enabled -eq "RxTxEnabled" -or $checksum.TcpIPv4Enabled -eq "RxTxEnabled" -or $checksum.UdpIPv4Enabled -eq "RxTxEnabled") {
            $returnstatus = $False
        }
        else {
            $returnstatus = $True
        }
    }
    elseif($Protocol -eq "IPV6") {
        if($checksum.TcpIPv6Enabled -eq "RxTxEnabled" -or $checksum.UdpIPv6Enabled -eq "RxTxEnabled") {
            $returnstatus = $false
      }
      else {
           $returnstatus = $True
       }
     }
}

      return $returnstatus 
}


Export-ModuleMember -Function *-TargetResource

