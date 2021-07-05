---
sidebar_position: 2
title: Basic Giveaway
---

Main Giveaway CC. Supports intuitive `execCC` usage.

**Trigger Type:** `Command`

**Trigger:** `giveaway`

**Usage:**  
Read the [README](basicREADME.md)

````go
{{/*
        Main Giveaway CC. Supports execCC invoke. Usage: Read README.md

        Recommended Trigger: Command trigger with trigger `giveaway`
        (Can also work with `regex` and `starts with` triggers if triggers are correctly set)
*/}}

{{/* CONFIGURATION VALUES START */}}
{{$giveawayEmoji := `🎉`}}{{/* set giveaway emoji to be used */}}
{{/* CONFIGURATION VALUES END */}}

{{/*Actual Code , do not touch unless you know what youre doing*/}}

{{/*Declaring global variables*/}}
{{$CCID := .CCID}}{{$syntaxError := 0}}{{$CmdArgs := ""}}{{$StrippedMsg := ""}}{{$Cmd := ""}}{{$ExecData := 0}}
{{/* if direct invoke just copy data to relevant variables */}}
{{if not .ExecData}}{{$CmdArgs = .CmdArgs}}{{$StrippedMsg = reReplace `\A\s+|(\s+\z)` .StrippedMsg ""}}{{$Cmd = .Cmd}}
{{/* if indirect invoke, check datatype of .ExecData to determine self invoke or not */}}
{{else if toInt .ExecData}}{{$ExecData = toString .ExecData}}
{{/* if external cc invoke, check if correct datatype passed and then generate $CmdArgs , $StrippedMsg etc*/}}
{{else if eq (printf "%T" .ExecData) "string"}}
{{$args := split .ExecData " "}}
{{if gt (len $args) 1}}
{{$StrippedMsg = reReplace `(\A\s+)|(\s+\z)` (joinStr " " (slice (split .ExecData " ") 1)) ""}}
{{$Cmd = index $args 0}}{{$CmdArgs = split (reReplace `\s{2,}` $StrippedMsg " ") " "}}
{{end}}
{{end}}

{{/*checking if or not invoked by itself for Giveaway Ending handling*/}}
{{if  not $ExecData }}
{{if gt ( len $CmdArgs ) 0 }}
{{if or (gt (len $CmdArgs) 1) (eq (lower (index $CmdArgs 0) ) "list")}}

{{/*Command - Start*/}}
{{if eq (lower (index $CmdArgs 0) ) "start"}}

{{/*Variable declarations & assignments*/}}
{{$CmdArgs := joinStr " " (slice (split $StrippedMsg " ") 1 )}}
{{$CmdArgs = reReplace `\A\s+` $CmdArgs ""}}
{{$maxP := -1}}{{$maxW := 1}}{{$chan:= .Channel.ID}}{{$ID:= ""}}{{$dbData := sdict}}
{{$uniqueID := toInt (currentTime.Sub (newDate 2019 10 10 0 0 0)).Seconds}}


{{/*Handling flags, parsing data from input*/}}
     {{with reFindAllSubmatches `(?i)((-w) (\d+)(?:\s|$))` $CmdArgs}}
     {{$CmdArgs = reReplace `(?i)(-w \d+\s+)|(-w \d+$)` $CmdArgs ""}}
          {{$maxW = toInt (index (index . 0) 3)}}
     {{end}}

     {{with reFindAllSubmatches `(?i)((-p) (\d+)(?:\s|$))` $CmdArgs}}
     {{$CmdArgs = reReplace `(?i)(-p \d+(\s+))|(-p \d+$)` $CmdArgs ""}}
          {{$maxP = toInt (index (index . 0) 3)}}
     {{end}}

     {{with reFindAllSubmatches `(?i)(-c (?:<#)?(\d+)(?:>?)(?:\s|$))` $CmdArgs}}
     {{$CmdArgs = reReplace `(?i)(-c ((<#)?\d+(>?))\s+)|(-c ((<#)?\d+(>?))$)` $CmdArgs ""}}
          {{$chan = index (index . 0) 2}}
     {{end}}

{{$temp := split $CmdArgs  " "}}
{{$dur:= lower (index  $temp 0)}}
{{$prize := ""}}
{{if gt (len $temp) 1}}{{$prize = joinStr " " (slice $temp 1)}}{{end}}
{{$prize = reReplace `\A\s+` $prize ""}}

{{/* String to Duration */}}
{{$duration := toDuration $dur}}

{{/* if valid duration & prize */}}
{{if and ($duration)  ($prize)}}

{{/*if max Participants > max Winners*/}}
{{if or (ge $maxP $maxW) (eq $maxP -1)}}

