function Get-NitradoPing
{
  <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER Param1

    .PARAMETER Param2

    .EXAMPLE
    Get-NitradoPing -Token $Token
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
    $BaseURL = 'https://api.nitrado.net/ping'

    $Params = @{
      Token  = $Token
      Method = 'Get'
    }
    $PropertyColl = @{
      'String' = @(
        'message'
      )
    }
  }
  process
  {

    $Params.Add('Uri', ('{0}' -f $BaseURL))
    $APIObjectColl = (Invoke-NitradoRestMethod @Params)
    $Result = Get-NitradoPropertyCast -APIObjectColl $APIObjectColl -PropertyColl $PropertyColl
    $Result.message
  }
  end
  {
  }
}