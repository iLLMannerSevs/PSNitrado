function Get-NitradoService
{
  [CmdletBinding(DefaultParameterSetName = 'All')]
  Param
  (
    [Parameter(Mandatory)]
    [string]
    $Token,

    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, ParameterSetName = 'Id')]
    [int]
    $Id
  )

  begin
  {
    $BaseURL = 'https://api.nitrado.net/services'
  }
  process
  {
    $Params = @{
      Token  = $Token
      Method = 'Get'
    }
    switch ($PsCmdlet.ParameterSetName)
    {
      'All'
      {
        $Params.Add('Uri', ('{0}' -f $BaseURL))
        $Result = (Invoke-NitradoRestMethod @Params).data.services
      }
      'Id'
      {
        $Params.Add('Uri', ('{0}/{1}' -f $BaseURL, $Id))
        $Result = (Invoke-NitradoRestMethod @Params).data.service
      }
    }
    $Result
  }
  end
  {
  }
}