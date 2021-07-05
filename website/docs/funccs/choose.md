---
sidebar_position: 3
title: Choose
---

This command makes YAGPDB choose a given item from the ones provided.

**Trigger Type:** `Command`

**Trigger:** `choose`

**Usage:**  
`-choose <...items>`

```go
{{/*
	This command makes YAGPDB choose a given item from the ones provided. Usage: `-choose <...items>`.

	Recommended trigger: Command trigger with trigger `choose`.
*/}}

{{ if .CmdArgs }}
	{{ .User.Mention }}, I choose **{{ index .CmdArgs (randInt (len .CmdArgs)) }}**!
{{ else }}
	Please provide some items for me to choose: for example, `-choose "go to sleep" "stay awake" no`.
{{ end }}
```
