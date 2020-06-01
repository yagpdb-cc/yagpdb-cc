{{$gEmoji:=`<:yag:277569741932068864>`}}

{{/*Code*/}}
{{$rEmoji:=reReplace `\A<|>\z` $gEmoji ""}}
{{$syntaxError:=0}}{{$CmdArgs:=cslice}}{{$StrippedMsg:=""}}{{$Cmd:=""}}{{$ExecData:=0}}
{{if not .ExecData}}{{$CmdArgs =.CmdArgs}}{{$StrippedMsg =reReplace `\A\s+|\s+\z` .StrippedMsg ""}}{{$Cmd =.Cmd}}
{{else if toInt .ExecData}}{{$ExecData =str .ExecData}}
{{else if eq (printf "%T" .ExecData) "string"}}
{{$args:=split .ExecData " "}}
{{if gt (len $args) 1}}
{{$StrippedMsg =reReplace `\A\s+|\s+\z` (joinStr " " (slice $args 1)) ""}}
{{$Cmd =index $args 0}}{{range (reFindAllSubmatches `\x60(.*?)\x60|"(.*?)"|(\S+)` $StrippedMsg)}}{{$CmdArgs =$CmdArgs.Append (or (index . 1) (index . 2) (index . 3))}}{{end}}{{$CmdArgs =$CmdArgs.StringSlice}}
{{end}}
{{end}}

{{if  not $ExecData}}

{{if gt (len $CmdArgs) 0}}
{{$subCmd:=lower (index $CmdArgs 0)}}
{{if or (gt (len $CmdArgs) 1) (eq $subCmd "list") (eq $subCmd "reroll")}}

{{if eq $subCmd "start"}}

{{$CmdArgs:=reReplace (print `(?i)\A` $subCmd `\s*`) $StrippedMsg ""}}
{{$maxP:=-1}}{{$maxW:=1}}{{$chan:=.Channel.ID}}{{$ID:=""}}
{{$uID:=toInt (currentTime.Sub (newDate 2019 10 10 0 0 0)).Seconds}}

{{with reFindAllSubmatches `(?i)-w (\d+)(?:\s+|\z)` $CmdArgs}}{{$CmdArgs =reReplace (index . 0 0) $CmdArgs ""}}{{$maxW =toInt (index . 0 1)}}{{end}}
{{with reFindAllSubmatches `(?i)-p (\d+)(?:\s+|\z)` $CmdArgs}}{{$CmdArgs =reReplace (index . 0 0) $CmdArgs ""}}{{$maxP =toInt (index . 0 1)}}{{end}}
{{with reFindAllSubmatches `(?i)(-c (?:<#)?(\d+)>?(?:\s+|$))` $CmdArgs}}{{$CmdArgs =reReplace (index . 0 0) $CmdArgs ""}}{{$chan =index . 0 2}}{{end}}

{{$temp:=split $CmdArgs  " "}}{{$duration:=toDuration (index $temp 0)}}{{$prize := ""}}
{{if gt (len $temp) 1}}{{$prize =joinStr " " (slice $temp 1)}}{{end}}
{{$prize =reReplace `\A\s+|\s+\z` $prize ""}}

{{if and ($duration)  ($prize)}}

{{if or (ge $maxP $maxW) (eq $maxP -1)}}

{{with (sendMessageNoEscapeRetID $chan cembed)}}
{{$ID =joinStr "" $chan .}}{{$giveawaySdict:=sdict "chan" $chan "count" 0 "ID" $ID "listID" "" "maxWinners"  $maxW "maxParticipants" $maxP "expiresAt" (currentTime.Add $duration) "prize" $prize "uID" $uID "host" $.User.Mention}}
{{addMessageReactions $chan . $rEmoji}}{{$desc:=print  `>>> **Prize : **` $prize "\n\n"}}
{{if gt $maxW 0}}{{$desc =print $desc "**Max Winners :** " $maxW }}{{end}}{{if gt $maxP 0}}{{$desc =print $desc "⠀⠀⠀⠀⠀**Max Participants :** " $maxP}}{{end}}
{{$desc =print $desc "\n\n**Hosted By :** " $.User.Mention "\n\n**React with " $gEmoji " to enter GiveAway **"}}{{editMessage $chan . (cembed "title" "🌟🌟**GiveAway Started !!**🌟🌟" "description"  $desc "color" 16763170 "footer" (sdict "text" (print "ID: " $uID " | GiveAway Ends " )) "timestamp" $giveawaySdict.expiresAt)}}

