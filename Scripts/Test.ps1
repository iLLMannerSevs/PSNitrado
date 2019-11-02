Import-Module ../PSNitrado/PSNitrado.psm1 -Force

$TokenPath = [Environment]::GetEnvironmentVariable('HOME')
$TokenName = '.nitradotoken'
[int]$GameserverId = 4089632

$Token = Get-NitradoToken -Path ('{0}/{1}' -f $TokenPath, $TokenName)
$Result = Get-NitradoUser -Token $Token
$Result

<#
Get-NitradoGameserverBackup -Token $Token -Id $GameserverId
Get-NitradoGameserver -Token $Token -Id $GameserverId
Get-NitradoService -Token $Token
Get-NitradoPing -Token $Token
Get-NitradoMaintenance -Token $Token
#>