{{- /*
	This command allows users to suggest suggestions for your server. Usage: `-suggest <suggestion>`.

	Recommended trigger: Command trigger with trigger `suggest`
*/ -}}

{{/* CONFIGURATION VARIABLES START - THIS SHOULD BE THE SAME IN ALL FILES */}}
{{ $suggestions := 671509095433371688 }} {{/* Suggestion channel ID */}}
{{ $colors := sdict
	"default" 0x0070BB
	"approved" 0x50C878
	"denied" 0xDC143C
}} {{/* Same as in other files, colors for the suggestion embed */}}
{{/* CONFIGURATION VARIABLES END */}}

{{ deleteTrigger 10 }}
{{ deleteResponse 10 }}
{{ $attachment := "" }}
{{ with .Message.Attachments }} {{ $attachment = (index . 0).ProxyURL }} {{ end }}
{{ if .StrippedMsg }}
	{{ $id := sendMessageRetID $suggestions (cembed
		"author" (sdict "name" (printf "Suggestion from %s" .User.String) "icon_url" (.User.AvatarURL "256"))
		"color" $colors.default
		"description" .StrippedMsg
		"footer" (sdict "text" (joinStr "" "User ID: " .User.ID))
		"timestamp" currentTime
		"image" (sdict "url" $attachment)
	) }}
	{{ addMessageReactions $suggestions $id "upvote:524907425531428864" "downvote:524907425032175638" }}
	Successfully sent your suggestion to <#{{ $suggestions }}>!
{{ else }}
	You need to provide something to suggest with `-suggest <suggestion>`.
{{ end }}