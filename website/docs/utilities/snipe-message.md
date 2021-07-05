---
sidebar_position: 18
title: Snipe Message
---

This command retrieves the most recent deleted message in the past hour(non-premium)/ 12 hours(premium)

**Trigger Type:** `Command`

**Trigger:** `snipe`

**Usage:**  
`-snipe`

```go
{{/*

    This command retrieves the most recent deleted message in the past hour(non-premium)/ 12 hours(premium)

    Trigger: snipe
    Trigger Type: Command

    Credits:
    zen | ゼン#0008 (https://github.com/z3nn13/)

*/}}

{{/* Global Variables */}}
{{ $ex := or (and (reFind "a_" .Guild.Icon) "gif" ) "png" }}
{{ $icon := print "https://cdn.discordapp.com/icons/" .Guild.ID "/" .Guild.Icon "." $ex "?size=1024" }}
{{ $regex := `\n\n\x60(\d{1,2}) (\w{5,7}) ago \((?:.{24})\)\x60 \*{2}(?:[^#]*)\*{2}\#\d{4} \(ID (\d{17,19})\)\: ` }}
{{ $imgRegex := `(?i)https?:(?:\/\/(?:[^\/?#]*))?(?:[^?\n#\s]*?\/[^?\n#\s]+\.(?:jpg|jpeg|png|gif|tif|webp))(?:\?(?:[^?\n#\s]*))?(?:#(.*))?`}}
{{ $undelete := execAdmin "ud -a" }}

{{ with reFindAllSubmatches $regex $undelete }}
        {{ $time := printf "%s%s" (index . 0 1) (index . 0 2) | toDuration }}
        {{ $member := (index . 0 3 | toInt64 | getMember) }}
        {{ $message := index (reSplit $regex $undelete 3) 1 }}

        {{ $file := "" }}{{ $image_url := "" }}
        {{ if $image_url = reFind $imgRegex  $message }}
                {{ $split := reSplit $imgRegex $message 2 }}
                {{ $message = print "> ⚠️ An image link is detected\n" (joinStr "" $split) }}
        {{ end }}
        {{ if gt (toRune $message|len) 2000 }}{{/* Preventing 2k limit error */}}
                {{ $file = $message }}
                {{ $message = "*Message exceeded 2k limit. Contents sent as file instead*"}}
        {{ else if not $message }}
                {{ $message = "> ⚠️ An attachment/embed was deleted" }}
        {{ end }}

        {{ $col := 0 }}{{ $p := 0 }}{{ $r := $member.Roles }}
        {{ range $.Guild.Roles}}{{if and (in $r .ID) (.Color) (lt $p .Position)}}{{$p = .Position}}{{$col = .Color}}{{end}}{{end }}

        {{ $embed := cembed "author" (sdict "name" (print $member.User.String " (ID " $member.User.ID ")") "icon_url" ($member.User.AvatarURL "256"))
            "description" $message
            "color" $col
            "image" (sdict "url" $image_url)
            "footer" (sdict "text" (printf "%s %s ago" (index . 0 1) (index . 0 2)) "icon_url" $icon)
            "timestamp" (currentTime.Add (mult $time -1|toDuration)) }}

        {{ with $file }}
            {{ sendMessage nil (complexMessage "file" . "embed" $embed) }}
        {{ else }}
            {{ sendMessage nil $embed }}
        {{ end }}
{{ else }}
        {{ sendMessage nil "Nothing to snipe here" }}
{{ end }}
```
