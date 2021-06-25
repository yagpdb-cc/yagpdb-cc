---
sidebar_position: 5
title: Slowmode
---

This command helps using a slowmode. it deletes a user's message if their slowmode isnt over people who you want can bypass slowmode as well as set it.

**Trigger Type:** `Regex`

**Trigger:** `.*`

**Usage:**  
`-slowmode on (time in seconds)`  
`-slowmode off`

```go
{{/*
	This command helps using a slowmode. it deletes a user's message if their slowmode isnt over people who you want can bypass slowmode as well as set it 
 
	Usage: "-slowmode on (time in seconds) / -slowmode off "

	Trigger type: Regex
	Recommended trigger: `.*`
 
	Credits:
	Sponge :D
*/}}
 
{{/* CONFIGURATION VALUES START */}}
{{ $bypassperms := "ManageMessages" }}{{/* perms needed to bypass slowmode */}}
{{ $usageperms := "ManageMessages" }}{{/* perms needed for slowmode commands */}}
{{/* put in the permissions you want the use to have in order to use or bypass the command */}}
{{/* available perms: Administrator, ManageServer, ReadMessages, SendMessages, SendTTSMessages, ManageMessages, EmbedLinks, AttachFiles, ReadMessageHistory, MentionEveryone, VoiceConnect, VoiceSpeak, VoiceMuteMembers, VoiceDeafenMembers, VoiceMoveMembers, VoiceUseVAD, ManageNicknames, ManageRoles, ManageWebhooks, ManageEmojis, CreateInstantInvite, KickMembers, BanMembers, ManageChannels, AddReactions, ViewAuditLogs  */}}
{{/* CONFIGURATION VALUES END */}}
 
{{/* ACTUAL CODE */}}
{{ $viewperms := (split (index (split (exec "viewperms") "\n") 2) ", ") }}
{{ $usageaccess := in $viewperms $usageperms }}
{{ $bypassaccess := in $viewperms $bypassperms }}
{{ if $usageaccess }}
{{ if $matches := reFindAllSubmatches `\A-slowmode on (\d+)` .Message.Content }}
{{ $slowmodeduration := (index $matches 0 1) }}
{{ with (dbGet 660 "channels").Value }}
{{ $value := sdict . }}
{{ $value.Set (str $.Channel.ID) (str $slowmodeduration) }}
{{ dbSet 660 "channels" $value }}
{{ else }}
{{ dbSet 660 "channels" (sdict (str $.Channel.ID) (str $slowmodeduration)) }}
{{ end }}
done! slowmode has been set to `{{ $slowmodeduration }}s`
{{ else if reFind `\A-slowmode off` .Message.Content }}
{{ if $db := (dbGet 660 "channels").Value }}
{{ $value := sdict $db }}
{{ $value.Del (str $.Channel.ID) }}
{{ dbSet 660 "channels" $value }}
{{ end }}
the slowmode has been removed from this channel
{{ end }}
{{ end }}
{{ if not $bypassaccess }}
{{ if $db := (dbGet 660 "channels").Value }}
{{ $value := sdict $db }}
{{ $get := $value.Get (str .Channel.ID) }}
{{ if $get }}
{{ if $slowmode := dbGet .User.ID (str .Channel.ID) }}
{{ deleteTrigger 0 }}
{{ else }}
{{ dbSetExpire .User.ID (str .Channel.ID) "epic" (toInt $get) }}
{{ end }}
{{ end }}
{{ end }}
{{ end }}
```