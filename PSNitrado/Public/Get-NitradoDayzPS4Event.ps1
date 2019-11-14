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
      'Time'
      'PlayerName'
      'PlayerId'
      'Pos'
      'HP'
      'Into'
      'ByX'
      'Damage'
      'With'
      'ByPlayerName'
      'ByPlayerId'
      'ByPos'
      'Water'
      'Energy'
      'BleedSources'
    )
    $Rx = [ordered]@{
      Date         = '(?<Date>\d{4}-\d{2}-\d{2})'
      Time         = '(?<Time>\d{2}:\d{2}:\d{2})'
      PlayerName   = "Player\s*[\`"|\`'](?<PlayerName>.[^\`"|^\`']*)\W+"
      PlayerId     = 'id=(?<PlayerId>[\w|\-]+)='
      Pos          = 'pos=<(?<Pos>[\d|\.|-]+,\s*[\d|\.|-]+,\s*[\d|\.|-]+)>'
      Hp           = '\[HP:\s*(?<HP>[\d|\.|-]+)\]'
      Into         = '(?<Into>.+)'
      ByX          = '(?<ByX>.+)'
      Damage       = '(?<Damage>[\d|\.|-]+)'
      With         = '(?<With>.+)'
      ByPlayerName = "Player\s*[\`"|\`'](?<ByPlayerName>.[^\`'|^\`"]*)\W+"
      ByPlayerId   = 'id=(?<ByPlayerId>[\w|\-]+)='
      ByPos        = 'pos=<(?<ByPos>[\d|\.|-]+,\s*[\d|\.|-]+,\s*[\d|\.|-]+)>'
      Water        = '(?<Water>[\d|\.|-]+)'
      Energy       = '(?<Energy>[\d|\.|-]+)'
      BleedSources = '(?<BleedSources>\d+)'
    }

    $PatternColl = [ordered]@{
      LogBegin                = ('AdminLog\s*started\s*on\s*{1}\s*at\s*{0}$' -f
        $Rx.Time, $Rx.Date)
      Connected               = ('^{0}\s*\|\s*{1}\s*is\s*connected\s*\({2}\)$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId)
      Disconnected            = ('^{0}\s*\|\s*{1}\s*\({2}\)\s*has\s*been\s*disconnected$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId)
      Suicide2                = ('^{0}\s*\|\s*{1}\s*\({2}\)\s*committed\s*suicide\.$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId)
      Conscious               = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\)\s*regained\s*consciousness$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos)
      Unconscious             = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\)\s*is\s*unconscious$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos)
      Suicide1                = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\)\s*committed\s*suicide$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos)
      HitByPlayerIntoWithDead = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{5}\s*\({6}\s*{7}\)\s*into\s*{8}\s*for\s*{9}\s*damage\s*{10}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.ByPlayerName, $Rx.ByPlayerId, $Rx.ByPos, $Rx.Into, $Rx.Damage, $Rx.With)
      HitByXIntoWithDeath     = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{5}\s*into\s*{6}\s*for\s*{7}\s*damage\s*{8}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.ByX, $Rx.Into, $Rx.Damage, $Rx.With)
      HitByXWithDeath         = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{5}\s*with\s*{6}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.ByX, $Rx.With)
      HitByPlayerIntoWith     = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{5}\s*\({6}\s*{7}\)\s+into\s*{8}\s*for\s*{9}\s*damage\s*{10}\s*$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.ByPlayerName, $Rx.ByPlayerId, $Rx.ByPos, $Rx.Into, $Rx.Damage, $Rx.With)
      HitByPlayerInto         = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{5}\s*\({6}\s*{7}\)\s*into\s*{8}\s*for\s*{9}\s*damage.*$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.ByPlayerName, $Rx.ByPlayerId, $Rx.ByPos, $Rx.Into, $Rx.Damage)
      HitByXIntoWith          = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{6}\s*into\s*{5}\s*for\s*{7}\s*damage\s*{8}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.Into, $Rx.ByX, $Rx.Damage, $Rx.With)
      HitByXInto              = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{6}\s*into\s*{5}\s*for\s*{7}\s*damage$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.Into, $Rx.ByX, $Rx.Damage)
      HitByXWith              = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{5}\s*with\s*{6}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.ByX, $Rx.With)
      HitByX                  = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\){4}\s*hit\s*by\s*{5}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Hp, $Rx.ByX)
      KilledByXWithDead       = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\)\s*killed\s*by\s*with\s*{4}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.ByX)
      KilledByPlayerDead      = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\)\s*killed\s*by\s*{6}\s*\({4}\s*{5}\)\s*with\s*{7}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.ByPlayerId, $Rx.ByPos, $Rx.ByPlayerName, $Rx.With)
      KilledByXDead           = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\)\s*killed\s*by\s*{4}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.ByX)
      Died                    = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\)\s*died\.\s*Stats\>\s*Water:\s*{4}\s*Energy:\s*{5}\s*Bleed\s*sources:\s*{6}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos, $Rx.Water, $Rx.Energy, $Rx.BleedSources)
      BledOut                 = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\)\s*bled\s*out$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.Pos)
      LogEnd                  = '^\**EOF\**$'
    }
  }

  <#
  process
  {
    Write-Host '##############################################################'
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
            #Write-Host '--------------'
            #Write-Host $Pattern.Name
            #Write-Host $String
            #Write-Host $Pattern.Value
            #Write-Host '++++++++++++++'
            break
          }
        }
        if ($x -eq 0)
        {
          Write-Host '--------------'
          Write-Host $String
          Write-Host '++++++++++++++'
        }
      }
    }
    #$Result
  }
  #>
  #<#
  process
  {
    $Result = foreach ($InputString in (Get-Content -Path $Path))
    {
      foreach ($String in $InputString.trim() | Where-Object { $_ })
      {
        foreach ($Pattern in $PatternColl.GetEnumerator())
        {
          if ($String -match $Pattern.Value)
          {
            if ($PropertyNames = $Matches.Keys | Where-Object { $_ -is [string] })
            {
              $Properties = $PropertyNames |
              ForEach-Object -Begin { $t = @{ } } -Process { $t[$_] = $Matches[$_] } -End { $t }
              $Properties.Add('Type', $Pattern.Name)
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
  }
  #>
  end
  {
  }
}