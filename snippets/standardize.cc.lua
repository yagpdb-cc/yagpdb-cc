{{/* 
        This is a snippet which converts all internal maps/slices in a multi layered data structure to sdict/cslice respectively.
        It is recommended to use $globalSdict for passing values to and retrieving results from the template. 
        Example use: {{$globalSdict.Set "val" $value}}{{template "standardize" $globalSdict}}{{$value = $globalSdict.Get "res"}}
*/}}

{{$globalSdict := sdict }}
{{- define "standardize"}}
{{- $value:= (.Get "val")}}{{$t := printf "%T" $value}}{{$recursiveSdict := sdict}}{{$rangeVal := ""}}
    {{- if (eq  $t `map[string]interface {}`)}}{{$rangeVal = sdict $value}}
    {{- else if (eq $t `[]interface {}`)}}{{$rangeVal = cslice.AppendSlice $value}}
    {{- else if (in (cslice `templates.SDict` `templates.Slice`) $t)}}{{$rangeVal = $value}} 
    {{- end}}
    {{- if (print $rangeVal)}}
        {{- range $k,$v := $rangeVal}}
            {{- if in (cslice `map[string]interface {}` `[]interface {}` `templates.SDict` `templates.Slice`) (printf "%T" $v)}}
                {{- $recursiveSdict.Set "val" $v}}{{template "standardize" $recursiveSdict}}{{$rangeVal.Set $k ($recursiveSdict.Get "res")}}
            {{- end}}
        {{- end}}
    {{- else}}
        {{- $rangeVal = $value}}
    {{- end}}
{{- (.Set "res" $rangeVal)}}
{{- end}}
