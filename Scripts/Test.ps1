Import-Module ../PSNitrado/PSNitrado.psm1 -Force

$TokenPath = $Env:HOME
$TokenName = '.nitradotoken'

$Token = Get-NitradoToken -Path ('{0}/{1}' -f $TokenPath, $TokenName)
Get-NitradoService -Token $Token

<#
Get-NitradoUser -Token $Token
Get-NitradoMaintenance -Token $Token
Get-NitradoPing -Token $Token

$Properties = @{
  Token = 'Ox7YqB_8X7DPbGssVj5lw8v-VBzBYnyUMcZzwljZmPvIq_q648hmtt87Ry0WCwGNCdHmNsWBRwHNu5TMO3ncHg2G9OVARG0jpiE6'
  Path  = $TokenPath
  Name  = $TokenName
}
Export-NitradoToken @Properties
#>