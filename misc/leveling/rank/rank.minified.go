{{$d:="□"}}{{$f:="■"}}{{$w:=0}}{{$j:=14232643}}{{$o:=.User}}{{$e:=false}}{{with .CmdArgs}}{{$p:=userArg (index . 0)}}{{if $p}}{{$o =$p}}{{with dbGet $o.ID "xpColor"}}{{$j =.Value}}{{end}}{{else if and (eq (index . 0) "set-color") (ge (len .) 2)}}{{$e =true}}{{$a:=cslice 1048576 65536 4096 256 16 1}}{{$g:=sdict "A" 10 "B" 11 "C" 12 "D" 13 "E" 14 "F" 15}}{{with reFindAllSubmatches `(?:#?default|([a-fA-F\d]{1,6}))` (joinStr " " (slice . 1))}}{{$r:="D92C43"}}{{with index . 0 1}}{{$r =(printf "%06s" .) | upper}}{{end}}{{$s:=0}}{{range $k, $x:=split $r ""}}{{$b:=index $a $k}}{{$t:=or ($g.Get $x) $x}}{{$s =add $s (mult $t $b)}}{{end}}{{dbSet $o.ID "xpColor" $s}}{{$o.Mention}}, I set your rank card color to `#{{$r}}`.
{{else}}
Please provide a valid hex to set your rank card color to.
{{end}}{{end}}{{end}}{{if not $e}}{{with dbGet $o.ID "xpColor"}}{{$j =.Value}}{{end}}{{with dbGet $o.ID "xp"}}{{$w =.Value}}{{end}}{{$k:=roundFloor (mult 0.1 (sqrt $w))}}{{$h:=sub $w (mult 100 $k $k)}}{{if lt (toInt $w) 100}}{{$h =$w}}{{end}}{{$i:=add $k 1}}{{$l:=sub (mult 100 $i $i) (mult 100 $k $k)}}{{$c:=(mult (fdiv $h $l) 100) | roundFloor}}{{$c =div $c 10 | toInt}}{{$u:=""}}{{range seq 1 11}}{{if ge $c .}}{{$u =joinStr "" $u $f}}{{else}}{{$u =joinStr "" $u $d}}{{end}}{{end}}{{$m:=sdict 
"title" (printf "❯ %s's Rank" $o.String)
"color" $j
"description" (printf 
"❯ **%d / %d** XP\n❯ **Total:** %d\n❯ **Level:** %d\n❯ **Progress bar:**\n[**%s**](https://yagpdb.xyz)"
(toInt $h) (toInt $l) (toInt $w) (toInt $k) $u)}}{{$q:=0}}{{range $index, $n:=dbTopEntries "xp" 100 0}}{{if eq .UserID $o.ID}}{{$q =add $index 1}}{{end}}{{end}}{{if $q}}{{$m.Set "description" (printf 
"🏆 *Member of Top 100*\n\n❯ **Rank:** %d\n%s"
$q
$m.description
)}}{{end}}{{sendMessage nil (cembed $m)}}{{end}}
