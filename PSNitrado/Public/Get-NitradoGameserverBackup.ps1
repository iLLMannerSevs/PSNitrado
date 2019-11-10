function Get-NitradoGameserverBackup
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
    $Params.Add('Uri', ('{0}/{1}/gameservers/backups' -f $BaseURL, $Id))
    (Invoke-NitradoRestMethod @Params).data.backups
  }
  end
  {
  }
}