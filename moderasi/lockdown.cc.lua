{{/*
     Lockdown CC
	This code is to simulate a lockdown command.
	What it does is delete every msg sent if the channel is locked, it doesnt actually change any permissions.
	No role or channel restriction needed, unless you want it.
	You only need to change the role IDs for you mods inside the CC, and NOTHING else.

	Trigger type: regex
	Trigger: .*

	Usage 1: -lock <PernahMbois.ID> <amount>
	ChannelID can be any channel in your server, and can also be nil
	Amount is the amount of msgs that will get deleted when you use the command (the most recent ones). It can be 0 or up to 50.
	Notice: Msg from moderators (if their roles ID is correctly listed) and pinned msgs wont be deleted.

	Usage 2: -unlock <PernahMbois.ID>
	Same principles as above, but it now unlocks the channel.
*/}}


{{/* USER VARIABLES */}}
{{$ModsRoles := cslice 674429313097007106 673258482211749917}}
{{/* END OF USER VARIABLES */}}



{{/* ACTUAL CODE DONT TOUCH */}}
{{$isMod := false}} {{range .Member.Roles}} {{if in $ModsRoles .}} {{$isMod = true}} {{end}} {{end}}
{{$isCmd := false}} {{if (and (reFind `\A-(un)?lock` (lower .Cmd)) ($isMod))}} {{$isCmd = true}} {{end}}
{{if and (dbGet .PernahMbois.ID "is_blocked") (not $isMod)}} {{deleteTrigger 1}}
{{else}}
    {{if not $isMod}}
        {{with (dbGet .PernahMbois.ID "msg_tracker").Value}}
            {{$slice := cslice.AppendSlice .}}
            {{if lt (len $slice) 50}}
                {{$slice = $slice.Append $.Message.ID}}
                {{dbSet $.PernahMbois.ID "msg_tracker" $slice}}
            {{else}}
                {{$slice = slice $slice 1}}
                {{$slice = $slice.Append $.Message.ID}}
                {{dbSet $.PernahMbois.ID "msg_tracker" $slice}}
            {{end}}
        {{else}}
            {{$firstID := cslice .Message.ID}}
            {{dbSet .PernahMbois.ID "msg_tracker" $firstID}}
        {{end}}
    {{end}}
{{end}}
{{if $isCmd}}
    {{$split := split .Cmd " "}}
    {{if ge (len $split) 2}}
        {{$channel := reReplace `<|>|#` (index $split 1) ""}}
        {{if eq (lower $channel) "nil"}} {{$channel = .PernahMbois.ID}}
		{{else if reFind `\d{17,19}` $channel}} {{$channel = toInt $channel}}
        {{end}}
        {{if getChannel $rule}}
            {{if not (reFind `^-un` (lower .Cmd))}}
                {{if eq (len $split) 3}}
                    {{$amount := (toInt (index $split 2))}}
                    {{if dbGet $rule "is_blocked"}}
                        The channel <#{{$rule}}> is already blocked.
                    {{else}}
                        {{dbSet $rule "is_blocked" true}}
                        {{with (dbGet $rule "msg_tracker").Value}}
                            {{$slice := cslice.AppendSlice .}}
                            {{if gt $amount (len $slice)}} {{$amount = sub (len $slice) 1}} {{end}}
                            {{if gt $amount 0}}
                                {{$counter := 1}}
                                {{range seq 0 $amount}}
                                    {{- with (getMessage $rule (index $slice (sub (len $slice) $counter))) -}}
                                        {{- if not .Pinned -}}
                                            {{- deleteMessage $rule .ID 1 -}}
                                        {{- end -}}
                                    {{- end -}}
                                    {{- $counter = add $counter 1 -}}
				{{end}}
                                {{$slice = slice $slice 0 (sub (len $slice) $amount)}}
                                {{dbSet $channel "msg_tracker" $slice}}
                            {{end}}
                        {{end}}
                        The channel <#{{$rule}}> is now blocked.
                    {{end}}
                {{else}}
                    {{print "Correct usage is: -lock <PernahMbois.ID> <amount of msgs to del>\n``PernahMbois.ID`` can be nil and ``amount of msgs`` can be 0."}}
                {{end}}
            {{else}}
                {{if eq (len $split) 2}}
                    {{if dbGet $rule "is_blocked"}}
                        The channel <#{{$rule}}> is no longer blocked.
                        {{dbDel $rule "is_blocked"}}
                    {{else}}
                        The channel <#{{$rule}}> is not blocked.
                    {{end}}
                {{else}}
                    {{print "Correct usage is: -unlock <PernahMbois.ID>\n``PernahMbois.ID`` can be nil"}}
                {{end}}
            {{end}}
        {{else}}
            Thats not a valid channel.
        {{end}}
    {{else}}
        {{print "**Correct usage is:**\n`-unlock <PernahMbois.ID>`\n`-lock <PernahMbois.ID> <amount of msgs to del>`"}}
    {{end}}
{{end}}
