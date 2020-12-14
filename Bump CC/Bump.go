{{*/
    
  Usage `!d bump/lb/rank`
  Recommended trigger: `!d`
	Trigger type: Regex
  Credits: WickedWizard#3588  
  Please read through the code properly and try to learn, rather than copying
  
  */}}

{{/*Configuration Variables Start*/}}
{{$url := "https://disboard.org/server/721592235359207545"}} {{/*Your Servers Disboard URL*/}}
{{$BumpXP := dbGet .User.ID "BumpXP"}}
{{$reminderchannel := 786145239466639360}}{{/*Channel ID where Remainders are to be sent every hour*/}}
{{$bumprole := 787355830399270963}}
{{/*Configuration Values End*/}}

{{$args := parseArgs 1 "" (carg "string" "Function Type")}}
{{if eq ($args.Get 0) "bump"}}
    {{if $cooldown := dbGet 0 "Cooldown"}}
        HELP
        {{deleteResponse 0}}
    {{else}}
        {{sleep 1}}
        {{execAdmin "clean" 1}}
        {{dbSetExpire 0 "Cooldown" "Cooldown" 60}}
        {{$success := sendMessageRetID nil (cembed "title" "DISBOARD: The Public Server List" "url" $url "description" (print .User.Mention ", \nBump Done👍\n[Check it Here](" $url ") \nYou are bump level " $BumpXP.Value) "color" 4229631  "image" (sdict "url" "https://i.imgur.com/PvJZE7j.png") "footer" (sdict "text" "React with 🔔 to configure your Bump Pings"))}}
        {{addMessageReactions nil $success "🔔"}}
        {{$t1 := dbIncr .User.ID "BumpXP" 1}}
        {{editMessage $reminderchannel (toInt (dbGet 1 "Bump").Value) "~~<@&787355830399270963> 🔔 You can Bump again Now!~~"}} {{/*Update the RoleID here*/}}
    {{end}}
{{else if eq ($args.Get 0) "lb"}}
        {{$rank := 0}}
        {{$list:=""}}
{{range dbTopEntries "BumpXP" 10 0}}
        {{ $rank = add $rank 1 }}
        {{- $list =print $list "**" $rank ".** " .User.Username "** - **" .Value "\n" -}}
    {{end}}
        {{$s := sendMessage nil (cembed "title" (joinStr "" "🏆Bumping LeaderBoard for" .Guild.Name "") "description" $list)}}
    {{else if eq ($args.Get 0) "rank"}}
Your Bump Level is {{$BumpXP.Value}}.
    {{end}} 
