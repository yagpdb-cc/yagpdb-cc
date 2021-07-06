---
sidebar_position: 11
title: Ghost-Ping Detector v2
---

Ghost-Ping Detector CC v2

**Trigger Type:** `Regex`

**Trigger:** `.*`  
Optional Trigger: `<@!?\d{17,19}>`

```go
{{/*
    Ghost-Ping Detector CC v2

    Recommended Trigger Type: Regex
    Recommended Trigger: `.*`
    Optional Trigger: `<@!?\d{17,19}>`

    Credits:
    Devonte <https://github.com/devnote-dev>
*/}}

{{/* THINGS TO CHANGE */}}

{{ $CHECK := false }} {{/* Change to "true" for double exec-check */}}

{{ $LOG := false }} {{/* Change to "true" to create message logs */}}

{{/* ACTUAL CODE - DO NOT TOUCH */}}

{{ if .ExecData }}
    {{ $mentions := "" }} {{ $ping := false }}
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

        {{ $col := 16777215 }} {{ $p := 0 }} {{ $r := .Member.Roles }}
        {{ range .Guild.Roles }}
            {{- if and (in $r .ID) (.Color) (lt $p .Position) -}}
                {{- $p = .Position -}}
                {{- $col = .Color -}}
            {{- end -}}
        {{ end }}

        {{ $log := "" }}
        {{ if $LOG }}
            {{ $log = print "\n**Logs:** [Message Logs](" (exec "logs") ")" }}
        {{ end }}

        {{/* Embed Construct */}}
        {{ $embed := cembed
            "description" (print "**Channel:** <#" .Channel.ID ">\n**Message:**\n" .ExecData.content "\n\n**Mentioned Users:** <@" $mentions ">" $log)
            "color" $col
            "footer" (sdict "text" "Detector triggered")
            "timestamp" currentTime }}

        {{/* Content Format */}}
        {{ $msgContent := print "Ghost ping detected by <@" .ExecData.author ">!" }}

        {{ sendMessage nil (complexMessage "content" $msgContent "embed" $embed) }}
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

        {{ execCC .CCID nil 5 (sdict "message" .Message.ID "author" .Message.Author.ID "mentions" $ids "content" .Message.Content "break" false) }}
    {{ end }}
{{ end }}
```
