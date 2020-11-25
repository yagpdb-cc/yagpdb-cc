{{/*
Originally published by @Jonas747#0001, regex fixed by (O1)#0001.

This command displays an embed with the contents of a linked discord message.
Usage: Paste a link to a Discord message.

Recommended trigger: Regex trigger with trigger `https?://(?:.+\.)?discord(?:app)?.com/channels\/(\d+)\/(\d+)\/(\d+)`
*/}}

{{ $matches := reFindAllSubmatches `https?://(?:.+\.)?discord(?:app)?.com/channels\/(\d+)\/(\d+)\/(\d+)` .Message.Content }} 
{{$msg := getMessage (index (index $matches 0) 2) (index (index $matches 0) 3) }}
{{if not $msg}}

{{else}}
{{ $avatar := (joinStr "" "https://cdn.discordapp.com/avatars/" (toString $msg.Author.ID) "/" $msg.Author ".png") }}

{{$embedRaw := sdict 
"description" (joinStr "" "**[Message Link](" (index (index $matches 0) 0) ")  to <#" $msg.ChannelID ">**\n" $msg.Content)
"color" 4645612 
"author" (sdict "name"  $msg.Author.Username "icon_url" ($msg.Author.AvatarURL "64")) 
"footer" (sdict "text" (joinStr "" "Req. by "  .Message.Author.Username ". Quote from ")) 
"timestamp" $msg.Timestamp  }}

{{if $msg.Attachments}}
{{$embedRaw.Set "image" (sdict "url" (index $msg.Attachments 0).URL) }}
{{end}}

{{ sendMessage nil (cembed $embedRaw) }}

{{/* delete the trigger if it only contained a link and nothing more */}}
{{if eq (len (index (index $matches 0) 0)) (len .Message.Content) }} {{deleteTrigger 1}} {{end}} 
{{end}}