{{$d:=.Reaction.Emoji.Name}}{{$a:=cslice "▶️" "◀️"}}{{$b:=false}}{{$g:=0}}{{with and (eq .ReactionMessage.Author.ID 204255221017214977) .ReactionMessage.Embeds}}{{$e:=index . 0}}{{if and (eq $e.Title "❯ Leaderboard") $e.Footer}}{{$g =reFind `\d+` $e.Footer.Text}}{{$b =true}}{{end}}{{end}}{{if and (in $a $d) $b $g}}{{deleteMessageReaction nil .ReactionMessage.ID .User.ID $d}}{{if eq $d "▶️"}}{{$g =add $g 1}}{{else}}{{$g =sub $g 1}}{{end}}{{if ge $g 1}}{{$h:=mult (sub $g 1) 10}}{{$f:=dbTopEntries "xp" 10 $h}}{{if (len $f)}}{{$i:=$h}}{{$c:=""}}{{range $f}}{{$j:=toInt .Value}}{{$i =add $i 1}}{{$c =printf "%s\n• **%d.** [%s](https://yagpdb.xyz) :: Level %d (%d XP)"
$c $i .User.String (toInt (roundFloor (mult 0.1 (sqrt $j)))) $j}}{{end}}{{editMessage nil .ReactionMessage.ID (cembed
"title" "❯ Leaderboard"
"thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png")
"color" 14232643
"description" $c
"footer" (sdict "text" (joinStr "" "Page " $g))
)}}{{end}}{{end}}{{end}}
