 {{/*
	Using this cc users can suggest new emojis to add on your personal server 

	Recommended trigger: Command trigger with trigger `emojisuggest`.
*/}}

{{/* CONFIGURATION VALUES START */}}
	{{ $channel := replace-with-channel-id }} {{/*Channel ID where the suggestions will be send */}}
{{/* CONFIGURATION VALUES END */}}
{{/* DONT TOUCH BELOW UNLESS YOU KNOW WHAT YOU DO */}}

{{ $embed := sdict}}
{{{$url := ""}}
{{$animat := false}}
{{$nume := ""}}
{{$allowed := false}}

{{ $s := (reFindAllSubmatches `<(a)?:.*?:(\d+)>` .StrippedMsg)  }}
{{ $image := .Message.Attachments }}
	{{ if $s }}
		{{ if ge (len .CmdArgs) 2}} 
			{{ $nume = (index .CmdArgs 1) }}
			{{ $animated := index $s 0 1 }}
			{{ $id := index $s 0 2 }}
			{{ $ext := ".png" }}
			{{ $animat = false }}
			{{ $allowed = true }}
				{{ if $animated }} 
					{{ $ext = ".gif" }} 
					{{ $animat = true }} 
				{{ end }}
			{{ $url = printf "https://cdn.discordapp.com/emojis/%s%s" $id $ext }}
		{{ else }}
		Syntax is: -emojisuggest <Link/Emoji> <Emoji Name>
    	{{ end }}
    {{ else if $image }}
		{{ if ge (len .CmdArgs) 1}} 
		{{ $nume = (index .CmdArgs 0) }}
		{{ $url = (index .Message.Attachments 0).ProxyURL }}
			{{ if reFind `.gif` $url }}
			{{ $animat = true }}
			{{ end }} 
		{{ $allowed = true }}
		{{ end }}	
		{{else}} 
		Syntax is: -emojisuggest <Link/Emoji> <Emoji Name>
		{{ end }}
	{{ if $allowed }}
	{{ $mid := sendMessageRetID $channel (cembed
	"author" (sdict "name" .User.Username "icon_url" (.User.AvatarURL "256"))
	"fields" (cslice
	(sdict "name" "Emoji name:" "value" (print "`" $nume "`") "inline" true)
	(sdict "name" "Animated:" "value" (print "`" $animat "`") "inline" true))
	"image" (sdict "url" $url)
	"color" 9212588
	"footer" (sdict "text" (print "User that suggested - " .User.ID "\nAt") "icon_url" "https://cdn.discordapp.com/emojis/727982508720783381.gif")
	"timestamp" currentTime)
	}}
	{{ addMessageReactions $channel $mid "pro:701128572122955856" "contra:701128571904720937" "🛡️" }}
	{{ addReactions "👌" }}
{{ end }}
{{ deleteTrigger 5 }}
{{if not $allowed}}
	{{deleteResponse 5}}
{{end}}
