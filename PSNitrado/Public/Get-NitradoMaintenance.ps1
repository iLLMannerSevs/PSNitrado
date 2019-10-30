function Get-NitradoMaintenance
{
  <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER Param1

    .PARAMETER Param2

    .EXAMPLE
    Get-NitradoMaintenance -Token $Token
  #>

  [CmdletBinding(DefaultParameterSetName = 'All')]
  Param
  (
    [Parameter(Mandatory)]
    [string]
    $Token
  )

  begin
  {
    $BaseURL = 'https://api.nitrado.net/maintenance'

    $Params = @{
      Token  = $Token
      Method = 'Get'
    }
    $PropertyColl = @{
      'Bool' = @(
        'cloud_backend',
        'domain_backend'
        'dns_backend'
        'pmacct_backend'
      )
    }
  }
  process
  {

    $Params.Add('Uri', ('{0}' -f $BaseURL))
    $APIObjectColl = (Invoke-NitradoRestMethod @Params).data.maintenance
    $Result = Get-NitradoPropertyCast -APIObjectColl $APIObjectColl -PropertyColl $PropertyColl
    $Result
  }
  end
  {
  }
}