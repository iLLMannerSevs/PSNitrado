function Get-NitradoGameserverBackup
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
    $Params.Add('Uri', ('{0}/{1}/gameservers/backups' -f $BaseURL, $Id))
    (Invoke-NitradoRestMethod @Params).data.backups
  }
  end
  {
  }
}