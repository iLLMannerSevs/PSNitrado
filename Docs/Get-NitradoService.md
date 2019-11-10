---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Get-NitradoService

## SYNOPSIS

Get service details.

## SYNTAX

### All (Default)
```
Get-NitradoService [-Token] <String> [<CommonParameters>]
```

### Id
```
Get-NitradoService [-Token] <String> [[-Id] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Get service details from the Nitrado API.

## EXAMPLES

### Example 1
```powershell
Get-NitradoService -Token $Token

id                      : 4087452
location_id             : 2
status                  : active
websocket_token         : 6dd8c6d0611a65c088a5229bd4f9e9f12b43592b
user_id                 : 3027212
comment                 :
auto_extension          : False
auto_extension_duration : 720
type                    : gameserver
type_human              : Publicserver 10 Slots
details                 : @{address=5.62.108.113:2302; name=DayZ Server; game=DayZ (PS4);
                          portlist_short=dayzps; folder_short=dayzps; slots=10}
start_date              : 2019-08-07T13:12:11
suspend_date            : 2019-10-05T12:38:42
delete_date             : 2019-10-15T12:38:42
suspending_in           : 81828
deleting_in             : 945828
username                : ni3027212_1
roles                   : {ROLE_GAMESERVER_CHANGE_GAME, ROLE_WEBINTERFACE_GENERAL_CONTROL, ROLE_WEBINTERFACE_SETTINGS_READ,
                          ROLE_WEBINTERFACE_SETTINGS_WRITE...}

id                      : 4550639
location_id             : 2
status                  : active
websocket_token         : 85061c5da8e76332971052fa26431aa94af7fe34
user_id                 : 3027212
comment                 :
auto_extension          : False
auto_extension_duration : 720
type                    : gameserver
type_human              : Publicserver 50 Slots
details                 : @{address=194.168.219.177:7120; name=Gameserver ; game=Citadel: Forged With Fire (PS4); portlist_short=citadelps;
                          folder_short=citadelps; slots=50}
start_date              : 2019-10-02T18:40:15
suspend_date            : 2020-02-31T18:07:15
delete_date             : 2020-02-10T18:07:15
suspending_in           : 7614680
deleting_in             : 8478680
username                : ni3027212_5
roles                   : {ROLE_WEBINTERFACE_GENERAL_CONTROL, ROLE_WEBINTERFACE_SETTINGS_READ, ROLE_WEBINTERFACE_SETTINGS_WRITE,
                          ROLE_WEBINTERFACE_LOGS_READ...}
```

### Example 2
```powershell
4087452 | Get-NitradoService -Token $Token

id                      : 4087452
location_id             : 2
status                  : active
websocket_token         : 6dd8c6d0611a65c088a5229bd4f9e9f12b43592b
user_id                 : 3027212
comment                 :
auto_extension          : False
auto_extension_duration : 720
type                    : gameserver
type_human              : Publicserver 10 Slots
details                 : @{address=5.62.108.113:2302; name=DayZ Server; game=DayZ (PS4);
                          portlist_short=dayzps; folder_short=dayzps; slots=10}
start_date              : 2019-08-07T13:12:11
suspend_date            : 2019-10-05T12:38:42
delete_date             : 2019-10-15T12:38:42
suspending_in           : 81828
deleting_in             : 945828
username                : ni3027212_1
roles                   : {ROLE_GAMESERVER_CHANGE_GAME, ROLE_WEBINTERFACE_GENERAL_CONTROL, ROLE_WEBINTERFACE_SETTINGS_READ,
                          ROLE_WEBINTERFACE_SETTINGS_WRITE...}
```

## PARAMETERS

### -Id
Service Id

```yaml
Type: Int32
Parameter Sets: Id
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Token
Token for the API call

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

https://doc.nitrado.net/#api-Service-List

https://doc.nitrado.net/#api-Service-Details
