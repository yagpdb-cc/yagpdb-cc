{{/*
Made by: Crenshaw#1312

Trigger Type: Regex
Trigger: .*
		
Note: read the other file for more info :)
~~~
Note: ONLY ALLOW THIS TO RUN IN ONE CHANNEL (this should be your suggestion chanel)
Note: Allow people to type in your suggestion channel
~~~
Note: You can change your upvote/downvote in line 75 (on Github)
*/}}

{{{/* CONFIGURATION VAlUES START*/}}
{{ $color := 0x4B0082 }} {{/* 0x(Hex code)*/}}
{{ $autoDel := 300 }} {{/* delete suggestions after X seconds, 0 to dissable*/}}
{{/* CONFIGURATION VALUES END*/}}
 
{{ if .ExecData.Key }}
	{{ if (dbGet 0 .ExecData.Key).ExpiresAt }}
		{{ deleteMessage nil .ExecData.ID 0 }}
		{{ dbDel 0 (print "sugs|" .ExecData.sugCount) }}
	{{ end }}
{{ else }}
 
	{{ if and (not (reFind `\A-s(ug|uggestion)?\s?\w+` .Cmd)) }}
		{{/* Getting suggestion number*/}}
		{{ $sugCount := 0 }}
		{{ if ($s := (dbGet 0 "sugCount").Value) }}
			{{ $sugCount = add 1 $s }}
			{{ $_ := dbIncr 0 "sugCount" 1}}
		{{ else }}
			{{ dbSet 0 "sugCount" 1 }}
			{{ $sugCount = 1 }}
		{{ end }}
 
		{{ $embed := sdict 
	  		"Author" (sdict "Icon_URL" (.User.AvatarURL "256") "Name" .User.String)
			"Title" (print "Suggestion #" $sugCount)
			"Description" .Cmd
	      	"Fields" (cslice)
			"Color" $color
			"Timestamp" currentTime
			"Footer" (sdict "Text" "Suggested")
	 	}}
 
	{{/* getImages.cc.lua, edited*/}}
	  {{ $filegex := `https?://(?:\w+\.)?[\w-]+\.[\w]{2,3}(?:\/[\w-_.]+)+\.(png|jpe?g|gif|webp|mp4|mkv|mov|wav)` }}
	  {{ $attachLinks := cslice }}
		{{ range .Message.Attachments }}
	    	{{- if reFind $filegex .URL -}}
				{{ $attachLinks = $attachLinks.Append .URL }}
	    	{{ end }}
		{{ end }}
 
		{{ $links := $attachLinks.AppendSlice (reFindAll $filegex .Message.Content) }}
		{{ range $i,$v := $links }}
			{{ $name := reFind `/[^/]+$` $v }} {{ $name = slice $name 1 }}
			{{ if reFind `(?:png|jpg|jpeg|gif|webp|tif)$` $v }}
				{{ $embed.Set "Image" (sdict "url" $v) }}
			{{ end }}
			{{ $val := print (add $i 1) " **»** [" $name "](" $v ")" }}
			{{ if eq 1 (len $embed.Fields) }}
				{{ (index $embed.Fields 0).Set "Value" (print (index $embed.Fields 1).Value "\n" $val) }}
			{{ else }}
				{{ $embed.Set "Fields" (cslice 
						(sdict "Name" "Attachments" "Value" $val "Inline" false)
				) }}
			{{ end }}
		{{ end }}
	
		{{/* Sending the embed*/}}
		{{ $sugID := sendMessageRetID nil (cembed $embed) }}
		{{ editMessage nil $sugID .User.Mention }}
		{{ addMessageReactions nil $sugID "✅" "❎" }}
	
		{{/* autoDel*/}}
		{{ if $autoDel }}
			{{ dbSet 0 (print "sugs|" $sugCount) (toString $sugID) }}
			{{ scheduleUniqueCC .CCID .Channel.ID $autoDel $sugCount (sdict "sugCount" $sugCount "Key" (print "sugs|" $sugCount) "ID" $sugID) 	}}
		{{ else }}
			{{ dbSet 0 (print "sugs|" $sugCount) (toString $sugID) }}
		{{ end }}
 
		{{ deleteTrigger 1 }}
	{{ end }}
{{ end }}
