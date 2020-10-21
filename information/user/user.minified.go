{{$b:=.Member}}{{$d:=.User}}{{$e:=parseArgs 0 "**Syntax:** `-userinfo [user]`" (carg "member" "target")}}{{if $e.IsSet 0}}{{$b =$e.Get 0}}{{$d =$b.User}}{{end}}{{$c:=""}}{{range $k, $g:=$b.Roles}}{{if eq $k 0}}{{$c =printf "<@&%d>" .}}{{else}}{{$c =printf "%s, <@&%d>" $c .}}{{end}}{{end}}{{$f:="No"}}{{if $d.Bot}}{{$f ="Yes"}}{{end}}{{$a:=div $d.ID 4194304 | add 1420070400000 | mult 1000000 | toDuration | (newDate 1970 1 1 0 0 0).Add}}{{sendMessage nil (cembed
"author" (sdict "name" (printf "%s (%d)" $d.String $d.ID) "icon_url" ($d.AvatarURL "256"))
"fields" (cslice
(sdict "name" "❯ Nickname" "value" (or $b.Nick "*None set*"))
(sdict "name" "❯ Joined At" "value" ($b.JoinedAt.Parse.Format "Jan 02, 2006 3:04 AM"))
(sdict "name" "❯ Created At" "value" ($a.Format "Monday, January 2, 2006 at 3:04 AM"))
(sdict "name" (printf "❯ Roles (%d Total)" (len $b.Roles)) "value" (or $c "n/a"))
(sdict "name" "❯ Bot" "value" $f)
)
"color" 14232643
"thumbnail" (sdict "url" ($d.AvatarURL "256"))
)}}
