{{$c:=1}}{{with reFind `\d+` (joinStr " " .CmdArgs)}}{{$c =. | toInt}}{{end}}{{$d:=mult (sub $c 1) 10}}{{$b:=dbTopEntries "xp" 10 $d}}{{if not (len $b)}}
There were no users on that page! 
{{else}}{{$e:=$d}}{{$a:=""}}{{range $b}}{{$f:=toInt .Value}}{{$e =add $e 1}}{{$a =printf "%s\n• **%d.** [%s](https://yagpdb.xyz) :: Level %d (%d XP)"
$a $e .User.String (toInt (roundFloor (mult 0.1 (sqrt $f)))) $f}}{{end}}{{$g:=sendMessageRetID nil (cembed
"title" "❯ Leaderboard"
"thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png")
"color" 14232643
"description" $a
"footer" (sdict "text" (joinStr "" "Page " $c))
)}}{{addMessageReactions nil $g "◀️" "▶️"}}{{end}}
