{{$b:=parseArgs 2 "**Syntax:** `-entry <id> <key>`" (carg "int" "id") (carg "string" "key")}}{{with dbGet ($b.Get 0) ($b.Get 1)}}{{$a:=json .Value}}{{if gt (len $a) 1900}}{{sendMessage nil (complexMessage "file" $a "content" "**Value:**")}}{{else}}{{sendMessage nil (printf "**Value:**\n%s" $a)}}{{end}}{{else}}
    Could not find entry.
{{end}}
