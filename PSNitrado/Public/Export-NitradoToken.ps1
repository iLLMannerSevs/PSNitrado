function Export-NitradoToken
{
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
      ConvertTo-SecureString -String $Token -AsPlainText -Force |
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