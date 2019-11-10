function Get-NitradoFunctionString
{
  <#
  .SYNOPSIS
  Construct parameter string for Nitrado API call.

  .DESCRIPTION
  Construct parameter string for Nitrado API call.

  .EXAMPLE
  Get-NitradoFunctionString -Search "*.ADM"

  .EXAMPLE
  Get-NitradoFunctionString -Dir "/games/ni1529538_1/noftp/dayzps/config/"

  .EXAMPLE
  Get-NitradoFunctionString -Dir "/games/ni1529538_1/noftp/dayzps/config/" -Search "*.ADM"
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