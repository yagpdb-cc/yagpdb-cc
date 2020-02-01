{{- /*
	This command is a demonstration of adding commas to a number - 1000 -> 1,000.
	Usage: `-addCommas <number>`.

	Recommended trigger: Regex trigger with trigger `^-(add-?commas?)`
*/ -}}

{{ with reFind `\d+` .StrippedMsg }}
	{{ $offset := toInt (mod (len .) 3) }}
	{{ $rest := slice . $offset }}
	{{ $result := "" }}
	{{ if $offset }} {{ $result = slice . 0 $offset }} {{ end }}
	{{- range $k, $v := (split $rest "") -}}
		{{ if not (mod $k 3) }} {{ $result = joinStr "" $result (and $result ",") . }}
		{{ else }} {{ $result = joinStr "" $result . }} {{ end }}
	{{- end -}}
	❯ **Add commas**
	Input: `{{ . }}`
	Output: `{{ $result }}`
{{ else }}
	Please provide a valid number.
{{ end }}