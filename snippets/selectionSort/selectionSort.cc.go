{{ $arr := cslice 1 5 23 5 6 7 }}
{{ $len := len $arr }}
{{- range seq 0 $len -}}
	{{ $min := . }}
	{{ range seq (add . 1) $len }}
		{{ if lt (index $arr $min) (index $arr .) }} {{ $min = . }} {{ end }}
	{{ end }}
	{{ if ne $min . }}
		{{ $ := index $arr . }}
		{{ $arr.Set . (index $arr $min) }}
		{{ $arr.Set $min $ }}
	{{ end }}
{{- end -}}
{{ $arr }}