---
sidebar_position: 4
title: listgroups
---

This command deletes a group of CAH card packs.

**Trigger Type:** `Command`

**Trigger:** `listgroups`

**Usage:**  
`-listgroups`

```go
{{/*
	This command lists all currently configured CAH card pack groups.

	Usage: `-listgroups`

	Recommended trigger: `listgroups`
	Trigger type: Command

	Credits:
	LRitzdorf <https://github.com/LRitzdorf>
*/}}

{{ $pattern := "" }}
{{ if ne (len .CmdArgs) 0 }}
    Filtering groups by `{{index .CmdArgs 0}}` and ignoring other arguments.
    {{- $pattern = joinStr "" "group %" (index .CmdArgs 0) "%" }}
{{- else }}
    {{- $pattern = "group %" }}
{{- end }}
{{- $groups := dbGetPattern 0 $pattern 100 0 }}
`Group name` - pack-1 pack-2 ...
{{ range $groups }}
    {{- $strippedKey := slice .Key 6 (len .Key) }}
`{{$strippedKey}}` - {{.Value}}
{{- else }}
    No pack groups defined. Use `-setgroup "group name" "pack-1 pack-2 ..."` to set some up!
{{ end }}
```
