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
        'phone.number',
        'phone.country_code',
        'profile.name',
        'profile.street',
        'profile.postcode',
        'profile.city',
        'profile.country',
        'profile.state'
      )
      'Int'      = @(
        'user_id',
        'credit'
      )
      'Bool'     = @(
        'activated',
        'donations',
        'phone.verified',
        'profile.country_and_state_verified',
        'employee'
      )
      'Datetime' = @(
        'registered'
      )
      'Array'    = @(
        'two_factor',
        'permissions'
      )
      'Object'   = @(

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