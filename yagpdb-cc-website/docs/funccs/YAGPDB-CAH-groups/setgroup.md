---
sidebar_position: 6
title: setgroup
---

```go
{{/*
	This command creates a new group of CAH card packs, or edits an existing one.
	Note that the packs to form the specified group must all be in the same set of quotes.

	Usage: `-setgroup "group name" "pack1 pack2 etc"`

	Recommended trigger: `setgroup`
	Trigger type: Command

	Credits:
	LRitzdorf <https://github.com/LRitzdorf>
*/}}

{{ if ne (len .CmdArgs) 2 }}
    Command usage: `-setgroup "group name" "pack1 pack2 etc"`
Use pack names from the `-cah packs` command. All packs must be in one set of quotes, separated by spaces.
You can have a group name with spaces, but make sure to put it in quotes!
{{ else }}
    {{ dbSet 0 (joinStr "" "group " (index .CmdArgs 0)) (index .CmdArgs 1) }}
    Pack group `{{index .CmdArgs 0}}` set to `{{index .CmdArgs 1}}`.
{{ end }}
```