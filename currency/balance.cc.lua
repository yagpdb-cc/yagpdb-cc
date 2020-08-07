{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Command (mention/cmd prefix): "balance"
        
        Gets Your Money and The Money From Others Users/Members, Usage "!balance [User/Member]" (If no args given, Get Users balance) 
*/}}

{{/* CONFIGURATION START*/}}

{{ $currency := "💰" }} {{/* Currency Emoji/Name */}}

{{/*CONFIGURATION END*/}}


{{/*MAIN CODE !!!*/}}

{{ $dbHandName := "HAND" }} {{/* Current Money In Hand Database(This is for using with other Fun Things, Like Slots) */}}
{{ $dbBankName := "GBANK" }} {{/* Bank Name Database(This is for Depositing Money in the bank) */}}
{{ $dbNetworthName := "NETWORTH" }} {{/* Networth Database(If The Server have a sort of clans or something)*/}}

{{if eq (len .Args) 2}}

{{ $handbal := toInt (dbGet (userArg (index .Args 1)).ID $dbHandName).Value }}
{{ $bankbal := toInt (dbGet (userArg (index .Args 1)).ID $dbBankName).Value }}
{{ $networthbal := toInt (dbGet (userArg (index .Args 1)).ID $dbNetworthName).Value }}

{{ $handamount := (joinStr $currency " " $handbal)}}
{{ $bankamount := (joinStr $currency " " $bankbal)}}
{{ $networthamount := (joinStr $currency " " $networthbal)}}

{{ $embed := cembed
"color" 6123007
"author" (sdict "name" (joinStr "" (userArg (index .Args 1)).Username) "url" "" "icon_url" ((userArg (index .Args 1)).AvatarURL "512"))
"fields" (cslice 
        (sdict "name" "**In Hand**" "value" $handamount "inline" false) 
        (sdict "name" "**GBank**" "value" $bankamount "inline" false) 
        (sdict "name" "**Networth**" "value" $networthamount "inline" false) 
    ) 
}}

{{sendMessage .Channel.ID $embed}}

{{else}}

{{ $handbal := toInt (dbGet .User.ID $dbHandName).Value }}
{{ $bankbal := toInt (dbGet .User.ID $dbBankName).Value }}
{{ $networthbal := toInt (dbGet .User.ID $dbNetworthName).Value }}

{{ $handamount := (joinStr $currency " " $handbal)}}
{{ $bankamount := (joinStr $currency " " $bankbal)}}
{{ $networthamount := (joinStr $currency " " $networthbal)}}

{{ $embed := cembed
"color" 6123007
"author" (sdict "name" (joinStr "" .User.Username) "url" "" "icon_url" (.User.AvatarURL "512"))
"fields" (cslice 
        (sdict "name" "**In Hand**" "value" $handamount "inline" false) 
        (sdict "name" "**GBank**" "value" $bankamount "inline" false) 
        (sdict "name" "**Networth**" "value" $networthamount "inline" false) 
    ) 
}}
{{sendMessage .Channel.ID $embed}}

{{end}}