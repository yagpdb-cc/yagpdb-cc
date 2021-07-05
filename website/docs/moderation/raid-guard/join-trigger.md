---
sidebar_position: 3
title: Join Trigger
---

This part of the code will track all incomming new members to a server. If their account is younger than 1 day then they will get added to the raid list. This list will expire every 10 minutes to account for any members not part of a RAID.

**Trigger:** `Member join`  
This code is to be placed in the `Join Message` section.

```go
{{/*
	Trigger: member join
	This code is to be placed in the "Join Message" section.

	About: This part of the code will track all incomming new members to a server.
    If their account is younger than 1 day then they will get added to the raid list.
    This list will expire every 10 minutes to account for any members not part of a RAID.

	Created by: ENGINEER15 - https://github.com/engineer152/
	Last Update: 4/13/2021
*/}}

{{/* CONFIGURATION START */}}
{{$age := 1440}} {{/*New account age in minutes 1440 = one day*/}}
{{$len := 25}}{{/*Number of new members in a RAID to be notified by*/}}
{{$rolemention := cslice ROLE_ID_HERE }} {{/*This will be the role that gets pinged. MAKE SURE YOU CHANGE ROLE_ID_HERE WITH YOUR ROLE ID!*/}}
{{$channel := MODLOG_CHANNEL_ID_HERE }} {{/*Channel ID for modlog*/}}

{{/* ACTUAL CODE - DO NOT TOUCH */}}
{{$newmem := .User }}
{{$l:=cslice}}

{{with (dbGet 0 "raidlist").Value}}
    {{$l = $l.AppendSlice . }}{{end}}

{{ if not (dbGet 0 "raidlistcool")}}
    {{dbDel 0 "raidlist"}}{{end}}

{{$embed := cembed
    "title" " ⚠ RAID ALERT!"
    "description" "I have determined that there are more than:\n**25 BRAND NEW ACCOUNTS**\nthat just joined the server!\n\n__Options:__\n1. `-raid kick` - Kicks all raid members.\n2. `-raid ban` - Bans all raid members.\n3. `-raid clear` - Clear Raid List"
    "color" (randInt 16777217)
    "thumbnail" (sdict "url" "https://cdn.discordapp.com/emojis/565142262401728512.png" )}}

{{if lt (currentUserAgeMinutes) $age}}
	{{if not (dbGet $newmem "raidcooldown") }}
        {{$l = $l.Append $newmem}}
        {{dbSet 0 "raidlist" $l}}
        {{if eq (len $l) $len}}
            {{sendMessageNoEscape $channel (complexMessage "content" (mentionRoleID $rolemention) "embed" $embed) }}
        {{end}}
        {{dbSetExpire $newmem "raidcooldown" true 3600}}
        {{dbSetExpire 0 "raidlistcool" true 1200 }}
    {{end}}
{{end}}
```
