{{- /*
	This command manages the role rewards of the server.

	Types of role giving:
	- stack: Users get all roles up to current level [DEFAULT]
	- highest: Users get the last role reward closet to current level [MAY BE BUGGY]

	Usage:

	-rr add <level> <role name> | Adds a role reward to given level in range 1-100. Max 1 per level.
	-rr remove <level> | Removes role reward from level.
	-rr set-type <stack|highest> | Sets type of role giving.
	-rr view | Views current setup
	-rr reset | Resets the settings

	Recommended trigger: Regex trigger with trigger `^-(role-?rowards|rr)`
*/ -}}
{{/* Help message */}}
{{ $helpMsg := "That wasn't a valid method. The possible usage is below.\n**Note:** All commands must be started with your prefix, like `-rolerewards reset`.\n\n```ini\n[rolerewards view]               | Views the server's role rewards.\n[rolerewards add <level> <role>] | Sets a role to be given at a certain level. A max of 1 role is allowed per level.\n[rolerewards set-type <type>]    | Sets the server's role reward giving configuration. One of \"stack\" or \"highest\" (stack meaning just give roles, highest meaning only the last role reward less than the user's current level.\n[rolerewards reset]              | Resets the role reward settings for this server. Note: This is irreversible.\n[rolerewards remove <level>]     | Removes the role reward from a given level.```"}}
{{ if .CmdArgs }}
	{{ $roleRewards := sdict "type" "stack" }} {{/* The default setup */}}
	{{ with (dbGet 0 "roleRewards") }}
		{{ $roleRewards = sdict .Value }} {{/* Update with DB entry if present */}}
	{{ end }}
	{{ $cmd := index .CmdArgs 0 }} {{/* The subcommand used for convenience */}}
	{{ if and (eq $cmd "add") (ge (len .CmdArgs) 3) }}
		{{ $level := index .CmdArgs 1 | toInt }} {{/* The level for this role reward */}}
		{{ $search := slice .CmdArgs 2 | joinStr " " | lower }} {{/* The role name in lowercase */}}
		{{ $role := 0 }} {{/* Role variable */}}
		{{/* Search for roles */}}
		{{- range .Guild.Roles -}}
			{{ if not $role }}
				{{ $rName := lower .Name }}
				{{ if or (eq $search $rName) (in $rName $search) }}
					{{ $role = . }}
				{{ end }}
			{{ end }}
		{{- end -}}
		{{/* If there is both level and role */}}
		{{ if and $level $role }}
			{{ if and (ge $level 1) (le $level 200) }} {{/* If level is in correct range */}}
				{{ $roleRewards.Set (toString $level) $role.ID }}
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
				{{ with ($roleRewards.Get (toString $level)) }}
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