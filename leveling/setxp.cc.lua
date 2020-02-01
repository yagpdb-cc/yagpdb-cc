{{- /*
	Sets XP or level of user.

	Usage:

	-setxp <user> <xp>
	-setlevel <user> <level>

	Recommended trigger: Regex trigger with trigger `^-(set-?(xp|level))`
*/ -}}
{{ $cmd := reFind `(?i)xp|level` .Cmd }} {{/* The type of command used */}}
{{ $user := 0 }} {{/* Target user */}}
{{ $newLvl := 0 }} {{/* Whether user leveled up with these changes */}}
{{ with .CmdArgs }} {{ $user = index . 0 | userArg }} {{ end }} {{/* We try to resolve user from arguments given */}}
{{ if and (eq $cmd "level") (eq (len .CmdArgs) 2) }}
	{{ $level := index .CmdArgs 1 | toInt }} {{/* The new level */}}
	{{ if and $level $user }}
		{{ $calculated := mult 100 (mult $level $level) }} {{/* Calculate XP for this level */}}
		{{ $s := dbSet $user.ID "xp" $calculated }} {{/* Update db */}}
		{{ $newLvl = $level }} {{/* As user leveled up, we change newLvl */}}
		{{ printf "Successfully set **%s**'s level to %d!" $user.String $level }}
	{{ else }}
		The syntax for this command is `-setlevel <user> <level>`. 
	{{ end }}
{{ else if eq (len .CmdArgs) 2 }}
	{{ $xp := index .CmdArgs 1 | toInt }} {{/* The new XP */}}
	{{ if and $xp $user }}
		{{ $oldXp := 0 }} {{/* Old XP */}}
		{{ with (dbGet $user.ID "xp") }} {{ $oldXp = .Value }} {{ end }} {{/* Update old xp with db entry */}}
		{{ $oldLvl := roundFloor (mult 0.1 (sqrt $oldXp)) }} {{/* Calculate old level */}}
		{{ $s := dbSet $user.ID "xp" $xp }} {{/* Silence the dbSet */}}
		{{ $updatedLvl := roundFloor (mult 0.1 (sqrt $xp)) }} {{/* Calculate updated level */}}
		{{ if ne $oldLvl $updatedLvl }} {{ $newLvl = $updatedLvl }} {{ end }} {{/* If level was updated, update newLvl */}}
		{{ printf "Successfully set **%s**'s XP to %d!" $user.String $xp }}
	{{ else }}
		The syntax for this command is `-setxp <user> <xp>`.
	{{ end }}
{{ end }}
{{/* Handle leveling up | Basically the same as whats in the message listener, so if you are curious look at that */}}
{{ if $newLvl }}
	{{ $roleRewards := sdict "type" "stack" }}
	{{ with dbGet 0 "roleRewards" }} {{ $roleRewards = sdict .Value }} {{ end }}
	{{ $type := $roleRewards.type }}
	{{ $toAdd := or ($roleRewards.Get (json $newLvl)) 0 }}
	{{ range $level, $reward := $roleRewards }}
		{{ if and (ge (toInt $newLvl) (toInt $level)) (not (hasRoleID $reward)) (eq $type "stack") (ne $level "type") }} {{ addRoleID $reward }}
		{{ else if and (hasRoleID $reward) (eq $type "highest") $toAdd }} {{ removeRoleID $reward }} {{ end }}
	{{ end }}
	{{ if $toAdd }} {{ addRoleID $toAdd }} {{ end }}
{{ end }}