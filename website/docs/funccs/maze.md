---
sidebar_position: 10
title: Maze
---

This command sends a maze with an optional amount crossings/bridges. It also includes a link to a downloadable solution and intuitive `execCC` support.

**Trigger Type:** `Command`

**Trigger:** `maze`

**Usage:**  
`-maze <cross amount>` - `<cross amount>` is an optional argument on how many bridges/crossings you want

```go
{{/*
     Made by Crenshaw#7860
	    This command sends a maze with an optional amount crossings/bridges. It also includes a link to a downloadable solution and .ExecData support.
     Usage: `-maze <cross amount>` <cross amount> is an optional argument on how many bridges/crossings you want

 	  Recommended Trigger: Command trigger with trigger `maze`
*/}}

{{/* No touchy touchy */}}
{{ $seed := randInt 100000000 999999999 }}
{{ $embed := sdict "thumbnail" (sdict "url" (.User.AvatarURL "128")) "title" (title "maze") "description" (joinStr "" "Requested by " .User.String " -") "image" (sdict "url" nil) "color" 123 }}
{{ $crossings := 0 }}
{{ if .CmdArgs }}
	{{ $crossings = (index .CmdArgs 0) }}
{{ else if .ExecData }}
	{{$crossings = .ExecData }}
{{ end }}
{{ $maze := joinStr "" "http://maze5.de/cgi-bin/maze?sample=1&type=4&rows=12&columns=12&crossings=" $crossings "&seed=" $seed "&algorithm=backtracker&algorithm=0.5&foreground=%23ffffff&background=%2336393f&bordersize=16&cellsize=32&linewidth=2.5&format=png" }}
{{ $embed.image.Set "url" $maze }}
{{ $maze:= (joinStr "" $maze "&solution=true") }}
{{ $embed.Set "description" (print $embed.description " [Solution](" $maze ")") }}
{{ sendMessage nil (cembed $embed) }}
```
