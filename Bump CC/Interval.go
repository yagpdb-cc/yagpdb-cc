{{/*Update the IDs*/}}
{{$vcid := 774645677590446083}} {{/*Voice Channel which shows the Bump Time Remaining*/}}
{{$channelid := 774658131204505610}} {{/*Channel where Bump Notifications need to appear*/}}

{{/* Dont edit unless you know what you're doing. Better not edit, if you do, you need to change the Database and other things in the other CC's too*/}}
{{if $db := dbGet 0 "cooldown"}}
	{{editChannelName $vcid (print "Next Bump in " (($db.ExpiresAt.Sub currentTime).Round .TimeSecond))}}
{{else}}
{{$message := "<@&778219294986207232> 🔔 You can Bump again Now!"}} {{/*Update the RoleID*/}}
{{$id := sendMessageRetID $channelid $message}}
{{dbSet 1 "Bump" (str $id)}}
	{{editChannelName $vcid "Bump Now!"}}
{{end}}
