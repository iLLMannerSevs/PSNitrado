function Export-NitradoGameserverFile
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
    $Id,

    [Parameter(Mandatory)]
    [string]
    $File,

    [ValidateScript( {
        if (-Not ($_ | Test-Path) )
        {
          throw "File or folder does not exist"
        }
        return $true
      })]
    [System.IO.FileInfo]$Path
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
    $Params.Add('Uri', ('{0}/{1}/gameservers/file_server/download?file={2}' -f $BaseURL, $Id, $File))
    $Result = (Invoke-NitradoRestMethod @Params).data.token
    $FileName = ([regex]::match($File, '^.+\/(?<FileName>.+)$').captures.groups).Where{
      $_.Name -eq 'FileName'
    }.Value
    try
    {
      Invoke-WebRequest -Uri $Result.url -OutFile ('{0}{1}' -f $Path, $FileName)
    }
    catch
    {
      throw $PSItem.Exception
    }
    $Result |
    Add-Member -MemberType NoteProperty -Name 'location' -Value ('{0}{1}' -f $Path, $FileName) -PassThru
  }
  end
  {
  }
}