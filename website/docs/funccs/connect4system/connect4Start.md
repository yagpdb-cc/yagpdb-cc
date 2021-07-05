---
sidebar_position: 2
title: Connect4
---

This is the command to start the connect4 game

**Trigger Type:** `Regex`

**Trigger:** `\A(?:\-|<@!?204255221017214977>)\s*(?:c(?:on(?:nect)?)?4)(?: +|\z)`

**Usage:**  
`-connect4 <User:Mention>`  
`-connect4 help`

```go
{{/*    
	This is the command to start the connect4 game

	Recommended Trigger: \A(?:\-|<@!?204255221017214977>)\s*(?:c(?:on(?:nect)?)?4)(?: +|\z)
	Recommended Trigger Type: Regex
	
	Usage:
		-connect4 <User:Mention>
		-connect4 help
        
	Aliases: connect4,con4,c4

	Credits:
	zen | ゼン (https://github.com/z3nn13)
*/}}

{{/* Grid Create */}}
{{define "board_maker"}}
        {{- $board := cslice }}{{- $out := "" -}}
        {{- range seq 0 6 }} {{/* 6 rows */}}
		{{- $columns := cslice }}
		{{- $rows := "" }}
		{{- range seq 0 7 }}{{/* 7 columns */}}
			{{- $columns = $columns.Append 0}}
			{{- $rows = print $rows "⚫ "}}
		{{- end}}
		{{- $board = $board.Append $columns}}
		{{- $out = print $rows "\n" $out -}}
        {{- end}}
        {{- $out := print $out "1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣"}}
        {{- $embed := sdict "title" "Connect4" "description" $out "color" 0x0045e6 "footer" (sdict "text" "Powered by • Yagpdb.xyz")}}
        {{- .Set "board" $board}}
        {{- .Set "embed" $embed}}
{{ end}}

{{ $help := cembed "title" "Connect4/con4/c4 Help" "description" "> **How To Play**\n> • Each player will be given separate color tokens (🔴  or 🟡)\n> • The first person to make a four-in-a-row will __win__\n> • If all slots are filled with no winner determined, the game will result in a __draw__\n\n\n> **Commands**\n> `-connect4 <User:Mention>`\n> **↳** sends a challenge to a person\n> `-connnect4 <confirm/deny:Text>`\n> **↳** accepts or decline an incoming challenge\n\n> To Drop A Token\n> **↳** React to the number emojis\n> To Quit\n> **↳** React to the <a:r_leave:844556617085485058> emoji." "color" 0xbdf2f0 "thumbnail" (sdict "url" "https://i.ibb.co/wr3Rxzh/7614604.png")}}
{{ $errorMsg := ""}}{{ $data := sdict}}{{ $reply := false}}
{{ $p1 := ""}}{{ $p2 := ""}}

{{/* Setting limits */}}
{{ if dbGet 2021 "connect4"}}
	{{ $errorMsg = "Another game is still ongoing. Please wait for it to finish\n> To quit, react to the <a:r_leave:844556617085485058>"}}
{{ else if $db := dbGet 2021 "c4cooldown"}}
        {{ $data = $db.Value}}
        {{ $p1 = ($data.p1|getMember).User}}
        {{ $p2 = ($data.p2|getMember).User}}
        {{ if and (eq $p1.ID .User.ID) .Message.Mentions }} {{/* If the user sent a challenge to someone already*/}}
                {{ $errorMsg = print "You already have an ongoing challenge. Try again in " ($db.ExpiresAt.Sub currentTime|humanizeDurationSeconds) "."}}
        {{ else if eq $p2.ID .User.ID}}
                {{ $reply = true }}
        {{ end }}
{{end}}

{{/* Processing Input */}}
{{ with .StrippedMsg }}
        {{ if eq (.|lower) "help"}}
                {{$errorMsg = ""}}
                {{sendMessage nil $help}}
        {{  else if $reply }}
                {{ if not $errorMsg }}
                        {{ dbDel 2021 "c4cooldown" }}
                        {{ if reFind `(?i)(?:confirm|accept)` . }}
                                {{ $temp := sdict}}
                                {{ template "board_maker" $temp}}
                                {{ $temp.embed.Set "author" (sdict "name" (print $p1.Username "'s turn") "icon_url" ($p1.AvatarURL "256"))}}
                                {{ $temp.embed.Set "fields" (cslice (sdict "name" "Player 1" "value" (print "> " $p1.Mention) "inline" true) 
                                (sdict "name" "Player 2" "value" $p2.Mention "inline" true))}}
                                {{ $msgID := sendMessageRetID nil (complexMessage "content" (print "> A connect4 game has been started\n🔴┃" $p1.Mention ", Please pick a slot") "embed" $temp.embed)}}
                                {{ addMessageReactions nil $msgID "1️⃣" "2️⃣" "3️⃣" "4️⃣" "5️⃣" "6️⃣" "7️⃣" "a:r_leave:844556617085485058"}}
                                {{ dbSet 2021 "connect4" (sdict "players" (cslice "offset" $data.p1 $data.p2) "turn" 1 "board" $temp.board "msgID" $msgID "time" currentTime)}}
                        {{ else if reFind `(?i)(?:deny|refuse|decline)` . }}
                                {{ sendMessage nil (print $p1.Mention ", your challenge has been declined.")}}
                        {{ else }}
                                {{ sendMessage nil "Unknown Response. Challenge has been cancelled"}}
                        {{ end }}
                {{ end }}
        {{ else }}
                {{ with reFind `\d{17,19}` .}}
                        {{ if not $errorMsg }}
                                {{ $p2 := .|toInt64|userArg}}
                                {{ if $p2 }}
                                        {{ dbSetExpire 2021 "c4cooldown" (sdict "p1" $.User.ID "p2" $p2.ID) 15}}
                                        {{ sendMessage nil (printf "%s, %s has challenged you to a connect4 match! (15s)\nReply with `-connect4 (accept/deny)`" $p2.Mention $.User.Mention)}} 
                                {{ else }}
                                        {{ $errorMsg = "Error: Invalid User" }}
                                {{ end }}
                        {{ end }}
                {{ else }}
                        {{ $errorMsg = "Unknown Arguments\nType `-connect4 help` for more info" }}
                {{ end }}
        {{ end }}
{{ else }}
        {{ $errorMsg = "" }}
        {{ sendMessage nil $help }}
{{ end }}

{{ with $errorMsg}}{{ sendMessage nil . }}{{ end }}
```