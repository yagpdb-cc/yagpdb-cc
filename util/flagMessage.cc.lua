{{/*
	This command allows users to flag messages by reacting with a custom emoji.

	Recommended trigger: Reaction trigger on REACTION ADD only.
*/}}

{{/* CONFIGURATION VARIABLES START */}}
{{ $reportEmoji := 675512907391434759 }} {{/* ID of report emoji */}}
{{ $reportChannel := 675513854888771595 }}
{/* CONFIGURATION VARIABLES END */}

{{ if eq .Reaction.Emoji.ID $reportEmoji }}
	{{ $isFirst := true }}
	{{ range .ReactionMessage.Reactions }}
		{{ if and (eq .Emoji.ID $reportEmoji) (gt .Count 1) }} {{ $isFirst = false }} {{ end }}
	{{ end }}
	{{ if $isFirst }}
		{{ $attachment := "" }}
		{{ with .ReactionMessage.Attachments }} {{ $attachment = (index . 0).ProxyURL }} {{ end }}
		{{ sendMessage $reportChannel (cembed
			"title" (printf "❯ Message was flagged in #%s" .Channel.Name)
			"color" 0xDC143C
			"description" (or .ReactionMessage.Content "*No content*")
			"image" (sdict "url" $attachment)
			"fields" (cslice
				(sdict "name" "❯ Flagged by" "value" .User.String "inline" true)
				(sdict "name" "❯ Message Author" "value" .ReactionMessage.Author.String "inline" true)
				(sdict "name" "❯ Message" "value" (printf "[Jump to](https://discordapp.com/channels/%d/%d/%d)" .Guild.ID .Channel.ID .ReactionMessage.ID) "inline" true)
				(sdict "name" "❯ Logs" "value" (printf "[View here](%s)" (execAdmin "log")) "inline" true)
			)
			"footer" (sdict "text" "Flagged at")
			"timestamp" currentTime
		) }}
	{{ end }}
{{ end }}