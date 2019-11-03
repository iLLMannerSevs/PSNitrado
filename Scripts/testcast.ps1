$Json = @'
{
    "status": "success",
    "data": {
        "user": {
            "user_id": 3028307,
            "username": "fheiland",
            "activated": true,
            "timezone": "Europe/Berlin",
            "email": "falkheiland@gmail.com",
            "credit": 0,
            "currency": "EUR",
            "registered": "2019-09-03T13:48:48",
            "language": "deu",
            "avatar": null,
            "donations": true,
            "phone": {
                "number": null,
                "country_code": null,
                "verified": false
            },
            "two_factor": [],
            "profile": {
                "name": "Erwin Muster",
                "street": "Strasse",
                "postcode": "",
                "city": "",
                "country": "DE",
                "state": "AZ",
                "country_and_state_verified": true
            },
            "permissions": [
                "CLOUDSERVER"
            ],
            "employee": false
        }
    }
}
'@
$InputObject = ($Json | ConvertFrom-Json).data.user

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

$TypeColl = $PropertyColl.GetEnumerator().Name
$Result = foreach ($Type in $TypeColl)
{
  #$Type
  foreach ($Property in $PropertyColl.$($Type))
  {
    $Name = ((Get-Culture).TextInfo.ToTitleCase($Property).Split('_').Split('.') -join '').Replace(' ', '')
    $Value = (Invoke-Expression "`$inputObject.$Property")
    $Properties = @{
      $Name = $Value
    }
    $Properties
  }
}
$Result