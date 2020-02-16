{{/*
	Counterpart to keypad CC.

	Recommended trigger: Reaction trigger with option ADDED REACTIONS only.
*/}}

{{ $colors := sdict "success" 0x50C878 "failure" 0xDC143C "neutral" 0xFF7900 }}
{{ $reactionsList := cslice "1️⃣" "2️⃣" "3️⃣" "4️⃣" "5️⃣" "6️⃣" "7️⃣" "8️⃣" "9️⃣" }}
{{ $reactions := sdict
	"1️⃣" "1"
	"2️⃣" "2"
	"3️⃣" "3"
	"4️⃣" "4"
	"5️⃣" "5"
	"6️⃣" "6"
	"7️⃣" "7"
	"8️⃣" "8"
	"9️⃣" "9"
}}
{{ $reaction := .Reaction.Emoji.Name }}
{{ if and (in $reactionsList $reaction) ($data := (dbGet .ReactionMessage.ID "keypad").Value) }}
	{{/* {{ deleteMessageReaction nil .ReactionMessage.ID .User.ID .Reaction.Emoji.Name }} */}}
	{{ $embed := index .ReactionMessage.Embeds 0 }}
	{{ $raw := sdict "title" $embed.Title "footer" (sdict "text" $embed.Footer.Text) "color" $embed.Color }}
	{{ $current := joinStr "" $data.current (index $reactions $reaction) }}
	{{ if not (reFind (printf "^%s" $current) $data.expect) }}
		{{ $raw.footer.Set "text" "Sorry, you entered a wrong number." }}
		{{ $raw.Set "color" $colors.failure }}
		{{ editMessage nil .ReactionMessage.ID (cembed $raw) }}
		{{ dbDel .ReactionMessage.ID "keypad" }}
		{{ deleteAllMessageReactions nil .ReactionMessage.ID }}
	{{ else if eq (len $current) 4 }}
		{{ $raw.Set "color" $colors.success }}
		{{ $raw.footer.Set "text" "Correct!" }}
		{{ editMessage nil .ReactionMessage.ID (cembed $raw) }}
		{{ dbDel .ReactionMessage.ID "keypad" }}
		{{ deleteAllMessageReactions nil .ReactionMessage.ID }}
	{{ else }}
		{{ $data = sdict $data }}
		{{ $data.Set "current" $current }}
		{{ dbSet .ReactionMessage.ID "keypad" $data }}
	{{ end }}
{{ end }}