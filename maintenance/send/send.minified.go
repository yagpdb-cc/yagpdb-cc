{{$c:=or (reFind `raw` .Cmd) ""}}{{$b:=.Channel}}{{$e:=joinStr " " .CmdArgs}}{{if .CmdArgs}}{{$a:=""}}{{with reFindAllSubmatches `<#(\d+)>` (index .CmdArgs 0)}}{{$a =index . 0 1}}{{end}}{{$d:=getChannel (or $a (index .CmdArgs 0))}}{{if $d}}{{$b =$d}}{{$e =slice .CmdArgs 1 | joinStr " "}}{{end}}{{end}}{{if $e}}{{if eq $c "raw"}}{{sendMessageNoEscape $b.ID $e}}{{else}}{{sendMessage $b.ID (cembed
"author" (sdict "name" .User.String "icon_url" (.User.AvatarURL "256"))
"description" $e
"color" 14232643
"footer" (sdict "text" (printf "Message sent from #%s" .Channel.Name))
"timestamp" currentTime
)}}{{end}}{{if ne $b.ID .Channel.ID}}
Successfully sent message to <#{{$b.ID}}>!
{{end}}{{else}}
Sorry, you didn't provide anything to say!
{{end}}
