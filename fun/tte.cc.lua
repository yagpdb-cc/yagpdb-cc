{{- /*
	This command converts given text to emoji. Usage: `-tte <text>` (raw content with `-tteraw <text>`).

	Recommended trigger: Regex trigger with trigger `^-(tte|emojify|emotify)(-raw)?`
*/ -}}
{{ $keycap := "⃣" }}
{{ $emojis := sdict "#" "#⃣" "*" "*⃣" "!" "❗" "?" "❓" }}
{{ $codeblock := reFind `raw` .Cmd }}
{{ if .StrippedMsg }}
	{{ $msg := "" }}
	{{- range (split .StrippedMsg "") -}}
		{{ $c := index . 0 }}
		{{ if or (and (ge $c 65) (le $c 90)) (and (ge $c 97) (le $c 122)) }}
			{{ $msg = joinStr "" $msg ":regional_indicator_" (lower .) ":" }}
		{{ else if and (ge $c 48) (le $c 56) }}
			{{ $msg = joinStr "" $msg . $keycap }}
		{{ else }}
			{{ $msg = joinStr "" $msg (or ($emojis.Get .) .) }}
		{{ end }}
	{{- end -}}
	{{ if $codeblock }}
		{{ sendMessage nil (printf "**❯ Text to Emoji:**\n```\n%s```" $msg) }}
	{{ else }}
		{{ sendMessage nil (cembed
			"title" "❯ Text to Emoji"
			"description" $msg
			"color" 14232643
			"footer" (sdict "text" "Powered by YAGPDB.xyz")
		) }}
	{{ end }}
{{ end }}
