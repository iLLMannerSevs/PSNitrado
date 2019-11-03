function Get-NitradoUser
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
    $BaseURL = 'https://api.nitrado.net/user'
    $Params = @{
      Token  = $Token
      Method = 'Get'
    }
  }
  process
  {
    $Params.Add('Uri', ('{0}' -f $BaseURL))
    $Result = (Invoke-NitradoRestMethod @Params).data.user
    $Result
  }
  end
  {
  }
}