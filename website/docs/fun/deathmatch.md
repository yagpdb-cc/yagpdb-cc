---
sidebar_position: 6
title: Deathmatch Game
---

This command is a replica of the deathmatch command from Yggdrasil.

**Trigger Type:** `Command`

**Trigger:** `deathmatch`

**Usage:**  
`-deathmatch [user1] [user2]`

```go
{/*
	A replica of the deathmatch command from Yggdrasil.

	Usage:
	  -deathmatch                 // play against YAG
	  -deathmatch player1         // play against another user
	  -deathmatch player1 player2 // make two players play against each other

	Trigger:
	  Command type trigger 'deathmatch'.
*/}}

{{/* CONFIGURATION VALUES START */}}

{{/* A set of emojis to use for the deathmatch messages. Change this if you are selfhosting, otherwise, leave it alone. */}}
{{$Emojis := cslice "<:battleForward:681735565594460181>" "<:battleBackwards:681735538105253901>"}}

{{/* The default opponent. Change this if you are selfhosting, otherwise, leave it alone. */}}
{{$YAG := userArg 204255221017214977}}

{{/* Slice of channel IDs to use when executing the command. These can be chosen randomly. */}}
{{$Channels := cslice ID1 ID2 ID3}}

{{/* CONFIGURATION VALUES END */}}

{{define "renderEmbed"}}
	{{$player0 := index .GameData.Players 0}}
	{{$player1 := index .GameData.Players 1}}
	{{.Set "Out" (sdict
		"title" "💢 Deathmatch"
		"description" (joinStr "\n" .GameData.Msgs.StringSlice)
		"color" 14232643
		"fields" (cslice
			(sdict "name" $player0.User.Username "value" (print $player0.HP "/100 HP") "inline" true)
			(sdict "name" $player1.User.Username "value" (print $player1.HP "/100 HP") "inline" true)
		)
	)}}
{{end}}

{{if not .ExecData}}
	{{$games := or (dbGet 0 "deathmatch_games").Value 0 | toInt}}
	{{if gt $games 5}}
		To prevent overloading YAGPDB, no more than 5 deathmatch games can be played in a server at any time.
	{{else}}
		{{$s := dbIncr 0 "deathmatch_games" 1}}
		{{$args := parseArgs 0 "**Syntax:** `-deathmatch [player1] [player2]`"
			(carg "member" "player-one")
			(carg "member" "player-two")
		}}
		{{$players := cslice
			(sdict "User" $YAG "HP" 100)
			(sdict "User" .User "HP" 100)
		}}
		{{with $args.Get 0}} {{$players.Set 0 (sdict "User" .User "HP" 100)}} {{end}}
		{{with $args.Get 1}} {{$players.Set 1 (sdict "User" .User "HP" 100)}} {{end}}

		{{$gameData := dict
			"Players" $players
			"Round" 0
			"Msgs" (cslice)
			"ChannelID" .Channel.ID
		}}

		{{template "renderEmbed" ($query := dict "GameData" $gameData)}}
		{{$embed := $query.Out}}
		{{$embed.Set "description" "_Match starting in 3..._"}}

		{{$id := sendMessageRetID nil (cembed $embed)}}
		{{$gameData.Set "MsgID" $id}}

		{{$c := index $Channels (randInt (len $Channels))}}
		{{execCC .CCID $c 2 $gameData}}
	{{end}}
{{else}}
	{{$gameData := .ExecData}}
	{{$idx := mod $gameData.Round 2 | toInt}}

	{{$attacker := index $gameData.Players $idx}}
	{{$defender := index $gameData.Players (sub 1 $idx)}}

	{{/* compute damage */}}
	{{$p := randInt 100}}
	{{$dmg := 0}}
	{{if lt $p 5}} {{$dmg = randInt 40 50}}
	{{else if lt $p 15}} {{$dmg = randInt 30 40}}
	{{else if lt $p 45}} {{$dmg = randInt 20 30}}
	{{else}} {{$dmg = randInt 1 20}}
	{{end}}

	{{/* clamp $dmg to defender's health so we don't get negative HP */}}
	{{if gt $dmg $defender.HP}} {{$dmg = $defender.HP}} {{end}}
	{{$defender.Set "HP" (sub $defender.HP $dmg)}}

	{{$m := printf "%s **%s** attacked **%s**, dealing __%d__ damage!"
		(index $Emojis $idx)
		$attacker.User.Username
		$defender.User.Username
		$dmg
	}}
	{{$gameData.Set "Msgs" ($gameData.Msgs.Append $m)}}

	{{if eq $defender.HP 0}}
		{{$wm := print "🏆 **" $attacker.User.Username "** has won!"}}
		{{$gameData.Set "Msgs" ($gameData.Msgs.Append $wm)}}
		{{$s := dbIncr 0 "deathmatch_games" -1}}
	{{else}}
		{{$gameData.Set "Round" (add $gameData.Round 1)}}
		{{$c := index $Channels (randInt (len $Channels))}}
		{{execCC .CCID $c 2 $gameData}}
	{{end}}

	{{/* update embed */}}
	{{template "renderEmbed" ($query := dict "GameData" $gameData)}}
	{{editMessage $gameData.ChannelID $gameData.MsgID (cembed $query.Out)}}
{{end}}
```
