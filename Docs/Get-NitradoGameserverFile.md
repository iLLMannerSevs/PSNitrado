---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Get-NitradoGameserverFile

## SYNOPSIS
Get gameserver files.

## SYNTAX

### All (Default)
```
Get-NitradoGameserverFile [-Token] <String> [-Id] <Int32> [<CommonParameters>]
```

### Search
```
Get-NitradoGameserverFile [-Token] <String> [-Id] <Int32> [[-Search] <String>] [[-Dir] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Get gameserver files from the Nitrado API.

## EXAMPLES

### Example 1
```powershell
Get-NitradoGameserverFile -Token $Token -Id 4556459 -Dir '/games/ni1445168_5/ftproot/' -Search '*log'

chmod       : 100666
accessed_at : 1572717345
group       : ni1445168_5
path        : /games/ni1445168_5/ftproot/restart.log
type        : file
owner       : ni1445168_5
name        : restart.log
size        : 5276
created_at  : 1573117350
modified_at : 1573117350
```

## PARAMETERS

### -Dir
Directory to list, default value: Home directory

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Service Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Benannt
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Search
Search pattern for specific files

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: False
Position: Benannt
Default value: None
Accept pipeline input: False
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
[Gameserver - Files - List](https://doc.nitrado.net/#api-Gameserver-GameserverFilesList)