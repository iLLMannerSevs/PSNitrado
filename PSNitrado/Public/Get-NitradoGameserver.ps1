function Get-NitradoGameserver
{
  <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER Param1

    .PARAMETER Param2

    .EXAMPLE
    Get-NitradoMaintenance -Token $Token
  #>

  [CmdletBinding()]
  Param
  (
    [Parameter(Mandatory)]
    [string]
    $Token,

    [Parameter(Mandatory)]
    [int]
    $Id
  )

  begin
  {
    $BaseURL = 'https://api.nitrado.net/services'

    $Params = @{
      Token  = $Token
      Method = 'Get'
    }
  }
  process
  {
    $Params.Add('Uri', ('{0}/{1}/gameservers' -f $BaseURL, $Id))
    (Invoke-NitradoRestMethod @Params).data.gameserver
  }
  end
  {
  }
}