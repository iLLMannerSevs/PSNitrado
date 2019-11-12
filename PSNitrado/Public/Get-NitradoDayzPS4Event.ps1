function Get-NitradoDayzPS4Event
{
  [OutputType('System.String')]
  [CmdletBinding()]
  Param
  (
    [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [ValidateScript( {
        if (-Not ($_ | Test-Path) )
        {
          throw "File or folder does not exist"
        }
        return $true
      })]
    [System.IO.FileInfo]
    $Path
  )

  begin
  {
    $PatternKeyColl = @(
      'Date'
      #'Year'
      #'Month'
      #'Day'
      'Time'
      #'Hour'
      #'Minute'
      #'Second'
      'PlayerName'
      'PlayerId'
      'PosX'
      'PosY'
      'PosZ'
      'ByPosX'
      'ByPosY'
      'ByPosZ'
      'HP'
      'Into'
      'ByX'
      'Damage'
      'With'
      'ByPlayerName'
      'ByPlayerId'
      'Disconnected'
      'Water'
      'Energy'
      'BleedSources'
      'Suicide'
      'Bledout'
    )

    #$RxDate = '(?<Year>\d{4})-(?<Month>\d{2})-(?<Day>\d{2})'
    $RxDate = '(?<Date>\d{4}-\d{2}-\d{2})'
    #$RxTime = '(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})'
    $RxTime = '(?<Time>\d{2}:\d{2}:\d{2})'
    $RxDiv01 = '\|'
    $RxPlayer = "Player\s*[`"|`'](?<PlayerName>.+)[`"|`']"
    $RxByPlayer = "Player\s*[`"|`'](?<ByPlayerName>.+)[`"|`']"
    $RxBrOp = '\('
    $RxBrCl = '\)'
    $RxPlayerId = 'id=(?<PlayerId>[\w|\-]+)='
    $RxByPlayerId = 'id=(?<ByPlayerId>[\w|\-]+)='
    $RxDead = 'DEAD'
    $RxPos = 'pos=<(?<PosX>.+),\s*(?<PosY>.+),\s*(?<PosZ>.+)>'
    $RxByPos = 'pos=<(?<ByPosX>.+),\s*(?<ByPosY>.+),\s*(?<ByPosZ>.+)>'
    $RxHp = '\[HP:\s*(?<HP>.+)\]'
    $RxInto = '(?<Into>.+)'
    $RxByX = '(?<ByX>.+)'
    $RxDamage = '(?<Damage>[\d|\.]+)'
    $RxWith = '(?<With>.+)'

    $PatternColl = [ordered]@{
      LogBegin            = ('AdminLog\s*started\s*on\s*{1}\s*at\s*{0}$' -f $RxTime, $RxDate)
      Connected           = ('^{0}\s*{1}\s*{2}\s*is\s*(?<Connected>connected)\s*{3}{5}{4}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId)
      Disconnected        = ('^{0}\s*{1}\s*{2}\s*{3}{5}{4}\s*has\s*been\s*(?<Disconnected>disconnected)$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId)
      Suicide2            = ('^{0}\s*{1}\s*{2}\s*{3}{5}{4}\s*committed\s*(?<Suicide>suicide)\.$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId)
      Conscious           = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}\s*regained\s*consciousness$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos)
      Unconscious         = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}\s*is\s*unconscious$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos)
      Suicide1            = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}\s*committed\s*(?<Suicide>suicide)$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos)
      HitByXDeadIntoWith  = ('^{0}\s*{1}\s*{2}\s*{3}{6}{4}\s*{3}{5}\s*{7}{4}{8}\s*hit\s*by\s*{10}\s*into\s*{9}\s*for\s*{11}\s*damage\s*{12}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxDead, $RxPos, $RxHp, $RxInto, $RxByX, $RxDamage, $RxWith)
      HitByPlayerWithDead = ('^{0}\s*{1}\s*{2}\s*{3}{6}{4}\s*{3}{5}\s*{7}{4}{8}\s*hit\s*by\s*{9}\s*{3}{10}\s*{11}{4}\s*into\s*{12}\s*for\s*{13}\s*damage\s*{14}$' -f
        $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxDead, $RxPos, $RxHp, $RxByPlayer, $RxByPlayerId, $RxByPos, $RxInto, $RxDamage, $RxWith)
      HitByXDeadWith      = ('^{0}\s*{1}\s*{2}\s*{3}{6}{4}\s*{3}{5}\s*{7}{4}{8}\s*hit\s*by\s*{9}\s*with\s*{10}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxDead, $RxPos, $RxHp, $RxByX, $RxWith)
      HitByPlayerIntoWith = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}{7}\s*hit\s*by\s*{8}\s*{3}{9}\s*{10}{4}\s+into\s*{11}\s*for\s*{12}\s*damage\s*{13}\s*$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos, $RxHp, $RxByPlayer, $RxByPlayerId, $RxByPos, $RxInto, $RxDamage, $RxWith)
      HitByPlayerInto     = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}{7}\s*hit\s*by\s*{8}\s*{3}{9}\s*{10}{4}\s*into\s*{11}\s*for\s*{12}\s*damage.*$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos, $RxHp, $RxByPlayer, $RxByPlayerId, $RxByPos, $RxInto, $RxDamage)
      HitByXIntoWith      = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}{7}\s*hit\s*by\s*{9}\s*into\s*{8}\s*for\s*{10}\s*damage\s*{11}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos, $RxHp, $RxInto, $RxByX, $RxDamage, $RxWith)
      HitByXInto          = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}{7}\s*hit\s*by\s*{9}\s*into\s*{8}\s*for\s*{10}\s*damage$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos, $RxHp, $RxInto, $RxByX, $RxDamage)
      HitByXWith          = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}{7}\s*hit\s*by\s*{8}\s*with\s*{9}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos, $RxHp, $RxByX, $RxWith)
      HitByX              = ('^{0}\s*{1}\s*{2}\s*{3}{5}\s*{6}{4}{7}\s*hit\s*by\s*{8}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxPos, $RxHp, $RxByX)
      KilledByXWithDead   = ('^{0}\s*{1}\s*{2}\s*{3}{6}{4}\s*{3}{5}\s*{7}{4}\s*killed\s*by\s*with\s*{8}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxDead, $RxPos, $RxByX)
      KilledByXDead       = ('^{0}\s*{1}\s*{2}\s*{3}{6}{4}\s*{3}{5}\s*{7}{4}\s*killed\s*by\s*{8}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxDead, $RxPos, $RxByX)
      KilledByPlayerDead  = ('^{0}\s*{1}\s*{2}\s*{3}{6}{4}\s*{3}{5}\s*{7}{4}\s*killed\s*by\s*{10}\s*{3}{8}\s*{9}{4}\s*with\s*{11}$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxDead, $RxPos, $RxByPlayerId, $RxByPos, $RxByPlayer, $RxWith)
      Died                = ('^{0}\s*{1}\s*{2}\s*{3}{6}{4}\s*{3}{5}\s*{7}{4}\s*died\.\s*Stats\>\s*Water:\s*(?<Water>.+)\s*Energy:\s*(?<Energy>.+)\s*Bleed\s*sources:\s*(?<BleedSources>.+)$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxDead, $RxPos)
      BledOut             = ('^{0}\s*{1}\s*{2}\s*{3}{6}{4}\s*{3}{5}\s*{7}{4}\s*(?<Bledout>bled\s*out)$' -f $RxTime, $RxDiv01, $RxPlayer, $RxBrOp, $RxBrCl, $RxPlayerId, $RxDead, $RxPos)
      LogEnd              = '^\**EOF\**$'
    }
  }
  <#
  process
  {
    $Result = foreach ($InputString in (Get-Content -Path $Path))
    {
      foreach ($String in $InputString.trim() | Where-Object { $_ })
      {
        $x = 0
        foreach ($Pattern in $PatternColl.GetEnumerator())
        {
          if ($String -match $Pattern.Value)
          {
            $x = 1
            '--------------'
            $Pattern.Name
            $String
            $Pattern.Value
            '++++++++++++++'
            break
          }
        }
      }
    }
    $Result
    #>
  #<#
  process
  {
    $Result = foreach ($InputString in (Get-Content -Path $Path))
    {
      foreach ($String in $InputString.trim() | Where-Object { $_ })
      {
        $x = 0
        foreach ($Pattern in $PatternColl.GetEnumerator())
        {
          if ($String -match $Pattern.Value)
          {
            $x = 1
            if ($PropertyNames = $Matches.Keys | Where-Object { $_ -is [string] })
            {
              $Properties = $PropertyNames |
              ForEach-Object -Begin { $t = @{ } } -Process { $t[$_] = $Matches[$_] } -End { $t }
              $Properties.Add('Type', $Pattern.Name)
              #$Properties.Add('Time', ( (Get-Date -Hour $Properties.Hour -Minute $Properties.Minute -Second $Properties.Second -Format 'HH:mm:ss') ))
              foreach ($PatternKey in $PatternKeyColl)
              {
                if ($PatternKey -notin $Properties.GetEnumerator().Name)
                {
                  $Properties.Add($PatternKey, '')
                }
              }
              [PSCustomObject]$Properties
            }
            break
          }
        }
      }
    }
    $Result
    #>
  }
  end
  {
  }
}