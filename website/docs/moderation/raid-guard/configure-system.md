---
sidebar_position: 2
title: Configure System
---

This part of the code provides the Admin commands.

**Trigger Type:** `Command`

**Trigger:** `raid`

**Usage:**  
All commands are preceeded by `-raid <action>`  
Actions include: `ban`, `kick`, `clear`

```go
{{/*
    Trigger Type: Command
	Trigger: `raid`

	About: This part of the code provides the Admin commands. All commands are preceeded by `-raid <action>` Actions include: `ban`, `kick`, `clear`

	Created by: ENGINEER15 - https://github.com/engineer152/
	Last Update: 4/13/2021
*/}}

{{$t := "" }}
{{$cc := toInt .CCID }}
{{$l := cslice}}
{{$thumb := (sdict "url" "https://cdn.discordapp.com/emojis/714051544265392229.gif")}}
{{$qlen := 0}}

{{$q:=cslice}}
{{with (dbGet 0 "raidlist").Value}}
    {{$q =$q.AppendSlice .}}{{end}}
{{$nq:=cslice}}
{{range $i,$e:=$q}}
    {{if $i}}
        {{$nq =$nq.Append $e}}
    {{end}}
{{end}}

{{with .CmdArgs}}
    {{$t = index . 0}}{{end}}
{{with (dbGet 0 "raidlist").Value}}
    {{$l = $l.AppendSlice . }}{{end}}
{{$qlen = len $l}}

{{$embed := sdict
	"title" " 🛡 RAID GUARD"
	"description" "*Initializing in 3...*"
	"color" 14232643
    "thumbnail" $thumb }}

{{$channel := .Channel.ID }}
{{$user := "" }}

{{with .ExecData }}
    {{$embed = sdict .Embed }}
    {{$qlen = .Qlen }}
    {{$data := sdict . }}
    {{$thumb := "" }}
    {{$command := .Command}}
   	{{ $msgs := split $embed.description "\n" | cslice.AppendSlice }}
    {{$title := split $embed.title "\n" | cslice.AppendSlice }}
	{{$msgs = cslice }}{{ $title = cslice }}
    {{if $q}}
        {{with (index $q 0) }}
            {{$user = . }}{{end}}
        {{if eq $command "kick"}}
            {{$k := execAdmin (printf "kick %d For being part of a RAID" $user.ID ) }}
        {{else if eq $command "ban"}}
            {{$k := execAdmin (printf "ban %d For being part of a RAID" $user.ID ) }}
        {{end}}
        {{if not (eq (len $nq) 0) }}
            {{$title = $title.Append (print "👢 REMOVING ALL RAID MEMBERS" )}}
            {{$msgs = $msgs.Append (printf "Currently Removing: %s" $user.Username )}}
		    {{$thumb = (sdict "url" "https://cdn.discordapp.com/emojis/714051544265392229.gif")}}
            {{dbSet 0 "raidlist" $nq}}
            {{execCC $cc $channel 2 $data }}
        {{else}}
            {{$title = $title.Append (print "**✅ COMPLETE**" )}}
            {{$msgs = $msgs.Append (printf "ALL %d RAIDERS HAVE BEEN REMOVED.\nYour server has been protected by**🛡 RAID GUARD.**" $qlen )}}
            {{$thumb = (sdict "url" "https://cdn.discordapp.com/emojis/565142262401728512.png")}}
		    {{dbDel 0 "raidlist"}}
        {{end}}
    {{else}}
        {{$thumb = (sdict "url" "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/twitter/281/person-shrugging_1f937.png")}}
        {{$title = $title.Append (print "\n" )}}
        {{$msgs = $msgs.Append (print "❌ THE RAIDLIST IS EMPTY\n\nNo RAID has happened recently. 👍" )}}
    {{end}}
    {{$embed.Set "title" (joinStr "\n" $title.StringSlice ) }}
    {{$embed.Set "description" (joinStr "\n" $msgs.StringSlice ) }}
    {{$embed.Set "thumbnail" $thumb }}
    {{$data.Set "Embed" $embed }}
    {{editMessage .ChannelID .MsgID (cembed $embed) }}

{{else}}

    {{if eq $t "clear"}}
        {{dbDel 0 "raidlist"}}
        {{$embed2 := sdict
	        "title" "✅ COMPLETE"
	        "description" "🧹 RAID LIST HAS NOW BEEN CLEARED"
	        "color" 14232643 }}
        {{sendMessage nil (cembed $embed2) }}
    {{else if or (eq $t "kick") (eq $t "ban")}}
        {{$initial := sendMessageRetID nil (cembed $embed) }}
        {{sleep 3 }}
        {{execCC $cc (.Channel.ID) 0 (sdict
	        "Embed" $embed
	        "MsgID" $initial
	        "ChannelID" .Channel.ID
            "Qlen" $qlen
            "Command" $t)}}
    {{end}}{{end}}
```
