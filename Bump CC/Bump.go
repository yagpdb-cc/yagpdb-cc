{{/*
  Trigger :- Starts with `!d bump`
  This command runs successfully if you bump at the right time
  Make sure to put all the CC's when you are sure that you can Bump Successfully with Disboard and then use `!d bump`
  */}}

{{/* Configuration Values */}}
{{$channel := 774658131204505610}} {{/*Channel where Bump Notification needs to appear*/}}
{{$success := sendMessageRetID nil (cembed "title" "DISBOARD: The Public Server List" "url" "https://disboard.org/server/721592235359207545" 
  	"description" (print .User.Mention ", \nBump Done👍\n[Check it Here](https://disboard.org/server/721592235359207545) \nYou are bump level " $BumpXP) 
    	"color" 4229631  "image" (sdict "url" "https://i.imgur.com/PvJZE7j.png") 
      	"footer" (sdict "text" "React with 🔔 to configure your Bump Pings"))}} {{/* You can change the Bump Message if you know what you're doing */}}
				{{/* Update the URL's to your Server URL's*/}}
{{/*Configuration Values End */}}

{{$BumpXP := (dbGet .User.ID "BumpXP").Value}}
{{if dbGet 0 "Cooldown"}}
	HELP
		{{deleteResponse 0}}
{{else}}
	{{sendMessage nil "You're next level is..........Check it yourself man, I'm too lazy to code \nLOL"}}
		{{dbSetExpire 0 "cooldown" "Cooldown" 7200}}
			{{addMessageReactions nil $success "🔔"}}
				{{execAdmin "clean" 1}}{{/* Optional Part, to delete the Bump Message sent by Disboard. Remove if not needed*/
				Sometimes, may lead to your `{{sendMessage nil "You're next level is........}}` Part to get deleted, so be careful with this statement.}}
{{if $db := dbGet 1 "Bump"}}
		{{editMessage $channel (toInt (dbGet 1 "Bump").Value) "~~<@&778219294986207232> 🔔 You can Bump again Now!~~"}}{{/* Update the ROLEID*/}}
{{end}}
{{end}}
