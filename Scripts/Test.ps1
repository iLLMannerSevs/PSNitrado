Import-Module ../PSNitrado/PSNitrado.psm1 -Force

$TokenPath = $Env:HOME
$TokenName = '.nitradotoken'
[int]$GameserverId = 4089632

$Token = Get-NitradoToken -Path ('{0}/{1}' -f $TokenPath, $TokenName)
Get-NitradoGameserverBackup -Token $Token -Id $GameserverId

<#
Get-NitradoGameserver -Token $Token -Id $GameserverId
Get-NitradoService -Token $Token
Get-NitradoPing -Token $Token
Get-NitradoUser -Token $Token
Get-NitradoMaintenance -Token $Token
#>