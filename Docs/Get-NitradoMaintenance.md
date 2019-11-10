---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Get-NitradoMaintenance

## SYNOPSIS

Get Global - Maintenance status.

## SYNTAX

```
Get-NitradoMaintenance [-Token] <String> [<CommonParameters>]
```

## DESCRIPTION
Global - Maintenance status from the Nitrado API.

## EXAMPLES

### Example 1
```powershell
Get-NitradoMaintenance -Token $Token

cloud_backend domain_backend dns_backend pmacct_backend
------------- -------------- ----------- --------------
        False          False       False          False
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

[Global - Maintenance status](https://doc.nitrado.net/#api-Global-GetMaintenance)