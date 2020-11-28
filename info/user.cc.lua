{{/*
	This command allows you to view information about a given user defaulting to yourself.
	Usage: `-userinfo [user]`.

	Recommended trigger: Regex trigger with trigger `\A(-|<@!?204255221017214977>\s*)(user|member)(-?info)?(\s+|\z)`
*/}}

{{ $member := .Member }}
{{ $user := .User }}
{{ $args := parseArgs 0 "**Syntax:** `-userinfo [user]`" (carg "member" "target") }}
{{ if $args.IsSet 0 }}
	{{ $member = $args.Get 0 }}
	{{ $user = $member.User }}
{{ end }}

{{ $roles := "" }}
{{- range $k, $v := $member.Roles -}}
	{{ if eq $k 0 }} {{ $roles = printf "<@&%d>" . }}
	{{ else }} {{ $roles = printf "%s, <@&%d>" $roles . }} {{ end }}
{{- end -}}
{{ $bot := "No" }}
{{ if $user.Bot }} {{ $bot = "Yes" }} {{ end }}
{{ $createdAt := div $user.ID 4194304 | add 1420070400000 | mult 1000000 | toDuration | (newDate 1970 1 1 0 0 0).Add }}

{{ sendMessage nil (cembed
	"author" (sdict "name" (printf "%s (%d)" $user.String $user.ID) "icon_url" ($user.AvatarURL "256"))
	"fields" (cslice
		(sdict "name" "❯ Nickname" "value" (or $member.Nick "*None set*"))
		(sdict "name" "❯ Joined At" "value" ($member.JoinedAt.Parse.Format "Jan 02, 2006 3:04 AM"))
		(sdict "name" "❯ Created At" "value" ($createdAt.Format "Monday, January 2, 2006 at 3:04 AM"))
		(sdict "name" (printf "❯ Roles (%d Total)" (len $member.Roles)) "value" (or $roles "n/a"))
		(sdict "name" "❯ Bot" "value" $bot)
	)
	"color" 14232643
	"thumbnail" (sdict "url" ($user.AvatarURL "256"))
) }}