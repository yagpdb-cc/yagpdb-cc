{{/*
	Working keypad using reactions as an interface.

	Recommended trigger: Command trigger with trigger `keypad`.
*/}}

{{ $colors := sdict "success" 0x50C878 "failure" 0xDC143C "neutral" 0xFF7900 }}
{{ $reactions := cslice "1️⃣" "2️⃣" "3️⃣" "4️⃣" "5️⃣" "6️⃣" "7️⃣" "8️⃣" "9️⃣" }}
{{ $generated := "" }}
{{ range seq 0 4 }}
	{{ $generated = joinStr "" $generated (randInt 1 10) }}
{{ end }}
{{ $ret := sendMessageRetID nil (cembed
	"title" (printf "❯ Keypad: %s" $generated)
	"footer" (sdict "text" "React with the numbers shown above, in order.")
	"color" $colors.neutral
) }}
{{ addMessageReactions nil $ret $reactions.StringSlice }}
{{ dbSet $ret "keypad" (sdict "expect" $generated "current" "") }}