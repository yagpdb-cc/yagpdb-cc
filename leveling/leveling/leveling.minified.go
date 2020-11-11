{{$c:=cembed
"title" "🏆 Leveling"
"description" (joinStr "\n\n"
"`leveling use-default`: Use the default settings"
"`leveling set <key> <value>`: Sets the given settings to the value provided. Valid keys are \"min\", \"max\", and \"cooldown\" (duration)."
"`leveling set-channel <channel|none>`: Sets the channel where level up messages will be sent (defaults to current channel). If you want to make it the current channel, use `leveling set-channel none`."
"`leveling view`: Views the current settings."
)
"color" 14232643}}{{if .CmdArgs}}{{$d:=false}}{{$a:=sdict 
"min" 15 
"max" 25 
"cooldown" .TimeMinute}}{{with (dbGet 0 "xpSettings")}}{{$d =true}}{{$a =sdict .Value}}{{end}}{{if eq (index .CmdArgs 0) "use-default"}}{{$j:=dbSet 0 "xpSettings" $a}} 
Done! You are now using the default settings for the leveling system.

{{else if and (eq (index .CmdArgs 0) "set") (ge (len .CmdArgs) 3)}}{{$i:=index .CmdArgs 1}}{{$g:=slice .CmdArgs 2 | joinStr " "}}{{if in (cslice "min" "max" "cooldown") $i}}{{$f:=or (and (eq $i "cooldown") (toDuration $g)) (toInt $g)}}{{if not $f}} 
Please provide a valid value for the key `{{$i}}`.
{{else}}{{$a.Set $i $f}}{{if ge $a.min $a.max}} 
The minimum xp cannot be larger than or equal to the max xp.
{{else}}{{$j:=dbSet 0 "xpSettings" $a}} 
Successfully set the key `{{$i}}` to `{{$g}}`!
{{end}}{{end}}{{else}}
That was not a valid key. The only valid settings are "min", "max", and "cooldown".
{{end}}{{else if and (eq (index .CmdArgs 0) "set-channel") (ge (len .CmdArgs) 2)}}{{$h:=index .CmdArgs 1}}{{with reFindAllSubmatches `<#(\d+)>` $h}}{{$h =toInt64 (index . 0 1)}}{{end}}{{$e:=getChannel $h}}{{if $e}}{{$a.Set "channel" $e.ID}}{{$j:=dbSet 0 "xpSettings" $a}}
Successfully set channel to <#{{$e.ID}}>!
{{else if eq $h "none"}}{{$a.Del "channel"}}{{$j:=dbSet 0 "xpSettings" $a}}
Successfully set the channel for level up notifications to none.
{{else}}
That was not a valid channel. Try again.
{{end}}{{else if eq (index .CmdArgs 0) "view"}}{{$e:="*None set*"}}{{with $a.channel}}{{$e =printf "<#%d>" .}}{{end}}{{$b:=printf "**❯ Minimum XP:** %d\n**❯ Maximum XP:** %d\n**❯ Cooldown:** %s\n**❯ Level-up Channel:** %s"
$a.min
$a.max
(humanizeDurationSeconds ($a.cooldown | toDuration)) 
$e}}{{if $d}}{{sendMessage nil (cembed "title" "Level Settings" "description" $b "thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png"))}}{{else}}
This server has not set up the leveling system. Run `-leveling use-default` to use the default settings or customize it using `-leveling set <key> <value>`.
{{end}}{{else}}{{sendMessage nil $c}}{{end}}{{else}}{{sendMessage nil $c}}{{end}}
