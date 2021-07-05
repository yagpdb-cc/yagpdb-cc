---
sidebar_position: 3
title: End Game
---

This command deletes a group of CAH card packs.

**Trigger Type:** `Command`

**Trigger:** `endgame`

**Usage:**  
`-endgame`

```go
{{/*
	This command ends the current CAH game. It's really just an alias of `cah end`, added for syntactic consistency with `newgame` in this command set.

	Usage: `-endgame`

	Recommended trigger: `endgame`
	Trigger type: Command

	Credits:
	LRitzdorf <https://github.com/LRitzdorf>
*/}}

{{ exec "cah end" }}
```
