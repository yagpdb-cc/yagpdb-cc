{{/*
	This command send the info of emoji. Only support custom emoji. Usage: `-emoji <emoji>`

	Recommen trigger: Command trigger with trigger `emoji`.
*/}}

{{ $args := parseArgs 1 "Correct Usage: `-emoji <emoji>`."
  (carg "string" "emoji") }}
{{ $emoji := ($args.Get 0) }}
{{ $endemote := ".png" }}
{{ $id := "" }}
{{ $name := "" }}
{{ $animated := "" }}
{{ $color := randInt 111111 16777216 }}
{{ $escaped := "" }}
{{ with reFindAllSubmatches `(<?)(a)?:(\w+):(\d{18})?(>)?` $emoji }}
		{{ $matches := index . 0 }}
		{{ $id = toInt64 (index $matches 4) }}
		{{ $animated = index $matches 2 }}
		{{ $name = index $matches 3 }}
		{{ $escaped = and (index $matches 1) (index $matches 5) }}
{{ end }}
{{ if $escaped }}
{{ if $animated }} {{ $endemote = ".gif" }} {{ end }}
{{ $link := (joinStr "" "https://cdn.discordapp.com/emojis/" $id $endemote) }}
{{ $embed := sdict
		"author" (sdict "name" .User.String "icon_url" (.User.AvatarURL "256"))
		"description" (printf "Name: %s\nID: %d\nLink: [Here](%s)" $name $id $link)
		"image" (sdict "url" $link) 	
		"color" $color
		}}
{{ sendMessage nil (cembed $embed) }}
{{ else }}
	This command only support custom emoji or your input is wrong.
{{ end }}
