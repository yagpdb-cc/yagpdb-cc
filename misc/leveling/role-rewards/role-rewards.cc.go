{{/* Help message */}}
{{ $helpMsg := cembed
	"title" "🏆 Role Rewards"
	"description" (joinStr "\n\n"
		"`rolerewards add <level> <role>`: Adds a role reward at the given level"
		"`rolerewards remove <level>`: Removes the role reward from the given level"
		"`rolerewards set-type <highest|stack>`: Sets the role reward type. Highest means only the highest role reward less than or equal to the current level, stack is all role rewards up to that level."
		"`rolerewards reset`: Resets role reward settings."
		"`rolerewards view`: Views current settings for role rewards."
	)
	"color" 14232643
}}
{{ if .CmdArgs }}
	{{ $roleRewards := sdict "type" "stack" }} {{/* The default setup */}}
	{{ with (dbGet 0 "roleRewards") }}
		{{ $roleRewards = sdict .Value }} {{/* Update with DB entry if present */}}
	{{ end }}
	{{ $cmd := index .CmdArgs 0 }} {{/* The subcommand used for convenience */}}

	{{ if and (eq $cmd "add") (ge (len .CmdArgs) 3) }}
		{{ $level := index .CmdArgs 1 | toInt }} {{/* The level for this role reward */}}
		{{ $input := slice .CmdArgs 2 | joinStr " " | lower }} {{/* The role name in lowercase */}}

		{{/* Exact match (irregardless of case) */}}
		{{ $exactRole := 0 }}
		{{/* Match from inFold */}}
		{{ $maybeRole := 0 }}
		
		{{ with reFindAllSubmatches `^<@&(\d{17,19})>|(\d{17,19})$` $input }}
			{{ $id := toInt (or (index . 0 1) (index . 0 2)) }}
			{{ range $.Guild.Roles }}
				{{- if eq .ID $id }} {{ $exactRole = . }} {{ end -}}
			{{ end }}
		{{ else }}
			{{ range .Guild.Roles }}
				{{- if eq (lower .Name) (lower $input) }} {{ $exactRole = . }}
				{{- else if inFold (lower .Name) (lower $input) }} {{ $maybeRole = . }}
				{{- end -}}
			{{ end }}
		{{ end }}

		{{ $role := or $exactRole $maybeRole }}
		{{/* If there is both level and role */}}
		{{ if and $level $role }}
			{{ if and (ge $level 1) (le $level 200) }} {{/* If level is in correct range */}}
				{{ $roleRewards.Set (str $level) $role.ID }}
				{{ $s := dbSet 0 "roleRewards" $roleRewards }} {{/* Save settings */}}
				Successfully set the role `{{ $role.Name }}` to be given at the level `{{ $level }}`.
			{{ else }}
				Sorry, the level provided was not in the range 1-200.
			{{ end }}
		{{ else }}
			Sorry, I was unable to find the role you provided / the level provided was invalid.
		{{ end }}

	{{ else if and (eq $cmd "set-type") (ge (len .CmdArgs) 2) }}
		{{ $type := index .CmdArgs 1 }}
		{{ if not (in (cslice "stack" "highest") $type) }} {{/* Check whether type is valid */}}
			Sorry, that was not a valid type. The type must be either "stack" or "highest".
		{{ else }}
			{{ $roleRewards.Set "type" $type }}
			{{ $s := dbSet 0 "roleRewards" $roleRewards }} {{/* Save settings */}}
			Successfully set the role-giving type of this server to `{{ $type }}`.
		{{ end }}

	{{ else if eq $cmd "reset" }}
		{{ $s := dbSet 0 "roleRewards" (sdict "type" "stack") }} {{/* We set the settings to default */}}
		Alright, I cleared the role rewards for this server!

	{{ else if and (eq $cmd "remove") (ge (len .CmdArgs) 2) }}
		{{ with (reFind `\d+` (index .CmdArgs 1)) }} {{/* Find level to remove */}}
			{{ if $roleRewards.Get . }}
				{{ $roleRewards.Del . }}
				{{ $s := dbSet 0 "roleRewards" $roleRewards }}
				Successfully removed the role reward from the level `{{ . }}`.
			{{ else }}
				Sorry, there is not a role reward set for that level!
			{{ end }}
		{{ else }}
			Please provide a valid level to remove the role reward from.
		{{ end }}

	{{ else if eq $cmd "view" }}
		{{ if eq (len $roleRewards) 1 }} {{/* If it is still the default settings */}}
			{{ sendMessage nil (cembed "title" "Role Rewards" "thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png") "description" (joinStr "" "**❯ Role Rewards:** n/a\n**❯ Type:** " $roleRewards.type)) }}
		{{ else }}
			{{ $out := "" }} {{/* The embed description */}}
			{{- range $level := seq 1 201 -}} {{/* We can do this as we know level roles are in range 1-100 */}}
				{{ with ($roleRewards.Get (str $level)) }}
					{{ $out = printf "%s\n❯ **Level %d:** <@&%d>" $out $level . }}
				{{ end }}
			{{- end -}}
			{{/* Format and send embed */}}
			{{ sendMessage nil (cembed "title" "Role Rewards" "thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png") "description" (joinStr "" $out "\n\n" "**❯ Type:** " $roleRewards.type)) }}
		{{ end }}

	{{ else }}
		{{ sendMessage nil $helpMsg }}
	{{ end }}
{{ else }}
	{{ sendMessage nil $helpMsg }}
{{ end }}
