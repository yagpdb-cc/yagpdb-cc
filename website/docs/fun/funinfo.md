---
sidebar_position: 8
title: Fun Info
---

A command to see user's info about counting, qotd and x-word-story

**Trigger Type:** `Regex`

**Trigger:** `\A-funinfo(?:\s+(?:\d{17,19}|<@!?\d{17,19}>))?\z`

**Usage:**  
`-funinfo <User: ID/Mention>`

```go
{{/*
    SETUP:
    - Set the trigger type to Regex and the trigger to: `\A-funinfo(?:\s+(?:\d{17,19}|<@!?\d{17,19}>))?\z`
      If your own prefix is not "-" then change it up here ^ to your correct prefix.

    USAGE:
    - Type -funinfo <User: ID/Mention> to see info about counting, qotd and x-word-story.
      The bot will respond with a nice embed showing the user's count, answers and story lines.

    CREDITS: SpecialEliteSNP <https://github.com/SpecialEliteSNP>
*/}}

{{/* VARIABLES - You can edit these values */}}
  {{/* The command cooldown in seconds. Set it to 0 to disable the cooldown. */}}
    {{ $cooldown := 20 }}

  {{/* The colour of the embed (use hex: 0xFF00FF or decimal: 0-16777216) */}}
    {{ $colour := 16734296 }}


{{/* CODE - Don't edit this part */}}
{{ if dbGet .User.ID "funinfo" }}
  {{ addReactions "⏳" }}
{{ else }}
  {{ $e := sdict "color" $colour }}
  {{ $u := str .User.ID }}
  {{ if eq (len .Args) 2 }}
    {{ $u = index .Args 1 }}
    {{ if .Message.Mentions }}{{ $u = str (index .Message.Mentions 0).ID }}{{ end }}
  {{ end }}

  {{ $c := sdict }}{{ with (dbGet 20 "counting").Value }}{{ $c = sdict . }}{{ end }}
  {{ if $c }}
    {{ $v := 0 }}{{ with ($c.Get $u) }}{{ $v = . }}{{ end }}
    {{ $e.Set "description" (printf "🔢 Counts: `%d`" $v) }}
  {{ end }}

  {{ $q := sdict }}{{ with (dbGet 20 "qotd").Value }}{{ $q = sdict . }}{{ end }}
  {{ if $q }}
    {{ $v := 0 }}{{ with ($q.Get $u) }}{{ $v = .n }}{{ end }}
    {{ $e.Set "description" (printf "%s\n❓ QOTD answers: `%d`" $e.description $v) }}
  {{ end }}

  {{ $s := sdict }}{{ with (dbGet 20 "story-channel").Value }}{{ $s = sdict . }}{{ end }}
  {{ if $s }}
    {{ $v := 0 }}{{ with ($s.Get $u) }}{{ $v = . }}{{ end }}
    {{ $e.Set "description" (printf "%s\n📖 Story lines: `%d`" $e.description $v) }}
  {{ end }}

  {{ if not (or $c $q $s) }}
    {{ $e.Set "title" "❌ No data found!"}}
  {{ else if $n := getMember (toInt $u) }}
    {{ $e.Set "title" (printf "💎 Funinfo for: *%s*" $n.User.String) }}
    {{ $e.Set "color" 15344584 }}
  {{ else }}
    {{ $e.Set "title" "❌ Member not found!" }}
    {{ $e.Del "description" }}
  {{ end }}

  {{ sendMessage nil (cembed $e) }}

  {{ if $cooldown }}{{ dbSetExpire .User.ID "funinfo" 1 $cooldown }}{{ end }}
{{ end }}
```
