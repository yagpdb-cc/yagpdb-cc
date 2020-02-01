{{- /*
	This command manages suggestions. You can deny, approve, or comment on suggestions.

	Usage:

	-sa deny <id> [reason]
	-sa approve <id> [reason]
	-sa comment <id> <comment>

	Recommended trigger: Regex trigger with trigger `^-(sa|suggestion-?admin)`
*/ -}}

{{/* CONFIGURATION VARIABLES START - THIS SHOULD BE THE SAME IN ALL FILES */}}
{{ $suggestions := 671509095433371688 }} {{/* Suggestion channel ID */}}
{{ $colors := sdict
	"default" 0x0070BB
	"approved" 0x50C878
	"denied" 0xDC143C
}} {{/* Same as in other files, colors for the suggestion embed */}}
{{/* CONFIGURATION VARIABLES END */}}

{{ if .CmdArgs }}
	{{ $id := "" }}
	{{ $action := "" }}
	{{ $reason := "" }}
	{{ with reFindAllSubmatches `^(deny|comment|approve) (\d+) ?(.*)` (joinStr " " .CmdArgs) }}
		{{ $matches := index . 0 }}
		{{ $id = toInt64 (index $matches 2) }}
		{{ $action = index $matches 1 }}
		{{ $reason = index $matches 3 }}
	{{ end }}
	{{ $suggestionMsg := getMessage $suggestions $id }}
	{{ $valid := and $id $action $suggestionMsg }}
	{{ if and (eq $action "comment") (not $reason) }} {{ $valid = false }} {{ end }}
	{{ if $valid }}
		{{ $archived := false }}
		{{ $color := $colors.default }}
		{{ $title := "" }}
		{{ $fieldName := printf "Comment from %s" .User.String }}
		{{ if eq $action "approve" }}
			{{ $color = $colors.approved }}
			{{ $archived = true }}
			{{ $title = "Approved by %s" }}
			{{ $fieldName = "Reason:" }}
		{{ else if eq $action "deny" }}
			{{ $color = $colors.denied }}
			{{ $archived = true }}
			{{ $title = "Denied by %s" }}
			{{ $fieldName = "Reason:" }}
		{{ end }}
		{{ $suggestion := index $suggestionMsg.Embeds 0 }}
		{{ $embed := sdict
			"author" (sdict "name" $suggestion.Author.Name "icon_url" $suggestion.Author.IconURL)
			"description" $suggestion.Description
			"color" $color
			"fields" (cslice (sdict "name" $fieldName "value" (or $reason "*No reason provided.*")))
		}}
		{{ if $archived }}
			{{ $ups := 0 }}
			{{ $downs := 0 }}
			{{- range $suggestionMsg.Reactions -}}
				{{ $id := or .Emoji.ID 0 }}
				{{ if eq $id 524907425531428864 }} {{ $ups = .Count }}
				{{ else if eq $id 524907425032175638 }} {{ $downs = .Count }}
				{{ end }}
			{{- end -}}
			{{ $embed.Set "footer" (sdict "text" (printf "✔️ %d | ❌ %d " $ups $downs)) }}
			{{ deleteAllMessageReactions $suggestions $id }}
		{{ end }}
		{{ if $title }} {{ $embed.Set "title" (printf $title .User.String) }} {{ end }}
		{{ editMessage $suggestions $id (cembed $embed) }}
		Done!
	{{ else }}
		Sorry, the syntax for this command is `-sa <deny|approve|comment> <id> <reason>` (If you are commenting, reason is required).
	{{ end }}
{{ else }}
	Sorry, the syntax for this command is `-sa <deny|approve|comment> <id> <reason>` (If you are commenting, reason is required).
{{ end }}