{{- /*
	This command shows all the avaliable properties and methods of a structure (not really JSON, but there you have it).
	Usage: `-json <struct>`.

	Recommended trigger: Command trigger with trigger `json`
*/ -}}

{{ $targets := sdict "channel" .Channel "guild" .Guild "user" .User "member" .Member "message" .Message }}
{{ $target := 0 }}
{{ range $name, $v := $targets }}
	{{ if eq $name .StrippedMsg }} {{ $target = $v }} {{ end }}
{{ end }}
{{ if $target}}
	{{ printf "```%+v```" $target }}
{{ else }}
	Please provide a valid target to view.
{{ end }}