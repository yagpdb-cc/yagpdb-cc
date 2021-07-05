---
sidebar_position: 13
title: Reaction Logs
---

This command allows you to set up a reaction logging.

**Trigger Type:** `Reaction` on `Added and Removed`

```go
{{/*
	      This command allows you to set up a reaction logging.

	      Recommended trigger: Reaction - Added + Removed
*/}}


{{/* CONFIGURATION VALUES START */}}

{{$logging_channel_id := .Channel.ID}} {{/* change this to your logging channel id*/}}

{{/* CONFIGURATION VALUES END */}}

{{/* Actual CODE */}}
{{$reaction_url := ""}}

{{with .Reaction.Emoji.ID}}
    {{$ext := ".png"}}{{if $.Reaction.Emoji.Animated}}{{$ext = ".gif"}}{{end}}
    {{$reaction_url = printf "https://cdn.discordapp.com/emojis/%d%s" . $ext}}
{{else}}
    {{$emoji_U := ""}}
    {{- range toRune .Reaction.Emoji.Name }}
        {{- $emoji_U = joinStr "-" $emoji_U (printf "%04x" .) }}
    {{- end -}}
    {{ $reaction_url = print "https://raw.githubusercontent.com/iamcal/emoji-data/master/img-google-136/" $emoji_U ".png" }}
{{end}}
{{$addrem := "`Removed`"}}{{if .ReactionAdded}}{{$addrem = "`Added`"}}{{end}}

{{sendMessage $logging_channel_id (cembed "description" (print "**Reaction:** "  $addrem "\n**By:**[ " .User "](https://discord.com/users/" .User.ID ")") "color" 0xFF0000
"fields" (cslice (sdict "name" "Message location: " "value" (joinStr "" "[#" .Channel.Name "](https://discordapp.com/channels/" .Guild.ID "/" .Channel.ID "/" .ReactionMessage.ID ")") "inline" false))
"thumbnail" (sdict "url" $reaction_url)
)}}
```
