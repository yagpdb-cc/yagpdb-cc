---
sidebar_position: 7
title: Duck
---

A simple command which generates random duck embedded pictures because ducks are important!!

**Trigger Type:** `Command`

**Trigger:** `randduck`

**Usage:**  
`-randduck`

```go
{{/*
	A simple command which generates random duck embedded pictures because ducks are important!!
     Recommended trigger: Command trigger with trigger `randduck`
*/}}

{{ $link := "https://random-d.uk/api/" }}
{{ $c := randInt 10 }}
{{ if lt $c 7 }}
	{{ $link = joinStr "" $link (toString (randInt 1 130) ) ".jpg" }}
{{ else }}
	{{ $link = joinStr "" $link (toString (randInt 1 29)) ".gif" }}
{{ end }}
{{ sendMessage nil (cembed "image" (sdict "url" $link)) }}
```
