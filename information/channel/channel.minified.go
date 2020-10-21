{{$b:=.Channel}}{{$e:=parseArgs 0 "**Syntax:** -channel [channel]" (carg "channel" "channel")}}{{if $e.IsSet 0}}{{$b =$e.Get 0}}{{end}}{{$d:=cslice "Text" "DM" "Voice" "Category" "News" "Store"}}{{$f:="No"}}{{$c:="*None set*"}}{{if $b.NSFW}}{{$f ="Yes"}}{{end}}{{with $b.ParentID}}{{$c =printf "<#%d>" .}}{{end}}{{$a:=div $b.ID 4194304 | add 1420070400000 | mult 1000000 | toDuration | (newDate 1970 1 1 0 0 0).Add}}{{sendMessage nil (cembed
"title" (printf "❯ Info for #%s" $b.Name)
"fields" (cslice
(sdict "name" "❯ ID" "value" (str $b.ID) "inline" true)
(sdict "name" "❯ Topic" "value" (or $b.Topic "*None set*") "inline" true)
(sdict "name" "❯ Parent Channel" "value" $c "inline" true)
(sdict "name" "❯ NSFW" "value" $f "inline" true)
(sdict "name" "❯ Position" "value" (str (add $b.Position 1)) "inline" true)
(sdict "name" "❯ Type" "value" (index $d $b.Type) "inline" true)
)
"color" 14232643
"footer" (sdict "text" "Created at")
"timestamp" $a
)}}
