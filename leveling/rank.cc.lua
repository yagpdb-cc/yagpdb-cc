{{/*
	This command manages viewing the rank of a given member.
	Use by running `-rank [member]` where member is optional. Defaults to yourself.
	You may also set a color for your rank card using `-rank set-color <hex>` or `-rank set-color default`.

	Recommended trigger: Regex trigger with trigger `\A(-|<@!?204255221017214977>\s*)(rank|lvl|xp)(\s+|\z)`.
*/}}
{{/* CONFIGURATION AREA STARTS */}}
{{ $rankcard := 1 }} {{/* set to `1` for a rank card */}}
{{ $background := "https://xbox-store-checker.com/assets/upload/game/2020/06/optimize/9n5qmw0x81jm-background.jpg" }}{{/* background for rankcard, dont edit if you dont use it */}}
{{/* CONFIGURATION AREA ENDS*/}}
{{/* Instantiate constants */}}
{{ $barEmpty := "□" }}
{{ $barFull := "■" }}
{{ $xp := 0 }} {{/* Xp of user */}}
{{ $color := 14232643 }} {{/* Embed color */}} 
{{ $user := .User }} {{/* Target user */}}
{{ $colorSet := false }}
{{ if (dbGet .User.ID "background") }}
{{ $background = ((dbGet .User.ID "background").Value) }} {{end}}

{{ with .CmdArgs }}
	{{ $temp := userArg (index . 0) }}
	{{ if $temp }}
		{{ $user = $temp }}
		{{ with dbGet $user.ID "xpColor" }} {{ $color = .Value }} {{ end }}
	{{ else if and (eq (index . 0) "set-color") (ge (len .) 2) }}
		{{ $colorSet = true }}
		{{ $multipliers := cslice 1048576 65536 4096 256 16 1 }}
		{{ $hex2dec := sdict "A" 10 "B" 11 "C" 12 "D" 13 "E" 14 "F" 15 }}
		{{ with reFindAllSubmatches `\A(?:#?default|([a-fA-F\d]{1,6}))\z` (joinStr " " (slice . 1)) }}
			{{ $hex := "D92C43" }}
			{{ with index . 0 1 }}
				{{ $hex = (printf "%06s" .) | upper }}
			{{ end }}
			{{ $dec := 0 }}
			{{ range $k, $v := split $hex "" -}}
				{{- $multiplier := index $multipliers $k }}
				{{- $num := or ($hex2dec.Get $v) $v}}
				{{- $dec = add $dec (mult $num $multiplier) -}}
			{{ end }}
			{{ dbSet $user.ID "xpColor" $dec }}
			{{ $user.Mention }}, I set your rank card color to `#{{ $hex }}`.
		{{ else }}
			Please provide a valid hex to set your rank card color to.
		{{ end }}
	{{ end }}
{{ end }}
{{ if not $colorSet }}
	{{/* Get the color for this user */}}
	{{ with dbGet $user.ID "xpColor" }} {{ $color = .Value }} {{ end }}
	{{ with dbGet $user.ID "xp" }}
		{{ $xp = .Value }}
	{{ end }} {{/* If XP is there, use that */}}

	{{ $level := roundFloor (mult 0.1 (sqrt $xp)) }} {{/* Calculate level */}}
	{{ $current := sub $xp (mult 100 $level $level) }} {{/* current XP for this level */}}
	{{ if lt (toInt $xp) 100 }}
		{{ $current = $xp }}
	{{ end }} {{/* If this level < level 1, use total XP as current */}}

	{{ $nextLvl := add $level 1 }} {{/* Next level */}}
	{{ $total := sub (mult 100 $nextLvl $nextLvl) (mult 100 $level $level) }} {{/* The total until next level */}}
	{{ $percentage := (mult (fdiv $current $total) 100) | roundFloor }} {{/* Start with percentage calculations */}}
	{{ $percentage = div $percentage 10 | toInt }} {{/* Percentage out of 10 */}}

	{{ $bar := "" }} {{/* The progress bar */}}
	{{- range seq 1 11 -}}
		{{ if ge $percentage . }} {{ $bar = joinStr "" $bar $barFull }} {{/* We join with full bar unicode if percentage > current iteration */}}
		{{ else }} {{ $bar = joinStr "" $bar $barEmpty }} {{ end }} {{/* Otherwise, join with empty bar */}}
	{{- end -}}

	{{ $embed := sdict 
		"title" (printf "❯ %s's Rank" $user.String)
		"color" $color
		"description" (printf 
			"❯ **%d / %d** XP\n❯ **Total:** %d\n❯ **Level:** %d\n❯ **Progress bar:**\n[**%s**](https://yagpdb.xyz)"
			(toInt $current) (toInt $total) (toInt $xp) (toInt $level) $bar)
	}} {{/* Format embed */}}

	{{ $rank := 0 }} {{/* Current rank of user */}}
	{{- range $index, $entry := dbTopEntries "xp" 100 0 -}} {{/* Loop over top 100 entries - see if user is in top 100 */}}
		{{ if eq .UserID $user.ID }} {{ $rank = add $index 1 }} {{ end }}
	{{- end -}}

	{{ if $rank }}
		{{ $embed.Set "description" (printf 
			"🏆 *Member of Top 100*\n\n❯ **Rank:** %d\n%s"
			$rank
			$embed.description
		) }} {{/* If user in top 100, update the description */}}
	{{ end }}
{{ if $rankcard}}
{{ if not $rank }} {{ $rank = urlescape "100" }} {{ end }}
{{ $username := urlescape ($user.Username) }}
{{ $pfp := ($user.AvatarURL "256") }}
	{{ sendMessage nil (cembed "color" 4645612 "image" (sdict "url" (print "https://vacefron.nl/api/rankcard?username=" $username "&avatar=" $pfp "&level=" $level "&rank=" $rank "&currentxp=" $current "&nextlevelxp=" $total "&previouslevelxp=0&custombg=" $background "&xpcolor=fc1d04"))) }} {{ else }}
	{{ sendMessage nil (cembed $embed) }}
{{ end }}
{{ end }}
