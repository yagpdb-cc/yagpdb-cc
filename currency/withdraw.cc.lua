{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "^-(withdraw|with)"
        
        Withdraw Your Money from The Bank, Usage "-withdraw <Amount> or all " 
*/}}

{{/* CONFIGURATION START*/}}
{{ $currency := "💰" }}
{{$bankName := "GBank"}}
{{$minAmountToWithdraw := 1}}
{{/*CONFIGURATION END*/}}

{{/*MAIN CODE!!*/}}

{{ $dbHandName := "HAND" }} 
{{ $dbBankName := "GBANK" }}

{{$error1 := "**Error, Syntax is !withdraw <all> or <amount>**"}}
{{$error2 := "**Error, You Need At Least: **"}}
{{$withall := "all"}}

{{ $handbal := toInt (dbGet .User.ID $dbHandName).Value }}
{{ $bankbal := toInt (dbGet .User.ID $dbBankName).Value }}

{{ $withMsg := "**Successfully Withdrawed "}}
{{ $withMsg2 := print " of The " $bankName "**"}}

{{if eq (len .Args) 2}}
{{if gt $bankbal 0}}
{{$arg1 := (index .Args 1)}}
{{if in $arg1 $withall}}

{{ $newamount := dbIncr .User.ID $dbHandName  $bankbal}}
{{ $newbankamount := dbIncr .User.ID $dbBankName  (mult -1 $bankbal)}}

{{$withMsg := print $withMsg $bankbal $currency $withMsg2}}
{{sendMessage .Channel.ID $withMsg}}
{{else if gt (toInt $arg1) 0}}

{{if gt (toInt $arg1) $bankbal}}

{{ $newamount := dbIncr .User.ID $dbHandName  $bankbal}}
{{ $newbankamount := dbIncr .User.ID $dbBankName  (mult -1 $bankbal)}}

{{$withMsg := print $withMsg $bankbal $currency $withMsg2}}
{{sendMessage .Channel.ID $withMsg}}

{{else}}
{{ $newamount := dbIncr .User.ID $dbHandName  (toInt $arg1)}}
{{ $newbankamount := dbIncr .User.ID $dbBankName  (mult -1 (toInt $arg1))}}

{{$withMsg := print $withMsg (toInt $arg1) $currency $withMsg2}}
{{sendMessage .Channel.ID $withMsg}}
{{end}}
{{else}}
{{sendMessage .Channel.ID $error1}}
{{end}}
{{else}}
{{$error2 := print $error2 $minAmountToWithdraw $currency}}
{{sendMessage .Channel.ID $error2}}
{{end}}

{{else}}
{{sendMessage .Channel.ID $error1}}
{{end}}