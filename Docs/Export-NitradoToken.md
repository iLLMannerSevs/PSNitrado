---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Export-NitradoToken

## SYNOPSIS

## SYNTAX

```
Export-NitradoToken [-Token] <String> [-Path] <FileInfo> [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### BEISPIEL 1
```
$Properties = @{
```

Token    = 'Ox7YqB_8X7DPbGssVj5lw8v-VBzBYnyUMcZzwljZmPvIq_q648hmtt87Ry0WCwGNCdHmNsWBRwHNu5TMO3ncHg2G9OVARG0jpiE6'
  Path     = \[Environment\]::GetEnvironmentVariable('HOME')
  Name     = '.nitradotoken'
}
Export-NitradoToken @Properties

## PARAMETERS

### -Token
{{ Fill Token Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
{{ Fill Path Description }}

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
{{ Fill Name Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES

## RELATED LINKS
