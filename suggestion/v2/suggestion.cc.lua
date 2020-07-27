{{/*
	This command is the main suggestion command with suggestion create/edit/delete and suggestadmin commands. Usage: Refer README.md

	Recommended trigger: Regex trigger with non case sensitive and trigger `\A(\-\s?|<@!?204255221017214977>\s*)((del(ete)?|edit)?suggest(ion)?|(sa|suggestadmin)\s+(edit|dupe|markdupe|deny|implement(ed)?|archive|approved?|comment))(\s+|\z)`
        Note: If your prefix is not `-` replace the `-` at the start of the trigger with your prefix. 
*/}}

{{/* CONFIGURATION VARIABLES START */}}
{{$Suggestion_Channel := 737324313341853796}}
{{$Logging_Channel := 737324355784278186}}
{{$Implemented_Channel := 737324417096482907}}
{{$Approved_Channel := 737324384498221147}}
{{$Mod_Roles := cslice  384008687951282177 419970533069815808}} {{/* No need to add Admin roles. They are automatically detected given Yag has right Perms */}}
{{$Cooldown := 600}} {{/* Can be set to 0 for no cooldown */}}
{{$Upvote := "upvote:524907425531428864"}}
{{$Downvote := "downvote:524907425032175638"}}
{{/* CONFIGURATION VARIABLES END */}}
 
{{/* Actual Code Starts Here */}}
{{$globalDict := dict "chans" (dict $Suggestion_Channel true $Approved_Channel true $Implemented_Channel true) "msg" .nil}}
{{$Prefix := index (reFindAllSubmatches `.*?: \x60(.*)\x60\z` (execAdmin "Prefix")) 0 1}}
{{$error := ""}}
{{$Syntax := ""}}
{{$IS_Mod := false}}
{{if in (slice (exec "viewperms") (add 25 (len .User.Username))) `Administrator`}}
	{{$IS_Mod = true}}
{{else}}
	{{range $Mod_Roles}}{{if in $.Member.Roles .}}{{$IS_Mod = true}}{{end}}{{end}}
{{end}}

