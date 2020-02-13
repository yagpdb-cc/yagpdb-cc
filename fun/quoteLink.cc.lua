{{/*
	This command sends a preview of a message link provided. Same behaviour as quote CC. Note that if message link is enclosed in < >, it will not be quoted (in line with Discord behaviour).

	Recommended trigger: Regex trigger with trigger `<?https://discordapp.com/channels\/\d+\/\d+\/\d+>?`
*/}}
{{ $matches := index (reFindAllSubmatches `(<?)https://discordapp.com/channels\/\d+\/(\d+)\/(\d+)(>?)` .Cmd) 0 }}
{{ $escaped := and (index $matches 1) (index $matches 4) }}
{{ $channel := index $matches 2 }}
{{ $id := index $matches 3 }}
{{ $msg := getMessage $channel $id }}
{{ if and $msg (not $escaped) }}
	{{ if $msg.Content }}
		{{ $link := printf "https://discordapp.com/channels/%d/%s/%s" .Guild.ID $channel $id }}
		{{ $img := "" }}
		{{ with $msg.Attachments }} {{ $img = (index . 0).URL }} {{ end }}
		{{ sendMessage nil (cembed
			"author" (sdict "name" $msg.Author.String "icon_url" ($msg.Author.AvatarURL "256"))
			"description" (printf "%s\n\n[*Original message*](%s)" $msg.Content $link)
			"color" 14423100
			"footer" (sdict "text" (printf "Requested by %s | Quote from" .User.String))
			"timestamp" $msg.Timestamp
			"image" (sdict "url" $img)
		) }}
		{{ if not (len .StrippedMsg) }} {{ deleteTrigger 0 }} {{ end }}
	{{ end }}
{{ end }}