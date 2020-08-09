{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "^-(money-leaderboard|m-lb|m-top)"
        
        Checks Leaderboards of Money in Bank, Hand and Networth, Usage "-money-leaderboard <Module> [Page]" 
*/}}

{{/* CONFIGURATION START*/}}
{{ $currency := "🍟" }}
{{/*CONFIGURATION END*/}}



{{/*MAIN CODE!!*/}}

{{ $args := parseArgs 1 "**Syntax is !money-leaderboard <Module> [Page]**" 
    (carg "string" "Module")
    (carg "int" "Page")}}

{{ $page := 1 }}
{{ if eq (len .Args) 3 }} {{ with reFind `\d+` (joinStr " " .CmdArgs 2) }} {{ $page = . | toInt }} {{end}} {{end}}
{{ $skip := mult (sub $page 1) 10 }}
{{ $error1 := "**That Module Doesnt Exist!!, The Modules Are: -h, -b, -n**"}}

{{ $inhand := "-h"}}
{{ $inbank := "-b"}}
{{ $networth := "-n"}}

{{ if in (toString (index .Args 1)) $inhand }}

{{ $users := dbTopEntries "HAND" 10 $skip }}

{{ if not (len $users) }}
	There were no users on that page! 
{{ else }}
	{{ $money := $skip }}
	{{ $display := "" }} 
	{{- range $users -}}
		{{ $networth := toInt .Value }} 
		{{ $money = add $money 1 }} 
		{{ $display = printf "%s\n• **%d.** [%s](https://yagpdb.xyz) > **%d%s**"
			$display $money .User.String $networth $currency
		}} 
	{{ end }}
	{{ $id := sendMessageRetID nil (cembed
		"title" "❯ Money Leaderboards (In Hand)"
		"thumbnail" (sdict "url" "https://i.imgur.com/sFq0wAC.jpg")
		"color" 3144833
		"description" $display
		"footer" (sdict "text" (joinStr "" "Page " $page))
	) }} 
{{ end }}

{{ else if in (toString (index .Args 1)) $inbank }}

{{ $users := dbTopEntries "GBANK" 10 $skip }}

{{ if not (len $users) }}
	There were no users on that page! 
{{ else }}
	{{ $money := $skip }}
	{{ $display := "" }} 
	{{- range $users -}}
		{{ $networth := toInt .Value }} 
		{{ $money = add $money 1 }} 
		{{ $display = printf "%s\n• **%d.** [%s](https://yagpdb.xyz) > **%d%s**"
			$display $money .User.String $networth $currency
		}} 
	{{ end }}
	{{ $id := sendMessageRetID nil (cembed
		"title" "❯ Money Leaderboards (In Bank)"
		"thumbnail" (sdict "url" "https://i.imgur.com/sFq0wAC.jpg")
		"color" 3144833
		"description" $display
		"footer" (sdict "text" (joinStr "" "Page " $page))
	) }} 
{{ end }}

{{else if in (toString (index .Args 1)) $networth }}
{{ $users := dbTopEntries "NETWORTH" 10 $skip }}

{{ if not (len $users) }}
	There were no users on that page! 
{{ else }}
	{{ $money := $skip }}
	{{ $display := "" }} 
	{{- range $users -}}
		{{ $networth := toInt .Value }} 
		{{ $money = add $money 1 }} 
		{{ $display = printf "%s\n• **%d.** [%s](https://yagpdb.xyz) > **%d%s**"
			$display $money .User.String $networth $currency
		}} 
	{{ end }}
	{{ $id := sendMessageRetID nil (cembed
		"title" "❯ Money Leaderboards (Networth)"
		"thumbnail" (sdict "url" "https://i.imgur.com/sFq0wAC.jpg")
		"color" 3144833
		"description" $display
		"footer" (sdict "text" (joinStr "" "Page " $page))
	) }} 
{{ end }}
{{else}}
{{$error1}}
{{ end }}