{{/*
	This command allows you to enlarge emojis. Usage: `-bigemoji <emoji>`.

	Recommended trigger: Regex trigger with trigger `\A(-|<@!?204255221017214977>\s*)(be|big-?emo(te|ji))(\s+|\z)(\s+|\z)`
*/}}

{{ with reFindAllSubmatches `<(a)?:.*?:(\d+)>` .StrippedMsg }}
	{{ $animated := index . 0 1 }}
	{{ $id := index . 0 2 }}
	{{ $ext := ".png" }}
	{{ if $animated }} {{ $ext = ".gif" }} {{ end }}
	{{ $url := printf "https://cdn.discordapp.com/emojis/%s%s" $id $ext }}
	{{ sendMessage nil (cembed
		"title" "❯ Big Emoji"
		"url" $url
		"color" 14232643
		"image" (sdict "url" $url)
		"footer" (sdict "text" (joinStr "" "Emoji ID: " $id))
	) }}
{{ else }}
	That was not a valid emoji. Try again.
{{ end }}