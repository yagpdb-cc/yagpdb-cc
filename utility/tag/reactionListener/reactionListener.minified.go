{{$e:=.Reaction.Emoji.Name}}{{$a:=cslice "▶️" "◀️"}}{{$b:=false}}{{$h:=0}}{{with and (eq .ReactionMessage.Author.ID 204255221017214977) .ReactionMessage.Embeds}}{{$g:=index . 0}}{{if and (eq $g.Title "❯ Tags") $g.Footer}}{{$h =reFind `\d+` $g.Footer.Text}}{{$b =true}}{{deleteMessageReaction nil $.ReactionMessage.ID $.User.ID $e}}{{end}}{{end}}{{if and (in $a $e) $b $h}}{{if eq $e "▶️"}}{{$h =add $h 1}}{{else}}{{$h =sub $h 1}}{{end}}{{if ge $h 1}}{{$i:=mult (sub $h 1) 10}}{{$j:=dbTopEntries "tg.|%|" 10 $i}}{{if (len $j)}}{{$f:=$i}}{{$c:=""}}{{range $k, $ := $j}}{{$d:=index (split (slice .Key 4 (sub (len .Key) 1)) "|") 0}}{{if $k}}{{$c =joinStr "" $c ", `" $d "`"}}{{else}}{{$c =printf "`%s`" $d}}{{end}}{{end}}{{editMessage nil .ReactionMessage.ID (cembed
"title" "❯ Tags"
"color" 14232643
"description" $c
"footer" (sdict "text" (joinStr "" "Page " $h))
)}}{{end}}{{end}}{{end}}