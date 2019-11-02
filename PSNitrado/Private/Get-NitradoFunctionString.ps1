function Get-NitradoFunctionString
{
  <#
  .EXAMPLE
  $Params = [ordered]@{
    Query = 'some+message'
    Limit = '10'
    Expand = $true
    Page   = 1
    Per_page = 3
  }
  Get-ZammadFunctionString @Params

  .EXAMPLE
  $Params = [ordered]@{
    Query = "Heiland"
    Limit = 1
    Expand = $true
    Page   = 1
    Per_page = 1
  }
  Get-ZammadFunctionString @Params

  Get-ZammadFunctionString -Query "Heiland"


  /search?query=some+message&limit=10&expand=true'
  /search?query=state:new%20OR%20state:open&limit=10&expand=true'
  /search?query=smith&limit=10&expand=true'
  ?expand=true&page=1&per_page=5 HTTP/1.1

  ?dir=/games/ni1429468_1/noftp/dayzps/config/&search=*.ADM
  #>

  [CmdletBinding()]
  param (
    [string]
    $Search,

    [string]
    $Dir
  )

  begin
  {
  }
  process
  {
    foreach ($item in $PSBoundParameters.GetEnumerator())
    {
      if ($item.Value)
      {
        switch ($item)
        {
          { $_.Value -is [int] }
          {
            $Value = ($item.Value).toString()
            continue
          }
          default
          {
            $Value = $item.Value
          }
        }
      }
      $FunctionString += ('&{0}={1}' -f $($item.Key).ToLower(), $Value)
    }
    $FunctionString -replace ('^&', '?')
  }
  end
  {
  }
}