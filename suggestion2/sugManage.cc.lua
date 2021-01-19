{{/*
Made by: Crenshaw#1312

Trigger Type: Regex
Trigger: \A-s(ug(s|gestion(s)?)?)\s\w+
		
Note: `-sug implement` and `-sug approve` both make it so the suggestion WILL NOT be deleted after given seconds in sugCreate.cc.lua
Note: This system is much cleaner then most others due to the simplicity and databse used for it
Note: MAKE SURE TO PUT THE CORRECT DATA/INFORMATION IN CONFIG VALUES!!!!!!!!
~~~~
Note: has image and MULTIPLE file(s)/image(s) support, dynamically showed in a field
Note: Supports multipule comments and editing them (and deletion)
Note: Can show emoji count perecntages if wanted
Note: Has quoting mechanisim

Usage:
  Base: -suggestion/-sug/-s
  
  -sug del/delete/deny <sugNum> [reason]
      ^Remove a suggestion
      
  -sug com/comment <sugNum> <comment>
      ^Comment on a suggestion (supports multipule comments and editing them)
      ^Use \del in the comment section to delete your comment
      
  -sug ap/approve <sugNum> [reason]
      ^Approve of a suggestion, also makes the suggestion stay forever so it can possibly be implemented later
      
  -sug imp/implement <sugNum> [reason]
      ^Implement a suggestion, done what this suggestion asked/suggested
      
  -sug q/quote <sugNum>
      ^Anyone can use this, quote a suggestion
			
  -sug l/list [page num]
      ^Anyone can use this, lists all suggestions in groups of 10
		
*/}}
{{/* ~you only have to copy below this line, the above is just me telling you shit~ */}}

{{/* REQUIRED CONFIGURATION VALUES START*/}}
{{ $sugChan := 796916867586719784 }} {{/* (CHANNEL ID) suggestions channel*/}}
{{ $sugCreateCCID := 38 }} {{/* (NUMNER) the custom command number/ID of the sugCreate command*/}}
{{ $notify := 770299126528606208 }} {{/* (CHANNEL ID) or (false) notify the author of the suggestion of mod actions to it?*/}}
{{ $impChan := 770299126528606208 }} {{/* (CHANNEL ID) or (false) channel to send implemented suggestions to, false to disable*/}}
{{ $rolesS := cslice 770291866208829470 770291857783390228 }} {{/* (ROLED IDs) role(s) that can manage suggestions*/}}

{{/* OPTIONAL CONFIGURATION VALUES*/}}
{{ $reason := false }} {{/* (true) or (false), weather or not a reason is required*/}}
{{ $Pershow := true }} {{/* (true) or (false, weather or not to show emoji count on quote and implement embeds)*/}}
{{/* CONFIGURATION VALUES END*/}}

{{/* role requirement*/}}
{{ $mangR := false }}
{{range .Member.Roles }}
	{{ if in $rolesS . }}
		{{ $mangR = true }}
	{{ end }}
{{ end }}

{{ define "emCount"}}
	{{ if .Show }}
		{{ if len .Embed.Fields}}
			{{ (index .Embed.Fields (sub (len .Embed.Fields) 1)).Set "Inline" true }}
		{{ end }}
		{{ .Embed.Set "Fields" (.Embed.Fields.Append (sdict 
			"Name" "Emoji Count"
			"Value" (print (index .Message.Reactions 0).Emoji.Name " **»** " (index .Percents 0) " " (index .Message.Reactions 1).Emoji.Name " **»** " (index .Percents 1))
        	"Inline" true) 
		) }}
	{{ end }}
{{ end }}

{{ define "error"}}
	{{ $id := sendMessageRetID nil (cembed
		"Title" "Suggestion System"
		"Description" (joinStr "\n\n"
			"`suggestion/suggest/sug/s <action> <sugNum> [reason]` can be used as base"
			"`sug quote/q <sugNum> [reason]` quote a suggestion, anyone can do this"
			"`sug approve/ap <sugNum> [reason]` approve a suggestion"
			"`sug implement/imp <sugNum> [reason]` implement a suggestion"
			"`sug` l/list [page num] kist suggestions"
			"`sug comment/com <sugNum> [comment][\\delete]` comment on a suggestion (or delete one)"
			"`Note: approve and implement make it so a suggestion won't be auto-deleted`"
		)
		"Color" 0x4B0082
	) }}
	{{ deleteMessage nil $id 30 }}
{{ end }}

{{/* Reason and args management*/}}
{{ if and (not (reFind `\s?(q(uote)?|l(ist)?)\s?` .Cmd)) $reason }}
	{{ $reason = 2 }}
{{ else }}
	{{ $reason = 0 }}
{{ end }}

{{ if and (lt (len .CmdArgs) 2) $reason (not (reFind `\s?(q(uote)?|l(ist)?)\s?` .Cmd)) }}
	{{ template "error"}}
{{ end }}

{{ $a := parseArgs $reason "Reason has been made required" (carg "int" "sugCount") (carg "string" "reason") }}

