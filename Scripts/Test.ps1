$DSC = [IO.Path]::DirectorySeparatorChar

Import-Module ('..{0}PSNitrado{0}PSNitrado.psm1' -f $DSC) -Force

$TokenPath = [Environment]::GetEnvironmentVariable('HOME')
$TokenName = '.nitradotoken'
[int]$GameserverId = 4089632
$Dir = '/games/ni1429468_1/noftp/dayzps/config/'
#$Search = '*.ADM'
$Search = '*_10_30_*ADM'

$Token = Get-NitradoToken -Path ('{0}/{1}' -f $TokenPath, $TokenName)
$Result = Get-NitradoGameserverFile -Token $Token -Id $GameserverId -Dir $Dir -Search $Search
$Result

<#
$Result = Get-NitradoGameserver -Token $Token -Id $GameserverId
$Result = Get-NitradoUser -Token $Token
$Result = Get-NitradoGameserverBackup -Token $Token -Id $GameserverId
$Result = Get-NitradoService -Token $Token
$Result = Get-NitradoPing -Token $Token
$Result = Get-NitradoMaintenance -Token $Token
#>