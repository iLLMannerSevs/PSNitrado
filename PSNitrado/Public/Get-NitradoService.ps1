function Get-NitradoService
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
    $BaseURL = 'https://api.nitrado.net/services'

    $Params = @{
      Token  = $Token
      Method = 'Get'
    }
    $PropertyColl = @{
      'String'   = @(
        'status',
        'websocket_token',
        'comment',
        'type',
        'type_human'
        'address',
        'name',
        'game',
        'portlist_short',
        'folder_short',
        'username'
      )
      'Int'      = @(
        'id',
        'location_id',
        'user_id',
        'auto_extension_duration',
        'slots',
        'suspending_in',
        'deleting_in'
      )
      'Bool'     = @(
        'auto_extension'
      )
      'Datetime' = @(
        'start_date',
        'suspend_date',
        'delete_date'
      )
      'Array'    = @(
        'roles'
      )
      'Object'   = @(
        'details'
      )
    }
  }
  process
  {

    $Params.Add('Uri', ('{0}' -f $BaseURL))
    $APIObjectColl = (Invoke-NitradoRestMethod @Params).data.services
    $Result = Get-NitradoPropertyCast -APIObjectColl $APIObjectColl -PropertyColl $PropertyColl
    $Result
  }
  end
  {
  }
}