{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "\A-(bal(ance)?)"
        
        Gets Your Money and The Money From Others Users/Members, Usage "-balance [User/Member]" (If no args given, Get Users balance) 
*/}}

{{/* CONFIGURATION START*/}}

{{ $currency := "💰" }} {{/* Currency Emoji/Name */}}
{{ $bankName := "**GBank**" }} {{/* Bank Name where do you deposit / withdraw (This doesnt affect other cc's) */}}
{{ $dbHandName := "HAND" }} {{/* Current Money In Hand Database(This is for using with other Fun Things, Like Slots) */}}
{{ $dbBankName := "GBANK" }} {{/* Bank Name Database(This is for Depositing Money in the bank) */}}
{{ $dbNetworthName := "NETWORTH" }} {{/* Networth Database(Bank + Hand)*/}}

{{/*CONFIGURATION END*/}}


{{/*MAIN CODE !!!*/}}


{{ $args := parseArgs 0 "-balance [User] to see your balance or a user balance" (carg "member" "User to see balance of") }}
{{ $member := or ($args.Get 0) .Member }}
{{ $user := $member.User }}



{{ $handbal := toInt (dbGet $user.ID $dbHandName).Value }}
{{ $bankbal := toInt (dbGet $user.ID $dbBankName).Value }}
{{ dbSet $user.ID $dbNetworthName (add $bankbal $handbal) }}
{{ $networthbal := toInt (dbGet $user.ID $dbNetworthName).Value }}

{{ $handamount := print $currency " " $handbal}}
{{ $bankamount := print $currency " " $bankbal}}
{{ $networthamount := print $currency " " $networthbal}}

{{ $embed := cembed
"color" 6123007
"author" (sdict "name" (joinStr "" ($user.Username)) "icon_url" (($user).AvatarURL "512"))
"fields" (cslice 
        (sdict "name" "**In Hand**" "value" $handamount) 
        (sdict "name" $bankName "value" $bankamount) 
        (sdict "name" "**Networth**" "value" $networthamount) 
    ) 
}}

{{sendMessage nil $embed}}