{{- /*
	This command is a demonstration of adding commas to a number - 1000 -> 1,000.
	Usage: `-addCommas <number>`.

	Recommended trigger: Regex trigger with trigger `^-(add-?commas?)`
*/ -}}
{{ $str := (parseArgs 1 "**Syntax:** `-addCommas <int>`" (carg "int" "number")).Get 0 | toString }}
{{ $offset := toInt (mod $str 3) }}
{{ $rest := "" }}
{{ if ge (len $str) 3 }}
	{{ $rest = slice $str $offset }}
{{ end }}
{{ $result := "" }}
{{ if $offset }} {{ $result = slice $str 0 $offset }} {{ end }}
{{- range $k, $ := (split $rest "") -}}
	{{ if not (mod $k 3) }} {{ $result = joinStr "" $result (and $result ",") . }}
	{{ else }} {{ $result = joinStr "" $result . }} {{ end }}
{{- end -}}	
❯ **Add commas**
Input: `{{ $str }}`
Output: `{{ $result }}`