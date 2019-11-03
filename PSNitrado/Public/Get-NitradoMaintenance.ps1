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