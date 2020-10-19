{{with reFindAllSubmatches `<(a)?:.*?:(\d+)>` .StrippedMsg}}{{$a:=index . 0 1}}{{$d:=index . 0 2}}{{$b:=".png"}}{{if $a}}{{$b =".gif"}}{{end}}{{$c:=printf "https://cdn.discordapp.com/emojis/%s%s" $d $b}}{{sendMessage nil (cembed
"title" "❯ Big Emoji"
"url" $c
"color" 14232643
"image" (sdict "url" $c)
"footer" (sdict "text" (joinStr "" "Emoji ID: " $d))
)}}{{else}}
That was not a valid emoji. Try again.
{{end}}
