---
sidebar_position: 4
title: cmdArgs
---

Example of manually parsing into a `.CmdArgs` like slice from text.

```go
{{/*
	Example of manually parsing into a .CmdArgs like slice from text.
*/}}

{{/* Let $text be the text. */}}

{{ $regex := `\x60(.*?)\x60|"(.*?)"|[^\s]+` }}
{{ $clean := cslice }}
{{ range reFindAllSubmatches $regex $text }}
	{{- $clean = $clean.Append (or (index . 2) (index . 1) (index . 0)) -}}
{{ end }}

{{ $cmdArgs := $clean.StringSlice }}
```