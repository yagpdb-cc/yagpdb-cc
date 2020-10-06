{{/*
    This command sends a message to a specified channel when the user reacts to a specified message (e.g. a rolemenu) with a specified react.

    Recommended trigger: Reaction trigger.
    
*/}}

{{/* CONFIGURATION VALUES START */}}
{{ $rolemenu_message_id := ########### }} {{/* The message id of the rolemenu */}}
{{ $welcome_channel_id := ########### }} {{/* The channel to send a message to when the user reacts to the rolemenu with $emoji_name }}
{{ $emoji_name := "xxxxxx" }} {{/* The name of the emoji reaction that triggers the message */}}
{{/* CONFIGURATION VALUES END */}}

{{ if and (eq .Message.ID $rolemenu_message_id) (eq .Reaction.Emoji.Name $emoji_name) }} 

    {{ if .ReactionAdded }}

        {{ sendMessageNoEscape $welcome_channel_id (print "Insert your welcome message here") }}

    {{ end }}

{{ end }}
