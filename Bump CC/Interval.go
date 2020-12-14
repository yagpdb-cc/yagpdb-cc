{{/* 
	Trigger
		Interval - 10m
	
		Made by WickedWizard#3588
	
*/}}

{{$vcid := 783324374051848265}}{{/*Channel where the time remaining for next bump is displayed*/}}
{{$reminderchannel := 786145239466639360}} {{/*This should be same as the other file*/}}
{{if $db := dbGet 0 "Cooldown"}}
{{editChannelName $vcid (print "Next Bump in " (($db.ExpiresAt.Sub currentTime).Round .TimeSecond))}}
{{else}}
{{editChannelName $vcid (print "You can Bump Now")}}
{{$message := "<@&787355830399270963> 🔔 You can Bump again Now!"}} {{/*Update the RoleID. Make sure this is the same as Bump.gotmpl file.*/}}
{{$id := sendMessageNoEscapeRetID $reminderchannel $message}}
{{dbSet 1 "Bump" (str $id)}}
{{end}}
