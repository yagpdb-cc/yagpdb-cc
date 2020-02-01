{{- /*
	This command deletes a given suggestion. Usage: `-deletesuggestion <id>`.

	Recommended trigger: Regex trigger with trigger `^-delete-?(suggestion|sgt)`
*/ -}}

{{/* CONFIGURATION VARIABLES START - THIS SHOULD BE THE SAME IN ALL FILES */}}
{{ $suggestions := 671509095433371688 }} {{/* Suggestion channel ID */}}
{{ $colors := sdict
	"default" 0x0070BB
	"approved" 0x50C878
	"denied" 0xDC143C
}} {{/* Same as in other files, colors for the suggestion embed */}}
{{ $staff := 671951488083296267 }} {{/* Role ID of role that can delete suggestions from other people */}}
{{/* CONFIGURATION VARIABLES END */}}

{{ deleteTrigger 10 }}
{{ deleteResponse 10 }}
{{ $args := parseArgs 1 "**Syntax:** `-deletesuggestion <id> [-f|force]`" (carg "int" "message id") (carg "string" "force") }}
{{ $force := false }}
{{ if $args.IsSet 1 }}
	{{ $force = and (hasRoleID $staff) (in (cslice "-f" "--force") ($args.Get 1)) }}
{{ end }}
{{ $suggestion := getMessage $suggestions ($args.Get 0) }}
{{ if $suggestion }}
	{{ $suggestion = index $suggestion.Embeds 0 }}
	{{ $id := toInt64 (reFind `\d+` $suggestion.Footer.Text) }}
	{{ if and (ne $id .User.ID) (not $force) }}
		You cannot delete a suggestion that was not sent by you. (If you are staff, you may be looking for `-deletesuggestion <id> -force`).
	{{ else if eq $suggestion.Color $colors.approved }}
		That suggestion was approved, therefore you cannot delete it.
	{{ else }}
		{{ deleteMessage $suggestions ($args.Get 0) }}
		Successfully deleted suggestion in <#{{ $suggestions }}>!
	{{ end }}
{{ else }}
	Sorry, that was not a valid suggestion ID. Try again.
{{ end }}