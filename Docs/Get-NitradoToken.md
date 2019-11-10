---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Get-NitradoToken

## SYNOPSIS

Get Token from Secure String.

## SYNTAX

```
Get-NitradoToken [-Path] <FileInfo> [<CommonParameters>]
```

## DESCRIPTION
Get Token from Secure String for use in the Nitrado API.

## EXAMPLES

### Example 1
```powershell
Get-NitradoToken -Path ('{0}/.nitradotoken' -f $Env:HOME)

Ox7YqB_9X7DPbGssDE98w8v-VBz4KdyUMcZzwljZmPvIq_q648hmtt87Ry0WCwGNCdKnfsWBRwHNi4GMO32hHg2G9OVAlG0jpiF8
```

## PARAMETERS

### -Path
Path to the Token file

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
