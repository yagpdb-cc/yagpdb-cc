{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "^-(deposit|dep)"
        
        Deposit Your Money To The Bank, Usage "-deposit <Amount> or all " 
*/}}

{{/* CONFIGURATION START*/}}
{{ $currency := "💰" }}
{{$bankName := "GBank"}}
{{$minAmountToDeposit := 1}}
{{/*CONFIGURATION END*/}}

{{/*MAIN CODE!!*/}}

{{ $dbHandName := "HAND" }} 
{{ $dbBankName := "GBANK" }}

{{$error1 := "**Error, Syntax is !deposit <all> or <amount>**"}}
{{$error2 := "**Error, You Need At Least: **"}}
{{$depall := "all"}}

{{ $handbal := toInt (dbGet .User.ID $dbHandName).Value }}
{{ $bankbal := toInt (dbGet .User.ID $dbBankName).Value }}

{{ $depMsg := "**Successfully Deposited "}}
{{ $depMsg2 := print " to The " $bankName "**"}}

{{if eq (len .Args) 2}}
{{if gt $handbal 0}}
{{$arg1 := (index .Args 1)}}
{{if in $arg1 $depall}}

{{ $newbankamount := dbIncr .User.ID $dbBankName  $handbal}}
{{ $newamount := dbIncr .User.ID $dbHandName  (mult -1 $handbal)}}

{{$depMsg := print $depMsg $handbal $currency $depMsg2}}
{{sendMessage .Channel.ID $depMsg}}

{{else if gt (toInt $arg1) 0}}

{{if ge (toInt $arg1) $handbal}}
{{$all := $handbal}}

{{ $newbankamount := dbIncr .User.ID $dbBankName  $handbal}}
{{ $newamount := dbIncr .User.ID $dbHandName  (mult -1 $handbal)}}

{{$depMsg := print $depMsg $handbal $currency $depMsg2}}
{{sendMessage .Channel.ID $depMsg}}

{{else}}

{{ $newbankamount := dbIncr .User.ID $dbBankName  (toInt $arg1)}}
{{ $newamount := dbIncr .User.ID $dbHandName  (mult -1 (toInt $arg1))}}

{{$depMsg := print $depMsg (toInt $arg1) $currency $depMsg2}}
{{sendMessage .Channel.ID $depMsg}}
{{end}}
{{else}}
{{sendMessage .Channel.ID $error1}}
{{end}}
{{else}}
{{$error2 := print $error2 $minAmountToDeposit $currency}}
{{sendMessage .Channel.ID $error2}}
{{end}}

{{else}}
{{sendMessage .Channel.ID $error1}}
{{end}}