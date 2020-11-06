{{/* USER VARIABLES */}}
{{$ModsRoles := cslice 674429313097007106 673258482211749917}}
{{/* END OF USER VARIABLES */}}



{{/* ACTUAL CODE DONT TOUCH */}}
{{$isMod := false}} {{range .Member.Roles}} {{if in $ModsRoles .}} {{$isMod = true}} {{end}} {{end}}
{{$isCmd := false}} {{if (and (reFind `\A-(un)?lock` (lower .Cmd)) ($isMod))}} {{$isCmd = true}} {{end}}
{{if and (dbGet .Channel.ID "is_blocked") (not $isMod)}} {{deleteTrigger 1}}
{{else}}
    {{if not $isMod}}
        {{with (dbGet .Channel.ID "msg_tracker").Value}}
            {{$slice := cslice.AppendSlice .}}
            {{if lt (len $slice) 50}}
                {{$slice = $slice.Append $.Message.ID}}
                {{dbSet $.Channel.ID "msg_tracker" $slice}}
            {{else}}
                {{$slice = slice $slice 1}}
                {{$slice = $slice.Append $.Message.ID}}
                {{dbSet $.Channel.ID "msg_tracker" $slice}}
            {{end}}
        {{else}}
            {{$firstID := cslice .Message.ID}}
            {{dbSet .Channel.ID "msg_tracker" $firstID}}
        {{end}}
    {{end}}
{{end}}
{{if $isCmd}}
    {{$split := split .Cmd " "}}
    {{if ge (len $split) 2}}
        {{$channel := reReplace `<|>|#` (index $split 1) ""}}
        {{if eq (lower $channel) "nil"}} {{$channel = .Channel.ID}}
		{{else if reFind `\d{17,19}` $channel}} {{$channel = toInt $channel}}
        {{end}}
        {{if getChannel $channel}}
            {{if not (reFind `^-un` (lower .Cmd))}}
                {{if eq (len $split) 3}}
                    {{$amount := (toInt (index $split 2))}}
                    {{if dbGet $channel "is_blocked"}}
                        The channel <#{{$channel}}> is already blocked.
                    {{else}}
                        {{dbSet $channel "is_blocked" true}}
                        {{with (dbGet $channel "msg_tracker").Value}}
                            {{$slice := cslice.AppendSlice .}}
                            {{if gt $amount (len $slice)}} {{$amount = sub (len $slice) 1}} {{end}}
                            {{if gt $amount 0}}
                                {{$counter := 1}}
                                {{range seq 0 $amount}}
                                    {{- with (getMessage $channel (index $slice (sub (len $slice) $counter))) -}}
                                        {{- if not .Pinned -}}
                                            {{- deleteMessage $channel .ID 1 -}}
                                        {{- end -}}
                                    {{- end -}}
                                    {{- $counter = add $counter 1 -}}
				{{end}}
                                {{$slice = slice $slice 0 (sub (len $slice) $amount)}}
                                {{dbSet $channel "msg_tracker" $slice}}
                            {{end}}
                        {{end}}
                        The channel <#{{$channel}}> is now blocked.
                    {{end}}
                {{else}}
                    {{print "Correct usage is: -lock <channelID> <amount of msgs to del>\n``ChannelID`` can be nil and ``amount of msgs`` can be 0."}}
                {{end}}
            {{else}}
                {{if eq (len $split) 2}}
                    {{if dbGet $channel "is_blocked"}}
                        The channel <#{{$channel}}> is no longer blocked.
                        {{dbDel $channel "is_blocked"}}
                    {{else}}
                        The channel <#{{$channel}}> is not blocked.
                    {{end}}
                {{else}}
                    {{print "Correct usage is: -unlock <channelID>\n``ChannelID`` can be nil"}}
                {{end}}
            {{end}}
        {{else}}
            Thats not a valid channel.
        {{end}}
    {{else}}
        {{print "**Correct usage is:**\n`-unlock <channelID>`\n`-lock <channelID> <amount of msgs to del>`"}}
    {{end}}
{{end}}
