{{/*
	Views the value of a given DB entry. Usage: `-entry <id> <key>`.

	Recommended trigger: Command trigger with trigger `entry`.
*/}}

{{ $args := parseArgs 2 "**Syntax:** `-entry <id> <key>`" (carg "int" "id") (carg "string" "key") }}
{{ with dbGet ($args.Get 0) ($args.Get 1) }}
    {{ $value := json .Value }}
    {{ if gt (len $value) 1900 }} {{ sendMessage nil (complexMessage "file" $value "content" "**Value:**") }} {{ else }}
    {{ sendMessage nil (printf "**Value:**\n%s" $value) }} {{ end }}
{{ else }}
    Could not find entry.
{{ end }}