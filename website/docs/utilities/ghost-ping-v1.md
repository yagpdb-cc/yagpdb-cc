---
sidebar_position: 10
title: Ghost-Ping Detector v1
---

Ghost-Ping Detector CC v1

**Trigger Type:** `Regex`

**Trigger:** `.*`  
Optional Trigger: `<@!?\d{17,19}>`

```go
{{/*
    Ghost-Ping Detector CC v1

    Recommended Trigger Type: Regex
    Recommended Trigger: `.*`
    Optional Trigger: `<@!?\d{17,19}>`

    Credits:
    Devonte <https://github.com/devnote-dev>
*/}}

{{/* THINGS TO CHANGE */}}

{{ $CHECK := false }} {{/* Change to "true" for double exec-check */}}

{{/* ACTUAL CODE - DO NOT TOUCH */}}

{{ if .ExecData }}
    {{ $mentions := "" }}{{ $ping := false }}

    {{ if ($m := getMessage nil .ExecData.message) }}
        {{ if not $m.Mentions }}
            {{ $ping = true }}
        {{ end }}
    {{ else }}
        {{ $ping = true }}
    {{ end }}

    {{ if $ping }}
        {{ if gt (len .ExecData.mentions) 1 }}
            {{ range .ExecData.mentions }}
                {{- $mentions = joinStr ">, <@" $mentions . -}}
            {{ end }}
        {{ else }}
            {{ $mentions = index .ExecData.mentions 0 }}
        {{ end }}

        {{/* Message to send when a ping is detected: */}}
        {{ sendMessage nil (print "Ghost ping detected by <@" .ExecData.author "> - <@" $mentions ">") }}
    {{ else }}
        {{ if and $CHECK (not .ExecData.break) }}
            {{ $ids := cslice }}
            {{ range .Message.Mentions }}
                {{- $ids = $ids.Append (str .ID) -}}
            {{ end }}

            {{ execCC .CCID nil 5 (sdict "message" .Message.ID "author" .Message.Author.ID "mentions" $ids "content" .Message.Content "break" true) }}
        {{ end }}
    {{ end }}
{{ else }}
    {{ if .Message.Mentions }}
        {{ $ids := cslice }}
            {{ range .Message.Mentions }}
                {{ $ids = $ids.Append (str .ID) }}
            {{ end }}

        {{ execCC .CCID nil 5 (sdict "message" .Message.ID "author" .Message.Author.ID "mentions" $ids "break" false) }}
    {{ end }}
{{ end }}
```
