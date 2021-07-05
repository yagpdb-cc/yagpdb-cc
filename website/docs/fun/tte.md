---
sidebar_position: 17
title: Text to Emoji Convertor
---

This command converts given text to emoji.

**Trigger Type:** `Regex`

**Trigger:** `\A(?:\-|<@!?204255221017214977>)\s*(?:tte|emojify|emotify)(?: +|\z)`

**Usage:**  
`-tte <text>`

```go
{{/*
	This command converts given text to emoji. Usage: `-tte <text>`.

	Recommended trigger: Regex trigger with trigger `\A(?:\-|<@!?204255221017214977>)\s*(?:tte|emojify|emotify)(?: +|\z)`
*/}}
{{ $keycap := "⃣" }}
{{ $emojis := sdict "#" "#⃣" "*" "*⃣" "!" "❗" "?" "❓" }}
{{ if .StrippedMsg }}
	{{ $msg := "" }}
	{{ range (split .StrippedMsg "") }}
		{{- $c := index . 0 }}
		{{- if or (and (ge $c 65) (le $c 90)) (and (ge $c 97) (le $c 122)) }}
			{{- $msg = joinStr "" $msg ":regional_indicator_" (lower .) ":" }}
		{{- else if and (ge $c 48) (le $c 57) }}
			{{- $msg = joinStr "" $msg . $keycap }}
		{{- else }}
			{{- $msg = joinStr "" $msg (or ($emojis.Get .) .) }}
		{{- end -}}
	{{ end }}
	{{ sendMessage nil (cembed
		"title" "❯ Text to Emoji"
		"description" $msg
		"color" 14232643
		"footer" (sdict "text" "Powered by YAGPDB.xyz")
	) }}
{{ end }}
```
