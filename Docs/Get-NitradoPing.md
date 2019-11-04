---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
schema: 2.0.0
---

# Get-NitradoPing

## SYNOPSIS

Execute Global - Health Check.

## SYNTAX

```
Get-NitradoPing [-Token] <String> [<CommonParameters>]
```

## DESCRIPTION
Execute Global - Health Check for Nitrado API.

## EXAMPLES

### Example 1
```
Get-NitradoPing -Token $Token

All systems operate as expected.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

https://doc.nitrado.net/#api-Global-DoPing