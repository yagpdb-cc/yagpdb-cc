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
{{$IDregex:=print .User.ID ","}}

{{if .ReactionAdded}}{{$amount:=1}}{{if reFind $IDregex $giveawayData.listID}}{{$giveawayData.Set "listID" (reReplace $IDregex $giveawayData.listID "")}}{{$amount =0}}{{end}}{{$giveawayData.Set "listID" (print $giveawayData.listID  $IDregex)}}{{$giveawayData.Set "count" (add $giveawayData.count $amount)}}
{{else}}{{if reFind $IDregex $giveawayData.listID}}{{$giveawayData.Set "listID" (reReplace $IDregex $giveawayData.listID "")}}{{$giveawayData.Set "count" (add $giveawayData.count -1)}}{{end}}    
{{end}}

{{$data.Set (joinStr "" .Reaction.ChannelID .Reaction.MessageID) $giveawayData}}{{dbSet 7777 "giveaway_active" $data}}

{{end}}
{{end}}
