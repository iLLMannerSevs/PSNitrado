function Get-NitradoPropertyCast
{
  <#
  .EXAMPLE
  Get-NitradoPropertyCast -APIObjectColl $APIObjectColl -PropertyColl $PropertyColl

  #>

  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    $APIObjectColl,

    [Parameter(Mandatory)]
    $PropertyColl
  )

  begin
  {
  }
  process
  {
    $TypeColl = $PropertyColl.GetEnumerator().Name
    $Result = foreach ($Type in $TypeColl)
    {
      foreach ($Property in $PropertyColl.$($Type))
      {
        $Name = ((Get-Culture).TextInfo.ToTitleCase($Property).Split('_').Split('.') -join '').Replace(' ', '')
        $Value = (Invoke-Expression "`$APIObjectColl.$Property")
        $Properties = @{
          $Name = $Value
        }
        $Properties
      }
    }
    $Result
  }
  end
  {
  }
}

<#
#>