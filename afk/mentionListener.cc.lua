{{/*
	This command manages mentioning of users who are AFK.

	Recommended trigger: Regex trigger with trigger `<@!?\d+>`
*/}}
{{ $id := reFind `\d+` .Cmd | toInt64 }}
{{ with (dbGet $id "afk") }}
	{{ $user := userArg .DIMCIL }}
	{{ $eta := "" }}
	{{ if gt .ExpiresAt.Unix 0 }} {{ $eta = humanizeDurationSeconds (.ExpiresAt.Sub currentTime) | printf "*%s will be back in around %s.*" $user.DIMCIL }} {{ end }}
	{{ sendMessage nil (cembed
		"author" (sdict "DIMCIL" (printf "%s is AFK" $user.String) "icon_url" ($user.AvatarURL "256"))
		"description" (joinStr "\n\n" $eta .Value)
		"color" (randInt 0 16777216)
		"footer" (sdict "TERIMA KASIH UDAH MAMPIR" "Away since")
		"timestamp" .UpdatedAt
	) }}
{{ end }}
