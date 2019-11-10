---
external help file: PSNitrado-help.xml
Module Name: PSNitrado
online version:
schema: 2.0.0
---

# Export-NitradoGameserverFile

## SYNOPSIS
Download gameserver file.

## SYNTAX

```
Export-NitradoGameserverFile [-Token] <String> [-Id] <Int32> [-File] <String> [[-Path] <FileInfo>]
 [<CommonParameters>]
```

## DESCRIPTION
Download gameserver file from the Nitrado API.

## EXAMPLES

### Example 1
```powershell
Export-NitradoGameserverFile -Token $Token -Id 4401233 -Path C:\Temp -File '/games/ni1434321_1/noftp/dayzps/config/DayZServer_PS4_x64.ADM'
```

### Example 2
```powershell
$Gameserver = Get-NitradoGameserver -Token $Token -Id $GameserverId
$BasePath = ([regex]::match($Gameserver.game_specific.path, '^(?<Path>.+noftp\/)').captures.groups).Where{ $_.Name -eq 'Path' }.Value
$Result = foreach ($Logfile in $Gameserver.game_specific.log_files)
{
  '{0}{1}' -f $BasePath, $Logfile |
  Export-NitradoGameserverFile -Token $Token -Id $GameserverId -Path $DestDir
}
$Result

url      : https://fileserver.nitrado.net/umkn031/download/?token=250bf9c5-0ce2-46ea-a87f-e392373a34fa
token    : 250bf9c5-0ce2-46ea-a87f-e392373a34fa
location : C:\Temp\DayZServer_PS4_x64.ADM

url      : https://fileserver.nitrado.net/umkn031/download/?token=0f32d651-db5d-4468-9b40-51345c53fce7
token    : 0f32d651-db5d-4468-9b40-51345c53fce7
location : C:\Temp\DayZServer_PS4_x64_2019_11_09_230540910.ADM

url      : https://fileserver.nitrado.net/umkn031/download/?token=d7d143d8-4c7a-4d64-8926-69f650ba2219
token    : d7d143d8-4c7a-4d64-8926-69f650ba2219
location : C:\Temp\DayZServer_PS4_x64_2019_11_09_180221029.ADM

url      : https://fileserver.nitrado.net/umkn031/download/?token=05b8d597-e305-43aa-bff7-f4de9531eb7c
token    : 05b8d597-e305-43aa-bff7-f4de9531eb7c
location : C:\Temp\DayZServer_PS4_x64_2019_11_09_130216532.ADM

url      : https://fileserver.nitrado.net/umkn031/download/?token=bbfa03f7-bc9f-442f-9b42-be6290e2e2b3
token    : bbfa03f7-bc9f-442f-9b42-be6290e2e2b3
location : C:\Temp\DayZServer_PS4_x64_2019_11_09_090255261.ADM
```

Download all logfiles from a Dayz Server.

## PARAMETERS

### -File
Path of the file to download

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id
Gameserver Id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Destination path for the downloaded files

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

https://doc.nitrado.net/#api-Gameserver-GameserverFilesDownload
