---
sidebar_position: 5
title: newgame
---

```go
{{/*
	This command starts a new CAH game using the specified packs and pack groups.
	It first checks whether each argument is a valid pack group and, if so, expands it into its component packs. If not, that argment is assumed to be an individual pack and is skipped. After expanding all applicable pack groups, the resulting list of packs is used to start a new game, and all members with the CAH role are pinged.

	Usage: `-newgame pack1 "pack 2" packGroup1 "pack group 2" etc` (no specific ordering necessary)

	Recommended trigger: `newgame`
	Trigger type: Command

	Credits:
	LRitzdorf <https://github.com/LRitzdorf>
*/}}

{{/* This is the default list of packs to use if nothing is specified: */}}
{{ $packs := "*" }}
{{/* This is the ID of the CAH role, which will be pinged when a new game is started: */}}
{{ $CAHrole := 123456789 }}

{{ if gt (len .CmdArgs) 0 }}
    {{ $star := false }}
    {{ $reqst := cslice }}
    {{ range .CmdArgs }}
        {{- $dbResult := dbGet 0 (joinStr "" "group " .) }}
        {{- if $dbResult }}
            {{- $reqst = $reqst.Append $dbResult.Value }}
        {{- else }}
            {{- $reqst = $reqst.Append . }}
        {{- end }}
    {{- end }}
    {{ $packs = "" }}
    {{ range $reqst }}
        {{- if (eq . "*") }}
            {{- $star = true }}
        {{- else }}
            {{- if eq (len (reFindAll (joinStr "" "(" . ")") $packs)) 0 }}
                {{- $packs = joinStr " " $packs . }}
           {{- end }}
        {{- end }}
    {{- end }}
    {{ if $star }}
        {{ $packs = "*" }}
    {{ end }}
{{ end }}
 
{{ $resp := exec "cah create" $packs }}
{{ if eq (len (reFind "Unknown pack" $resp)) 0 }}
    {{.User.Mention}} has summoned all the{{mentionRoleID $CAHrole}}s to a new game!
We'll be using the following pack(s): `{{$packs}}`.
{{ end }}
{{ $resp }}
```