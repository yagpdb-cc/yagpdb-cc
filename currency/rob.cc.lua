{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Command (mention/cmd prefix): "rob"
        
        Robs Random Money of a User with a min amount the Target User Needs , Usage "!rob <User/Member>" 
*/}}

{{$args := parseArgs 1 "Syntax is !rob <User>"
    (carg "user" "User To Rob")}}

{{/*CONFIGURATION START*/}}
{{ $dbHandName := "HAND" }} {{/*Database Entry To rob*/}}
{{ $currency := "💰" }} {{/*Currency Emoji/Name*/}}
{{ $minamounttorob := 1000}} {{/*MinAmount the Player Gets and Needs To Rob*/}}
{{$cooldown := 3600}} {{/*Cooldown "In Seconds": 60secs = 1 min, 3600secs = 1h, 86400 = 1day*/}}
{{/*CONFIGURATION END*/}}


{{/*Main Code*/}}

{{/*Cooldown Code*/}}

{{$isGlobal := 0}}
{{$name := "rob"}}
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

{{/* Rob Main Code */}}
{{$error1 := "**The User Doesn`t Have at Least 1000 to Rob, Is Not Worth It!!**"}}
{{$error2 := "**You Cannot Rob Yourself!!!**"}}
{{$error3 := "**Hey, You Dont Have At Least: "}}

{{$losemsg := "We Caught You Stealing, Youre Fined "}}
{{$winmsg := "You Stealed: "}}

{{ $winorlose := randInt 4 }} {{/* 0  - Lose / 1 or more - Win */}}

{{ $handbal := toInt (dbGet .User.ID $dbHandName).Value }}
{{ $userhandbal := toInt (dbGet ($args.Get 0).ID $dbHandName).Value}}

{{ $amounttowinorlose := randInt $minamounttorob $userhandbal }}

{{if ne .User.ID ($args.Get 0).ID }}
{{if ge $handbal $minamounttorob}}
{{if ge $userhandbal $minamounttorob}}

	{{if ge $winorlose 1}}
		{{if gt $amounttowinorlose $userhandbal}}
		{{$amounttowinorlose := $userhandbal }}
		{{end}}

		{{ $newrobbedmoneyamount := dbIncr ($args.Get 0).ID $dbHandName (mult -1 $amounttowinorlose) }} {{/*Quit Users Money*/}}
		{{ $newmoneyamount := dbIncr .User.ID $dbHandName $amounttowinorlose }}
		{{ $winmsg := print "**" $winmsg $amounttowinorlose $currency " of " ($args.Get 0).Mention "!!**"}}
		{{dbSetExpire (toInt64 $id) $key "cooldown" $lengthSec}}
		{{sendMessageNoEscape nil $winmsg}}

{{else}}
{{if ge $amounttowinorlose $handbal}}
{{$amounttowinorlose := $handbal}}
{{end}}
	{{ $newmoneyamount := dbIncr .User.ID $dbHandName (mult -1 $amounttowinorlose) }} {{/*Quit Users Money*/}}
	{{ $losemsg := print "**" $losemsg $amounttowinorlose $currency "!!**"}}
    {{dbSetExpire (toInt64 $id) $key "cooldown" $lengthSec}}
	{{sendMessageNoEscape nil $losemsg}}
{{end}}
{{else}}
{{sendMessageNoEscape nil $error1}}
{{end}}
{{else}}
{{$error3 := print $error3 $minamounttorob $currency "**"}}
{{sendMessageNoEscape nil $error3}}
{{end}}
{{else}}
{{sendMessageNoEscape nil $error2}}
{{end}}
{{end}}




