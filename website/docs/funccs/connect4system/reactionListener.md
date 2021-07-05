---
sidebar_position: 3
title: Connect4 Reaction Listener
---

This is the reaction listener for the Connect4 system

**Trigger Type:** `Reaction` on `Added Reactions Only`

```go
{{/*
	This is the reaction listener for the connect4 system

	Trigger Type: Reaction
	Trigger: Added Reactions Only

	Credits:
	zen | ゼン (https://github.com/z3nn13)
*/}}

{{ define "board_maker" }}
        {{- $store := .store -}}
        {{- $board := .board -}}
        {{- $out := "" -}}
        {{- range $board -}}
                {{$rows := ""}}
                {{- range . -}}
                        {{- $rows = printf "%s%s " $rows (index $store.emojis .) -}}
                {{- end -}}
                {{- $out = print $rows "\n" $out -}}
        {{- end -}}
        {{- $out = print $out "1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣" -}}
        {{- $embed := sdict "author" (sdict "name" (print .cPlayer.Username "'s turn") "icon_url" (.cPlayer.AvatarURL "256"))
            "title" "Connect4"
            "description" $out
            "color" (index $store.color .turn)
            "fields" (cslice 1 2)
            "footer" (sdict "text" "Powered by • Yagpdb.xyz" ) -}}
        {{- $embed.fields.Set (sub .turn 1) (sdict "name" (print "Player " .turn) "value" (print "> " .cPlayer.Mention) "inline" true) -}}
        {{- $embed.fields.Set (sub .nextTurn 1 ) (sdict "name" (print "Player " .nextTurn) "value" .nPlayer.Mention "inline" true ) -}}
        {{- .Set "embed" $embed -}}
{{- end}}

{{/* Global variables */}}
{{ $data := sdict}}{{$players := cslice}}{{$cPlayer := ""}}{{$turn := ""}}{{$nextTurn := ""}}{{$nPlayer := ""}}{{$input := ""}}{{$flag := false}}
{{ $store := sdict
    "emojis" (cslice "⚫" "🔴" "🟡" "🔵")
    "color" (cslice "unused" 0xff4d12 0xfff457)}}

{{ if $db := dbGet 2021 "connect4" }}
    {{ $data = $db.Value}}
    {{ $players = $players.AppendSlice $data.players}}{{/* cslice ["offset",p1,p2] */}}
    {{ $turn = $data.turn}} {{/* 1 or 2 */}}
    {{ $cPlayer = (index $players $turn|getMember).User}}
    {{ $nextTurn = sub 3 $turn}} {{/* switch between 1 and 2 */}}
    {{ $nPlayer = (index $players $nextTurn|getMember).User }}

    {{ if eq $data.msgID .Message.ID}}
            {{ deleteMessageReaction nil .Message.ID .User.ID .Reaction.Emoji.APIName}}
            {{/* quit reaction */}}
            {{ if and (eq .Reaction.Emoji.ID 844556617085485058) (in $players .User.ID) }}
                    {{ $otherPlayer := or (and (eq $cPlayer.ID .User.ID) $nPlayer) $cPlayer}}
                    {{ $embed := index .Message.Embeds 0 | structToSdict}}
                    {{ $embed.Set "author" (sdict "name" "Game Over" "icon_url" ($otherPlayer.AvatarURL "256"))}}
                    {{ $embed.Set "color" 0xffdc42}}
                    {{ editMessage nil .Message.ID (complexMessageEdit "content" (printf "> <a:r_leave:844556617085485058>┃**%s** have left the game\n🎊┃**Winner: %s**" .User.Username $otherPlayer.Mention) "embed" (cembed $embed))}}
                    {{ deleteAllMessageReactions nil .Message.ID }}
                    {{ dbDel 2021 "connect4" }}
            {{ else }}
                    {{ if eq $cPlayer.ID $.User.ID}}
                            {{/* Getting integer from keycap reaction */}}
                            {{ if and (le ($temp := index (toRune .Reaction.Emoji.Name) 0) '7') (gt $temp '0') }}
                                    {{$input = sub $temp '1'}}
                                    {{$flag = true}}
                            {{end}}
                    {{ end }}
            {{ end }}
    {{ end }}
{{ end }}

{{if $flag}}
    {{ $tempData := sdict "board" $data.board "store" $store "input" $input "turn" $turn "nextTurn" $nextTurn "cPlayer" $cPlayer "nPlayer" $nPlayer "valid" false}}
    {{ template "slot_checker" $tempData}}
    {{ template "board_maker" $tempData}}
    {{ if not $tempData.valid}}
            {{ editMessage nil .Message.ID (complexMessageEdit
            "content" (printf "> Slot %d⃣ is full.\n%s┃%s, Please pick another slot" ($input|add 1) (index $store.emojis $turn) .User.Mention)
            "embed" (cembed $tempData.embed))}}
    {{ else }}
        {{ template "win_checker" $tempData}}
        {{ $msg := printf "> %s┃**%s** dropped token in slot %d⃣\n" (index $store.emojis $turn) .User.Username ($input|add 1) }}
        {{ if or $tempData.gameWon $tempData.gameTie}}
                {{ $col := "" }}{{ $winner := "None"}}
                {{ if $tempData.gameWon}}
                        {{ $p := 0}}{{$r := .Member.Roles}}{{range .Guild.Roles}}{{if and (in $r .ID) (.Color) (lt $p .Position)}}{{$p = .Position}}{{$col = .Color}}{{end}}{{end}}
                        {{ $col = or $col (index $store.color $turn)}}{{ $winner = .User.Mention}}
                        {{ $msg = printf "%s🎊┃%s made a **connect4**" $msg .User.Mention }}
                        {{ $tempData.embed.author.Set "name" (print "Game Over • " (index $store.emojis $turn) " wins !")}}
                {{ else if $tempData.gameTie}}
                        {{ $col =  0xba19ff }}
                        {{ $msg = print $msg "🤝┃Owo what's this, the match is a **draw**"  }}
                        {{ $tempData.embed.author.Set "name" "Game Over • Tied !" }}
                {{ end }}

                {{ sendMessage nil (cembed "color" 0x03fc90 "description" (printf "<:status_online:845602611872399381> **Results** • %s vs %s\n> **Winner**┃%s\n> **Time Taken**┃`%s`" $nPlayer.Mention .User.Mention $winner ((currentTime.Sub $data.time).Round .TimeSecond)))}}
                {{ $tempData.embed.Set  "color" $col }}
                {{ deleteAllMessageReactions nil .Message.ID }}
                {{ dbDel 2021 "connect4" }}
        {{ else }}
                {{ $tempData.Set "turn" $nextTurn }}{{ $tempData.Set "nextTurn" $turn}} {{ $tempData.Set "cPlayer" $nPlayer}} {{ $tempData.Set "nPlayer" $cPlayer}}
                {{ template "board_maker" $tempData}}
                {{ $msg = printf "%s%s┃%s, Please pick a slot" $msg (index $store.emojis $nextTurn) $nPlayer.Mention}}
                {{ $data.Set "turn" $nextTurn }}
                {{ $data.Set "board" $tempData.board }}
                {{ dbSet 2021 "connect4" $data }}
        {{ end }}
        {{ editMessage nil .Message.ID (complexMessageEdit "content" $msg "embed" (cembed $tempData.embed))}}
    {{end}}
{{end}}

{{- define "slot_checker" -}}
    {{- $board := .board }}{{ $turn := .turn }}{{ $input := .input }}{{$position := 0 -}}{{ $found := false}}
    {{- $verti := cslice -}}
    {{/* Fetching input slot */}}
    {{- range $board -}}
        {{- $verti = $verti.Append (index . $input) -}}
    {{- end -}}
    {{- if eq (index $verti 5) 0 3}}
        {{.Set "valid" true}}
        {{/* Returning the first empty spot from bottom */}}
        {{- range $i,$v := $verti -}}
            {{- if not $found -}}
                {{- if eq $v 0 3}}
                    {{- $found = true}}
                    {{- $position = $i}}
                {{- end }}
            {{- else }}
                {{- (index $board $i).Set $input 3 -}}
            {{- end}}
        {{- end}}
        {{- (index $board $position).Set $input $turn -}}
    {{- end}}
    {{/* Cleaning blue highlights */}}
    {{- range $rowIndex,$row := $board -}}
        {{- range $col,$v := $row -}}
            {{- if and (eq $col $input|not) (eq $v 3) -}}
                {{- (index $board $rowIndex).Set $col 0 -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
    {{- .Set "board" $board -}}
    {{- .Set "position" $position -}}
{{- end -}}


{{- define "win_checker" -}}
    {{- $gameWon := false}}{{$board := .board -}}{{$turn := .turn}}{{$input := .input}}{{$position := .position -}}
    {{/* Horizontal checking */}}
    {{- $check  := index $board $position -}}
    {{- range $col,$v := $check -}}
        {{- if and (eq $v 0 3|not) (lt $col (len $check|add -3)) -}}
            {{- if and (eq $v (add $col 1|index $check)) (eq $v (add $col 2|index $check)) (eq $v (add $col 3|index $check)) -}}
                {{- $gameWon = true -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
    {{/* Vertical checking */}}
    {{- $verti := cslice -}}
    {{- range $board -}}
        {{- $verti = $verti.Append (index . $input) -}}
    {{- end -}}
    {{- range $i,$v := $verti -}}
        {{- if and (eq $v 0 3|not) (lt $i (len $verti|add -3)) -}}
            {{- if and (eq $v (add $i 1|index $verti)) (eq $v (add $i 2|index $verti)) (eq $v (add $i 3|index $verti)) -}}
                {{- $gameWon = true -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}

    {{/* Diagonal checking */}}
    {{- $marker := cslice -}}
    {{- $total := cslice -}}
    {{- range $rowIndex, $row := $board -}}
        {{- range $col,$v := $row -}}
            {{- if not (eq $v 0 3) -}}
                {{$total = $total.Append $v -}}
            {{- end -}}
            {{- if eq $v $turn -}}
                {{- $marker = $marker.Append (printf "%d%d" $rowIndex $col) -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
    {{- range $marker -}}
        {{- if and (in $marker (.|toInt|add 11|str)) (in $marker (.|toInt|add 22|str)) (in $marker (.|toInt|add 33|str)) -}}
            {{- $gameWon = true -}}
        {{- else if and (in $marker (.|toInt|add 9|str)) (in $marker (.|toInt|add 18|str)) (in $marker (.|toInt|add 27|str)) -}}
            {{- $gameWon = true -}}
        {{- end -}}
    {{- end -}}
    {{- if and (not $gameWon) (eq (len $total) 42) -}}
    {{- .Set "gameTie" true -}}
    {{- end -}}
    {{- .Set "gameWon" $gameWon -}}
{{- end }}
```