{{if reFind `(?i)\bsuggest(ion)?\b` .Cmd }}
	{{$Syntax = print .Cmd " <Suggestion_Here>"}}
	{{$col := 16777215}}{{$pos := 0}}{{$r := .Member.Roles}}{{range .Guild.Roles}}{{if and (in $r .ID) (.Color) (lt $pos .Position)}}{{$pos = .Position}}{{$col = .Color}}{{end}}{{end}}
	{{with .StrippedMsg}}
		{{with (dbGet $.User.ID "suggestCld")}}
			{{$error = print "This command is on cooldown for " (humanizeDurationSeconds (.ExpiresAt.Sub currentTime)) " to avoid spam."}}
		{{else}}
			{{if not $IS_Mod}}{{if $Cooldown}}{{dbSetExpire $.User.ID "suggestCld" "cooldown" $Cooldown}}{{end}}{{end}}
			{{$embed :=	cembed
						"title" (print "Suggestion #" (dbIncr 0 "suggestions-count" 1))
						"description" .
						"color" $col
						"author" (sdict "name" (str $.User) "icon_url" ($.User.AvatarURL "512"))
						"timestamp"  currentTime
						"footer" (sdict "text" (print "Author ID - " $.User.ID))
			}}
			{{$ID := sendMessageRetID $Suggestion_Channel $embed}}
			{{addMessageReactions $Suggestion_Channel $ID $Upvote $Downvote}}
			{{sendDM "Suggestion submitted successfully. If you want to delete your suggestion, do so with `" $Prefix "deletesuggestion " $ID "` on the " $.Guild.Name " server."}}
			{{addReactions $Upvote}}
		{{end}}
	{{else}}
		{{$error = "Insufficient Arguments."}}
	{{end}}	
{{else}}
	{{$authorID := 0}}{{$message := .nil}}{{$channel := .nil}}{{$rest := ""}}{{$command := ""}}{{$type:=""}}{{$SNum:=0}}
	{{$Syntax = print .Cmd " <Suggestion_ID> <Message/Arguments>"}}

	{{/* Suggestion Message Validation */}}
	{{with reFindAllSubmatches (print `(?si)\A(?:` (reReplace `[\.\[\]\-\?\!\\\*\{\}\(\)\|]` $Prefix `\${0}`) `\s?|\S+\s*)(?:(del)\w+|(edit)\w+|\w+\s+(\w+))\s+(\d+)\s*(.*)`) .Message.Content}}
		{{$command = lower (or (index . 0 1) (index . 0 2) (index . 0 3))}}
		{{$mID := index . 0 4}}
		{{$rest = index . 0 5}}
		{{$globalDict.Set "mID" $mID}}
		{{template "process-suggest-msg" $globalDict}}
		{{$message = $globalDict.msg}}{{$channel = $globalDict.chan}}{{$error = $globalDict.err}}{{$type = $globalDict.type}}{{$SNum = $globalDict.SNum}}{{$authorID = $globalDict.authorID}}
	{{else}}
		{{$error = "Invalid Syntax: did not provide valid Message ID"}}
	{{end}}

	{{if and (ne $command "comment") (not $error)}}
		{{if eq $type "Implemented"}}
			{{$error = print "Cannot use " $command " command on Implemented Suggestions"}}
		{{else if and (eq $type "Approved") (eq $command "del" "edit" "approve" "approved")}}
			{{$error = print "Cannot use " $command " command on Approved Suggestions"}}
		{{end}}
	{{end}}

	{{if not $error}}
		{{$embed := structToSdict (index $message.Embeds 0)}}{{range $k,$v:=$embed}}{{if eq (kindOf $v true) `struct`}}{{$embed.Set $k (structToSdict $v)}}{{end}}{{end}}{{$embed.Author.Set "Icon_URL" $embed.Author.IconURL}}
		{{if eq $command "del"}}
			{{if or (eq $authorID .User.ID) $IS_Mod}}
				{{deleteMessage $channel $message.ID 0}}
			{{else}}
				{{$error = "You can only delete your own suggestions. Ensure that you have used correct Suggestion ID."}}
			{{end}}
		{{else if eq $command "edit"}}
			{{if eq $authorID .User.ID}}
				{{if $rest}}
					{{$embed.Set "Description" $rest}}
					{{editMessage $channel $message.ID (cembed $embed)}}
				{{else}}
					{{$error = "Edited Suggestion cannot be blank"}}
				{{end}}
			{{else}}
				{{$error = "You can only edit your own suggestions. Ensure that you have used correct Suggestion ID."}}
			{{end}}
		{{else if $IS_Mod}}
			{{if eq $command "dupe" "edit" "markdupe"}}
				{{$Syntax = "<Suggestion_ID> <Original_Suggestion_ID>"}} 
				{{with $rest}}
					{{$globalDict.Set "mID" .}}{{$globalDict.Set "msg" $.nil}}
					{{template "process-suggest-msg" $globalDict}}
					{{if not $globalDict.err}}
						{{if lt $globalDict.SNum $SNum}}
							{{if $globalDict.msg}}
								{{$embed.Set "Description" (print $embed.Description "\n\n**This message has been marked as a dupe of:\n**https://discordapp.com/channels/" $.Guild.ID "/" $globalDict.chan "/" .)}}
								{{deleteMessage $channel $message.ID 0}}
								{{sendMessage $Logging_Channel (complexMessage "content" (print "<@" $authorID "> | The suggestion below has been marked as dupe!") "embed" $embed)}}
							{{else}}
								{{$error = print "Invalid Original Suggestion Message ID : `" $rest "`"}}
							{{end}}
						{{else}}
							{{$error = "Original Suggestion should be older than dupe Suggestion"}}
						{{end}}
					{{else}}
						{{$error = print "Original Suggestion: " $globalDict.err}}
					{{end}}
				{{else}}
					{{$error = "Did not provide valid ID for Original Suggestion Message"}}
				{{end}}
			{{else if eq $command "deny"}}
				{{deleteMessage $channel $message.ID 0}}
				{{sendMessage $Logging_Channel (complexMessage "content" (print "<@" $authorID "> | The suggestion below has been deleted for reason: " $rest) "embed" $embed)}}
			{{else if eq $command "comment"}}
				{{template "handle-comments" (sdict "embed" $embed "comment" $rest "user" $.User)}}
				{{editMessage $channel $message.ID (cembed $embed)}}
			{{else}}
				{{$chan:=$Implemented_Channel}}
				{{if eq $command "approve" "approved"}}{{$chan = $Approved_Channel}}{{$command = "Approved"}}{{else}}{{$command = "Implemented"}}{{end}}	
				{{if $rest}}{{template "handle-comments" (sdict "embed" $embed "comment" $rest "user" $.User)}}{{end}}
				{{$embed.Set "Title" (print $command " Suggestion #" $SNum)}}
				{{$embed.Footer.Set "Text" (print $command " By : " .User.Username " - " .User.ID " ● " $embed.Footer.Text)}}
				{{deleteMessage $channel $message.ID 0}}
				{{sendMessage  $chan (cembed $embed)}}
			{{end}}
		{{else}}
			{{$error = "Must be a Mod/Admin to use Suggest Admin commands"}}
		{{end}}
	{{end}}
{{end}}

