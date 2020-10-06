{{/*
    This command assigns the user an additional role if they react to a message (e.g. a role menu), and removes it if they remove their reaction. For example, it can be used to add a role category separator: if the user reacts to a rolemenu to select a colour, it could add the 'Colours' role as a title.

    Recommended trigger: Reaction trigger.
*/}

{{/* CONFIGURATION VALUES START */}}
{{ $rolemenu_message_id := ########## }} {{/* The id of the message/rolemenu */}}
{{ $role_id := ########## }} {{/* The additional role to be given if the user reacts to the message/rolemenu  */}}
{{/* CONFIGURATION VALUES END */}} 

{{ if eq .Message.ID $rolemenu_message_id }}

    {{ if .ReactionAdded }}

        {{ addRoleID $role_id }}

    {{ else }}

        {{ removeRoleID $role_id }}

    {{ end }}

{{ end }}
