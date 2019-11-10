function Get-NitradoToken
{
  [OutputType('System.String')]
  [CmdletBinding()]
  Param
  (
    [Parameter(Mandatory)]
    [ValidateScript( {
        if (-Not ($_ | Test-Path) )
        {
          throw "File or folder does not exist"
        }
        return $true
      })]
    [System.IO.FileInfo]
    $Path
  )

  begin
  {
  }
  process
  {
    try
    {
      $SecureString = Import-Clixml -Path $Path
      $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
      [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
      [Runtime.InteropServices.Marshal]::FreeBSTR($bstr)
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