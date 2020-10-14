{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "\A-(dep(osit)?)"
        
        Deposit Your Money To The Bank, Usage "-deposit <Amount> or all " 
*/}}

{{/* CONFIGURATION START*/}}
{{ $currency := "💰" }} {{/* Currency Name/Icon */}}
{{$bankName := "GBank"}} {{/* The bank name of the bank to deposit*/}}
{{$minAmountToDeposit := 1}} {{/* Minimum amount to deposit */}}
{{ $dbHandName := "HAND" }} {{/* Current Money In Hand Database(This is for using with other Fun Things, Like Slots) */}}
{{ $dbBankName := "GBANK" }} {{/* Bank Name Database(This is for Depositing Money in the bank) */}}
{{$depall := "all"}} {{/*Word for depositing all the money to the bank*/}}
{{/*CONFIGURATION END*/}}

{{/*MAIN CODE!!*/}}

{{$error1 := print "**Error, Syntax is -deposit <" $depall "> or <amount>**"}}
{{$error2 := "**To Deposit Money to the bank, you need at Least: **"}}

{{ $handbal := toInt (dbGet .User.ID $dbHandName).Value }}
{{ $bankbal := toInt (dbGet .User.ID $dbBankName).Value }}

{{ $depMsg := "**Successfully Deposited "}}
{{ $depMsg2 := print " to The " $bankName "**"}}

{{if eq (len .CmdArgs) 1}}
{{if gt $handbal 0}}
{{$arg1 := (index .CmdArgs 0)}}
{{if in $arg1 $depall}}

{{ $newbankamount := dbIncr .User.ID $dbBankName  $handbal}}
{{ $newamount := dbIncr .User.ID $dbHandName  (mult -1 $handbal)}}

{{$depMsg := print $depMsg $handbal $currency $depMsg2}}
{{$depMsg}}

{{else if gt (toInt $arg1) 0}}

{{if ge (toInt $arg1) $handbal}}
{{$all := $handbal}}

{{ $newbankamount := dbIncr .User.ID $dbBankName  $handbal}}
{{ $newamount := dbIncr .User.ID $dbHandName  (mult -1 $handbal)}}

{{$depMsg := print $depMsg $handbal $currency $depMsg2}}
{{$depMsg}}

{{else}}

{{ $newbankamount := dbIncr .User.ID $dbBankName  (toInt $arg1)}}
{{ $newamount := dbIncr .User.ID $dbHandName  (mult -1 (toInt $arg1))}}

{{$depMsg := print $depMsg (toInt $arg1) $currency $depMsg2}}
{{ $depMsg }}
{{end}}
{{else}}
{{ $error1 }}
{{end}}
{{else}}
{{$error2 := print $error2 $minAmountToDeposit $currency}}
{{$error2}}
{{end}}

{{else}}
{{$error1}}
{{end}}