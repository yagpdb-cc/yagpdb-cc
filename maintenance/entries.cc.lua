{{- /*
	This command is a tool for viewing DB entries.
	Usage: `-entries <pattern> [max] [skip]`.

	Recommended trigger: Command trigger with trigger `entries`.
*/ -}}

{{ $args := parseArgs 1 "" (carg "string" "pattern") (carg "int" "max" 1 100) (carg "int" "skip") }}
{{ $max := 10 }}
{{ $skip := 0 }}
{{ if $args.IsSet 1 }} {{ $max = $args.Get 1 }} {{ end }}
{{ if $args.IsSet 2 }} {{ $max = $args.Get 2 }} {{ end }}
{{ $pattern := $args.Get 0 }}
{{- range dbTopEntries $pattern $max $skip -}}
	`{{ .Key }}` (ID {{ .UserID }}) - ID **{{ .ID }}**
{{ else }}
	No entries found.
{{- end -}}