{{ if not (reFind `\s?(q(uote)?|l(ist)?)\s?` .Cmd ) }}
	{{ if ($a.IsSet 1) }}
		{{ $reason = $a.Get 1 }}
	{{ else }}
		{{ $reason = "None provided" }}
	{{ end }}
{{ end }}

{{/* Getting suggestion and other data*/}}
{{ if $a.IsSet 0 }}
	{{ if ($db := (dbGet 0 (print "sugs|" ($a.Get 0)))) }}
		{{ $id := toInt $db.Value }}
		{{ $msg := getMessage $sugChan $id }}
		{{ $embed := structToSdict (index $msg.Embeds 0) }}
		{{ $f := cslice }}
		{{ range $embed.Fields }}
			{{ $f = $f.Append (structToSdict .) }}
		{{ end }}
		{{ $embed.Set "Fields" $f }}

		{{ $cmd := reReplace `\A-s(ug|uggestion)?\s?` .Cmd "" }}
		{{ $action := 0 }}

{{/* emoji count + percents (modded from pollDelete.cc.lua) ty piter!!!!*/}}
		{{ $percents := cslice }} {{ $total := 0}}
		{{ $total = sub (add (index $msg.Reactions 0).Count (index $msg.Reactions 1).Count) 2 }}
        {{ range $index, $value := $msg.Reactions }}
			{{ if lt $index 2 }}
            	{{ $percents = $percents.Append (printf "%.0f%%" (round (fdiv (sub $value.Count 1) $total|mult 100.0))) }}
			{{ end }}
        {{ end }}

{{/* Comment add/edit*/}}
		{{ if and $mangR (eq $cmd "com" "comment") }}
{{/* Has the user already commented?*/}}
			{{ $foundCom := false }}
			{{ if $embed.Fields }}
				{{ range $i, $v := $embed.Fields }}
					{{ if eq $.User.String $v.Name }}
						{{ $foundCom = (add $i 1) }}
					{{ end }}
				{{ end }}
			{{ end }}
{{/* handle accordingly*/}}
			{{ if and $foundCom ($a.IsSet 1) }}
{{/* Delete comment*/}}
				{{- if reFind `\A\s?\\(rem(ove)?|del(ete)?)\s?` ($a.Get 1) -}}
					{{ $newFields := cslice }}
					{{ range $embed.Fields }}
						{{ if ne $.User.String .Name }}
							{{ $newFields = $newFields.Append . }}
						{{ end }}
					{{ end }}
					{{ $embed.Set "Fields" $newFields }}
					{{ $reason = reReplace `\A\s?\\(rem(ove)?|del(ete)?)\s?` ($a.Get 1) "" }}
					{{ if or (not $reason) (eq $reason " ") }} {{ $reason = "None Provided" }} {{ end }}
					{{ $action = "deleted comment" }}
{{/* Edit Comment*/}}
				{{ else }}
					{{ $embed.Fields.Set (sub $foundCom 1) (sdict "Name" .User.String "Value" (print "_Comment »_ " ($a.Get 1)) "Inline" true) }}
					{{ $action = "updated comment" }}
				{{ end }}
{{/* Error attempting comment*/}}
			{{ else if (not ($a.IsSet 1)) }}
	  	        {{ sendMessage nil "Please place text for your comment" }}
{{/* Add Comment*/}}
			{{ else if and (not $foundCom) ($a.IsSet 1) }} 
				{{ $embed.Set "Fields" ($embed.Fields.Append (sdict "Name" .User.String "Value" (print "_Comment »_ " ($a.Get 1)) "Inline" true)) }}
				{{ $action = "added comment" }}
			{{ end }}
			{{ editMessage $sugChan $id (cembed $embed) }}

{{/* Delete suggestion*/}}
		{{ else if and (or $mangR (eq .User.String (userArg (index $msg.Mentions 0)).String)) (eq $cmd "del" "delete" "deny") }}
			{{ deleteMessage $sugChan $id 0 }}
			{{ dbDel 0 $db.Key }}
			{{ $action = "deleted suggestion" }}

{{/* Quote suggestion*/}}
		{{ else if eq $cmd "q" "qoute" }}
			{{ $embed.Set "URL" (print "https://discord.com/channels/" .Guild.ID "/" $sugChan "/" $id) }}
			{{ $embed.Set "Title" (print "Quote | " $embed.Title) }}
			{{ $embed.Set "Footer" (sdict "Icon_URL" (.User.AvatarURL "256") "Text" (print "Quoted by " .User.String)) }}
			{{ $embed.Del "Timestamp"}}
			{{ $embed.Del "Image"}}
			{{ template "emCount" ($x := sdict "Embed" $embed "Message" $msg "Percents" $percents "Show" $Pershow) }}
			{{ $embed = $x.Embed }}
			{{ sendMessage nil (cembed $embed) }}

{{/* Approve Suggestion*/}}
		{{ else if and $mangR (eq $cmd "ap" "app" "approve") }}
			{{ if not (reFind "APPROVE" $embed.Title)}}
				{{ $embed.Set "Title" (reReplace `\s#` $embed.Title " (APPROVED) #") }}
				{{ editMessage $sugChan $id (cembed $embed) }}
				{{ cancelScheduledUniqueCC $sugCreateCCID ($a.Get 0) }}
				{{ dbSet 0 $db.Key (toString $db.Value) }}
				{{ $action = "suggestion approved" }}
			{{ else }}
				This suggestion has already been approved
			{{ end }}

