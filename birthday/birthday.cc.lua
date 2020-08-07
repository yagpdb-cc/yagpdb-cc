{{/* User Variables */}}
{{$mods := cslice 681482833944117250 740593852833857557}}
{{$channelID := 740588980919205999}} {{/* Channel ID to send the bday msgs */}}
{{$bdayMsg := "Congratulations for your birthday!"}}
{{$invertedOrder := false}}
{{$kickUnderAge := false}}
{{$banUnderAge := false}}
{{$moneytogiveonbday := 100}} {{/* Money To Give On Birthdays */}}
{{$moneyMsg := "Congratulations, You Gained "}} {{/* Money Msg To Send */}}
{{$moneyonbday := false}} {{/* Give Money OnBirthday? */}}
{{ $dbHandName := "HAND" }} {{/* Database Entry To Put Currency, The entries are: UserID+$dbHandName */}}
{{/* End */}}


{{/* DONT TOUCH */}}
{{/* Vars */}}
{{$isMod := false}}{{$map := ""}}{{$error := ""}}{{$day := 0}}{{$month := 0}}{{$year := 0}}{{$isUnderAge := false}}{{$isValidDate := false}}{{$user := .User}}{{$checkDate := ""}}{{$insideMap := sdict}}{{$list := cslice}}{{$out := ""}}{{$send := false}}{{$userMonth := ""}}{{$today := sdict}}{{$delay := 86400}}
{{$commonError := "Correct date syntax is: `dd/mm/yyyy` - Example: `20/12/1998`"}}
{{$commonErrorInverted := "Correct date syntax is: `mm/dd/yyyy` - Example: `12/20/1998`"}}
{{$synt := "Correct usage: -getbday @user"}}

{{/* Checks */}}
{{range .Member.Roles}} {{if in $mods .}} {{$isMod = true}} {{end}} {{end}}
{{if not .ExecData}}
	{{if reFind `(?i)(my|set)` .Cmd}}
		{{with .CmdArgs}}
			{{$map = split (index . 0) "/"}}
			{{if and (eq (len .) 2) $isMod}} {{with index . 1 | userArg}} {{$user = .}} {{else}} {{$error = "Invalid User."}} {{end}} {{end}}
		{{end}}
		{{with $map}}
			{{if eq (len .) 3}} {{$counter := 0}}
				{{$year := index . 2 | toInt}}
				{{if $invertedOrder}} {{$day = index . 1 | toInt}} {{$month = index . 0 | toInt}}
				{{else}} {{$day = index . 0 | toInt}} {{$month = index . 1 | toInt}}
				{{end}}
				{{with $day}} {{if or (gt . 31) (lt . 1)}} {{$error = print $error "\nInvalid Day."}} {{else}} {{$counter = add $counter 1}} {{end}} {{end}}
				{{with $month}} {{if or (gt . 12) (lt . 1)}} {{$error = print $error "\nInvalid Month."}} {{else}} {{$counter = add $counter 1}} {{end}} {{end}}
				{{if not $year}} {{$error = print $error "\nInvalid Year."}} {{else}} {{$counter = add $counter 1}} {{end}}
				{{$checkDate = newDate $year $month $day 0 0 0}}
				{{if and (eq $counter 3) (eq (printf "%d" $checkDate.Month) (str $month)) (eq (printf "%d" $checkDate.Day) (str $day)) (eq (printf "%d" $checkDate.Year) (str $year))}} {{$counter = add $counter 1}}
				{{else if (or (not $error) (eq $error "Invalid User."))}} {{$error = print $error "\nInvalid Date (usually day 31 on a 30 day month, or 29 of Feb in a non leap year)"}}
				{{end}}
				{{if eq $counter 4}} {{$isValidDate = true}}
					{{if lt ((currentTime.Sub $checkDate).Hours | toInt) 113880}} {{$isUnderAge = true}} {{end}}
				{{end}}
			{{else}}
				{{if $invertedOrder}} {{$error = $commonErrorInverted}}
				{{else}} {{$error = $commonError}}
				{{end}}
			{{end}}
		{{else}}
			{{if $invertedOrder}} {{$error = $commonErrorInverted}}
			{{else}} {{$error = $commonError}}
			{{end}}
		{{end}}
	{{end}}
{{end}}
{{if $isValidDate}}
	{{$userMonth = printf "%d" $checkDate.Month | toInt}}
	{{with (dbGet $userMonth "bdays").Value}}
		{{$insideMap = sdict .}}
	{{end}}
{{end}}

