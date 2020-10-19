{{$b:=675512907391434759}}{{$a:=675513854888771595}}{{if eq .Reaction.Emoji.ID $b}}{{$d:=true}}{{range .ReactionMessage.Reactions}}{{if and (eq .Emoji.ID $b) (gt .Count 1)}}{{$d =false}}{{end}}{{end}}{{if $d}}{{$c:=""}}{{with .ReactionMessage.Attachments}}{{$c =(index . 0).ProxyURL}}{{end}}{{sendMessage $a (cembed
"title" (printf "❯ Message was flagged in #%s" .Channel.Name)
"color" 0xDC143C
"description" (or .ReactionMessage.Content "*No content*")
"image" (sdict "url" $c)
"fields" (cslice
(sdict "name" "❯ Flagged by" "value" .User.String "inline" true)
(sdict "name" "❯ Message Author" "value" .ReactionMessage.Author.String "inline" true)
(sdict "name" "❯ Message" "value" (printf "[Jump to](https://discordapp.com/channels/%d/%d/%d)" .Guild.ID .Channel.ID .ReactionMessage.ID) "inline" true)
(sdict "name" "❯ Logs" "value" (printf "[View here](%s)" (execAdmin "log")) "inline" true)
)
"footer" (sdict "text" "Flagged at")
"timestamp" currentTime
)}}{{end}}{{deleteMessageReaction nil .ReactionMessage.ID .User.ID (printf "%s:%d" .Reaction.Emoji.Name $b)}}{{end}}
