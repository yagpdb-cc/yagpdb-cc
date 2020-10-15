{{$a:=.User}}{{$b:=parseArgs 0 "**Syntax:** `-avatar [user]`" (carg "userid" "user")}}{{if $b.IsSet 0}}{{$a =userArg ($b.Get 0)}}{{end}}{{sendMessage nil (cembed
"author" (sdict "name" (printf "%s (%d)" $a.String $a.ID) "icon_url" ($a.AvatarURL "256"))
"title" "❯ Avatar"
"image" (sdict "url" ($a.AvatarURL "2048"))
"color" 14232643
)}}