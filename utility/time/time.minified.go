{{$d:=sdict
"morning" (sdict
"image" "https://www.bnrconvention.com/wp-content/uploads/2017/04/coffee-icon-1.png"
"color" 9498256
)
"afternoon" (sdict
"image" "https://www.bnrconvention.com/wp-content/uploads/2017/04/coffee-icon-1.png"
"color" 16747520
)
"evening" (sdict
"image" "https://cdn4.iconfinder.com/data/icons/outdoors-3/460/night-512.png"
"color" 8087790
)
"night" (sdict
"image" "https://cdn4.iconfinder.com/data/icons/outdoors-3/460/night-512.png"
"color" 1062054
)}}{{$a:="America/Vancouver"}}{{$i:="Joe"}}{{$b:="Vancouver"}}{{$e:="night"}}{{$f:=exec "weather" $b}}{{$f =reReplace `\x60+` $f ""}}{{$m:=split $f "\n"}}{{$c:=slice (index $m 3) 15}}{{$j:=reReplace `\.\.` (reReplace ` \(.+$` (slice (index $m 4) 15) "") " - "}}{{$n:=currentTime.In (newDate 0 0 0 0 0 0 $a).Location}}{{$o:=$n.Hour}}{{if and (ge $o 5) (lt $o 12)}}{{$e ="morning"}}{{else if and (ge $o 12) (lt $o 17)}}{{$e ="afternoon"}}{{else if and (ge $o 17) (lt $o 21)}}{{$e ="evening"}}{{end}}{{$g:=$d.Get $e}}{{$k:=$n.Format "3:04:05 PM"}}{{$l:=$n.Format "Monday, January 2, 2006"}}{{$h:=cembed
"title" (printf "Good %s, %s" $e $i)
"color" $g.color
"thumbnail" (sdict "url" $g.image)
"description" (printf "❯ **Time:** %s\n❯ **Date:** %s\n❯ **Weather:** %s (%s)" $k $l $c $j)}}{{sendMessage nil $h}}