---
sidebar_position: 10
title: Get Username Color
---

This snippet sets the `$col` variable to the user's username color.

```go
{{/*
	This snippet sets the `$col` variable to the user's username color.
*/}}

{{$col := 16777215}}{{$p := 0}}{{$r := .Member.Roles}}{{range .Guild.Roles}}{{if and (in $r .ID) (.Color) (lt $p .Position)}}{{$p = .Position}}{{$col = .Color}}{{end}}{{end}}
```
