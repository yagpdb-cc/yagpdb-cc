{{$b:=sdict "Channel" .Channel "Guild" .Guild "User" .User "Member" .Member "Message" .Message}}{{$a:=sdict
"Channel" "https://discordapp.com/developers/docs/resources/channel#channel-object"
"Guild" "https://discordapp.com/developers/docs/resources/guild#guild-resource"
"User" "https://discordapp.com/developers/docs/resources/user#user-object"
"Member" "https://discordapp.com/developers/docs/resources/guild#guild-member-object"
"Message" "https://discordapp.com/developers/docs/resources/channel#message-object"}}{{$c:=0}}{{$e:=""}}{{$d:=(parseArgs 1 "**Syntax:** -struct <struct>" (carg "string" "structure")).Get 0 | lower}}{{range $struct, $g:=$b}}{{if eq (lower $struct) $d}}{{$c =$g}}{{$e =$struct}}{{end}}{{end}}{{if $c}}{{$f:=printf "```go\n%+v```" $c}}{{sendMessage nil (cembed
"title" (printf "❯ %s Object" $e)
"url" (index $a $e)
"description" $f
"color" 14232643
)}}{{else}}
Please provide a valid target to view.
{{end}}
