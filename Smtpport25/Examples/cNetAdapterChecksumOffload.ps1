Configuration ConfigureNetAdapter
{
    param
    (
        [Parameter()]
        [System.String[]]
        $NodeName = 'localhost'
    )

  Import-DscResource -Module smtpport25
 
   Node $NodeName
    {
      
        cNetAdapterChecksumOffload NetAdapterChecksumOffload 
        {
            NetworkAdapterName = "Ethernet"
            Protocol = "IPV4"
            status = "Enable"
       }
   
   }

}