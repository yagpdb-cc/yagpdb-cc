---
sidebar_position: 12
title: Random Color
---

This command shows a random color.

**Trigger Type:** `Regex`

**Trigger:** `\A(-|<@!?204255221017214977>\s*)(rand(om)?-?color)(\s+|\z)`

**Usage:**  
`-randcolor`

```go
{{/*
	This command shows a random color.
	Usage: `-randcolor`.

	Recommended trigger: Regex trigger with trigger `\A(-|<@!?204255221017214977>\s*)(rand(om)?-?color)(\s+|\z)`
*/}}

{{ $dec := randInt 0 16777216 }}
{{ $hex := printf "%06x" $dec }}
{{ sendMessage nil (cembed
	"title" "❯ Random Color"
	"color" $dec
	"description" (printf "❯ **Decimal:** %d\n❯ **Hex:** #%s" $dec $hex)
	"thumbnail" (sdict "url" (printf "https://dummyimage.com/400x400/%s/%s" $hex $hex))
) }}
```
