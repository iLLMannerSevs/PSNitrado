---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Export-NitradoToken

## SYNOPSIS
Export Token to Secure String to file.

## SYNTAX

```
Export-NitradoToken [-Token] <String> [-Path] <FileInfo> [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
Export Token to Secure String to file for use in the Nitrado API.

## EXAMPLES

### Example 1
```powershell
$Properties = @{
Token    = 'Ox7YqB_8X7DPbGssVj5lw8v-VBzBYnyUMcZzwljZmPvIq_q648hmtt87Ry0WCwGNCdHmNsWBRwHNu5TMO3ncHg2G9OVARG0jpiE6'
  Path     = ([Environment]::GetEnvironmentVariable('HOME'))
  Name     = '.nitradotoken'
}
Export-NitradoToken @Properties
```

## PARAMETERS

### -Token
Token for the API call

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
Path of the Token file

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
Name of the Token file

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
