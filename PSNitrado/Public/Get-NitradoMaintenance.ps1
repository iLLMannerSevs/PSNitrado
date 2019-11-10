function Get-NitradoMaintenance
{
  [CmdletBinding()]
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
  }
  process
  {
    $Params.Add('Uri', ('{0}' -f $BaseURL))
    (Invoke-NitradoRestMethod @Params).data.maintenance
  }
  end
  {
  }
}