function Get-NitradoNTTime
{
  <#
    .SYNOPSIS
    Get NT Time from Nitrado Time

    .DESCRIPTION
    Get NT Time from Nitrado Time

    .EXAMPLE
    Get-NitradoNTTime -Time '1572586007'
    #>

  [CmdletBinding()]
  param (
    [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [string]
    $Time
  )

  begin
  {
  }
  process
  {
    [datetime]$NTTime = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds([math]::Round(($Time.Replace(',', '.')))))
    $NTTime
  }
  end
  {
  }
}