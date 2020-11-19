{{/*
  Trigger :- Starts with `!d bump`
  This command runs successfully if you bump at the right time
  Make sure to put all the CC's when you are sure that you can Bump Successfully with Disboard and then use `!d bump`
  */}}

{{$BumpXP := (dbGet .User.ID "BumpXP").Value}}
{{if dbGet 0 "cooldown"}}
HELP
{{deleteResponse 0}}
{{else}}
{{dbSetExpire 0 "cooldown" "Cooldown" 7200}}
{{$success := sendMessageRetID nil (cembed "title" "DISBOARD: The Public Server List" "url" "https://disboard.org/server/721592235359207545" "description" (print .User.Mention ", \nBump Done👍\n[Check it Here](https://disboard.org/server/721592235359207545) \nYou are bump level " $BumpXP) "color" 4229631  "image" (sdict "url" "https://i.imgur.com/PvJZE7j.png") "footer" (sdict "text" "React with 🔔 to configure your Bump Pings"))}}
{{addMessageReactions nil $success "🔔"}}
{{dbIncr .User.ID "BumpXP" 1}}
{{end}}
{{execAdmin "clean" 1}}
{{if $db := dbGet 1 "Bump"}}
{{editMessage 774658131204505610 (toInt (dbGet 1 "Bump").Value) "~~<@&778219294986207232> 🔔 You can Bump again Now!~~"}} {{/*Update the Channel and RoleID as usual*/}}
{{end}}
