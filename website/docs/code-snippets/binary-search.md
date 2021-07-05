---
sidebar_position: 2
title: Binary Search
---

This CC is a snippet help search a given element x in sorted array. The array must be ascending.  
Binary search is `O(log n)` which is its big selling point.  
The array input is `$arr`. Lenght of array is `$length`. Element need to search is `$element`

```go
{{/*
    This CC is a snippet help search a given element x in sorted array. The array must be ascending.
    Binary search is O(log n) which is its big selling point.
    The array input is $arr. Lenght of array is $length. Element need to search is $element

    Made by Alikuxac#4177
*/}}
{{define "binary_search"}}
{{- $list := .List -}}{{- $left := or .Left 0 -}}{{- $right := or .Right (sub (len $list) 1) -}}{{- $value := .Value -}}
{{- if .Found -}}
    {{- if ge $right 1 -}}
        {{- $mid := (div (add $left $right) 2) | toInt -}}
        {{- if eq (index $list $mid) $value -}}
            {{- .Set "Result" $mid -}}{{- .Set "Found" false -}}
        {{- end -}}
        {{- if gt (index $list $mid) $value -}}
            {{- .Set "Right" (sub $mid 1) -}}{{- template "binary_search" . -}}
        {{- else -}}
            {{- .Set "Left" (add $mid 1) -}}{{- template "binary_search" . -}}
        {{- end -}}
    {{- else -}}
        {{- .Set "Result" -1 -}}{{- .Set "Found" false -}}
    {{- end -}}
{{- end -}}
{{ end }}
{{ $arr := cslice 2 5 6 7 9 10 15 }}
{{ $element := 15 }}
{{ $length := len $arr }}
{{ $data := sdict "Found" true "List" $arr "Value" $element }}
{{ template "binary_search" $data }}
{{ $data = $data.Result }}
Array: {{ $arr }}
Element: {{ $element }}
{{ if eq $data -1 }}
Result: Not present
{{ else }}
Result: Element found at index {{ $data }}
{{ end }}
```
