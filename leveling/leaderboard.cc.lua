{{- /*
	This command manages the leaderboard. Usage is -leaderboard [page] where page is optional.

	Recommended trigger: Regex trigger with trigger `^-(leaderboard|lb|top)`.
*/ -}}
{{ $page := 1 }} {{/* Default page to start at */}}
{{ with reFind `\d+` (joinStr " " .CmdArgs) }} {{ $page = . | toInt }} {{ end }} {{/* If the user provided a page, change $page variable to that */}}
{{ $skip := mult (sub $page 1) 10 }} {{/* Amount of entries to skip */}}
{{ $users := dbTopEntries "xp" 10 $skip }} {{/* Retrieve the relevant DB entries with the parameters provided */}}
{{ if not (len $users) }}
	There were no users on that page! {{/* If there were no users, return */}}
{{ else }}
	{{ $rank := $skip }} {{/* Instantiate rank variable with value of $skip */}}
	{{ $display := "" }} {{/* The description for the leaderboard description */}}
	{{- range $users -}}
		{{ $xp := toInt .Value }} {{/* XP for this user entry */}}
		{{ $rank = add $rank 1 }} {{/* Increment rank variable */}}
		{{ $display = printf "%s\n• **%d.** [%s](https://yagpdb.xyz) :: Level %d (%d XP)"
			$display $rank .User.String (toInt (roundFloor (mult 0.1 (sqrt $xp)))) $xp
		}} {{/* Format this line */}}
	{{- end -}}
	{{ $id := sendMessageRetID nil (cembed
		"title" "❯ Leaderboard"
		"thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png")
		"color" 14232643
		"description" $display
		"footer" (sdict "text" (joinStr "" "Page " $page))
	) }} {{/* Construct and send the embed */}}
	{{ addMessageReactions nil $id "◀️" "▶️" }} {{/* Add reactions for pagination */}}
{{ end }}