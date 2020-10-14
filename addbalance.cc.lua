{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "\A-(addbal(ance)?)"
        
        Adds Money To a User,Also Removes It, Usage "-addbalance <User/Member> <Amount>" 
*/}}

{{/*CONFIGURATION START*/}}

{{ $currency := "💰" }} {{/*Currency Emoji/Name*/}}
{{ $dbHandName := "HAND" }} {{/* Database Name To Add The Currency (is UserID + $dbHandName)*/}}

{{/*CONFIGURATION END*/}}




{{/*MAIN CODE !!!*/}}


{{$args := parseArgs 2 "Syntax is -addbalance <User> <Amount>"
    (carg "member" "User To Send Balance")
    (carg "int" "Balance to Add")}}

{{ $member := ($args.Get 0)}}
{{ $balinput := ($args.Get 1)}}

{{ $handbal := toInt (dbGet ($member.User).ID $dbHandName).Value }}
{{ $newamount := dbIncr ($member.User).ID $dbHandName $balinput }}

{{if gt $balinput 0}}
**Added {{$balinput}} {{$currency}} to **  {{ ($member.User).Mention }}
{{else}}
**Removed {{mult ($balinput) -1}} {{$currency}} from ** {{ ($member.User).Mention }}
{{end}}