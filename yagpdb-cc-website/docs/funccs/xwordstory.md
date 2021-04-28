---
sidebar_position: 19
title: X Word Story
---

```go
{{/*
    SETUP:
    - Set the cc restrictions to only run in your x-word-story channel
    - Set the trigger type to Regex and the trigger to: `\A`

    USAGE:
    - Just type the right amount of words and write a story together :)

    CREDITS: SpecialEliteSNP <https://github.com/SpecialEliteSNP>
*/}}

{{/* VARIABLES - You can edit these values */}}
  {{/* Replace 3 with amount of words you want to be used in the x-word-story channel */}}
    {{ $words := 3 }}
  {{/* Roles to ignore, these could be your staff roles or just other exceptions */}}
    {{ $ignored_roles := cslice 763447831829938176 764103587223044116 778952687986802698 764054381535821825 775003755842109440 }}

  {{/* Responses: */}}
    {{/* Message when they try to write twice in a row */}}
      {{ $twice := "you can't write a story on your own 😉" }}


{{/* CODE - Don't edit this part */}}
{{ $r := true }}{{ range .Member.Roles }}{{ if in $ignored_roles . }}{{ $r = false }}{{ end }}{{ end }}
{{ if $r }}
  {{ $s := sdict }}{{ with (dbGet 20 "story-channel").Value }}{{ $s = sdict . }}{{ end }}
  {{ if not $s }}
    {{ dbSet 20 "story-channel" (sdict "l" 0) }}
    {{ addReactions "☑" }}
    {{ print .User.Mention ", <#" .Channel.ID "> is all set up as your " $words "-word-channel!" }}
  {{ else if eq $s.l .User.ID }}
    {{ addReactions "👎" }}
    {{ deleteTrigger 1 }}
    {{ print .User.Mention ", " $twice }}
    {{ deleteResponse 5 }}
  {{ else if not (reFind (print `\A\s*(?:[[:alpha:]]+\s+){` (sub $words 1) `}[[:alpha:]]+\s*\z`) .Message.Content) }}
    {{ addReactions "❌" }}
    {{ deleteTrigger 1 }}
    {{ print .User.Mention ", please use exactly **" $words "** words in this channel 😉" }}
    {{ deleteResponse 5 }}
  {{ else }}
    {{ $s.Set "l" .User.ID }}
    {{ $s.Set (str .User.ID) (add ($s.Get (str .User.ID)) 1) }}
    {{ dbSet 20 "story-channel" $s }}
  {{ end }}
{{ end }}
```