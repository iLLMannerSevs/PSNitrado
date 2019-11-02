function Get-NitradoGameserverFile
{
  <#
    .SYNOPSIS

    .DESCRIPTION

    .PARAMETER Param1

    .PARAMETER Param2

    .EXAMPLE
    Get-NitradoMaintenance -Token $Token
  #>

  [CmdletBinding(DefaultParameterSetName = 'All')]
  Param
  (
    [Parameter(Mandatory)]
    [string]
    $Token,

    [Parameter(Mandatory)]
    [int]
    $Id,

    [Parameter(ParameterSetName = 'Search')]
    [string]
    $Search,

    [Parameter(ParameterSetName = 'Search')]
    [string]
    $Dir
  )

  begin
  {
    $BaseURL = 'https://api.nitrado.net/services'
    switch ($PsCmdlet.ParameterSetName)
    {
      'Search'
      {
        $FunctionStringParams = [ordered]@{ }
        if ($Search)
        {
          $FunctionStringParams.Add('Search', $Search)
        }
        if ($Dir)
        {
          $FunctionStringParams.Add('Dir', $Dir)
        }
        $FunctionString = Get-NitradoFunctionString @FunctionStringParams
      }
    }
    $Params = @{
      Token  = $Token
      Method = 'Get'
    }
  }
  process
  {
    switch ($PsCmdlet.ParameterSetName)
    {
      'Search'
      {
        $Params.Add('Uri', ('{0}/{1}/gameservers/file_server/list{2}' -f $BaseURL, $Id, $FunctionString))
        $Result = (Invoke-NitradoRestMethod @Params).data.entries
      }
      'All'
      {
        $Params.Add('Uri', ('{0}/{1}/gameservers/file_server/list' -f $BaseURL, $Id))
        $Result = (Invoke-NitradoRestMethod @Params).data.entries
      }
    }
    $Result
  }
  end
  {
  }
}