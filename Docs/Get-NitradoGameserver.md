---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Get-NitradoGameserver

## SYNOPSIS
Get gameserver.

## SYNTAX

```
Get-NitradoGameserver [-Token] <String> [-Id] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Get gameserver from the Nitrado API.

## EXAMPLES

### Example 1
```powershell
Get-NitradoGameserver -Token $Token -Id 4401229

status          : started
must_be_started : True
websocket_token : eb3eecdc7cc75aac1ec8737c830f2b45071abab3
hostsystems     : @{linux=; windows=}
username        : ni1417448_1
user_id         : 1417448
service_id      : 4401229
location_id     : 6
minecraft_mode  : False
ip              : 95.156.171.127
ipv6            :
port            : 10800
query_port      : 10803
rcon_port       : 10803
label           : ni
type            : Gameserver
memory          : Standard
memory_mb       : 6144
game            : dayzps
game_human      : DayZ (PS4)
game_specific   : @{path=/games/ni1417448_1/noftp/dayzps/; update_status=up_to_date; last_update=2019-11-07T16:30:30;
                  path_available=True; features=; log_files=System.Object[]; config_files=System.Object[]}
modpacks        :
slots           : 100
location        : GB
credentials     : @{ftp=; mysql=}
settings        : @{config=; general=}
quota           : @{block_usage=158792; block_softlimit=10485760; block_hardlimit=15728640; file_usage=412; file_softlimit=1200000; file_hardlimit=2000000}
query           : @{server_name=Best DayZ Server; connect_ip=95.156.171.127:10800;
                  map=dayzOffline.chernarusplus; version=v1.05.152699; player_current=27; player_max=50; players=System.Object[]}  
```

### Example 2
```powershell
(4401229 | Get-NitradoGameserver -Token $Token).settings.config.password

p4Ssw0rD
```

## PARAMETERS

### -Id
Gameserver Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
https://doc.nitrado.net/#api-Gameserver-Details
