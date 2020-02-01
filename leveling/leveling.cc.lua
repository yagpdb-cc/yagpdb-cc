{{- /*
	This command manages the general level settings of the guild.
	Possible usage:

	-leveling set <key> value | example: -leveling set cooldown 1 minute 30 seconds 
	-leveling use-default | use default settings 
	-leveling view | view settings

	Recommended trigger: Regex trigger with trigger `^-(leveling|(level|lvl)-?conf|(level|lvl)=?settings)`.
*/ -}}
{{/* Help message for convenience in sending */}}
{{ $helpMsg := "That wasn't a valid method. The possible usage is below.\n**Note:** All commands must be started with your prefix, like `-leveling use-default`.\n\n```ini\n[leveling use-default]       | Uses the default settings.\n[leveling set <key> <value>] | Sets the given key to the value provided, where key is one of \"min\", \"max\", or \"cooldown\".\n[leveling view]              | Views the current settings.```"}}
{{ if .CmdArgs }}
	{{ $isSaved := false }} {{/* Whether the settings are saved */}}
	{{ $currentSettings := sdict 
		"min" 15 
		"max" 25 
		"cooldown" .TimeMinute
	}} {{/* Defaults for level settings */}}
	{{ with (dbGet 0 "xpSettings") }}
		{{ $isSaved = true }} {{/* Settings are in DB */}}
		{{ $currentSettings = sdict .Value }} {{/* Convert value to sdict */}}
	{{ end }}
	{{ if eq (index .CmdArgs 0) "use-default" }}
		{{ $s := dbSet 0 "xpSettings" $currentSettings }} {{/* Set defaults */}}
		Done! You are now using the default settings for the leveling system.
	{{ else if and (eq (index .CmdArgs 0) "set") (ge (len .CmdArgs) 3) }}
		{{ $key := index .CmdArgs 1 }} {{/* The key of the setting being set */}}
		{{ $value := slice .CmdArgs 2 | joinStr " " }} {{/* The value of the new setting */}}
		{{ if in (cslice "min" "max" "cooldown") $key }} {{/* Check that key is valid */}}
			{{ $parsed := or (and (eq $key "cooldown") (toDuration $value)) (toInt $value) }} {{/* Find the proper type of conversion needed */}}
			{{ if not $parsed }} {{/* Check whether it was parsed correctly / whether it was valid value */}}
				Please provide a valid value for the key `{{ $key }}`.
			{{ else }}
				{{ $currentSettings.Set $key $parsed }} {{/* Set key to value */}}
				{{ if ge $currentSettings.min $currentSettings.max }} {{/* Preemptively prevent user from setting larger min value than max which would cause error later */}}
					The minimum xp cannot be larger than or equal to the max xp.
				{{ else }}
					{{ $s := dbSet 0 "xpSettings" $currentSettings }} {{/* Save it */}}
					Successfully set the key `{{ $key }}` to `{{ $value }}`!
				{{ end }}
			{{ end }}
		{{ else }}
			That was not a valid key. The only valid settings are "min", "max", and "cooldown".
		{{ end }}
	{{ else if eq (index .CmdArgs 0) "view" }}
		{{ $formatted := printf "**❯ Minimum XP:** %d\n**❯ Maximum XP:** %d\n**❯ Cooldown:** %s"
			$currentSettings.min
			$currentSettings.max
			(humanizeDurationSeconds ($currentSettings.cooldown | toDuration)) 
		}} {{/* Construct the embed description */}}
		{{ if $isSaved }} {{/* If the settings are in DB */}}
			{{ sendMessage nil (cembed "title" "Level Settings" "description" $formatted "thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png")) }}
		{{ else }}
			This server has not set up it's leveling system. Run `-leveling use-default` to use the default settings or customize it using `-leveling set <key> <value>`.
		{{ end }}
	{{ else }} {{/* Send help messages */}}
		{{ sendMessage nil $helpMsg }} 
	{{ end }}
{{ else }}
	{{ sendMessage nil $helpMsg }}
{{ end }}