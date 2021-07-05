---
sidebar_position: 4
title: Bookmark Message
---

This custom commands functions similar to the reminder command, however it will send a DM instantly.  
One could say like a private pin command. Nothing much, but quite handy I think :)

**Trigger Type:** `Regex`

**Trigger:** `\A(?:-\s?|<@!?204255221017214977>\s*)b(?:ook)?m(?:ark)?(?:\s+|\z)`

**Usage:**  
`-bookmark <message>`  
`-bm <message>`

````go
{{/*
    This custom commands functions similar to the reminder command, however it will send a DM instantly.
    One could say like a private pin command. Nothing much, but quite handy I think  :)

    Usage:
        Bookmark <message>
        bm <message>

    Recommended trigger and trigger type: RegEx trigger with `\A(?:-\s?|<@!?204255221017214977>\s*)b(?:ook)?m(?:ark)?(?:\s+|\z)`

    Author: Luca Z. <https://github.com/l-zeuch>
    License: MIT
    Copyright: (c) 2021
*/}}

{{/* Actual Code - Only change this when you know what you are doing */}}
{{$args := parseArgs 1 "```Bookmark <Message:Text>```\nNot enough arguments passed." (carg "string" "Message")}}
{{$note := $args.Get 0}}
{{$link := (printf "https://discord.com/channels/%d/%d/%d" .Guild.ID .Channel.ID .Message.ID)}}
{{$embed := (cembed
    "title" "Bookmark"
    "description" "You asked me to bookmark this for you:"
    "fields" (cslice
        (sdict "name" "Note" "value" (print $note) "inline" true)
        (sdict "name" "Info" "value" (printf "Channel: <#%d>\nSource: [Jump!](%s)"  .Channel.ID $link) "inline" true)
    )
)}}
{{sendDM $embed}}
{{addReactions "📫"}}
````
