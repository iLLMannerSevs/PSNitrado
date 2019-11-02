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

  [CmdletBinding()]
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
  }
  process
  {
    $Params.Add('Uri', ('{0}' -f $BaseURL))
    (Invoke-NitradoRestMethod @Params).message
  }
  end
  {
  }
}