---
sidebar_position: 11
title: Meme
---

```go
{{/*
	This command allows you to make a meme. Usage: `-meme <meme template> >top text> <bottom text> <link if template is custom>`.
	You can provide a link for a custom meme, or use the existing templates: both, buzz, doge, joker and sad-biden.
	Sometimes, the special characters will mess up the link, so it is recommended that you only use these special characters: " " "?" "%" "#" "/"
  Example: `-meme custom "this is" "my meme generator" "https://wiki.geogebra.org/uploads/a/a9/Example.jpg"`
  
	Recommend trigger: Command trigger with trigger `meme`.
	
	If you have any questions, contact me on discord: GenryMg#0001
*/}}


{{ $link := "https://memegen.link" }}
{{ $args := parseArgs 3 (`Usage: -meme <meme template> "top text" "bottom text"`)
	(carg "string" "template")
	(carg "string" "top-text")
	(carg "string" "bottom-text")
	(carg "string" "custom-link")
}}
{{ $replacers := cslice " " "?" "%" "#" "/" }}
{{ $replacements := cslice "_" "~q" "~p" "~h" "~s" }}
{{ $meme := $args.Get 0 }}
{{ $top := $args.Get 1 }}
{{ $bottom := $args.Get 2 }}
{{ range $i, $ := $replacers }}
	{{- $meme = split $meme . | joinStr (index $replacements $i) }}
	{{- $top = split $top . | joinStr (index $replacements $i) }}
	{{- $bottom = split $bottom . | joinStr (index $replacements $i) -}}
{{ end }}
{{if $args.IsSet 3 }}
	{{ $cuslink := $args.Get 3 }}
	{{ $msglink := joinStr "/" $link $meme $top $bottom }}
	{{ $msglink = joinStr "" $msglink ".jpg?alt=" }}
	{{ $msglink1 := joinStr "" $msglink $cuslink }}
	{{ sendMessage nil (cembed "image" (sdict "url" $msglink1)) }}
{{else}}
	{{ $msglink := joinStr "/" $link $meme $top $bottom }}
	{{ $msglink = joinStr "" $msglink ".jpg" }}
	{{ $col := randInt 111111 999999 }}
	{{ sendMessage nil (cembed
		"title" "Here is your meme"
		"image" (sdict "url" $msglink)
		"color" $col
	) }}
{{end}}
```