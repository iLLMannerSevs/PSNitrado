function Get-NitradoDayzPS4Event
{
  [OutputType('System.String')]
  [CmdletBinding(DefaultParameterSetName = 'All')]
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
    $Path,

    [Parameter(ParameterSetName = 'PatternMatchTest')]
    [Switch]
    $PatternMatchTest
  )

  begin
  {
    $RxLogBegin = ('AdminLog\s*started\s*on\s*(?<Date>\d{4}-\d{2}-\d{2})\s*at\s*\d{2}:\d{2}:\d{2}$')
    $Rx = [ordered]@{
      Time         = '(?<Time>\d{2}:\d{2}:\d{2})'
      PlayerName   = "Player\s*[\`"|\`'](?<PlayerName>.[^\`"|^\`']*)\W+"
      PlayerId     = 'id=(?<PlayerId>[\w|\-]+)='
      PosX         = 'pos=<(?<PosX>[\d|\.|-]+),'
      PosY         = '(?<PosY>[\d|\.|-]+),'
      PosZ         = '(?<PosZ>[\d|\.|-]+)>'
      Hp           = '\[HP:\s*(?<HP>[\d|\.|-]+)\]'
      Into         = '(?<Into>.+)'
      ByX          = '(?<ByX>.+)'
      Damage       = '(?<Damage>[\d|\.|-]+)'
      With         = '(?<With>.+)'
      ByPlayerName = "Player\s*[\`"|\`'](?<ByPlayerName>.[^\`'|^\`"]*)\W+"
      ByPlayerId   = 'id=(?<ByPlayerId>[\w|\-]+)='
      ByPosX       = 'pos=<(?<ByPosX>[\d|\.|-]+),'
      ByPosY       = '(?<ByPosY>[\d|\.|-]+),'
      ByPosZ       = '(?<ByPosZ>[\d|\.|-]+)>'
      Water        = '(?<Water>[\d|\.|-]+)'
      Energy       = '(?<Energy>[\d|\.|-]+)'
      BleedSources = '(?<BleedSources>\d+)'
    }

    $PatternColl = [ordered]@{
      Connected               = ('^{0}\s*\|\s*{1}\s*is\s*connected\s*\({2}\)$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId)
      Disconnected            = ('^{0}\s*\|\s*{1}\s*\({2}\)\s*has\s*been\s*disconnected$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId)
      Suicide2                = ('^{0}\s*\|\s*{1}\s*\({2}\)\s*committed\s*suicide\.$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId)
      Conscious               = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\)\s*regained\s*consciousness$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ)
      Unconscious             = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\)\s*is\s*unconscious$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ)
      Suicide1                = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\)\s*committed\s*suicide$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ)
      HitByPlayerIntoWithDead = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}\s*\({8}\s*{9}\s*{10}\s*{11}\)\s*into\s*{12}\s*for\s*{13}\s*damage\s*{14}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.ByPlayerName, $Rx.ByPlayerId, $Rx.ByPosX, $Rx.ByPosY, $Rx.ByPosZ, $Rx.Into, $Rx.Damage, $Rx.With)
      HitByXIntoWithDeath     = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}\s*into\s*{8}\s*for\s*{9}\s*damage\s*{10}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.ByX, $Rx.Into, $Rx.Damage, $Rx.With)
      HitByXWithDeath         = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}\s*with\s*{8}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.ByX, $Rx.With)
      HitByPlayerIntoWith     = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}\s*\({8}\s*{9}\s*{10}\s*{11}\)\s+into\s*{12}\s*for\s*{13}\s*damage\s*{14}\s*$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.ByPlayerName, $Rx.ByPlayerId, $Rx.ByPosX, $Rx.ByPosY, $Rx.ByPosZ, $Rx.Into, $Rx.Damage, $Rx.With)
      HitByPlayerInto         = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}\s*\({8}\s*{9}\s*{10}\s*{11}\)\s*into\s*{12}\s*for\s*{13}\s*damage.*$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.ByPlayerName, $Rx.ByPlayerId, $Rx.ByPosX, $Rx.ByPosY, $Rx.ByPosZ, $Rx.Into, $Rx.Damage)
      HitByXIntoWith          = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}\s*into\s*{8}\s*for\s*{9}\s*damage\s*{10}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.Into, $Rx.ByX, $Rx.Damage, $Rx.With)
      HitByXInto              = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}\s*into\s*{8}\s*for\s*{9}\s*damage$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.ByX, $Rx.Into, $Rx.Damage)
      HitByXWith              = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}\s*with\s*{8}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.ByX, $Rx.With)
      HitByX                  = ('^{0}\s*\|\s*{1}\s*\({2}\s*{3}\s*{4}\s*{5}\){6}\s*hit\s*by\s*{7}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.Hp, $Rx.ByX)
      KilledByXWithDead       = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\s*{4}\s*{5}\)\s*killed\s*by\s*with\s*{6}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.ByX)
      KilledByPlayerDead      = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\s*{4}\s*{5}\)\s*killed\s*by\s*{6}\s*\({7}\s*{8}\s*{9}\s*{10}\)\s*with\s*{11}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.ByPlayerName, $Rx.ByPlayerId, $Rx.ByPosX, $Rx.ByPosY, $Rx.ByPosZ, $Rx.With)
      KilledByXDead           = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\s*{4}\s*{5}\)\s*killed\s*by\s*{6}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.ByX)
      Died                    = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\s*{4}\s*{5}\)\s*died\.\s*Stats\>\s*Water:\s*{6}\s*Energy:\s*{7}\s*Bleed\s*sources:\s*{8}$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ, $Rx.ByX, $Rx.Water, $Rx.Energy, $Rx.BleedSources)
      BledOut                 = ('^{0}\s*\|\s*{1}\s*\(DEAD\)\s*\({2}\s*{3}\s*{4}\s*{5}\)\s*bled\s*out$' -f
        $Rx.Time, $Rx.PlayerName, $Rx.PlayerId, $Rx.PosX, $Rx.PosY, $Rx.PosZ)
      LogEnd                  = '^\**EOF\**$'
    }
  }

  process
  {
    Switch ($PsCmdlet.ParameterSetName)
    {
      'PatternMatchTest'
      {
        $Result = foreach ($InputString in (Get-Content -Path $Path))
        {
          foreach ($String in $InputString.trim() | Where-Object { $_ })
          {
            if ($String -match $RxLogBegin)
            {
              break
            }
            $x = 0
            foreach ($Pattern in $PatternColl.GetEnumerator())
            {
              if ($String -match $Pattern.Value)
              {
                $x = 1
                break
              }
            }
            if ($x -eq 0)
            {
              [pscustomobject]@{
                String = $String
              }
            }
          }
        }
        $Result
      }
      'All'
      {
        $DateString = '2000-01-01'
        $TimeString = '00:00:00'
        $Result = foreach ($InputString in (Get-Content -Path $Path))
        {
          foreach ($String in $InputString.trim() | Where-Object { $_ })
          {
            if ($String -match $RxLogBegin)
            {
              $DateString = $Matches.Date
            }
            foreach ($Pattern in $PatternColl.GetEnumerator())
            {
              if ($String -match $Pattern.Value)
              {
                if ($PropertyNames = $Matches.Keys | Where-Object { $_ -is [string] })
                {
                  $Properties = $PropertyNames |
                  ForEach-Object -Begin {
                    $t = @{ }
                  } -Process {
                    if (@("$_") -match '(Hp|Damage|Water|Energy|Pos)')
                    {
                      $t[$_] = [Double]$Matches[$_]
                    }
                    elseif (@("$_") -match '(BleedSources)')
                    {
                      $t[$_] = [Int]$Matches[$_]
                    }
                    else
                    {
                      $t[$_] = $Matches[$_]
                    }
                  } -End {
                    $t
                  }
                  $Properties.Add('Type', $Pattern.Name)
                  if ([System.Convert]::ToDateTime($Properties.Time).Hour -ge [System.Convert]::ToDateTime($TimeString).Hour)
                  {
                    $DateTimeSTring = ('{0}T{1}' -f $DateString, $Properties.Time)
                    $DateTime = [System.Convert]::ToDateTime($DateTimeSTring)
                    $Properties.Add('DateTime', $DateTime)
                  }
                  else
                  {
                    $DateTimeSTring = ('{0}T{1}' -f $DateString, $Properties.Time)
                    $DateTime = [System.Convert]::ToDateTime($DateTimeSTring).AddDays(1)
                    $Properties.Add('DateTime', $DateTime)
                  }
                  $DateString = $DateTime.ToString('yyyy-MM-dd')
                  $TimeString = $DateTime.ToString('HH:mm:ss')
                  foreach ($RxKey in $Rx.Keys)
                  {
                    if ($RxKey -notin $Properties.GetEnumerator().Name)
                    {
                      $Properties.Add($RxKey, '')
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
    }
  }

  end
  {
  }
}