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
      'Hour'
      'Minute'
      'Second'
      'PlayerName'
      'PlayerId'
      'PosX'
      'PosY'
      'PosZ'
      'HP'
      'HitWith'
      'KilledBy'
      'ByPlayerName'
      'ByPlayerId'
      'ByPosX'
      'ByPosY'
      'ByPosZ'
      'Into'
      'Damage'
      'HitWith'
      'HitBy'
      'Disconnected'
      'Water'
      'Energy'
      'BleedSources'
      'Suicide'
      'Bledout'
    )

    $PatternColl = @{
      LogBegin           = 'AdminLog\sstarted\son\s(?<Year>\d{4})-(?<Month>\d{2})-(?<Day>\d{2})\s+at\s+(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s*$'
      Connected          = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+is\s+(?<Connected>connected)\s+\(id=(?<PlayerId>[\w|\-]+)=\)\s*$'
      Disconnected       = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\(id=(?<PlayerId>[\w|\-]+)=\)\s+has\s+been\s+(?<Disconnected>disconnected)\s*$'
      Conscious          = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\sregained\sconsciousness\s*$'
      Unconscious        = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\s+is\s+unconscious\s*$'
      HitByPlayer        = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s(?<HP>.+)\]\shit\sby\sPlayer\s"(?<ByPlayerName>.+)"\s\(id=(?<ByPlayerId>.+)=\s+pos=<(?<ByPosX>.+),\s(?<ByPosY>.+),\s(?<ByPosZ>.+)>\)\s+into\s(?<Into>.+)\s+for\s(?<Damage>.+)\s+damage\s+(?<HitWith>.+)\s*$'
      HitByWolf          = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s+(?<HP>.+)\]\s+hit\s+by\s+(?<HitBy>Wolf)\s+into\s+(?<Into>.+)\s+for\s+(?<Damage>.+)\s+damage\s+\((?<HitWith>.+)\)\s*$'
      HitByFallDamage    = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(id=(?<PlayerId>[\w | \-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s+(?<HP>.+)\]\s+hit\s+by\s+(?<HitBy>FallDamage)\s*$'
      HitByFireplace     = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s(?<HP>.+)\]\shit\sby\sFireplace\swith\s(?<HitWith>.+)\s*$'
      HitByFence         = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s(?<HP>.+)\]\shit\sby\sFence\swith\s(?<HitWith>.+)\s*$'
      HitByWatchtower    = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s(?<HP>.+)\]\shit\sby\sWatchtower\swith\s(?<HitWith>.+)\s*$'
      HitByFireplaceDead = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(DEAD\)\s\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s(?<HP>.+)\]\shit\sby\sFireplace\swith\s(?<HitWith>.+)\s*$'
      HitByTransport     = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s(?<HP>.+)\]\shit\sby\s(?<Car>.+)\swith\s(?<HitWith>TransportHit)\s*$'
      HitByFenceDead     = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(DEAD\)\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s(?<HP>.+)\]\shit\sby\sFence\swith\s(?<HitWith>.+)\s*$'
      HitByPlayerDead    = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(DEAD\)\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s(?<HP>.+)\]\shit\sby\sPlayer\s"(?<ByPlayerName>.+)"\s\(id=(?<ByPlayerId>.+)=\s+pos=<(?<ByPosX>.+),\s(?<ByPosY>.+),\s(?<ByPosZ>.+)>\)\s+into\s(?<Into>.+)\s+for\s(?<Damage>.+)\s+damage\s+(?<HitWith>.+)\s*$'
      HitByPlayerBlock   = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s+(?<HP>.+)\]\s+hit\s+by\s+Player\s\"(?<ByPlayerName>.+)\"\s\(id=(?<ByPlayerId>.+)=\spos=<(?<ByPosX>.+),\s(?<ByPosY>.+),\s(?<ByPosZ>.+)>\)\s+into\s(?<Into>.+)\sdamage\s*$'
      HitByExplosion     = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(id=(?<PlayerId>[\w | \-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s+(?<HP>.+)\]\s+hit\s+by\s+(?<HitBy>explosion)\s\((?<HitWith>.*)\)\s*$'
      HitByInfected      = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s+(?<HP>.+)\]\s+hit\s+by\s+(?<HitBy>Infected)\s+into\s+(?<Into>.+)\s+for\s+(?<Damage>.+)\s+damage\s+\((?<HitWith>.+)\)\s*$'
      HitByInfectedDead  = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(DEAD\)\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s+(?<HP>.+)\]\s+hit\s+by\s+(?<HitBy>Infected)\s+into\s+(?<Into>.+)\s+for\s+(?<Damage>.+)\s+damage\s+\((?<HitWith>.+)\)\s*$'
      HitByInfectedBlock = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\[HP:\s+(?<HP>.+)\]\s+hit\s+by\s+(?<HitBy>Infected)\s+into\s+(?<Into>.+)\s+for\s+(?<Damage>.+)\s+damage\s*$'
      KilledByFenceDead  = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(DEAD\)\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\s+killed\s+by\s+with\s+(?<KilledBy>.+)\s*$'
      KilledByDead       = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(DEAD\)\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\s+killed\s+by\s(?<KilledBy>.+)\s*$'
      Died               = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(DEAD\)\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\s+died\.\s+Stats\>\s+Water:\s+(?<Water>.+)\s+Energy:\s+(?<Energy>.+)\s+Bleed\s+sources:\s+(?<BleedSources>.+)\s*$'
      Suicide1           = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\s+committed\s+(?<Suicide>suicide)\s*$'
      Suicide2           = "^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s'(?<PlayerName>.+)'\s+\(id=(?<PlayerId>[\w|\-]+)=\)\s+committed\s+(?<Suicide>suicide)\.\s*$"
      BledOut            = '^(?<Hour>\d{2}):(?<Minute>\d{2}):(?<Second>\d{2})\s+\|\sPlayer\s"(?<PlayerName>.+)"\s+\(DEAD\)\s+\(id=(?<PlayerId>[\w|\-]+)=\s+pos=<(?<PosX>.+),\s(?<PosY>.+),\s(?<PosZ>.+)>\)\s+(?<Bledout>bled\sout)\s*$'
      LogEnd             = '^\**EOF\**$'
    }
  }
  process
  {
    $Result = foreach ($InputString in (Get-Content -Path $Path))
    {
      foreach ($String in $InputString | Where-Object { $_ })
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
              $Properties.Add('Time', ( (Get-Date -Hour $Properties.Hour -Minute $Properties.Minute -Second $Properties.Second -Format 'HH:mm:ss') ))
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
        if ($x -eq 0)
        {
          Write-Host ('{0}' -f $String)
        }
      }
    }
    #$Result
  }
  end
  {
  }
}