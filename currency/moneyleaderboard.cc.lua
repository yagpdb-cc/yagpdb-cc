{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "\A-(money-?leaderboard|m-?lb|m-?top)"
        
        A money leaderboard
*/}}

{{/* CONFIGURATION START*/}}
{{ $currency := "💰" }}  {{/*Currency name/Icon*/}}

{{ $dbHandName := "HAND" }} {{/* Current Money In Hand Database(-h module) */}}
{{ $dbBankName := "GBANK" }} {{/* Bank Name Database(-b Module) */}}
{{ $dbNetworthName := "NETWORTH" }} {{/* Networth Database(-n Module)*/}}
    
{{/*CONFIGURATION END*/}}



{{/*MAIN CODE!!*/}}

{{ $args := parseArgs 1 "**Syntax is -money-leaderboard <Module> [Page]**" 
    (carg "string" "Module")
    (carg "int" "Page")}}

{{ $page := 1 }}
{{ if eq (len .Args) 3 }} {{ with reFind `\d+` (joinStr " " .CmdArgs 2) }} {{ $page = . | toInt }} {{end}} {{end}}
{{ $skip := mult (sub $page 1) 10 }}
{{ $error1 := "**That Module doesnt exists, The Modules Are: -h(to see the leaderboards of the money that people have in hand), -b(to see the leaderboards of the money that people have in the bank), -n(to see the leaderboards of the money that people have networth)**"}}

{{ $inhand := "-h"}}
{{ $inbank := "-b"}}
{{ $networth := "-n"}}

{{ if eq (lower ($args.Get 0)) (lower $inhand) }}

{{ $users := dbTopEntries $dbHandName 10 $skip }}

{{ if not $users }}
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
	{{ sendMessage nil (cembed
		"title" "❯ Money Leaderboards (In Hand)"
		"thumbnail" (sdict "url" "https://i.imgur.com/sFq0wAC.jpg")
		"color" 3144833
		"description" $display
		"footer" (sdict "text" (joinStr "" "Page " $page))
	) }} 
{{ end }}

{{ else if eq (lower ($args.Get 0)) (lower $inbank) }}

{{ $users := dbTopEntries "GBANK" 10 $skip }}

{{ if not $users }}
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
	{{ sendMessage nil (cembed
		"title" "❯ Money Leaderboards (In Bank)"
		"thumbnail" (sdict "url" "https://i.imgur.com/sFq0wAC.jpg")
		"color" 3144833
		"description" $display
		"footer" (sdict "text" (joinStr "" "Page " $page))
	) }} 
{{ end }}

{{else if eq (lower ($args.Get 0)) (lower $networth) }}
{{ $users := dbTopEntries "NETWORTH" 10 $skip }}

{{ if not $users }}
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
	{{ sendMessage nil (cembed
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
