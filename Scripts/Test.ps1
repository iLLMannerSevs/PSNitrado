$DSC = [IO.Path]::DirectorySeparatorChar

Import-Module ('..{0}PSNitrado{0}PSNitrado.psm1' -f $DSC) -Force

$TokenPath = [Environment]::GetEnvironmentVariable('HOME')
$TokenName = '.nitradotoken'
[int]$GameserverId = 4089632
$SourceDir = '/games/ni1429468_1/noftp/dayzps/config/'
$Search = '*ADM'
$File = '/games/ni1429468_1/noftp/dayzps/config/DayZServer_PS4_x64.ADM'
$DestDir = [IO.Path]::GetTempPath()

$Token = Get-NitradoToken -Path ('{0}/{1}' -f $TokenPath, $TokenName)
$Result = Get-NitradoService -Token $Token -Id 4558109
$Result
<#
$Result = Get-NitradoService -Token $Token
$Result = Get-NitradoUser -Token $Token
$Result = (Get-NitradoGameserverFile -Token $Token -Id $GameserverId -Dir $SourceDir -Search $Search).foreach{
  Export-NitradoGameserverFile -Token $Token -Id $GameserverId -Path $DestDir -File $_.path
}
$Result = Get-NitradoGameserverFile -Token $Token -Id $GameserverId -Dir $SourceDir -Search $Search
$Result = Export-NitradoGameserverFile -Token $Token -Id $GameserverId -Path $DestDir -File $File
$Result = Get-NitradoGameserver -Token $Token -Id $GameserverId
$Result = Get-NitradoGameserverBackup -Token $Token -Id $GameserverId
$Result = Get-NitradoPing -Token $Token
$Result = Get-NitradoMaintenance -Token $Token
$Result = Get-NitradoToken -Path ('{0}/{1}' -f $TokenPath, $TokenName)
#>