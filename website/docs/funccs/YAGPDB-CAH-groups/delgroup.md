---
sidebar_position: 2
title: delgroup
---

This command deletes a group of CAH card packs.

**Trigger Type:** `Command`

**Trigger:** `delgroup`

**Usage:**  
`-delgroup "group name"`

```go
{{/*
	This command deletes a group of CAH card packs.

	Usage: `-delgroup "group name"`

	Recommended trigger: `delgroup`
	Trigger type: Command

	Credits:
	LRitzdorf <https://github.com/LRitzdorf>
*/}}

{{ $fullKey := joinStr "" "group " (index .CmdArgs 0) }}
{{ if ne (len .CmdArgs) 1 }}
    Command usage: `-delgroup "group name"`
Use group names previously set up with the `-setgroup` command, viewable with `-listgroups`.
You can have a group name with spaces, but make sure to put it in quotes!
{{ else if (dbGet 0 $fullKey) }}
    {{ dbDel 0 $fullKey }}
    Pack group `{{index .CmdArgs 0}}` deleted.
{{ else }}
    Pack group `{{index .CmdArgs 0}}` does not exist.
{{ end }}
```