{{deleteTrigger 20}}{{deleteResponse 5}}
{{if $error}}
	{{$ID := sendMessageRetID nil (cembed "title" "Error" "color" 0xFF0000 "description" (print "**Error:** " $error "\n\n**Syntax:** `" $Syntax "`"))}}
	{{deleteMessage nil $ID 25}}
{{else}}
Done :+1:
{{end}}

{{define "handle-comments"}}
	{{if and (not .embed.Fields) .comment}}{{.embed.Set "Description" (print .embed.Description "\n\n**__Comment:__**")}}{{else if not .comment}}{{.embed.Set "Description" (reReplace  `\n\n\*\*__Comment:__\*\*\z` .embed.Description "")}}{{end}}
	{{if .comment}}{{.embed.Set "Fields" (cslice (sdict "name" (print "BY : " .user " - " .user.ID) "value" .comment))}}{{else}}{{.embed.Set "Fields" cslice}}{{end}}
{{end}}

{{define "process-suggest-msg"}}
	{{$err:= ""}}
	{{range $k,$v:=.chans}}
			{{if not $.msg}}{{with getMessage $k $.mID}}{{$.Set "msg" .}}{{$.Set "chan" $k}}{{end}}{{end}}
	{{end}}
	
	{{with .msg}}
		{{with .Embeds}}
			{{with (index . 0).Footer}}
				{{with reFindAllSubmatches `(?s).*Author ID - (\d{17,19})\z` .Text}}
					{{$.Set "authorID" (toInt64 (index . 0 1))}}  
				{{else}}
					 {{$err = "Not a valid Suggestion Message"}}
				{{end}}			
			{{else}}
				{{$err = "Not a valid Suggestion Message"}}
			{{end}}
			{{with reFindAllSubmatches `\A(?:(Suggestion)|(Approved) Suggestion|(Implemented) Suggestion) #(\d+)\z` (index . 0).Title}}
				{{$.Set "type"  (or (index . 0 1) (index . 0 2) (index . 0 3))}}
				{{$.Set "SNum" (toInt (index . 0 4))}}
			{{else}}
				{{$err = "Not a valid Suggestion Message"}}
			{{end}}
		{{else}}
			{{$err = "Not a valid Suggestion Message"}}
		{{end}}
	{{else}}
		{{$err = print "Invalid Message ID : `" $.mID "`"}}
	{{end}}
	{{.Set "err" $err}}
{{end}}
