function Get-NitradoUser
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
    $Token
  )

  begin
  {
    $BaseURL = 'https://api.nitrado.net/user'

    $Params = @{
      Token  = $Token
      Method = 'Get'
    }
    $PropertyColl = @{
      'String'   = @(
        'username',
        'timezone',
        'email',
        'currency',
        'language',
        'avatar',
        'name',
        'street',
        'postcode',
        'city',
        'country',
        'state',
        'number',
        'country_code',
        'verified'
      )
      'Int'      = @(
        'user_id',
        'credit'
      )
      'Bool'     = @(
        'activated',
        'donations',
        'employee',
        'country_and_state_verified'
      )
      'Datetime' = @(
        'registered'
      )
      'Array'    = @(
        'two_factor',
        'permissions'
      )
      'Object'   = @(
        'phone',
        'profile'
      )
    }
  }
  process
  {

    $Params.Add('Uri', ('{0}' -f $BaseURL))
    $APIObjectColl = (Invoke-NitradoRestMethod @Params).data.user
    $Result = Get-NitradoPropertyCast -APIObjectColl $APIObjectColl -PropertyColl $PropertyColl
    $Result
  }
  end
  {
  }
}