{{$dbData:=sdict (or (dbGet 7777 "giveaway_active").Value sdict)}}{{$dbData.Set $ID $giveawaySdict}}{{dbSet 7777 "giveaway_active" $dbData}}
{{$dbData =sdict (or (dbGet 7777 "giveaway_active_IDs").Value sdict)}}{{$dbData.Set (str $uID) $ID}}{{dbSet 7777 "giveaway_active_IDs" $dbData}}
{{scheduleUniqueCC $.CCID $chan $duration.Seconds $uID  $ID}}

{{else}}
**Invalid Channel !!**
{{end}}
{{else}}
**Error:** Max Winners cannot be more than Max Participants!!
{{end}}
{{else}}
**Error:** Invalid Duration or Prize !!
{{end}}

{{else if eq $subCmd "end"}}
{{$uID:=index $CmdArgs 1}}
{{with (dbGet 7777 "giveaway_active").Value}}
{{$ID:=index (dbGet 7777 "giveaway_active_IDs").Value $uID}}
{{with (index . (str $ID))}}{{cancelScheduledUniqueCC $.CCID .uID}}{{$s := sendTemplate .chan "g_end" "ID" (str $ID)}}

{{else}}
**Error:** Invalid ID ``{{$uID}}``
{{end}}
{{else}}
**Error:** No Active Giveaways.
{{end}}

{{else if eq $subCmd "cancel"}}
{{$uID:=index $CmdArgs 1}}{{$ID:=0}}

{{with (dbGet 7777 "giveaway_active").Value}}
{{$dbID:=(dbGet 7777 "giveaway_active_IDs").Value}}{{$ID =index $dbID $uID}}

{{with (index . (str $ID))}}
{{$chan:=.chan}}{{$prize:=.prize}}{{$host:=.host}}{{cancelScheduledUniqueCC $.CCID .uID}}{{$msg:=index ( split $ID (str $chan)) 1}}
{{with (getMessage $chan $msg )}}{{editMessage $chan $msg (cembed "title" "🌟🌟**GiveAway Cancelled !!**🌟🌟" "description" (print ">>> **Prize :** "  $prize "\n\n**Hosted By : **" $host) "footer" (sdict "text" "Giveaway Cancelled") "color" 12257822)}}{{end}}Done!

{{else}}
**Error:** Invalid ID ``{{$uID}}``
{{end}}

{{if $ID}}
{{$newdbData:=sdict .}}{{$newdbData.Del $ID}}{{dbSet 7777 "giveaway_active" $newdbData}}
{{$newdbData =sdict $dbID}}{{$newdbData.Del $uID}}{{dbSet 7777 "giveaway_active_IDs" $newdbData}}
{{end}}

{{else}}
**Error:** No Active Giveaways.
{{end}}

{{else if eq $subCmd "reroll"}}
{{$ID:=1}}
{{if gt (len $CmdArgs) 1}}{{$ID =toInt (index $CmdArgs 1)}}{{end}}{{$found:=false}}

{{if ($e:=(dbGet 7777 "giveaway_old").Value)}}
{{range $i,$v:=$e}}{{if or (eq (sub (len $e) $i) $ID) (eq (toInt $v.uID) $ID)}}{{$found =true}}{{$s:=sendTemplate $v.chan "g_end" "ID" (str $v.ID) "Data" $v}}{{end}}
{{end}}
{{if not $found}}**Error** - Invalid Argument `{{index $CmdArgs 1}}`. Old Giveaway with corresponding ID or Position(1-10) not found!{{end}}

{{else}}
**Error:** No Old Giveaways.
{{end}}

{{else if eq $subCmd "list"}}

