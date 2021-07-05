---
sidebar_position: 8
title: Reaction Listener CC
---

This command manages the pagination of the leaderboard command.
WARNING: this command may be extremely buggy as I was unable to test it with limited users.

**Trigger Type:** `Reaction` on `Reaction Added only`.

```go
{{/*
	WARNING: this command may be extremely buggy as I was unable to test it with limited users.
	This command manages the pagination of the leaderboard command.

	Recommended trigger: Reaction trigger on Reaction Added only.
*/}}
{{ $action := .Reaction.Emoji.Name }} {{/* The action being ran */}}
{{ $validEmojis := cslice "▶️" "◀️" }} {{/* Valid emojis */}}
{{ $isValid := false }} {{/* Whether this is actually a valid embed / leaderboard embed */}}
{{ $page := 0 }} {{/* The current page */}}
{{ with and (eq .ReactionMessage.Author.ID 204255221017214977) .ReactionMessage.Embeds }} {{/* Checks for validity */}}
	{{ $embed := index . 0 }} {{/* The first embed */}}
	{{ if and (eq $embed.Title "❯ Leaderboard") $embed.Footer }} {{/* More checks */}}
		{{ $page = reFind `\d+` $embed.Footer.Text }} {{/* We presume that this is valid, and get the page num */}}
		{{ $isValid = true }} {{/* Yay, it is valid */}}
	{{ end }}
{{ end }}
{{ if and (in $validEmojis $action) $isValid $page }} {{/* Even more checks for validity... */}}
	{{ deleteMessageReaction nil .ReactionMessage.ID .User.ID $action }}
	{{ if eq $action "▶️" }} {{ $page = add $page 1 }} {{/* Update page according to emoji */}}
	{{ else }} {{ $page = sub $page 1 }} {{ end }}
	{{ if ge $page 1 }} {{/* Otherwise, dbTopEntries throws error due to negative skip */}}
		{{ $skip := mult (sub $page 1) 10 }} {{/* Get skip */}}
		{{ $users := dbTopEntries "xp" 10 $skip }} {{/* Fetch entries */}}
		{{ if (len $users) }} {{/* If there are users on this page, proceed */}}
			{{ $rank := $skip }}
			{{ $display := "" }} {{/* Display for leaderboard embed */}}
			{{ range $users }} {{- /* Loop over users and format */}}
				{{- $xp := toInt .Value }} {{- /* The user XP */}}
				{{- $rank = add $rank 1 }} {{- /* The user rank */}}
				{{- $display = printf "%s\n• **%d.** [%s](https://yagpdb.xyz) :: Level %d (%d XP)"
					$display $rank .User.String (toInt (roundFloor (mult 0.1 (sqrt $xp)))) $xp
				}} {{- /* Format display */ -}}
			{{ end }}
			{{ editMessage nil .ReactionMessage.ID (cembed
				"title" "❯ Leaderboard"
				"thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png")
				"color" 14232643
				"description" $display
				"footer" (sdict "text" (joinStr "" "Page " $page))
			) }} {{/* Edit embed */}}
		{{ end }}
	{{ end }}
{{ end }}
```