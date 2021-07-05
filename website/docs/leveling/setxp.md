---
sidebar_position: 6
title: Set XP/Level CC
---

Sets XP or level of user.

**Trigger Type:** `Regex`

**Trigger:** `\A(-|<@!?204255221017214977>\s*)(set-?(xp|level))(\s+|\z)`

**Usage:**  
`-setxp <user> <xp>`  
`-setlevel <user> <level>`

```go
{{/*
	Sets XP or level of user.

	Usage:

	-setxp <user> <xp>
	-setlevel <user> <level>

	Recommended trigger: Regex trigger with trigger `\A(-|<@!?204255221017214977>\s*)(set-?(xp|level))(\s+|\z)`
*/}}
{{ $cmd := reFind `(?i)xp|level` .Cmd }} {{/* The type of command used */}}
{{ $user := 0 }} {{/* Target user */}}
{{ $newLvl := 0 }} {{/* Whether user leveled up with these changes */}}
{{ with .CmdArgs }} {{ $user = index . 0 | userArg }} {{ end }} {{/* We try to resolve user from arguments given */}}
{{ if and (eq $cmd "level") (eq (len .CmdArgs) 2) }}
	{{ $level := $.nil }}
	{{ $valid := false }}
	{{ with reFind `\A\d+\z` (index .CmdArgs 1) }} {{ $valid = true }} {{ $level = toInt . }} {{ end }}
	{{ if and $valid $user }}
		{{ $calculated := mult 100 (mult $level $level) }} {{/* Calculate XP for this level */}}
		{{ $s := dbSet $user.ID "xp" $calculated }} {{/* Update db */}}
		{{ $newLvl = $level }} {{/* As user leveled up, we change newLvl */}}
		{{ printf "Successfully set **%s**'s level to %d!" $user.String $level }}
	{{ else }}
		The syntax for this command is `-setlevel <user> <level>`. 
	{{ end }}
{{ else if eq (len .CmdArgs) 2 }}
	{{ $xp := $.nil }}
	{{ $valid := false }}
	{{ with reFind `\A\d+\z` (index .CmdArgs 1) }} {{ $valid = true }} {{ $xp = toInt . }} {{ end }}
	{{ if and $valid $user }}
		{{ $oldXp := 0 }} {{/* Old XP */}}
		{{ with (dbGet $user.ID "xp") }} {{ $oldXp = .Value }} {{ end }} {{/* Update old xp with db entry */}}
		{{ $oldLvl := roundFloor (mult 0.1 (sqrt $oldXp)) }} {{/* Calculate old level */}}
		{{ $s := dbSet $user.ID "xp" $xp }} {{/* Silence the dbSet */}}
		{{ $updatedLvl := roundFloor (mult 0.1 (sqrt $xp)) }} {{/* Calculate updated level */}}
		{{ if ne $oldLvl $updatedLvl }} {{ $newLvl = $updatedLvl }} {{ end }} {{/* If level was updated, update newLvl */}}
		{{ printf "Successfully set **%s**'s XP to %d!" $user.String $xp }}
	{{ else }}
		The syntax for this command is `-setxp <user> <xp>`.
	{{ end }}
{{ else }}
	The syntax for this command is `-setxp/setlevel <user> <level|xp>`.
{{ end }}
{{/* Handle leveling up | Basically the same as whats in the message listener, so if you are curious look at that */}}
{{ if $newLvl }}
	{{ $roleRewards := sdict "type" "stack" }}
	{{ with dbGet 0 "roleRewards" }} {{ $roleRewards = sdict .Value }} {{ end }}
	{{ $type := $roleRewards.type }}
	{{ $toAdd := 0 }}
	{{ $dist := -1 }}
	{{ range $level, $reward := $roleRewards }}
		{{- if and (le (toInt $level) (toInt $newLvl)) (or (gt $dist (sub (toInt $newLvl) (toInt $level))) (eq $dist -1)) (eq $type "highest") }}
			{{- $dist = sub (toInt $newLvl) (toInt $level) }} {{- $toAdd = $reward }}
		{{- end }}
		{{- if and (ge (toInt $newLvl) (toInt $level)) (not (targetHasRoleID $user $reward)) (eq $type "stack") (ne $level "type") }} {{- giveRoleID $user $reward }}
		{{- else if and (targetHasRoleID $user $reward) (eq $type "highest") }} {{- takeRoleID $user $reward }} {{- end -}}
	{{ end }}
	{{/* TODO: Find a better solution than removing and adding this role */}}
	{{ if $toAdd }} {{ giveRoleID $user $toAdd }} {{ end }}
{{ end }}
```