---
sidebar_position: 3
title: Reaction Handler
---

This handy-dandy custom command-bundle allows a user to cancel their most recent report and utilizes  
Reactions to make things easier for staff.  
This custom command manages the reaction menu.  
Make this in a seperate Reaction CC, due to its massive character count.  
Remove this leading comment once you added this command.

**Trigger:** `Reaction` on `Added Reactions only`

```go
{{/*
    This handy-dandy custom command-bundle allows a user to cancel their most recent report and utilizes
    Reactions to make things easier for staff.
    This custom command manages the reaction menu.
    Make this in a seperate Reaction CC, due to its massive character count.
    Remove this leading comment once you added this command.
    
    Obligatory Trigger type and trigger: Reaction; added reactions only.

    Author: Luca Z. <https://github.com/l-zeuch>
    License: MIT
    Copyright: (c) 2021
*/}}


{{/* ACTUAL CODE */}}

{{/* Functions; edit report embed */}}
{{define "edit"}}
    {{$rEmbed := .rembed}}
    {{$rEmbed.Set "Fields" ((cslice).AppendSlice $rEmbed.Fields)}}
    {{$emojis := .emojis}}
    {{$moderator := .moderator}}
    {{if ne .menu "none"}}
        {{$rEmbed.Fields.Set 0 (sdict "name" "Current Status" "value" (printf "__%s__" .message))}}
        {{$rEmbed.Fields.Set 5 (sdict "name" "Reaction Menu Options" "value" .menu)}}
    {{else}}
        {{$rEmbed.Set "Fields" (slice $rEmbed.Fields 0 5)}}
        {{$rEmbed.Set "Footer" (sdict "text" (printf "Report closed! • Responsible Moderator: %s (ID: %d)" $moderator.String $moderator.ID) "icon_url" ($.User.AvatarURL "256"))}}
    {{end}}
    {{$rEmbed.Set "color" (toInt .color)}}
    {{deleteAllMessageReactions .log .reportID}}
    {{range $emojis}}
        {{addReactions .}}
    {{end}}
    {{editMessage .log .reportID (complexMessageEdit "embed" $rEmbed)}}
    {{if .notify}}
        {{$message := complexMessage "content" (print .author.Mention ":") "embed" (cembed
            "title" "Information"
            "description" "News regarding your report!"
            "fields" (cslice
                (sdict "name" "Responsible Moderator:" "value" (print $moderator.Mention "\nID: `" $moderator.ID "`") "inline" true)
                (sdict "name" "Status:" "value" .message "inline" true)
                (sdict "name" "\u200B" "value" "\u200B" "inline" true)
                (sdict "name" "Reported User:" "value" (index $rEmbed.Fields 2).Value "inline" true)
                (sdict "name" "Reason for Report:" "value" (index $rEmbed.Fields 1).Value "inline" true)
            )
            "footer" (sdict "text" (print $moderator.String " • " (currentTime.Format "Mon 02 Jan 15:04:05")) "icon_url" ($moderator.AvatarURL "256"))
        )}}
        {{sendMessage .discussion $message}}
    {{end}}
{{end}}

{{/* Initialising stuff */}}
{{$conf := sdict (dbGet .Guild.ID "reportSettings").Value}}
{{$disc := $conf.reportDiscussion}}
{{$logs := $conf.reportLog}}

{{/* Validating that it is a report message, the user a mod, parsing the author from description */}}
{{$isMod := in (split (index (split (exec "viewperms") "\n") 2) ", ") "ManageMessages"}}
{{if and ($embed := (index .ReactionMessage.Embeds 0)) (eq .Channel.ID $logs)}}
    {{$report := (index .Message.Embeds 0|structToSdict)}}
    {{range $k, $v := $report}}{{if eq (kindOf $v true) "struct"}}{{$report.Set $k (structToSdict $v)}}{{end}}{{end}}
    {{if and $isMod (reFindAllSubmatches (toString $.User.ID) $embed.Footer.Text) $embed.Author $embed.Footer}}
        {{with $report}}
            {{$author := (index (reFindAllSubmatches `\A<@!?(\d{17,19})>` .Description) 0 1|toInt|getMember).User}}
            {{.Set "Footer" .Footer}}
            {{.Set "Author" .Author}}
            {{$data := sdict "color" 0}}{{/* 'Empty' sdict as data to prevent errors */}}
            {{if eq $.Reaction.Emoji.Name "❌"}}
                {{if (reFindAllSubmatches `(?i)deny request` (index $embed.Fields 5).Value)}}
                    {{$data = sdict "color" 16711680 "message" "Request denied." "menu" "Dismiss report with ❌, start investigation with 🛡️, or ask for more background information with ⚠️." "emojis" (cslice "❌" "🛡" "⚠")}}
                {{else}}
                    {{$data = sdict "color" 65280 "message" "Report dismissed." "menu" "Warn for `False report` with ❗, or close without any further action with 👌." "emojis" (cslice "❗" "👌")}}
                {{end}}
                {{$data.Set "notify" true}}
            {{else if eq $.Reaction.Emoji.Name "⚠️"}}
                {{if (reFindAllSubmatches `(?i)deny request` (index $embed.Fields 5).Value)}}
                    {{$data = sdict "menu" "Dismiss request with ❌, or accept request (and nullify report) with 👌." "emojis" (cslice "❗" "👌")}}
                {{else}}
                    {{$data = sdict "menu" "Dismiss report with ❌ or start investigation with 🛡️." "emojis" (cslice "❌" "🛡️")}}
                {{end}}
                {{$data.Set "message" "More information requested."}}
                {{$data.Set "notify" true}}
                {{$data.Set "color" 255}}
            {{else if eq $.Reaction.Emoji.Name "👌"}}
                {{if (reFindAllSubmatches `(?i)deny request` (index $embed.Fields 5).Value)}}
                    {{$data = sdict "message" "Request accepted, report nullified." "menu" "none" "notify" true}}
                {{else if (reFindAllSubmatches `(?i)warn` (index $embed.Fields 5).Value)}}
                    {{$data = sdict "message" "Report dismissed, no further action taken." "menu" "none" "notify" false}}
                {{else}}
                    {{$data = sdict "message" "Report resolved." "menu" "none" "notify" true}}
                {{end}}
                {{$data.Set "color" 65280}}
                {{$data.Set "emojis" (cslice "🏳️")}}
            {{else if eq $.Reaction.Emoji.Name "🛡️"}}
                {{$data = sdict "color" 16776960 "message" "Under investigation." "menu" "Dismiss with ❌ or resolve with 👌." "emojis" (cslice "❌" "👌") "notify" true}}
            {{else if eq $.Reaction.Emoji.Name "❗"}}
                {{$data = sdict "color" 16711680 "message" "Report dismissed, warned for false report." "menu" "none" "emojis" (cslice "🏳️") "notify" false}}
            {{end}}
            {{if ne $.Reaction.Emoji.Name "🏳️"}}
            {{$data.Set "rembed" $report}}
            {{$data.Set "log" $logs}}
            {{$data.Set "reportID" $.Message.ID}}
            {{$data.Set "author" $author}}
            {{$data.Set "moderator" $.User}}
            {{$data.Set "discussion" $disc}}
            {{template "edit" $data}}
            {{end}}
        {{end}}
    {{else if and $isMod (eq .Reaction.Emoji.Name "🔐") (reFindAllSubmatches "•" $embed.Footer.Text)}}
        {{$report.Set "Footer" (sdict "text" (printf "Responsible Moderator: %s (ID %d)" .User.String .User.ID))}}
        {{$report.Set "Fields" ((cslice).AppendSlice $report.Fields)}}
        {{.User.Mention}}: You opened this report now - take good care of it.
        {{deleteResponse}}
        {{deleteAllMessageReactions nil .Message.ID}}
        {{editMessage nil .Message.ID (complexMessageEdit "embed" $report)}}
        {{addReactions "❌" "🛡️" "⚠️"}}
    {{else}}
        {{deleteMessageReaction nil .Message.ID .User.ID "🔐" "❌" "❗" "👌" "🛡️" "⚠️"}}
    {{end}}
{{end}}
```