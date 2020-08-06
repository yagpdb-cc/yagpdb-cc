{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Command (mention/cmd prefix): "addbalance"
        
        Adds Money To a User, Usage "!addbalance <User/Member> <Amount>" 
*/}}

{{/*CONFIGURATION START*/}}

{{ $currency := "💰" }} {{/*Currency Emoji/Name*/}}

{{/*CONFIGURATION END*/}}




{{/*MAIN CODE !!!*/}}


{{$args := parseArgs 2 "Syntax is !addbalance <User> <Amount>" {{/*Check if We Have two Args*/}}
    (carg "user" "channel to send to")
    (carg "int" "Balance to Add")}}


{{ $dbHandName := "HAND" }} {{/* Database Name To Add The Currency (is UserID + $dbHandName)*/}}

{{ $handbal := toInt (dbGet ($args.Get 0).ID $dbHandName).Value }}

{{ $handamount := (joinStr $currency " " $handbal)}}

{{ $newamount := dbIncr ($args.Get 0).ID $dbHandName ($args.Get 1) }}

{{sendMessage .Channel.ID (joinStr "" "**Added " ($args.Get 1) " to **" ($args.Get 0).Mention) }}
