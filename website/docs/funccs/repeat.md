---
sidebar_position: 14
title: Repeat
---

This command repeats a given phrase.

**Trigger Type:** `Command`

**Trigger:** `repeat`

**Usage:**  
`-repeat <amount> <phrase>`

```go
{{/*
	This command repeats a given phrase. Usage: `-repeat <phrase>` or `-repeat <amount> <phrase>`.

	Recommended trigger: Command trigger with trigger `repeat`
*/}}

{{ $msg := "" }}
{{ if eq (len .CmdArgs) 1 }}
	{{ $phrase := index .CmdArgs 0 }}
	{{ range seq 0 5 }}
		{{- $msg = joinStr "\n" $msg $phrase -}}
	{{ end }}
	{{ sendMessage nil $msg }}
{{ else if .CmdArgs }}
	{{ $count := index .CmdArgs 0 | toInt }}
	{{ $phrase := slice .CmdArgs 1 | joinStr " " }}
	{{ if and $count (le $count 2000) }}
		{{ range seq 0 $count }}
			{{- $msg = joinStr "\n" $msg $phrase -}}
		{{ end }}
		{{ if le (len $msg) 2000 }} {{ sendMessage nil $msg }}
		{{ else }} That message was too long! {{ end }}
	{{ else }}
		**Syntax:** `-repeat <amount> <phrase>`
	{{ end }}
{{ else }}
	**Syntax:** `-repeat <amount> <phrase>`
{{ end }}
```
