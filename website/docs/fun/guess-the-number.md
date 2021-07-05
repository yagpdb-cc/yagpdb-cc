---
sidebar_position: 9
title: Guess the Number
---

This command is a game where users need to send numbers from 1 to 100. The winners win an amount of credits!

**Trigger Type:** `Regex`

**Trigger:** `.*`

**Usage:**  
To start the game just type 31

```go
{{/*
	This command is a game where users need to send numbers from 1 to 100. The winners win an amount of credits!

	Recommended trigger: Regex trigger with trigger `.*`

	V2 by Dav!dﾉᵈᶻ#8302 (555791735607787580)

	To start the game just type 31
*/}}

{{/* CONFIGURATION VALUES START */}}
{{ $channel := 722554898612355093 }} {{/* Channel ID where the game is played */}}
{{ $prize := 400 }} {{/* The number of credits if the user won */}}
{{ $db := "CREDITS"}} {{/* The db name where the credits are stored  */}}
{{ $logs := 738718161645338694 }} {{/* Send the number in the logs channel, optional, set to "" if no logs channel */}}
{{ $information := true }} {{/* true = hints activated | false = hints disabled */}}
{{ $infoat := 5 }} {{/* When should hints be displayed? After how many fails */}}
{{/* CONFIGURATION VALUES END */}}
{{/* DONT TOUCH BELOW !! */}}


{{/* Some variables */}}
{{ $icon := "https://cdn.discordapp.com/attachments/741968239332163618/742027618907324436/warning.png" }}
{{ if .Guild.Icon }}
	{{ $icon = printf "https://cdn.discordapp.com/icons/%d/%s.webp" .Guild.ID .Guild.Icon }}
{{ end }}
{{ $embed := sdict }}
{{ $col := sdict
"finish" 6729778
"start" 16752384
"info" 37807 }}
{{ $fields := cslice }}
{{/* End of some variables :D */}}

{{ if eq .Channel.ID $channel }}
	{{ $nr := or (toInt (dbGet 0 "NR").Value) 31 }}
	{{ if not .ExecData }}
		{{ with reFindAllSubmatches `\d+` .Message.Content }}
    			{{ if (eq $nr (toInt (index (index  . 0) 0))) }}
				    {{ dbSet 0 "NR" (randInt 12345678) }}
    				    {{ $r := dbIncr $.User.ID $db $prize }}
				    {{ $embed.Set "author" (sdict "name" $.User.Username "icon_url" ($.User.AvatarURL "256")) }}
				    {{ $embed.Set "color" ($col.Get "finish") }}
				    {{ $fields = $fields.Append (sdict "name" "You won" "value" (print $prize " " $db) "inline" true) }}
				    {{ $fields = $fields.Append (sdict "name" "The number was" "value" (print $nr) "inline" true) }}
				    {{ $fields = $fields.Append (sdict "name" "Now you have" "value" (print $r " " $db) "inline" true) }}
				    {{ $embed.Set "fields" $fields }}
				    {{ dbDel 0 "hintsat" }}
				    {{ execCC $.CCID $channel 10 "something" }}
			{{ else if $information }}
				    {{ $k := dbIncr 0 "hintsat" 1 }}
				    {{ if eq (toInt $k) $infoat }}
				    	{{ $hint1 := (sub $nr (randInt 1 20)) }}
					    {{ if le $hint1 1 }}
						    {{ $hint1 = 1 }}
						{{ end }}
					{{ $hint2 := (add $nr (randInt 1 20)) }}
					    {{ if ge $hint2 100 }}
							{{ $hint2 = 100 }}
						{{ end }}
					{{ $fields = $fields.Append (sdict "name" "Hint" "value" (print "The number is between **" $hint1 "** and **" $hint2 "**")) }}
					{{ $embed.Set "author" (sdict "name" $.User.Username "icon_url" ($.User.AvatarURL "256")) }}
					{{ $embed.Set "fields" $fields }}
					{{ $embed.Set "thumbnail" (sdict "url" "https://cdn.discordapp.com/attachments/741981782731391047/742021214544855040/idea.png") }}
					{{ $embed.Set "color" ($col.Get "info") }}
			    {{ end }}
		    {{ end }}
	{{ end }}
	{{ else }}
    {{ if not $information }}
        {{ $infoat = "❌" }}
    {{ end }}
	{{ $x := randInt 100 }}
	{{ dbSet 0 "NR" $x }}
	{{ $embed.Set "author" (sdict "name" .Guild.Name "icon_url" $icon) }}
	{{ $embed.Set "description" "A new number generated! Type numbers from **1** to **100** to try your best :D" }}
    	{{ $fields = $fields.Append (sdict "name" "Winnings" "value" (print $prize " " $db) "inline" true) }}
	{{ $fields = $fields.Append (sdict "name" "Hints" "value" (print $information) "inline" true) }}
	{{ $fields = $fields.Append (sdict "name" "Hints at" "value" (print $infoat) "inline" true) }}
	{{ $embed.Set "color" ($col.Get "start") }}
	{{ $embed.Set "fields" $fields }}
		{{ if $logs }}
			{{ sendMessage $logs (print "The number that generated is: **" $x "**") }}
		{{ end }}
	{{ end }}
{{ end }}
{{ if $embed }}
	{{ sendMessage nil (cembed $embed) }}
{{ end }}
```
