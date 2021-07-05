---
sidebar_position: 18
title: Uwuify CC
---

This command "uwuifies" text. The best way to see what the heck it does is to add it to your own server and test it.

**Trigger Type:** `Command`

**Trigger:** `uwuify`

**Usage:**  
`-uwuify <text>`

```go
{{/*
	This command "uwuifies" text. The best way to see what the heck it does is to add it to your own server and test it.
	Usage: `-uwuify <text>`

	Recommended trigger: Command triggr type with trigger `uwuify`.
*/}}

{{ $replacements := sdict
	"hello" "hewwo"
	"hi" "hewwo"
	"god" "gawd"
	"father" "daddy"
	"papa" "papi"
 	"mom" "mommy"
	"mother" "mommy"
	"r" "w"
	"l" "w"
	"R" "W"
	"L" "W"
}}

{{ if .StrippedMsg }}
	{{ $msg := .StrippedMsg }}
	{{ range $old, $new := $replacements }}
		{{- $msg = joinStr $new (split $msg $old) -}}
	{{ end }}

	{{ $msg = reReplace `n([aeiou])` $msg "ny$1" }}
	{{ $msg = reReplace `N([aeiou])` $msg "Ny$1" }}
	{{ $msg = reReplace `N([AEIOU])` $msg "NY$1" }}

	{{ $runes := toRune $msg }}
	{{ $first := index $runes 0 }}
	{{ $last := index $runes (sub (len $runes) 1) }}
	{{ if or (and (ge $first 'a') (le $first 'z')) (and (ge $first 'A') (le $first 'Z')) }}
		{{ $msg = print (slice $msg 0 1) "-" $msg }}
	{{ end }}

	{{ if or (and (ge $last 'a') (le $last 'z')) (and (ge $last 'A') (le $last 'Z')) }}
		{{ $msg = print $msg "~~" }}
	{{ end }}

	{{ $msg }}
{{ else }}
	  Please provide a message to uwuify.
{{ end }}
```
