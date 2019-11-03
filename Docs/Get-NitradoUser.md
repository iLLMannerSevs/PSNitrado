---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Get-NitradoUser

## SYNOPSIS
Get user details.

## SYNTAX

```
Get-NitradoUser [-Token] <String> [<CommonParameters>]
```

## DESCRIPTION
Get user details from the Nitrado API.

## EXAMPLES

### Example 1
```powershell
Get-NitradoUser -Token $Token

user_id     : 3027212
username    : mmustermann
activated   : True
timezone    : Europe/Berlin
email       : mmustermann@gmail.com
credit      : 0
currency    : EUR
registered  : 2019-03-03T13:01:42
language    : deu
avatar      :
donations   : True
phone       : @{number=; country_code=; verified=False}
two_factor  : {}
profile     : @{name=; street=; postcode=; city=; country=DE; state=; country_and_state_verified=True}
permissions : {CLOUDSERVER}
employee    : False
```


## PARAMETERS

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

### Keine

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
https://doc.nitrado.net/#api-User-Details
