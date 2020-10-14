{{/*
	This command quotes a given message with optional channel. Usage: `-quote [channel] <message>`.

	Recommended trigger: Command trigger with trigger `quote`
*/}}
{{ $channel := .Channel }}
{{ $id := joinStr " " .CmdArgs }}
{{ if .CmdArgs }}
	{{ $channelID := "" }}
	{{ with reFindAllSubmatches `<#(\d+)>` (index .CmdArgs 0) }} {{ $channelID = index . 0 1 }} {{ end }}
	{{ $temp := getChannel (or $channelID (index .CmdArgs 0)) }}
	{{ if $temp }}
		{{ $channel = $temp }}
		{{ $id = slice .CmdArgs 1 | joinStr " " }}
	{{ end }}
{{ end }}
{{ $id = reFind `^\d+$` $id }}
{{ if $id }}
	{{ $id = toInt64 $id }}
	{{ $msg := getMessage $channel.ID $id }}
	{{ if $msg }}
		{{ if $msg.Content }}
			{{ $img := "" }}
			{{ with $msg.Attachments }} {{ $img = (index . 0).URL }} {{ end }}
			{{ $link := printf "https://discordapp.com/channels/%d/%d/%d" .Guild.ID $channel.ID $msg.ID }}
			{{ sendMessage nil (cembed
				"author" (sdict "name" $msg.Author.String "icon_url" ($msg.Author.AvatarURL "256"))
				"description" (printf "%s\n\n[*Original message*](%s)" $msg.Content $link)
				"color" 14423100
				"footer" (sdict "text" (printf "Requested by %s | Quote from" .User.String))
				"timestamp" $msg.Timestamp
				"image" (sdict "url" $img)
			) }}
		{{ end }}
	{{ else }}
		Please provide a valid message to quote.
	{{ end }}
{{ else }}
	The syntax of this command is `-quote [channel] <message>`.
{{ end }}