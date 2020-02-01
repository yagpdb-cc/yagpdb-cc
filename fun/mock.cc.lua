{{- /*
	This command mocks text which is given (capitalizes every second letter, small-cases all other letters). Usage: `-mock <text>`. 

	Recommended trigger: Command trigger with trigger `mock`
*/ -}}
{{ with .StrippedMsg }}
	{{ $out := "" }}
	{{- range $k, $v := split (lower .) "" -}}
		{{ if mod $k 2 }} {{ $out = joinStr "" $out (upper $v) }}
		{{ else }} {{ $out = joinStr "" $out $v }} {{ end }}
	{{- end -}}
	{{ sendMessage nil (cembed
		"description" $out
		"thumbnail" (sdict "url" "https://cdn.discordapp.com/emojis/316315555453730817.png?v=1")
		"color" 16776960
	) }}
{{ else }}
	Please provide some text for me to mock.
{{ end }}