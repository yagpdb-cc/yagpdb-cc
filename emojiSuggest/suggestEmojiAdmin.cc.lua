{{/*
	This is a command for admins which can accept/deny the emojis using the shield (🛡️) emoji than press on check_mark (✅) or X (❌) to accept/reject :D
	
    Recommended trigger: Reaction trigger ONLY ADDED EMOJIS
*/}}
{{/* CONFIGURATION VALUES START */}}
{{ $roles := cslice roleids }} {{/* Replace with roleIDs  that will have perms to accept/deny emoji suggestions. */}}
{{/* CONFIGURATION VALUES END */}}

{{/* DONT TOUCH BELOW UNLESS YOU KNOW WHAT YOU DO */}}

{{ $allowed := false }}
{{ $embed := sdict }}
{{ $user := "" }}
    {{ range .Member.Roles }}
        {{ if in . $roles }}
        {{ $allowed = true }}
        {{ end }}
    {{ end }}
{{ if $allowed }}
	{{ $message :=  index .ReactionMessage.Embeds 0 }}
	{{ with reFindAllSubmatches `\d+` $message.Footer.Text }}
	{{ $user = userArg (index (index . 0) 0) }}
	{{ end }}
		{{ if eq .Reaction.Emoji.Name "🛡️" }}
			{{ addMessageReactions .Reaction.ChannelID .Reaction.MessageID "✅" "❌" }}
		{{ else if (eq .Reaction.Emoji.Name "✅") }}
			{{ deleteAllMessageReactions .Reaction.ChannelID .Reaction.MessageID }}
			{{ $embed.Set "color" 11403055 }}
			{{ $embed.Set "author" (sdict "name" $user.String "icon_url" ($user.AvatarURL "256")) }}
			{{ $embed.Set "image" (sdict "url" ($message.Image).ProxyURL) }}
			{{ $embed.Set "footer" (sdict "text" (print "User - " .User.ID "\nAccepted at" )) }}
			{{ $embed.Set "timestamp" currentTime }} 
			{{ editMessage .Reaction.ChannelID .Reaction.MessageID (cembed $embed) }}
		{{ else if (eq .Reaction.Emoji.Name "❌") }}
			{{ deleteAllMessageReactions .Reaction.ChannelID .Reaction.MessageID }}
			{{ $embed.Set "color" 12845619 }}
			{{ $embed.Set "author" (sdict "name" $user.String "icon_url" ($user.AvatarURL "256")) }}
			{{ $embed.Set "image" (sdict "url" ($message.Image).ProxyURL) }}
			{{ $embed.Set "footer" (sdict "text" (print "User - " .User.ID "\nRejected at" )) }}
			{{ $embed.Set "timestamp" currentTime }} 
			{{ editMessage .Reaction.ChannelID .Reaction.MessageID (cembed $embed) }}
		{{ end }}	
{{ end }}	
