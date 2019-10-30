function Export-NitradoToken
{
  <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER Path

    .EXAMPLE
    $Properties = @{
      Token    = 'Ox7YqB_8X7DPbGssVj5lw8v-VBzBYnyUMcZzwljZmPvIq_q648hmtt87Ry0WCwGNCdHmNsWBRwHNu5TMO3ncHg2G9OVARG0jpiE6'
      Path     = $Env:HOME
      Name     = '.nitradotoken'
    }
    Export-NitradoToken @Properties
  #>

  [OutputType('System.String')]
  [CmdletBinding()]
  Param
  (
    [Parameter(Mandatory)]
    [string]
    $Token,

    [Parameter(Mandatory)]
    [ValidateScript( {
        if (-Not ($_ | Test-Path) )
        {
          throw "File or folder does not exist"
        }
        return $true
      })]
    [System.IO.FileInfo]
    $Path,

    [Parameter(Mandatory)]
    [string]
    $Name
  )

  begin
  {
  }
  process
  {
    try
    {
      ConvertTo-SecureString –String $Token -AsPlainText -Force |
        Export-Clixml -Path ('{0}/{1}' -f $Path, $Name)
    }
    catch
    {
      Write-Error $_.Exception.Message
    }
  }
  end
  {
  }
}