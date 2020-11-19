{{execAdmin "clean" 1}} {{/*Optional to clean Disboard's Message*/}}
{{/* Don't change anything */}}
{{$rank := 0}}
  {{$list:=""}}
{{range dbTopEntries "BumpXP" 10 0}}
  {{ $rank = add $rank 1 }}
    {{- $list =print $list "**" $rank ".** " .User.Username "** - **" .Value "\n" -}}
{{end}}
{{$s := sendMessage nil (cembed "title" "🏆Bumping LeaderBoard for Gamers Corner❤" "description" $list)}}
 
