$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "PesterDSCTemplate" {
    
    # Replace with target Resourece PSM1 file path
    $ResourecePSM1filepath = "C:\Program Files\WindowsPowerShell\Modules\Smtpport25\DSCResources\cNetAdapterChecksumOffload\cNetAdapterChecksumOffload.psm1"
    Copy-Item $ResourecePSM1filepath TestDrive:\PesterTest.ps1 -Force
    Mock Export-ModuleMember {return $true}
    . "TestDrive:\PesterTest.ps1"
 

    #Pass necessary parameters with Data for Get Method
    It "Test if the Get-TargetResource return a hashtable" {
        (Get-TargetResource -NetworkAdapterName "Ethernet" -Protocol "IPV4" -status "Enable").GetType() -as [string] | Should Be 'hashtable'
    }
 
    #Pass necessary parameters with Data for Test Method
    It "Test if the Test-TargetResource return true or false" {
        (Test-TargetResource -NetworkAdapterName "Ethernet" -Protocol "IPV4" -status "Enable").GetType() -as [string] | Should Be 'bool'
    }


} 