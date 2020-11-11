{{/*
	This command edits a given suggestion. Usage: `-editsuggestion <id> <new content>`. Only usable by author of suggestion.

	Recommended trigger: Regex trigger with trigger `\A-(edit-?(suggestion|sgt))`
*/}}

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
{{ $args := parseArgs 2 "**Syntax:** `-editsuggestion <id> <edited>`" (carg "int" "message id") (carg "string" "edited") }}
{{ $suggestion := getMessage $suggestions ($args.Get 0) }}
{{ if $suggestion }}
	{{ $suggestion = index $suggestion.Embeds 0 }}
	{{ $id := toInt64 (reFind `\d+` $suggestion.Footer.Text) }}
	{{ if ne $id .User.ID }}
		You cannot edit a suggestion that was not sent by you.
	{{ else if ne $suggestion.Color $colors.default }}
		That suggestion was already approved or denied.
	{{ else }}
		{{ $embed := cembed
			"author" (sdict "name" $suggestion.Author.Name "icon_url" $suggestion.Author.IconURL)
			"color" $colors.default
			"description" ($args.Get 1)
			"footer" (sdict "text" (joinStr "" "User ID: " .User.ID " | Edited at"))
			"timestamp" currentTime
		}}
		{{ editMessage $suggestions ($args.Get 0) $embed }}
		Successfully edited your suggestion in <#{{ $suggestions }}>!
	{{ end }}
{{ else }}
	Sorry, that was not a valid suggestion ID. Try again.
{{ end }}
