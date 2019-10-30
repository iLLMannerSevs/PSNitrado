function Get-NitradoPropertyCast
{
  <#
  .EXAMPLE
  Get-NitradoPropertyCast -APIObjectColl $APIObjectColl -CastedPropertyColl $CastedPropertyColl

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
    $Result = foreach ($APIObject in $APIObjectColl)
    {
      $CastedPropertyColl = @{ }
      foreach ($StringProperty in $PropertyColl.String)
      {
        $Name = ((Get-Culture).TextInfo.ToTitleCase($StringProperty).Split('_') -join '').Replace(' ', '')
        if ($APIObject.($StringProperty))
        {
          $Value = [String]$APIObject.($StringProperty)
          $CastedPropertyColl.Add($Name, $Value)
        }
      }
      foreach ($IntProperty in $PropertyColl.Int)
      {
        $Name = ((Get-Culture).TextInfo.ToTitleCase($IntProperty).Split('_') -join '').Replace(' ', '')
        if ($APIObject.($IntProperty))
        {
          $Value = [Int]$APIObject.($IntProperty)
          $CastedPropertyColl.Add($Name, $Value)
        }
      }
      foreach ($BoolProperty in $PropertyColl.Bool)
      {
        $Name = ((Get-Culture).TextInfo.ToTitleCase($BoolProperty).Split('_') -join '').Replace(' ', '')
        $Value = [System.Convert]::ToBoolean($APIObject.($BoolProperty))
        $CastedPropertyColl.Add($Name, $Value)
      }
      foreach ($DatetimeProperty in $PropertyColl.Datetime)
      {
        $Name = ((Get-Culture).TextInfo.ToTitleCase($DatetimeProperty).Split('_') -join '').Replace(' ', '')
        if ($APIObject.($DatetimeProperty))
        {
          $Value = [System.Convert]::ToDateTime($APIObject.($DatetimeProperty))
          $CastedPropertyColl.Add($Name, $Value)
        }
      }
      foreach ($ArrayProperty in $PropertyColl.Array)
      {
        $Name = ((Get-Culture).TextInfo.ToTitleCase($ArrayProperty).Split('_') -join '').Replace(' ', '')
        if ($APIObject.($ArrayProperty))
        {
          $Value = [array]$APIObject.($ArrayProperty)
          $CastedPropertyColl.Add($Name, $Value)
        }
      }
      foreach ($ObjectProperty in $PropertyColl.Object)
      {
        $Name = ((Get-Culture).TextInfo.ToTitleCase($ObjectProperty).Split('_') -join '').Replace(' ', '')
        if ($APIObject.($ObjectProperty))
        {
          $Value = [pscustomobject]$APIObject.($ObjectProperty)
          $CastedPropertyColl.Add($Name, $Value)
        }
      }
      New-Object psobject -Property $CastedPropertyColl
    }
    $Result
  }
  end
  {
  }
}