{{/* Implement Suggestion*/}}
		{{ else if and $mangR (eq $cmd "imp" "implement" "implemented") }}
			{{ if not (reFind "APPROVED" $embed.Title) }}
				{{ cancelScheduledUniqueCC $sugCreateCCID ($a.Get 0) }}
			{{ end }}
			{{ $embed.Set "Title" (reReplace `(\(APPROVED\))?\s#` $embed.Title " (IMPLEMENTED) #") }}
			{{ $embed.Set "Footer" (sdict "Text" (print .User.String " implemented this ")) }}
			{{ $embed.Set "Timestamp" currentTime }}
			{{ template "emCount" ($x := sdict "Embed" $embed "Message" $msg "Percents" $percents "Show" $Pershow) }}
			{{ $embed = $x.Embed }}
			{{ if $impChan }}
				{{ $embed.Set "Description" (print $embed.Description "\nReason: " $reason) }}
				{{ sendMessage $impChan (complexMessage "content" (userArg (index $msg.Mentions 0)).Mention "embed" (cembed $embed)) }}
				{{ deleteMessage $sugChan $id 0 }}
				{{ $action = 0 }}
			{{ else }}
				{{ editMessage $sugChan $id (cembed $embed) }}
				{{ $action = "suggestion implemented" }}
			{{ end }}
			{{ dbDel 0 $db.Key }}

{{/* Error*/}}
		{{ else if not (reFind `l(ist)?` .Cmd) }}
			{{ template "error"}}
		{{ end }}

{{/* Notfiy?*/}}
		{{ if and $notify $action }}
			{{ sendMessage $notify (complexMessage "content" (userArg (index $msg.Mentions 0)).Mention "embed" (cembed
				"Title" (title $action)
				"Description" (print "[Suggestion #" ($a.Get 0) "](" (print "https://discord.com/channels/" .Guild.ID "/" $sugChan "/" $id) ") action was done by " .User.Mention "\nReason: " $reason)
				"Color" $embed.Color
			)) }}
		{{ end }}
	{{ else if not (reFind `l(ist)?` .Cmd) }}
		{{ template "error"}}
	{{ end }}
{{ else if not (reFind `l(ist)?` .Cmd) }}
	{{ template "error"}}
{{ end }}
{{/* list suggestions*/}}
{{ if (reFind `\s?l(ist)?\s?` .Cmd) }}
	{{ $page := or ($a.Get 0) 1 }}
	{{ $skip := mult (sub $page 1) 10 }}
	{{ $sugs := dbTopEntries "sugs|%" 10 $skip }}
	{{ with $sugs }}
		{{ $e := sdict
			"Title" "Suggestions"
			"Fields" (cslice)
			"Color" 0x4B0082
			"Footer" (sdict "Text" "sugs list [page num]")
		}}
		{{ range $i, $v := .}}
{{/* getting vars*/}}
			{{ $msg := getMessage $sugChan (toInt $v.Value) }}
			{{ $sug := structToSdict (index $msg.Embeds 0) }}
			{{ $f := cslice }}
				{{ range $sug.Fields }}
					{{ $f = $f.Append (structToSdict .) }}
				{{ end }}
			{{ $sug.Set "Fields" $f }}
{{/* percents*/}}
			{{ $percents := cslice }} {{ $total := 0}}
			{{ $total = sub (add (index $msg.Reactions 0).Count (index $msg.Reactions 1).Count) 2 }}
        	{{ range $index, $value := $msg.Reactions }}
				{{ if lt $index 2 }}
            		{{ $percents = $percents.Append (printf "%.0f%%" (round (fdiv (sub $value.Count 1) $total|mult 100.0))) }}
				{{ end }}
    	    {{ end }}
{{/* Attachments*/}}
			{{ $atts := "None" }}
			{{ range $i, $v := $sug.Fields }}
				{{ if eq $v.Name "Attachments" }}
					{{ $atts = (joinStr ", " (split $v.Value "\n")) }}
				{{ end }}
			{{ end }}
{{/* Making display*/}}
			{{ $e.Set "Fields" ($e.Fields.Append (sdict 
				"Name" (reReplace `\[\"|\"\]|\s\-\snull` (print  "Suggestion #" (slice $v.Key 5) " - " (json (reFindAll "APPROVED" $sug.Title))) "") 
				"Value" (print " __" $sug.Author.Name "__: "  
					$sug.Description "\n"
                         "__Attachments__: " $atts "\n_"
					(index $msg.Reactions 0).Emoji.Name (index $percents 0) " " (index $msg.Reactions 1).Emoji.Name " " (index $percents 1) "_")
				"Inline" false))
			}}
		{{ end }}
		{{ sendMessage nil (cembed $e) }}
	{{ else }}
		There were no suggestions.
	{{ end }}
{{ end }}
{{ deleteTrigger 5}}
