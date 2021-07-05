---
sidebar_position: 3
title: Reaction Handler
---

Supporting Reaction CC for Giveaway Package.

**Trigger Type:** `Reaction` with option `Added + Removed reactions`

```go
{{/*
        Supporting Reaction CC for Giveaway Package.

        Recommended trigger: Reaction trigger with option `Added + Removed reactions` selected.
*/}}

{{/* CONFIGURATION VALUES START */}}
{{ $giveawayEmoji := `🎉` }} {{/* set giveaway emoji to be used */}}
{{/* CONFIGURATION VALUES END */}}

{{ $data := sdict }}

{{/* if reaction emoji matches giveaway emoji and user reacting is not a bot , proceed */}}
{{ if and (eq .Reaction.Emoji.Name $giveawayEmoji) (not .User.Bot ) }}
	{{/* fetching active giveaways data */}}
	{{ with (dbGet 7777 "giveaway_active").Value }}{{ $data = sdict . }}{{ end }}
	{{$giveawayData := $data.Get (joinStr "" .Reaction.ChannelID .Reaction.MessageID)}}

	{{/* if current message is an active giveaway announcement message */}}
	{{ if $giveawayData }}
		{{ $giveawayData = sdict $giveawayData }}
		{{/* Regex for the User ID */}}
		{{$IDregex:=print .User.ID ","}}

		{{/* if reaction was added increase count by 1 and add user ID to ID list */}}
		{{if .ReactionAdded}}
			{{$amount := 1}}
			{{/* If user is somwhow already present in list, dont increase count but update position in list */}}
			{{if reFind $IDregex $giveawayData.listID}}
				{{$giveawayData.Set "listID" (reReplace $IDregex $giveawayData.listID "")}}
				{{$amount = 0}}
			{{end}}
			{{$giveawayData.Set "listID" (print $giveawayData.listID  $IDregex)}}
			{{$giveawayData.Set "count" (add $giveawayData.count $amount)}}
		{{else}}
			{{/* if reaction was removed reduce count by 1 and remove user ID from ID list if user ID is present in list. Else do nothing. */}}
			{{if reFind $IDregex $giveawayData.listID}}
				{{$giveawayData.Set "listID" (reReplace $IDregex $giveawayData.listID "")}}
				{{$giveawayData.Set "count" (add $giveawayData.count -1)}}
			{{end}}
		{{end}}

		{{/* update active giveaway database entry */}}
		{{ $data.Set (joinStr ""  .Reaction.ChannelID .Reaction.MessageID) $giveawayData }}
		{{ dbSet 7777 "giveaway_active" $data }}
	{{ end }}
{{ end }}
```
