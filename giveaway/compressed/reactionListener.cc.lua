{{$gEmoji:=`<:yag:277569741932068864>`}}
{{/*Code*/}}
{{ $data:=sdict}}

{{$compareEmoji:=.Reaction.Emoji.Name}}
{{with reFindAllSubmatches `(\d+)>\z` $gEmoji}}{{$gEmoji =index . 0 1}}{{$compareEmoji =str $.Reaction.Emoji.ID}}{{end}}
 
{{if and (eq $compareEmoji $gEmoji) (not .User.Bot)}}

{{with (dbGet 7777 "giveaway_active").Value}}{{$data =sdict .}}{{end}}
{{$giveawayData := $data.Get (joinStr "" .Reaction.ChannelID .Reaction.MessageID)}}

{{if $giveawayData}}
{{$giveawayData =sdict $giveawayData}}

{{if .ReactionAdded}}{{$giveawayData.Set "listID" (print $giveawayData.listID  .User.ID "," )}}{{$giveawayData.Set "count" (add $giveawayData.count 1)}}
{{else}}{{$IDregex:=print .User.ID `,`}}{{$giveawayData.Set "listID" (reReplace $IDregex $giveawayData.listID "")}}{{$giveawayData.Set "count" (add $giveawayData.count -1)}}      
{{end}}

{{$data.Set (joinStr "" .Reaction.ChannelID .Reaction.MessageID) $giveawayData}}{{dbSet 7777 "giveaway_active" $data}}

{{end}}
{{end}}
