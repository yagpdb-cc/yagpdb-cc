---
sidebar_position: 2
title: AFK CC
---

```go
{{/*
	This command allows users to set an AFK message with optional duration.
	Usage:

	-afk <message>
	-afk <message> -d <duration>

	Recommended trigger: Regex trigger with trigger `\A`
    
    Author: DaviiD1337 <https://github.com/DaviiD1337>
*/}}

{{/* CONFIGURATION VALUE STARTS HERE */}}
{{ $removeAfkOnMessage := true}}{{/* Whether or not to remove the AFK status from users when they send a message. */}}
{{/* CONFIGURATION VALUE ENDS HERE */}}

{{ $time := 0 }}{{ $afk := dbGet .User.ID "afk" }}{{ $prefix := index (reFindAllSubmatches `.*?: \x60(.*)\x60\z` (execAdmin "Prefix")) 0 1 }}{{ $desc := "" }}
{{ if $args := .Args }}
    {{ if eq (lower (index $args 0)) (print $prefix "afk") }}
        {{ if and (ge (len $args) 1) (not $afk) }}
            {{ $message := "" }}
            {{ $duration := 0 }}
            {{ $skip := false }}
            {{ if ge (len .Args) 2 }}
                {{ $args = (slice .Args 1) }}
                {{ range $i, $v := $args }}
                    {{- if and (gt (len $v) 1) (not $skip) }}
                        {{- if and (eq $v "-d") (gt (len $args) (add $i 1)) }}
                            {{- $duration = index $args (add $i 1) }}
                            {{- $skip = true }}
                        {{- else }}
                            {{- $message = joinStr " " $message $v }}
                            {{- $skip = false }}
                        {{- end }}
                    {{- else if not $skip }}
                        {{- $skip = false }}
                        {{- $message = joinStr " " $message $v }}
                    {{- else if $skip }}
                        {{- $skip = false }}
                    {{- end -}}
                {{ end }}
            {{ end }}
            {{ $parsedDur := 0 }}
            {{ with and $duration (toDuration $duration) }} {{ $parsedDur = . }} {{ end }}
                {{ if $parsedDur }}
                    {{ dbSetExpire .User.ID "afk" (or $message "No reason") (toInt $parsedDur.Seconds) }}
                {{ else }} 
                    {{ dbSet .User.ID "afk" (or $message "No reason") }}
                {{ end }}
            {{ .User.Mention }}, I set your AFK to `{{ or $message "No reason provided" }}`.
        {{ else if $afk }}
            Welcome back, {{ .User.Mention }}, I removed your AFK.
            {{ dbDel .User.ID "afk" }}
        {{ end }}
    {{ else if and $afk $removeAfkOnMessage }}
        Welcome back, {{ .User.Mention }}, I removed your AFK.
        {{ dbDel .User.ID "afk" }}
    {{ else if .Message.Mentions }}
        {{ with (dbGet (index .Message.Mentions 0).ID "afk") }}
            {{ $user := userArg .UserID }}
            {{ $eta := "" }}
            {{ if gt .ExpiresAt.Unix 0 }} 
                {{ $eta = humanizeDurationSeconds (.ExpiresAt.Sub currentTime) | printf "*%s will be back in around %s.*" $user.Username }} 
            {{ end }}
            {{ if and (eq .Value "No reason") $eta }}
                {{ $desc = printf "%s" $eta }}
            {{ else if and (not $eta) (ne .Value "No reason") }}
                {{ $desc = printf "%s" .Value }}
            {{ else if and $eta (ne .Value "No reason") }}
                {{ $desc = printf "%s\n\n%s" $eta .Value }}
            {{ else }}
                {{ $desc = "**No reason provided**"}}
            {{ end }}
            {{ sendMessage nil (cembed
                "author" (sdict "name" (printf "%s is AFK" $user.String) "icon_url" ($user.AvatarURL "256"))
                "description" $desc
                "color" (randInt 0 16777216)
                "footer" (sdict "text" "Away since")
                "timestamp" .UpdatedAt
            ) }}
        {{ end }}
    {{ end }}
{{ end }}
```