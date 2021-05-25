---
sidebar_position: 2
title: Avatar CC
---

```go
{{/*
	This command allows you to view the avatar of a given user defaulting to yourself.
	Usage: `-avatar [user]`.

	Recommended trigger: Regex trigger with trigger `\A(-|<@!?204255221017214977>\s*)(avatar|av|pfp)(\s+|\z)`
*/}}

{{ $user := .User }}
{{ $args := parseArgs 0 "**Syntax:** `-avatar [user]`" (carg "userid" "user") }}
{{ if $args.IsSet 0 }}
	{{ $user = userArg ($args.Get 0) }}
{{ end }}
{{ sendMessage nil (cembed
	"author" (sdict "name" (printf "%s (%d)" $user.String $user.ID) "icon_url" ($user.AvatarURL "256"))
	"title" "❯ Avatar"
	"image" (sdict "url" ($user.AvatarURL "2048"))
	"color" 14232643
) }}
```