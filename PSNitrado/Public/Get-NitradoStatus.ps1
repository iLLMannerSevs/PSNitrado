function Get-NitradoStatus
{
  [cmdletbinding()]
  param
  (
    [Parameter(Mandatory)]
    [String]
    $Computername,

    [ValidateRange(0, 65535)]
    [Int]
    $TCPPort = 8443,

    [ValidateSet(3)]
    [Int]
    $ApiVersion = 3,

    [Parameter(Mandatory)]
    $WebSession,
    
    [Bool]
    $SkipCertificateCheck = $true
  )

  Begin
  {
    $UriArray = @($Computername, $TCPPort, $ApiVersion)
    $BaseURL = ('https://{0}:{1}/umsapi/v{2}/serverstatus' -f $UriArray)
  }
  Process
  {
    $Params = @{
      WebSession       = $WebSession
      Method           = 'Get'
      ContentType      = 'application/json'
      Headers          = @{ }
      Uri              = $BaseURL
      SecurityProtocol = ($SecurityProtocol -join ',')
    }
    $APIObjectColl = Invoke-UMSRestMethodWebSession @Params

    $Result = foreach ($APIObject in $APIObjectColl)
    {
      $Properties = [ordered]@{
        'RmGuiServerVersion' = [String]$APIObject.rmGuiServerVersion
        'BuildNumber'        = [Int]$APIObject.buildNumber
        'ActiveMqVersion'    = [String]$APIObject.activeMQVersion
        'DerbyVersion'       = [String]$APIObject.derbyVersion
        'ServerUuid'         = [String]$APIObject.serverUUID
        'Server'             = [String]$APIObject.server
      }
      New-Object psobject -Property $Properties
    }
    $Result
  }
  End
  {
  }
}

