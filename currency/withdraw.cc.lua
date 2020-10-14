{{/*
		Simple Currency System By GasInfinity
        
        Recommended Trigger: Regex: "\A-(w(ith)?d(raw)?)"
        
        Withdraw Your Money from The Bank, Usage "-withdraw <Amount> or all " 
*/}}

{{/* CONFIGURATION START*/}}
{{ $currency := "💰" }} {{/* Currency Name/Icon */}}
{{$bankName := "GBank"}} {{/* The bank name of the bank to withdraw */}}
{{$minAmountToWithdraw := 1}} {{/* Minimum amount to deposit */}}
{{ $dbHandName := "HAND" }}  {{/* Current Money In Hand Database(This is for using with other Fun Things, Like Slots) */}}
{{ $dbBankName := "GBANK" }} {{/* Bank Name Database(This is for Depositing Money in the bank) */}}
{{$withall := "all"}} {{/*Word for withdraw all the money from the bank*/}}
{{/*CONFIGURATION END*/}}


{{/*MAIN CODE!!*/}}

{{$error1 := "**Error, Syntax is -withdraw <all> or <amount>**"}}
{{$error2 := "**Error, You Need At Least: **"}}

{{ $handbal := toInt (dbGet .User.ID $dbHandName).Value }}
{{ $bankbal := toInt (dbGet .User.ID $dbBankName).Value }}

{{ $withMsg := "**Successfully Withdrawed "}}
{{ $withMsg2 := print " of The " $bankName "**"}}

{{if eq (len .CmdArgs) 1}}
{{if gt $bankbal 0}}
{{$arg1 := (index .CmdArgs 0)}}
{{if eq (lower $arg1) (lower $withall)}}

{{ $newamount := dbIncr .User.ID $dbHandName  $bankbal}}
{{ $newbankamount := dbIncr .User.ID $dbBankName  (mult -1 $bankbal)}}

{{$withMsg := print $withMsg $bankbal $currency $withMsg2}}
{{$withMsg}}
{{else if gt (toInt $arg1) 0}}

{{if gt (toInt $arg1) $bankbal}}

{{ $newamount := dbIncr .User.ID $dbHandName  $bankbal}}
{{ $newbankamount := dbIncr .User.ID $dbBankName  (mult -1 $bankbal)}}

{{print $withMsg $bankbal $currency $withMsg2}}

{{else}}
{{ $newamount := dbIncr .User.ID $dbHandName  (toInt $arg1)}}
{{ $newbankamount := dbIncr .User.ID $dbBankName  (mult -1 (toInt $arg1))}}

{{print $withMsg (toInt $arg1) $currency $withMsg2}}
{{end}}
{{else}}
{{$error1}}
{{end}}
{{else}}
{{print $error2 $minAmountToWithdraw $currency}}
{{end}}

{{else}}
{{end}}