{{/*Giveaway Announcement*/}}
{{with sendMessageNoEscapeRetID $chan (cembed "title" "loading...")}}

{{/*Make giveaway sdict data Structure */}}
{{$ID = (joinStr "" $chan .) }}
{{$giveawaySdict := sdict "chan" $chan "count" 0 "listID" "" "maxWinners"  $maxW "maxParticipants" $maxP "expiresAt" (currentTime.Add $duration) "prize" $prize "uID" $uniqueID}}

{{/*Send Actual Announcement Message*/}}
{{addMessageReactions $chan . $giveawayEmoji}}
{{$desc := (joinStr ``  `>>> **Prize : **` $prize "\n\n") }}
{{if gt $maxW 0}}{{$desc = joinStr "" $desc "**Max Winners :** " $maxW }}{{end}}
{{if gt $maxP 0}}{{$desc = joinStr "" $desc "⠀⠀⠀⠀⠀**Max Participants :** " $maxP}}{{end}}
{{$desc = joinStr "" $desc "\n\n**React with " $giveawayEmoji " to enter GiveAway **"}}
{{editMessageNoEscape $chan . (cembed "title" "🌟🌟**GiveAway Started !!**🌟🌟" "description"  $desc "color" 16763170 "footer" (sdict "text" (joinStr "" "ID: " $uniqueID " | GiveAway Ends " )) "timestamp" $giveawaySdict.expiresAt) }}

{{/*Update database values ; schedule giveaway end*/}}
{{with (dbGet 7777 "giveaway_active").Value}}{{$dbData = sdict .}}{{end}}
{{$dbData.Set $ID $giveawaySdict}}{{dbSet 7777 "giveaway_active" $dbData}}
{{$dbData =sdict}}{{with (dbGet 7777 "giveaway_active_IDs").Value}}{{$dbData =sdict .}}{{end}}
{{$dbData.Set (toString $uniqueID) $ID}}{{dbSet 7777 "giveaway_active_IDs" $dbData}}
{{scheduleUniqueCC (toInt $CCID) $chan $duration.Seconds $uniqueID  $ID}}

{{else}}
**Invalid Channel !!**
{{end}}

{{else}}
**Error:** Max Winners cannot be more than Max Participants!!
{{end}}

{{else}}
**Error:** Invalid Duration or Prize !!
{{end}}

{{/*Command-End*/}}
{{else if eq (lower (index $CmdArgs 0) ) "end"}}
{{$uID := index $CmdArgs 1}}
{{/*if  giveaways active*/}}
{{with (dbGet 7777 "giveaway_active").Value}}
{{/*if uID is valid*/}}
{{$ID := index (dbGet 7777 "giveaway_active_IDs").Value $uID}}
{{with (index . (toString $ID))}}
{{/*reschedue giveaway to end instantly*/}}
{{scheduleUniqueCC (toInt $CCID) .chan 1  .uID $ID}}

{{else}}
**Error:** Invalid ID ``{{$uID}}``
{{end}}

{{else}}
**Error:** No Active Giveaways.
{{end}}

{{/* Command Cancel */}}
{{else if eq (lower (index $CmdArgs 0) ) "cancel"}}
{{$uID := index $CmdArgs 1}}{{$ID := 0}}

{{/* checking if any giveaways are active*/}}
{{with (dbGet 7777 "giveaway_active").Value}}
{{$dbID := (dbGet 7777 "giveaway_active_IDs").Value}} {{$ID = index $dbID  $uID}}

{{/*if ID is valid*/}}
{{with (index . (toString $ID))}}
{{/* cancelling giveaway end scheduled cc , updating giveaway announcement message */}}
{{$chan := .chan}}{{$prize := .prize}}
{{cancelScheduledUniqueCC (toInt $CCID) .uID}}
{{$msg := index ( split $ID (toString $chan)) 1}}
{{with (getMessage $chan $msg )}}{{editMessageNoEscape $chan $msg (cembed "title" "🌟🌟**GiveAway Cancelled !!**🌟🌟" "description" (joinStr "" ">>> **Prize:** "  $prize) "footer" (sdict "text" "Giveaway Cancelled") "color" 12257822 )}}{{end}}Done!

{{else}}
**Error:** Invalid ID ``{{$uID}}``
{{end}}

{{/* if found , updating giveaway database */}}
{{if $ID}}
{{$newdbData := sdict .}}{{$newdbData.Del $ID}}
{{dbSet 7777 "giveaway_active" $newdbData}}
{{$newdbData = sdict $dbID}}{{$newdbData.Del $uID}}
{{dbSet 7777 "giveaway_active_IDs" $newdbData}}
{{end}}

