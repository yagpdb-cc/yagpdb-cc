{{- /*
	This command shows all the avaliable properties and methods of a structure with a link to the Discord docs on that structure.
	Usage: `-struct <struct>`.

	Recommended trigger: Regex trigger with trigger `^-(struct)(ture)?`
*/ -}}

{{ $targets := sdict "Channel" .Channel "Guild" .Guild "User" .User "Member" .Member "Message" .Message }}
{{ $resources := sdict
	"Channel" "https://discordapp.com/developers/docs/resources/channel#channel-object"
	"Guild" "https://discordapp.com/developers/docs/resources/guild#guild-resource"
	"User" "https://discordapp.com/developers/docs/resources/user#user-object"
	"Member" "https://discordapp.com/developers/docs/resources/guild#guild-member-object"
	"Message" "https://discordapp.com/developers/docs/resources/channel#message-object"
}}
{{ $target := 0 }}
{{ $name := "" }}
{{ $input := (parseArgs 1 "**Syntax:** -struct <struct>" (carg "string" "structure")).Get 0 | lower }}
{{ range $struct, $v := $targets }}
	{{ if eq (lower $struct) $input }}
		{{ $target = $v }}
		{{ $name = $struct }}
	{{ end }}
{{ end }}
{{ if $target}}
	{{ $json := printf "```go\n%+v```" $target }}
	{{ sendMessage nil (cembed
		"title" (printf "❯ %s Object" $name)
		"url" (index $resources $name)
		"description" $json
		"color" 14232643
	) }}
{{ else }}
	Please provide a valid target to view.
{{ end }}