{{/* Work */}}
{{if and $isUnderAge $kickUnderAge (not $banUnderAge) (not $isMod)}} {{execAdmin "kick" $user "We do not allow users under 13 in this server."}} {{end}}
{{if and $isUnderAge $banUnderAge (not $isMod)}} {{execAdmin "ban" $user "We do not allow users under 13 in this server."}} {{end}}
{{with .ExecData}}
	{{if eq (printf "%T" .) "int64"}} {{scheduleUniqueCC $.CCID $channelID . "bdays" true}} {{end}}
	{{dbDel (currentTime.Add (mult -24 $.TimeHour | toDuration)).Day "bdayannounced"}}
	{{with (dbGet (printf "%d" currentTime.Month | toInt) "bdays").Value}} {{$today = sdict .}} {{end}}
	{{range (index $today (str currentTime.Day))}}
		{{if getMember .}}
			{{$bdayMsg = print $bdayMsg "\n<@" . ">"}}
			{{$send = true}}
		{{end}}
	{{end}}
	{{if and $send (not (dbGet currentTime.Day "bdayannounced"))}} {{dbSet currentTime.Day "bdayannounced" true}} {{if $moneyonbday}}{{$moneyMsg = print $moneyMsg $moneytogiveonbday " For Your Birthday"}}{{ $increasemoney := dbIncr $user.ID $dbHandName $moneytogiveonbday }} {{sendMessageNoEscape nil $moneyMsg}} {{end}} {{sendMessageNoEscape nil $bdayMsg}} {{end}}
{{else}}
	{{if $isMod}}
		{{if and (reFind `(?i)set` .Cmd) $isValidDate (not $error)}}
			{{if eq (len .CmdArgs) 2}}
				{{with $insideMap}}
					{{with index . (str $checkDate.Day)}} {{$list = $list.AppendSlice .}} {{end}}
					{{if not (in $list $user.ID)}}
						{{$list = $list.Append $user.ID}}
						{{.Set (str $checkDate.Day) $list}}
						{{dbSet $userMonth "bdays" $insideMap}}
					{{end}}
				{{else}}
					{{$list = $list.Append $user.ID}}
					{{$insideMap.Set (str $checkDate.Day) $list}}
					{{dbSet $userMonth "bdays" $insideMap}}
				{{end}}
				{{with (dbGet $user.ID "bday").Value}}
					{{if ne (print .) (print $checkDate)}}
						{{$listIn := cslice}}
						{{$thisDay := str .Day}} {{$thisMonth := printf "%d" .Month | toInt}}
						{{with sdict (dbGet (printf "%d" .Month | toInt) "bdays").Value}}
							{{$needMap := .}}
							{{range index . $thisDay}}
								{{if ne . $user.ID}}
									{{$listIn = $list.Append .}}
								{{end}}
							{{end}}
							{{$needMap.Set $thisDay $listIn}}
							{{dbSet $thisMonth "bdays" $needMap}}
						{{end}}
					{{else}}
						{{$error = print "This is already " $user.Mention "'s birthday."}}
					{{end}}
				{{end}}
				{{if not $error}}
					{{dbSet $user.ID "bday" $checkDate}}
					{{if $invertedOrder}} {{$out = print "The bday of " $user.Mention " was set to be " ($checkDate.Format "01/02/2006")}}
					{{else}} {{$out = print "The bday of " $user.Mention " was set to be " ($checkDate.Format "02/01/2006")}}
					{{end}}
				{{end}}
			{{else}}
				{{if $invertedOrder}} {{$error = "Not enough arguments passed.\nCorrect usage is: `-set 12/20/1998 @user`"}}
				{{else}} {{$error = "Not enough arguments passed.\nCorrect usage is: `-set 20/12/1998 @user`"}}
				{{end}}
			{{end}}
		{{else if reFind `(?i)stop` .Cmd}}
			{{cancelScheduledUniqueCC .CCID "bdays"}}
			{{$out = "I will no longer congratulate people on their birthday."}}
		{{else if reFind `start` .Cmd}}
			{{with .CmdArgs}} {{with index . 0 | toDuration}} {{$delay = add $delay .Seconds}} {{end}} {{end}}
			{{if or (ne (currentTime.Add (mult 1000000000 $delay | toDuration)).Day ((currentTime.Add (mult 24 .TimeHour | toDuration)).Day)) (ge $delay 172800)}} {{$error = "Too long delay to start sending bday messages. You can only set delays up to tommorrow at 00:00 UTC"}}
			{{else}}
				{{execCC .CCID $channelID 1 $delay}}
				{{$out = print "All set! Every day at **" ((currentTime.Add (mult 1000000000 $delay | toDuration)).Format "15:04 UTC") "** I will congratulate users if its their birthday."}}
			{{end}}
		{{else if reFind `(?i)get` .Cmd}}
			{{with .CmdArgs}}
				{{with index . 0 | userArg}}
					{{$user = .}}
					{{with (dbGet .ID "bday").Value}}
						{{if $invertedOrder}} {{$out = print "The bday of " $user.Mention " is " (.UTC.Format "01/02/2006")}}
						{{else}} {{$out = print "The bday of " $user.Mention " is " (.UTC.Format "02/01/2006")}}
						{{end}}
					{{else}}
						{{$error = "This user does not have a bday set."}}
					{{end}}
				{{else}}
					{{$error = $synt}}
				{{end}}
			{{else}}
				{{$error = $synt}}
			{{end}}
		{{end}}
	{{end}}
	{{if and (reFind `(?i)my` .Cmd) $isValidDate (not $out) (or (and (or $kickUnderAge $banUnderAge) (not $isUnderAge)) (and (not $kickUnderAge) (not $banUnderAge)))}}
		{{if not (dbGet .User.ID "bday")}}
			{{with $insideMap}}
				{{with index . (str $checkDate.Day)}} {{$list = $list.AppendSlice .}}  {{end}}
				{{if not (in $list $user.ID)}}
					{{$list = $list.Append $user.ID}}
					{{.Set (str $checkDate.Day) $list}}
					{{dbSet $userMonth "bdays" $insideMap}}
				{{end}}
			{{else}}
				{{$list = $list.Append $user.ID}}
				{{$insideMap.Set (str $checkDate.Day) $list}}
				{{dbSet $userMonth "bdays" $insideMap}}
			{{end}}
			{{dbSet .User.ID "bday" $checkDate}}
			{{if $invertedOrder}} {{$out = print "Your birthday was set to be " ($checkDate.Format "01/02/2006")}}
			{{else}} {{$out = print "Your birthday was set to be " ($checkDate.Format "02/01/2006")}}
			{{end}}
		{{else}}
			{{$error = "Your birthday has already been set."}}
		{{end}}
	{{end}}
	{{if and (reFind `(?i)del` .Cmd)}}
		{{$user := .User}} {{with .CmdArgs}} {{with index . 0 | userArg}} {{if $isMod}} {{$user = .}} {{end}} {{else}} {{$error = print $error "\nInvalid user."}} {{end}} {{end}}
		{{with (dbGet $user.ID "bday").Value}}
			{{dbDel $user.ID "bday"}}
			{{$listIn := cslice}}
			{{$thisDay := str .Day}} {{$thisMonth := printf "%d" .Month | toInt}}
			{{with sdict (dbGet (printf "%d" .Month | toInt) "bdays").Value}}
				{{$needMap := .}}
				{{range index . $thisDay}}
					{{if ne . $user.ID}}
						{{$listIn = $list.Append .}}
					{{end}}
				{{end}}
				{{$needMap.Set $thisDay $listIn}}
				{{dbSet $thisMonth "bdays" $needMap}}
			{{end}}
			{{$out = print "Successfully deleted the birthday from " $user.String}}
		{{else}}
			{{$error = print $user.String "doesnt have a birthday set."}}
		{{end}}
	{{end}}
{{end}}

{{/* Outs */}}
{{with $error}} {{.}} {{end}}
{{with $out}} {{.}} {{end}}
