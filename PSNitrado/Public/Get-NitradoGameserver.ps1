function Get-NitradoGameserver
{
  [CmdletBinding()]
  Param
  (
    [Parameter(Mandatory)]
    [string]
    $Token,

    [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
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