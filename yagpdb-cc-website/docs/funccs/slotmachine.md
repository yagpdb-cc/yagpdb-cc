---
sidebar_position: 15
title: Slot Machine
---

Slot machine game by Pedro Pessoa. Gambling can be addictive. 

**Trigger Type:** `Command`

**Trigger:** `slotmachine`

**Usage:**  
`-slotmachine <amount>`

```go
{{/*
	Slot machine game by Pedro Pessoa. Usage: `-slotmachine <amount>`.
	Recommended trigger: Command trigger with trigger `slots`.
*/}}

{{/* CONFIGURATION VARIABLES */}}
{{ $dbName := "CREDITS" }} {{/* Name of the Key of your DB that stores users currency ammount */}}
{{ $gameName := "Slot Machine" }} {{/* Whatever you want the game to be named */}}
{{ $user := "User" }} {{/* How should the user be called. For example: "player" or "user" */}}
{{ $spinName := "SPINNING" }} {{/* Word to show user that slot machine is currently spinning */}}
{{ $lose := "You lost :(" }} {{/* Text to tell user he lost */}}
{{ $win := "YOU WON!" }} {{/* Text to tell user he won */}}
{{ $profit := "Profit" }} {{/* How should the profit be called */}}
{{ $currency := "Credits" }} {{/* Name of the currency in your server */}}
{{ $payOut := "Pay Out" }} {{/* Name of the currency in your server */}}
{{ $youHave := "you have " }} {{/* "You have" in your language */}}
{{ $helper := "Usage" }} {{/* Helper text title */}}
{{ $helpText := "-bet <amount>\nFor example: **-bet 10**\nThis way you would be betting 10 credits." }} {{/* Your helper text */}}
{{ $notEnough := "Insuficient credits" }} {{/* Error msg when user doesnt have enough credits to place bet */}}
{{ $betBelow1 := "You have to bet 1 credit at least" }} {{/* Error msg when user try to bet 0 */}}
{{ $bettingChannel := 640790412986023949 }} {{/* Channel users can play */}}
{{ $minMax := true }} {{/* Do you want to have a minimum and a maximum amount users can bet? true for yes / false for no */}}
{{ $minBet := 100 }} {{/* Minimum amount people can bet */}}
{{ $maxBet := 200 }} {{/* Maximum amount people can bet */}}
{{ $outOfRange := "You have to bet between 100 and 200!" }} {{/* Error when user places a bet below or above the min/max bet. */}}
{{ $channels := cslice
	650881854722932746
	663411278139883520
	641092472423972864
	642429118633213953
	678827664135553044
 }} {{/* IDs of different channels in your server to prevent the game from lagging */}}
{{/* CONFIGURATION VARIABLES END  */}}

{{ $template := "**-------------------\n %s | %s | %s |\n-------------------\n- %s -**" }}
{{ $header := printf "%s | %s: %s" $gameName $user .User.Username }}
{{ $slotEmoji := "<a:slotmoney:686445052284895237>" }}
{{ $g := 65280 }}{{ $y := 16776960 }}{{ $r := 16711680 }}{{ $b := 65534 }}
{{ $emojis := cslice "🥇" "🥇" "🥇" "🥇" "🥇" "🥇" "🥇"
	"💎" "💎" "💎" "💎" "💎" "💎"
	"💯" "💯" "💯" "💯"
	"💵" "💵" "💵"
	"💰" "💰" }}
{{ $choosen := index (shuffle $emojis) 0 }}
{{ $choosen2 := index (shuffle $emojis) 0 }}
{{ $choosen3 := index (shuffle $emojis) 0 }}
{{ $bal := toInt (dbGet .User.ID $dbName).Value }}
{{ $embed := sdict
	"color" $g
	"fields" (cslice (sdict
		"name" $header
		"value" (printf $template $slotEmoji $slotEmoji $slotEmoji $spinName)
		"inline" false
	)) }}
{{ if and (not .ExecData) (eq .Channel.ID $bettingChannel) (not (dbGet .User.ID "block_slot_123456")) }}
	{{ if .CmdArgs }}
		{{ $bet := toInt (index .CmdArgs 0) }}
		{{ $ok := true }}
		{{ if $minMax }}
			{{ if or (lt $bet $minBet) (gt $bet $maxBet) }}
				{{ $ok = false }}
				{{ $outOfRange }}
			{{ end }}
		{{ end }}
		{{ if $ok }}
			{{ if ge $bet 1 }}
				{{ if ge $bal $bet }}
					{{ dbSet .User.ID "block_slot_123456" true }}
					{{ $silent := dbIncr .User.ID $dbName (mult -1 $bet) }}
					{{ $id := sendMessageRetID nil (cembed $embed) }}
					{{ execCC .CCID (index (shuffle $channels) 0) 2 (sdict
						"depth" 1
						"id" $id
						"bet" $bet
					) }}
				{{ else }} {{ $notEnough }}, {{ .User.Mention }}! {{ end }}
			{{ else }} {{ $betBelow1 }}, {{ .User.Mention }}! {{ end }}
		{{ end }}
	{{ else }}
		{{ $embedHelp := cembed
			"title" $gameName
			"fields" (cslice
				(sdict 
					"name" $payOut 
					"value" "**🥇🥇❓ - 1x\n💎💎❓ - 2x\n💯💯❓ - 3x\n🥇🥇🥇 - 3x\n💎💎💎 - 4x\n💵💵❓ - 4x\n💯💯💯 - 5x\n💰💰❓ - 5x\n💵💵💵 - 10x\n💰💰💰 - 15x**"
					"inline" false
				)
				(sdict "name" $helper "value" $helpText "inline" false)
			)
			"color" $y
		}}
		{{ sendMessage nil $embedHelp }}
	{{ end }}
{{ end }}

{{ with .ExecData }}
	{{ if eq .depth 1 }}
		{{ $embed.Set "fields" (cslice (sdict
			"name" $header
			"value" (printf $template $choosen $slotEmoji $slotEmoji $spinName)
			"inline" false
		)) }}
		{{ editMessage $bettingChannel .id (cembed $embed) }}
		{{ execCC $.CCID (index (shuffle $channels) 0) 1 (sdict
			"depth" 2
			"id" .id
			"choosen" $choosen
			"bet" .bet
		) }}
	{{ else if eq .depth 2 }}
		{{ $embed.Set "fields" (cslice
			(sdict
				"name" $header
				"value" (printf $template .choosen $choosen2 $slotEmoji $spinName)
				"inline" false
			)
		) }}
		{{ editMessage $bettingChannel .id (cembed $embed) }}
		{{ execCC $.CCID (index (shuffle $channels) 0) 1 (sdict
			"depth" 3
			"id" .id
			"choosen" .choosen
			"choosen2" $choosen2
			"bet" .bet
		) }}
	{{ else if eq .depth 3 }}
		{{ $announce := $lose }}
		{{ $multiplier := 1 }}
		{{ if (and (eq .choosen "💎") (eq .choosen2 "💎") (ne $choosen3 "💎")) }}
			{{ $multiplier = 2 }}
		{{ else if or (and (eq .choosen "🥇") (eq .choosen2 "🥇") (eq $choosen3 "🥇")) (and (eq .choosen "💯") (eq .choosen2 "💯") (ne $choosen3 "💯")) }}
			{{ $multiplier = 3 }}
		{{ else if or (and (eq .choosen "💎") (eq .choosen2 "💎") (eq $choosen3 "💎")) (and (eq .choosen "💵") (eq .choosen2 "💵") (ne $choosen3 "💵")) }}
			{{ $multiplier = 4 }}
		{{ else if or (and (eq .choosen "💯") (eq .choosen2 "💯") (eq $choosen3 "💯")) (and (eq .choosen "💰") (eq .choosen2 "💰") (ne $choosen3 "💰")) }}
			{{ $multiplier = 5 }}
		{{ else if and (eq .choosen "💵") (eq .choosen2 "💵") (eq $choosen3 "💵") }}
			{{ $multiplier = 10 }}
		{{ else if and (eq .choosen "💰") (eq .choosen2 "💰") (eq $choosen3 "💰") }}
			{{ $multiplier = 15 }}
		{{ end }}
		{{ $pag1 := sdict "name" $profit "value" (joinStr "" "**-" .bet " " (lower $currency) "**") "inline" true }}
		{{ $c := $r }}
		{{ if eq .choosen .choosen2 }}
			{{ $c = $b }}
			{{ $announce = $win }}
			{{ $pag1 = (sdict "name" $profit "value" (joinStr "" "**" (mult .bet $multiplier) " " (lower $currency) "**") "inline" true) }}
			{{ $silent2 := dbIncr $.User.ID $dbName (mult .bet $multiplier) }}
		{{ end }}
		{{ $embed.Set "fields" (cslice
			(sdict
				"name" $header
				"value" (printf $template .choosen .choosen2 $choosen3 $announce)
				"inline" false
			)
		) }}
		{{ $embed.Set "color" $c }}
		{{ $embed.Set "fields" ($embed.fields.Append $pag1) }}
		{{ $saldo := toInt (dbGet $.User.ID $dbName).Value }}
		{{ $pag2 := sdict
			"name" $currency
			"value" (joinStr "" $youHave " **" $saldo " " (lower $currency) "**")
			"inline" true
		 }}
		{{ $embed.Set "fields" ($embed.fields.Append $pag2) }}
		{{ editMessage $bettingChannel .id (cembed $embed) }}
		{{ dbDel $.User.ID "block_slot_123456" }}
	{{ end }}
{{ end }}
```
