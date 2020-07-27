{{/*
	This command is the main suggestion command with suggestion create/edit/delete and suggestadmin commands. Usage: Refer README.md

	Recommended trigger: Regex trigger with non case sensitive and trigger `\A(\-\s?|<@!?204255221017214977>\s*)((del(ete)?|edit)?suggest(ion)?|(sa|suggestadmin)\s+(edit|dupe|markdupe|deny|implement(ed)?|archive))(\s+|\z)`
        Note: If your prefix is not `-` replace the `-` at the start of the trigger with your prefix. 
*/}}

{{/* CONFIGURATION VARIABLES START */}}
{{$Suggestion_Channel := 356486960417734666}}
{{$Submission_Channel := 525535451839463424}}
{{$Implemented_Channel := 532918109036740608}}
{{$Mod_Roles := cslice 384008687951282177 419970533069815808}} 
{{$Cooldown := 600}} {{/* Can be set to 0 for no cooldown */}}
{{/* CONFIGURATION VARIABLES END */}}
 
{{/* Actual Code Starts Here */}}
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
			{{if not $IS_Mod}}{{if $Cooldown}}{{dbSetExpire .User.ID "suggestCld" "cooldown" $Cooldown}}{{end}}{{end}}
			{{$embed :=	cembed
						"description" .
						"color" $col
						"author" (sdict "name" (str $.User) "icon_url" ($.User.AvatarURL "512"))
						"timestamp"  currentTime
						"footer" (sdict "text" (print "Submit your suggestion with " $Prefix "suggest - " $.User.ID))
			}}
			{{$ID := sendMessageRetID $Suggestion_Channel $embed}}
			{{addMessageReactions $Suggestion_Channel $ID "upvote:524907425531428864" "downvote:524907425032175638"}}
			{{sendDM "Suggestion submitted successfully. If you want to discuss this or other suggestions, use the <#" $Submission_Channel "> channel. If you want to delete your suggestion, do so with `" $Prefix "deletesuggestion " $ID "` on the YAGPDB server."}}
			{{addReactions "upvote:524907425531428864"}}
		{{end}}
	{{else}}
		{{$error = "Insufficient Arguments."}}
	{{end}}	
{{else}}
	{{$authorID := 0}}{{$message := .nil}}{{$rest := ""}}{{$command := ""}}
	{{$Syntax = print .Cmd " <Suggestion_ID> <Message/Arguments>"}}
 
	{{/* Suggestion Message Validation */}}
	{{with reFindAllSubmatches (print `(?i)\A(?:` (reReplace `[\.\[\]\-\?\!\\\*\{\}\(\)\|]` $Prefix `\${0}`) `\s?|\S+\s*)(?:(del)\w+|(edit)\w+|\w+\s+(\w+))\s+(\d+)\s*(.*)`) .Message.Content}}
		{{$command = lower (or (index . 0 1) (index . 0 2) (index . 0 3))}}
		{{$message = getMessage $Suggestion_Channel (toInt (index . 0 4))}}
		{{$rest = index . 0 5}}
		{{with $message}}
			{{with .Embeds}}
				{{with (index . 0).Footer}}
					{{with reFindAllSubmatches `.*suggest - (\d{17,19})\z` .Text}}
						{{$authorID = toInt64 (index . 0 1)}}
					{{else}}
					 	{{$error = "Not a valid Suggestion Message"}}
					{{end}}			
				{{else}}
					 {{$error = "Not a valid Suggestion Message"}}
				{{end}}
			{{else}}
				{{$error = "Not a valid Suggestion Message"}}
			{{end}}
		{{else}}
			{{$error = print "Invalid Message ID : `" (index $.CmdArgs 0) "`"}}
		{{end}}
	{{else}}
		{{$error = "Invalid Syntax: did not provide valid Message ID"}}
	{{end}}
 
	{{if not $error}}
		{{$embed := structToSdict (index $message.Embeds 0)}}{{range $k,$v:=$embed}}{{if eq (kindOf $v true) `struct`}}{{$embed.Set $k (structToSdict $v)}}{{end}}{{end}}{{$embed.Author.Set "Icon_URL" $embed.Author.IconURL}}
		{{if eq $command "del"}}
			{{if or (eq $authorID .User.ID) $IS_Mod}}
				{{deleteMessage $Suggestion_Channel $message.ID 0}} Done :+1:
			{{else}}
				{{$error = "You can only delete your own suggestions. Ensure that you have used correct Suggestion ID."}}
			{{end}}
		{{else if eq $command "edit"}}
			{{if eq $authorID .User.ID}}
				{{if $rest}}
					{{$embed.Set "Description" $rest}}
					{{editMessage $Suggestion_Channel $message.ID (cembed $embed)}} Done :+1:
				{{else}}
					{{$error = "Edited Suggestion cannot be blank"}}
				{{end}}
			{{else}}
				{{$error = "You can only edit your own suggestions. Ensure that you have used correct Suggestion ID."}}
			{{end}}
		{{else if $IS_Mod}}
			{{if eq $command "dupe" "edit" "markdupe"}}
				{{$Syntax = "<Suggestion_ID> <Original_Suggestion_ID>"}} 
				{{with (toInt64 $rest)}}
					{{if gt $message.ID .}}
						{{if getMessage $Suggestion_Channel .}}
							{{$embed.Set "Description" (print $embed.Description "\n\n**This message has been marked as a dupe of:\n**https://discordapp.com/channels/" $.Guild.ID "/" $Suggestion_Channel "/" .)}}
							{{deleteMessage $Suggestion_Channel $message.ID 0}}
							{{sendMessage $Submission_Channel (complexMessage "content" (print "<@" $authorID "> | The suggestion below has been marked as dupe!") "embed" $embed)}}
						{{else}}
							{{$error = print "Invalid Original Suggestion Message ID : `" $rest "`"}}
						{{end}}
					{{else}}
						{{$error = "Original Suggestion should be older than dupe Suggestion"}}
					{{end}}
				{{else}}
					{{$error = "Did not provide valid ID for Original Suggestion Message"}}
				{{end}}
			{{else if eq $command "deny"}}
				{{deleteMessage $Suggestion_Channel $message.ID 0}}
				{{sendMessage $Submission_Channel (complexMessage "content" (print "<@" $authorID "> | The suggestion below has been deleted for reason: " $rest) "embed" $embed)}}
			{{else}}
				{{if $rest}}{{$embed.Set "Description" (print $embed.Description "\n\n**__Comment__**```" $rest "```")}}{{end}}
				{{$embed.Set "Title" "Successfully Implemented Suggestion:"}}
				{{$embed.Footer.Set "Text" (print "Implemented By : " .User.Username " - " .User.ID)}}
				{{deleteMessage $Suggestion_Channel $message.ID}}
				{{sendMessage $Implemented_Channel (cembed $embed)}}Done :+1:
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
{{end}}
