{{/* Birthday CC
	This CC will allow the following:
		-mybirthday 20/12/1998
			The above command will set the users birthday to be that date, and the bot will congratulate them on that day.
			Note: syntax is day/month/year if you want it to be month/day/year set $invertedOrder to true
		-startbdays
			Use this command at the time you want the bot to send the birthday msgs.
			Example: if you use this at 1PM in your local time, the congratulations messages will always be sent at 1PM everyday.
			Optional duration flag: -startbdays 1h12m
			Using the command like that, the bday msg would be sent everyday at 1h and 12 minutes after this command was triggered.
		-stopbdays
			This will stop the bdays msgs from being sent
		-setbday
			This will set a targeted user birthday
			Example: -set 20/12/1998 @Pedro
		-getbday
			This will tell you the birthday of the specified user
			Example: -getbday @Pedro
	All commands can be used with bday or birthday. Example: -getbday or -getbirthday
	This code will also kick/ban users if they are under 13 years old, if you want it to.
	Change ONLY the user variables, dont change ANYTHING else
	$mods is the list of IDs of roles that should be able to use the start/stop/set/get commands.
	User can only set their birthday once. After that, only mods will be able to change a users birthday by using the -setbday command
	Trigger Type should be regex
	The actual trigger should be: \A-(my|start|stop|set|get)b(irth)?days?
*/}}

{{/* User Variables */}}
{{$mods := cslice 668707598870118403 673258482211749917}}
{{$channelID := 655082852295376922}} {{/* Channel ID of where the bdays msgs should be sent to */}}
{{$bdayMsg := "Congratulations for your birthday!!!"}}
{{$invertedOrder := false}}
{{$kickUnderAge := false}}
{{$banUnderAge := true}}
{{/* End Of User Variables */}}



{{/* ACTUAL CODE, DONT TOUCH */}}
{{/* Vars */}}
{{$isMod := false}}{{$map := ""}}{{$error := ""}}{{$day := 0}}{{$month := 0}}{{$year := 0}}{{$isUnderAge := false}}{{$isValidDate := false}}{{$user := .User}}{{$checkDate := ""}}{{$insideMap := sdict}}{{$list := cslice}}{{$out := ""}}{{$send := false}}{{$userMonth := ""}}{{$today := sdict}}{{$delay := 86400}}
{{$commonError := "Correct date syntax is day/month/year like: 20/12/1998"}}
{{$commonErrorInverted := "Correct date syntax is month/day/year like: 12/20/1998"}}

{{/* Checks */}}
{{range .Member.Roles}} {{if in $mods .}} {{$isMod = true}} {{end}} {{end}}
{{if not .ExecData}}
	{{if reFind `(?i)(my|set)b(irth)?days?` .Cmd}}
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
					{{with reFind `\d+ years` (humanizeTimeSinceDays $checkDate) | reFind `\d+` | toInt}}
						{{if lt . 13}} {{$isUnderAge = true}} {{end}}
					{{end}}
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

{{/* Doing stuff */}}
{{if and $isUnderAge $kickUnderAge (not $banUnderAge) (not $isMod)}} {{execAdmin "kick" $user "We do not allow users under 13 years old in this server."}} {{end}}
{{if and $isUnderAge $banUnderAge (not $isMod)}} {{execAdmin "ban" $user "We do not allow users under 13 years old in this server."}} {{end}}
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
	{{if and $send (not (dbGet currentTime.Day "bdayannounced"))}} {{dbSet currentTime.Day "bdayannounced" true}} {{sendMessageNoEscape nil $bdayMsg}} {{end}}
{{else}}
	{{if $isMod}}
		{{if and (reFind `set` .Cmd) $isValidDate (not $error)}}
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
		{{else if reFind `stop` .Cmd}}
			{{cancelScheduledUniqueCC .CCID "bdays"}}
			{{$out = "I will no longer congratulate people on their birthday."}}
		{{else if reFind `start` .Cmd}}
			{{with .CmdArgs}} {{with index . 0 | toDuration}} {{$delay = add $delay .Seconds}} {{end}} {{end}}
			{{if ne (currentTime.Add (mult 1000000000 $delay | toDuration)).Day ((currentTime.Add (mult 24 .TimeHour | toDuration)).Day)}} {{$error = "Too long delay to start sending bday messages. You can only set delays up to tommorrow at 00:00 UTC"}}
			{{else}}
				{{execCC .CCID $channelID 1 $delay}}
				{{$out = print "All set! Every day at **" ((currentTime.Add (mult 1000000000 $delay | toDuration)).Format "15:04 UTC") "** I will congratulate users if its their birthday."}}
			{{end}}
		{{else if reFind `get` .Cmd}}
			{{with .CmdArgs}}
				{{with index . 0 | userArg}}
					{{$user = .}}
					{{with (dbGet .ID "bday").Value}}
						{{if $invertedOrder}} {{$out = print "The bday of " $user.Mention " is " (.Format "01/02/2006")}}
						{{else}} {{$out = print "The bday of " $user.Mention " is " (.Format "02/01/2006")}}
						{{end}}
					{{else}}
						{{$error = "This user does not have a bday set."}}
					{{end}}
				{{else}}
					{{$error = "Correct usage: -getbday @user"}}
				{{end}}
			{{else}}
				{{$error = "Correct usage: -getbday @user"}}
			{{end}}
		{{end}}
	{{end}}
	{{if and (reFind `(?i)myb(irth)?day` .Cmd) $isValidDate (not $out)}}
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
{{end}}

{{/* Outputs */}}
{{with $error}} {{.}} {{end}}
{{with $out}} {{.}} {{end}}
