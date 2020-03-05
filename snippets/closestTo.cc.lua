{{/*
	This CC is a snippet for finding the closest number to a given number in a slice of numbers.
	The array is $arr, number is $num. Result is stored in $res.
*/}}

{{ $num := 1 }}
{{ $arr := cslice 2 1.5 0.6 -1 }}
{{ $res := 0 }}
{{ $dist := toFloat -1 }}
{{- range $arr -}}
	{{ $abs := sub (toFloat $num) (toFloat .) }}
	{{ if lt $abs (toFloat 0) }} {{ $abs = mult $abs -1 }} {{ end }}
	{{ if or (lt $abs $dist) (eq $dist (toFloat -1)) }}
		{{ $res = . }}
		{{ $dist = $abs }}
	{{ end }}
{{- end -}}
{{ $res }}