{{else}}
**Error:** No Active Giveaways.
{{end}}

{{/* Command List */}}
{{else if eq (lower (index $CmdArgs 0) ) "list"}}

{{/* checking if giveaways active*/}}
{{with (dbGet 7777 "giveaway_active").Value}}
{{$count := 0}}

{{/* Listing all active giveaway data fields*/}}
{{range $k , $v := .}}{{$count = add $count 1}}
{{$count}}) **ID:** ``{{$v.uID}}``  **Prize:** ``{{$v.prize}}``
**Ends AT:** ``{{formatTime $v.expiresAt}}``
{{end}}

{{else}}
No Active Giveaways.
{{end}}

{{else}}
{{$syntaxError = 1}} {{/*update global variable for incorrect syntax*/}}
{{end}}
{{else}}
{{$syntaxError = 1}} {{/*update global variable for incorrect syntax*/}}
{{end}}
{{else}}
{{$syntaxError = 1}} {{/*update global variable for incorrect syntax*/}}
{{end}}
{{else}}

{{/* Giveaway Ending handling */}}
{{/* Setting Variables */}}
{{$ID := $ExecData}}{{$chan := .Channel.ID}}
{{$dbData := (dbGet 7777 "giveaway_active" ).Value}}

{{/* Proceed only if invoked with valid  ID or active giveaways exist*/}}
{{if $dbData}}
{{with (index $dbData $ID)}}
{{$countWinners := toInt .maxWinners}} {{$count := toInt .count}}

{{/* if reaction count < max winners ; update no of winners to find */}}
{{if lt $count $countWinners}}{{$countWinners = $count}}{{end}}
{{$msg := index ( split $ID (toString $chan)) 1}}
{{$listID :=  .listID}}

{{/* Consider the reactions/user IDs upto max allowed number if count > maxParticipants*/}}
{{if and (gt $count .maxParticipants) (gt .maxParticipants 0)}}{{$count = .maxParticipants}}{{$listID = joinStr "," (slice (split $listID ",") 0 $count) ""}}{{end}}

{{/* computing list of winner mentions */}}
{{$winnerList := ""}}
{{range seq 0 $countWinners}}
{{$winner := index (split $listID ",") (randInt 0 $count )}}
{{$listID = reReplace (joinStr "" $winner ",") $listID ""}}{{$count = add $count -1}}
{{$winnerList = (joinStr "" $winnerList "<@" $winner "> ")}}
{{end}}

{{/* Update existing giveaway announce message*/}}
{{$desc := joinStr "" ">>> **Prize:** " .prize "\n\n**Winners:** " }}
{{if  $countWinners }}{{$desc = joinStr "" $desc $winnerList}}{{else}}{{$desc = joinStr "" $desc "No Participants :( "}}{{end}}
{{with (getMessage $chan $msg )}}{{editMessageNoEscape $chan $msg (cembed "title" "🌟🌟**GiveAway Ended !!**🌟🌟" "description" $desc "footer" (sdict "text" "Giveaway Ended at ") "timestamp" currentTime "color" 12257822 )}}{{end}}

{{/* Announce winners */}}
{{if $countWinners}}
{{sendMessage nil (joinStr "" "**Prize:** " .prize "\n**Winner(s) :** " $winnerList)}}
{{else}}
**Giveaway Ended, No participants :( !!**
**Prize : {{.prize}}**
{{end}}

{{/* update giveaway database */}}
{{$newdbData := sdict $dbData}}{{$newdbData.Del $ID}}
{{dbSet 7777 "giveaway_active" $newdbData}}
{{$newdbData = sdict (dbGet 7777 "giveaway_active_IDs").Value}}{{$newdbData.Del (toString .uID)}}
{{dbSet 7777 "giveaway_active_IDs" $newdbData}}

{{else}}`Warning:` Invoked CC : {{$CCID}} using ExecCC with invalid Giveaway ID.
{{end}}
{{else}}`Warning:` Invoked CC : {{$CCID}} using ExecCC with no active Giveaways.
{{end}}

{{end}}

{{/*print error message & syntax details */}}
{{if $syntaxError}}
{{sendMessage nil (joinStr "" "__**Incorrect Syntax** __ \n**Commands are :** \n```elm\n" ($Cmd) " start <Time> [Prize] \n\noptional_flags \n-p (max participants : Number) \n-w (max winners : Number)\n-c (channel : Mention/ID)\n```\n```elm\n" ($Cmd) " end <ID>```\n```elm\n" ($Cmd) " cancel <ID>```\n```elm\n" ($Cmd) " list ``` ")}}
{{end}}
````
