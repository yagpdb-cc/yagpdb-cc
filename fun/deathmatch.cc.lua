{{- /*
	This command is a replica of the deathmatch command from Yggdrasil. Usage: `-deathmatch [user1] [user2]`.

	Recommended trigger: Command trigger with trigger `deathmatch`.
*/ -}}

{{ $emojis := sdict
	"UserA" "<:battleForward:675127538095357993>"
	"UserB" "<:battleBackwards:675127538455937024>"
}}
{{ $yag := userArg 204255221017214977 }}

{{ $args := parseArgs 0 "**Syntax:** -deathmatch [user1] [user2]" (carg "userid" "user1") (carg "userid" "user2") }}
{{ $userA := $yag }}
{{ $userB := .User }}
{{ $cc := toInt .CCID }}

{{ if $args.IsSet 0 }} {{ $userA = userArg ($args.Get 0) }} {{ end }}
{{ if $args.IsSet 1 }} {{ $userB = userArg ($args.Get 1) }} {{ end }}

{{ $embed := sdict 
	"title" "💢 Deathmatch"
	"description" "*Match starting in 3...*"
	"color" 14232643
	"fields" (cslice
		(sdict "name" $userA.Username "value" "100/100 HP" "inline" true)
		(sdict "name" $userB.Username "value" "100/100 HP" "inline" true)
	)
}}

{{ with .ExecData }}
	{{ $embed := sdict .Embed }}
	{{ $embed.Set "fields" (cslice.AppendSlice $embed.fields) }}

	{{ $msgs := split $embed.description "\n" | cslice.AppendSlice }}
	{{ if .IsFirst }} {{ $msgs = cslice }} {{ end }}

	{{ $attacker := index . .Attacker | sdict }}
	{{ $target := index . .Target | sdict }}
	{{ $emoji := $emojis.Get .Target }}

	{{ $rand := randInt 100 }}
	{{ $dmg := 0 }}
	{{ if lt $rand 5 }}
		{{ $dmg = randInt 40 50 }}
	{{ else if lt $rand 15 }}
		{{ $dmg = randInt 30 40 }}
	{{ else if lt $rand 45 }}
		{{ $dmg = randInt 20 30 }}
	{{ else }}
		{{ $dmg = randInt 1 20 }}
	{{ end }}

	{{ $newHp := sub $target.HP $dmg }}
	{{ if lt $newHp 0 }} {{ $newHp = 0 }} {{ end }}
	{{ $target.Set "HP" $newHp }}
	{{ $msgs = $msgs.Append (printf "%s **%s** attacked **%s** dealing %d damage!"
		$emoji
		$attacker.Name
		$target.Name
		$dmg
	) }}
	
	{{ $data := sdict . }}
	{{ $data.Set "IsFirst" false }}
	{{ $data.Set "Target" .Attacker }}
	{{ $data.Set "Attacker" .Target }}
	{{ $data.Set .Target $target }}

	{{ if not $target.HP }}
		{{ $msgs = $msgs.Append (printf "🏆 **%s** has won!" $attacker.Name) }}
	{{ end }}
	{{ if gt (len $msgs) 3 }}
		{{ $msgs = slice $msgs (sub (len $msgs) 3) (len $msgs) }}
	{{ end }}
	{{ $msg := "" }}
	{{ range $msgs }} {{ $msg = joinStr "\n" $msg . }} {{ end }}
	{{ $embed.Set "description" $msg }}
		
	{{ $embed.fields.Set (index (sdict "UserA" 0 "UserB" 1) .Target) (sdict
		"name" $target.Name
		"value" (printf "%d/100 HP" $target.HP)
		"inline" true
	) }}
	{{ $data.Set "Embed" $embed }}

	{{ if $target.HP }}
		{{ execCC $cc nil 2 $data }}
	{{ end }}

	{{ editMessage nil .MsgID (cembed $embed) }}
{{ else }}
	{{ $initial := sendMessageRetID nil (cembed $embed) }}
	{{ sleep 3 }}
	{{ execCC $cc nil 2 (sdict
		"UserA" (sdict "Name" $userA.Username "HP" 100)
		"UserB" (sdict "Name" $userB.Username "HP" 100)
		"Embed" $embed
		"Target" "UserA"
		"Attacker" "UserB"
		"MsgID" $initial
		"IsFirst" true
	) }}
{{ end }}