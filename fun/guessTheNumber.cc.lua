{{/*
	This command is a game where users need to send numbers from 1 to 100. The winners win an amount of credits!

	Recommended trigger: Regex trigger with trigger .*
*/}}
{{/* CONFIGURATION VALUES START */}}
{{ $channel := replace-with-channel-id }} {{/* Channel ID where the game is played */}}
{{ $prize := replace-with-prize }} {{/* The number of credits if the user won */}}
{{ $db := "replace-with-db-name"}} {{/* The db name where the credits are stored  */}}
{{/* CONFIGURATION VALUES END */}}

{{ if eq .Channel.ID $channel }}
	{{ if not .ExecData }}
		{{ with reFindAllSubmatches `\d+` .Message.Content }}
    			{{ if (eq (toInt (dbGet 0 "NR").Value) (toInt (index (index  . 0) 0))) }}
    				{{ $r := dbIncr $.User.ID $db $prize }}
   				{{ sendMessage nil (cembed 
    				"title" "**We have a winner**" 
    				"description" (print "Congrats " $.User.Username " you won!\nFor prize you won **" $prize "** credits !\nNow you have **" (toInt (dbGet $.User.ID $db).Value) "** credits.\nThe number was **" ( toInt (dbGet 0 "NR").Value) "** \nAnother number will be generated shortly !")
    				"thumbnail" (sdict "url" "https://cdn.discordapp.com/attachments/656522874491895808/673899344033742848/lottery-png-4.png")
    				"color" 34749 )}}
				{{ execCC $.CCID $channel 10 (sdict "value" "true") }}
			{{ end }}
		{{ end }}
	{{ else }}
	{{ $x := randInt 100 }}
	{{ dbSet 0 "NR" $x }}
	{{ sendMessage nil (cembed 
	"title" "**NEW NUMBER**" 
	"description" (print "A new number has been generated!\nType numbers between **1** and **100**.\nIf you guess the number you win **" $prize "** credits!")
	"thumbnail" (sdict "url" "https://cdn.discordapp.com/attachments/656522874491895808/673899344033742848/lottery-png-4.png")
	"color" 14232643
	"image" (sdict "url" "https://cdn.discordapp.com/attachments/695780710752976998/696349442303066212/slotmachine_2.gif")) }}
	{{ end }}
{{ end }}
