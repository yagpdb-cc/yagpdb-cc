{{/* 
        Supporting Reaction Command for Giveaway Package.

        Recommended Trigger : Reaction Type with trigger `Added + Removed reactions` 
*/}}

{{/* CONFIGURATION VALUES START */}}
{{$giveawayEmoji := `🎉`}} {{/* set giveaway emoji to be used */}}
{{/* CONFIGURATION VALUES END */}}

{{/* Actual Code , do not touch unless you know what youre doing */}}

{{/* defining some global variables */}}
{{ $data := sdict}}

{{/* if reaction emoji matches giveaway emoji and user reacting is not a bot , proceed */}}
{{if  and (eq .Reaction.Emoji.Name $giveawayEmoji) (not .User.Bot )}}

{{/* fetching active giveaways data */}}
{{with ( dbGet 7777 "giveaway_active" ).Value}}{{$data = sdict .}}{{end}}
{{$giveawayData := $data.Get (joinStr "" .Reaction.ChannelID .Reaction.MessageID)}}

{{/* if current message is an active giveaway announcement message */}}
{{if $giveawayData}}
{{$giveawayData = sdict $giveawayData}}

{{/* if reaction was added increase count by 1 and add user ID to ID list */}}
{{if .ReactionAdded}}
     {{$giveawayData.Set "listID" (joinStr "" $giveawayData.listID  .User.ID "," )}}
     {{$giveawayData.Set "count" (add $giveawayData.count 1)}}

{{/* if reaction was removed reduce count by 1 and remove user ID from ID list */}}
{{else}}
     {{$IDregex := joinStr  ""  .User.ID `,`  }}
     {{$giveawayData.Set "listID" (reReplace $IDregex $giveawayData.listID "")}}
     {{$giveawayData.Set "count" (add $giveawayData.count -1)}}          
{{end}}

{{/* update active giveaway database entry */}}
     {{$data.Set  (joinStr ""  .Reaction.ChannelID .Reaction.MessageID) $giveawayData}}{{dbSet 7777 "giveaway_active" $data}}

{{end}}

{{end}}
