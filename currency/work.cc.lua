{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Command (mention/cmd prefix): "work"
        
        Simple Work Command With Configurable Msg and configurable minWinAmount and maxWinAmount, Usage "!work" 
*/}}


{{/*CONFIGURATION START*/}}
{{ $dbHandName := "HAND" }} {{/*Database Currency Entry*/}}
{{ $currency := "💰" }} {{/*Currency Emoji/Name*/}}
{{ $minAmount := 5}} {{/*Minimum Money Given*/}}
{{ $maxAmount := 50}} {{/*Maximum Money Given*/}}
{{ $cooldown := 3600}} {{/*Cooldown "In Seconds": 60secs = 1 min, 3600secs = 1h, 86400 = 1day*/}}
{{ $winMsg := "You Worked Hard And Gained: "}} {{/*Win Message*/}}
{{ $loseMsg := "You Losed Your Hammer and Payed For Replace it: "}} {{/*Lose Message*/}}
{{/*CONFIGURATION END*/}}


{{/*MAIN CODE!!!*/}}

{{/*COOLDOWN CODE*/}}
{{/* 0 for per user, 1 for global */}}
{{$isGlobal := 0}}
{{$name := "work"}}
{{$lengthSec := $cooldown}}
{{$error4 := "**Hey, This Command have a Cooldown of: "}}

{{/* CREATING VARIABLES DO NOT TOUCH */}}
{{$id := 0}}
{{$key := joinStr "" "cooldown_" $name}}
{{if eq $isGlobal 0}}
{{$id = .User.ID}}
{{end}}


{{if dbGet (toInt64 $id) $key}} 
{{$error4 := print  $error4 $cooldown "s**"}}
{{sendMessageNoEscape nil $error4}}
{{else}}
{{/* Create cooldown entry */}}
{{dbSetExpire (toInt64 $id) $key "cooldown" $lengthSec}}

{{/*WORK CODE*/}}
{{ $handbal := toInt (dbGet .User.ID $dbHandName).Value }}
{{ $handamount := (joinStr $currency " " $handbal)}}


{{ $winorlose := randInt 4 }} {{/* 0  - Lose / 1 or more - Win */}}
{{ $winorloseamount := randInt $minAmount $maxAmount}}
{{if gt $winorlose 1}}

{{ $newamount := dbIncr .User.ID $dbHandName $winorloseamount }}

{{ print $winMsg $winorloseamount $currency}}

{{else}}

{{ $newamount := dbIncr .User.ID $dbHandName (mult $winorloseamount -1) }}

{{ print $loseMsg $winorloseamount $currency}}

{{end}}
{{end}}