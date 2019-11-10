---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Get-NitradoGameserverBackup

## SYNOPSIS

Get gameserver backups.

## SYNTAX

```
Get-NitradoGameserverBackup [-Token] <String> [-Id] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Get gameserver backups from the Nitrado API.

## EXAMPLES

### Example 1
```
Get-NitradoGameserverBackup -Token $Token -Id 4311229

database                          gameserver
--------                          ----------
@{ni1417868_2_DB=System.Object[]} @{dayzps=System.Object[]}
```

### Example 2
```
(Get-NitradoGameserverBackup -Token $Token -Id 4311229).gameserver.dayzps[0]

backup_size      : 33355990
backup_file_size : 33355990
backup_timestamp : 1572586007
backup_type      : master
backup_number    : 35
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
Default value: 0
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

## OUTPUTS

## NOTES

## RELATED LINKS

https://doc.nitrado.net/#api-Gameserver-BackupList
