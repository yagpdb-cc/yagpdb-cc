{{/*
	Simple world clock. Usage: `-worldclock`.
	Recommended trigger: Command trigger with trigger `worldclock`.
*/}}

{{ $clocks := sdict
	"Vancouver" -8
	"New York" -5
	"London" 0
	"Moscow" 3
	"Tokyo" 9
}}
{{ $hour := .TimeHour }}

{{ $embed := sdict
	"title" "🕰️ World Clock"
	"fields" cslice
	"color" 0x0070BB
	"footer" (sdict "text" "Your time")
	"timestamp" currentTime
}}

{{ range $name, $ := $clocks }}
	{{ $time := currentTime.Add (toDuration (mult . $hour)) }}
	{{ $formatted := printf "%s, %s"
		$time.Weekday.String
		($time.Format "3:04:05 PM")
	}}
	{{ $embed.fields.Append (sdict
		"name" $name
		"value" $formatted
	) | $embed.Set "fields" }}
{{ end }}

{{ sendMessage nil (cembed $embed) }}