{{with (dbGet 7777 "giveaway_active").Value}}
{{$count := 0}}
{{range $k , $v:=.}}{{$count =add $count 1}}
{{$count}}) **ID:** ``{{$v.uID}}``  **Prize:** ``{{$v.prize}}``
**Ends AT:** ``{{formatTime $v.expiresAt}}``
{{end}}

{{else}}
No Active Giveaways.
{{end}}

{{else}}
{{$syntaxError =1}}
{{end}}
{{else}}
{{$syntaxError =1}}
{{end}}
{{else}}
{{$syntaxError =1}}
{{end}}

{{else}}
{{$s:=sendTemplate nil "g_end" "ID" $ExecData}}
{{end}}

{{define "g_end"}}
{{$ID:=.TemplateArgs.ID}}{{$chan:=.Channel.ID}}{{$dbData:=or (dbGet 7777 "giveaway_active" ).Value (sdict (str $ID) .TemplateArgs.Data)}}

{{if $dbData}}
{{with (index $dbData $ID)}}
{{$countWinners:=toInt .maxWinners}}{{$count:=toInt .count}}

{{if lt $count $countWinners}}{{$countWinners = $count}}{{end}}
{{$msg:=index ( split $ID (str $chan)) 1}}{{$listID:=.listID}}

{{if and (gt $count .maxParticipants) (gt .maxParticipants 0)}}{{$count =.maxParticipants}}{{$listID =joinStr "," (slice (split $listID ",") 0 $count) ""}}{{end}}

{{$winnerList:=""}}
{{range seq 0 $countWinners}}{{$winner:=index (split $listID ",") (randInt 0 $count )}}{{$listID =reReplace (print $winner ",") $listID ""}}{{$count = add $count -1}}{{$winnerList =(print $winnerList "<@" $winner "> ")}}{{end}}

{{$desc:=print ">>> **Prize :** " .prize "\n\n**Winners :** "}}
{{if  $countWinners }}{{$desc =print $desc $winnerList}}{{else}}{{$desc =print $desc "No Participants :( "}}{{end}}
{{$desc:=print $desc "\n\n**Hosted By :** " .host}}
{{with (getMessage $chan $msg )}}{{editMessage $chan $msg (cembed "title" "🌟🌟**GiveAway Ended !!**🌟🌟" "description" $desc "footer" (sdict "text" "Giveaway Ended at ") "timestamp" currentTime "color" 12257822)}}{{end}}

{{if $countWinners}}{{sendMessage nil (print "**Prize :** " .prize "\n**Winner(s) :** " $winnerList)}}
{{else}}
**Giveaway Ended, No participants :( !!**
**Prize : {{.prize}}**
{{end}}

{{if not $.TemplateArgs.Data}}
{{$newdbData:=sdict $dbData}}{{$newdbData.Del $ID}}{{dbSet 7777 "giveaway_active" $newdbData}}
{{$newdbData =sdict (dbGet 7777 "giveaway_active_IDs").Value}}{{$newdbData.Del (str .uID)}}{{dbSet 7777 "giveaway_active_IDs" $newdbData}}
{{$old:= cslice.AppendSlice (or (dbGet 7777 "giveaway_old").Value cslice)}}{{if gt (len $old) 9}}{{$old =slice $old 1}}{{end}}{{dbSet 7777 "giveaway_old" ($old.Append .)}}
{{end}}

{{else}}`Warning:` Invoked CC : {{$.CCID}} using ExecCC with invalid Giveaway ID.
{{end}}
{{else}}`Warning:` Invoked CC : {{$.CCID}} using ExecCC with no active Giveaways.
{{end}}

{{end}}

{{if $syntaxError}}{{sendMessage nil (print "__**Incorrect Syntax** __ \n**Commands are :** \n```elm\n" ($Cmd) " start <time : Duration> <prize : String> \n\noptional_flags \n-p (max participants : Number) \n-w (max winners : Number)\n-c (channel : Mention/ID)\n```\n```elm\n" ($Cmd) " end <id : Number>```\n```elm\n" ($Cmd) " cancel <id : Number>```\n```elm\n" ($Cmd) " reroll [id or n giveaways old : Number]```\n```elm\n"  ($Cmd) " list ``` ")}}{{end}}
