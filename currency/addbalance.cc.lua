{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "^-(addbalance|addbal)"
        
        Adds Money To a User,Also Removes It, Usage "-addbalance <User/Member> <Amount>" 
*/}}

{{/*CONFIGURATION START*/}}

{{ $currency := "💰" }} {{/*Currency Emoji/Name*/}}

{{/*CONFIGURATION END*/}}




{{/*MAIN CODE !!!*/}}


{{$args := parseArgs 2 "Syntax is !addbalance <User> <Amount>"
    (carg "user" "User To Send Balance")
    (carg "int" "Balance to Add")}}


{{ $dbHandName := "HAND" }} {{/* Database Name To Add The Currency (is UserID + $dbHandName)*/}}

{{ $handbal := toInt (dbGet ($args.Get 0).ID $dbHandName).Value }}

{{ $handamount := (joinStr $currency " " $handbal)}}

{{ $newamount := dbIncr ($args.Get 0).ID $dbHandName ($args.Get 1) }}

{{if gt ($args.Get 1) 0}}
{{sendMessage .Channel.ID (joinStr "" "**Added " ($args.Get 1) $currency " to **" ($args.Get 0).Mention) }}
{{else}}
{{sendMessage .Channel.ID (joinStr "" "**Removed " ($args.Get 1) $currency " to **" ($args.Get 0).Mention) }}
{{end}}