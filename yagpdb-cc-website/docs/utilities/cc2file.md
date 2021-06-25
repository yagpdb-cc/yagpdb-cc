---
sidebar_position: 5
title: CC to File
---

This command sends your CC(s) code in a text file, rather than "plain" Discord messages, preserving Tabs, markdown, etc.  
You can especify more than one ID or trigger, and bot will generate one file per input parameter. If none are provided, output will be CC list

**Trigger Type:** `Command`

**Trigger:** `cc2file`
Optional Trigger 2: `cc` IF you disable built-in `cc` command, via CommandOverrides

**Usage:**  
`-cc2file <ID or Trigger> [ID or Trigger] [ID or Trigger]...`  
For example: `-cc2file 10 "te st" 23`

```go
{{/*
	This command sends your CC(s) code in a text file, rather than "plain" Discord messages, preserving Tabs, markdown, etc. 
	You can especify more than one ID or trigger, and bot will generate one file per input parameter. If none are provided, output will be CC list

	Trigger type: Command
	Recommended trigger 1: `cc2file`
	Recommended trigger 2: `cc` IF you disable built-in "cc" command, via CommandOverrides

	Usage: `-cc2file <ID or Trigger> [ID or Trigger] [ID or Trigger]...`. For example: `-cc2file 10 "te st" 23`

	Credits:
		- MatiasMFM2001: Main author
		- Joe L.: Reviewer
		- TheHDCrafter: Some Regex I've used
*/}}

{{/* CONFIGURATION AREA STARTS */}}
	{{/*If `true`, bot will do that. Prevents flood in the chat*/}}
	{{$limitTo5CCs:= true}}

	{{/*If `true`, the info of each CC will be included in the message content*/}}
	{{$CCInfo_MessageContent:= true}}

	{{/*If `true`, the info of each CC will be included in the attached file*/}}
	{{$CCInfo_Attachment:= false}}

	{{/*These CCs will NOT be processed. DON'T QUOTE THE NUMBERS NOR ADD "#" TO THEM*/}}
	{{$blacklisted_CCIDs:= cslice 1234 5678}}

	{{/*If false, blacklisted CCs will be strikethroughted from CC list. If true, they will be left out*/}}
	{{$hideBlacklistedCCs:= false}}
{{/* CONFIGURATION AREA ENDS */}}



{{/*
	sendLongMessage is able to split a long text and send them in individual messages (of 2000 chars long max)

	INPUT (arguments) is an SDICT with keys:
		[String/Int/nil] "channelID" = Channel ID/Name/nil where message(s) will be sent
		[String] "text" = The content itself you want to send
		[String] "separator" = This will define when a 'word' starts or ends
*/}}
{{define "sendLongMessage"}}
	{{$outStr:= ""}}

	{{/*If separator is not found on the text, fallback to a default empty string*/}}
	{{if not (in .text .separator)}}
		{{.Set "separator" ""}}
	{{end}}

	{{/*Split text in 'words' and iterate over them*/}}
	{{range (split .text .separator)}}
		{{/*Keep appending words while length is under the limit. Then, send the message and "reset" the content for a new message*/}}
		{{- if gt (add (len $outStr) (len .)) 2000}}
			{{- sendMessage $.channelID $outStr}}
			{{- $outStr = .}}
		{{- else}}
			{{- $outStr = joinStr $.separator $outStr .}}
		{{- end -}}
	{{end}}

	{{/*Send the last message, that was left when range loop ended*/}}
	{{sendMessage .channelID $outStr}}
{{end}}

{{/*
	parseCC executes "-cc .argument" and extracts all possible information from it

	INPUT is an SDICT with keys:
		[String] "argument" = The CC ID or Trigger to parse

	OUTPUT is the same SDICT with keys:
		[String] "error" = If there are errors, they will be returned here (as a string)
		[Int] "CCID" = The ID of processed CC
		[String] "triggerType" = The type of the trigger this CC has (i.e. "None", "Command", "Regex", etc)
		[String] "trigger" = The trigger itself this CC has (i.e. "cc2file", ".*", etc)
		[Bool] "caseSensitive" = If lowercase and uppercase characters, are not considered equal
		[String] "group" = CC group, this CC belongs to
		[String] "code" = Executable source code of this CC
*/}}
{{define "parseCC"}}
	{{/*EXECute "-cc" and extract stuff from its output*/}}
	{{$answer:= exec "cc" .argument}}
	{{$answerLines:= split $answer "\n"}}
	{{$extractedCode:= slice $answerLines 2 (sub (len $answerLines) 1)}}
	{{$firstLine:= index $answerLines 0}}

	{{/*Check if Answer's $firstLine is actually an error message*/}}
	{{- if in $firstLine "here is a list of"}}
		{{.Set "error" (printf "❌ CC `%s` not found" .argument)}}
	{{- else if in $firstLine "More than 1 matched command"}}
		{{/*Insert argument in message output, and if it's empty, replace it with "<Empty trigger specified>"*/}}
		{{.Set "error" (reReplace "``" (printf "`%s`: %s" .argument $answer) "`<Empty trigger specified>`")}}
	{{end}}

	{{/*If not, extract info from the CC*/}}
	{{if not .error}}
		{{/*Modified copy of TheHDCrafter's Regex expression. Licensed under MIT*/}}
		{{$parsedFirstLine:= reFindAllSubmatches `^#\s*(\d+) - ((.*)(?:(?:: \x60(.*)\x60 - Case sensitive trigger: \x60(.+)\x60)|\b))? - Group: \x60(.+)\x60$` $firstLine}}

		{{.Set "CCID" (index $parsedFirstLine 0 1 | toInt)}}
		{{.Set "triggerType" (or (index $parsedFirstLine 0 3) "None")}}
		{{.Set "trigger" (index $parsedFirstLine 0 4)}}
		{{.Set "caseSensitive" (index $parsedFirstLine 0 5 | eq "true")}}
		{{.Set "group" (index $parsedFirstLine 0 6)}}

		{{.Set "code" (joinStr "\n" $extractedCode)}}
	{{end}}
{{end}}

{{/*EXECUTION STARTS HERE*/}}
{{/*If CC was called via execCC/scheduleUniqueCC, use .ExecData as the $args. If not, use .CmdArgs*/}}
{{$args:= cslice}}
{{with .ExecData}}
	{{$args = .}}
{{else}}
	{{/*Delete duplicated $args*/}}
	{{range .CmdArgs}}
		{{- if not (in $args .)}}
			{{- $args = $args.Append .}}
		{{- end}}
	{{- end}}
{{end}}
{{$numArgs:= len $args}}

{{/*Exec can be called 5 times max, so $selectedArgs will have up to 5 $args to be processed*/}}
{{$selectedArgs:= cslice}}
{{if gt $numArgs 5}}
	{{$selectedArgs = slice $args 0 5}}

	{{if $limitTo5CCs}}
		{{sendMessage nil "⚠️ WARNING: Only first 5 CCs will be processed"}}
	{{end}}
{{else}}
	{{$selectedArgs = $args}}
{{end}}

{{/*Process each selected argument in this execution*/}}
{{range $selectedArgs}}
	{{- $params:= sdict "argument" .}}
	{{- template "parseCC" $params}}

	{{/*Check if that CC was $blacklisted*/}}
	{{- if $params.error}}
		{{- sendMessage nil $params.error}}
	{{- else if in $blacklisted_CCIDs $params.CCID}}
		{{- sendMessage nil (printf "🚫 CC `%s` is blacklisted" .)}}
	{{- else}}
		{{/*No error message, so send CC's code and info*/}}
		{{- $content:= ""}}
		{{- $attachment:= $params.code}}

		{{/*If $CCInfo_MessageContent flag is set, the info will be sent as message content*/}}
		{{- if $CCInfo_MessageContent}}
			{{- $content = printf "#%d - %s: `%s` - Case sensitive trigger: `%t` - Group: `%s`" $params.CCID $params.triggerType $params.trigger $params.caseSensitive $params.group}}
		{{- end}}

		{{/*If $CCInfo_Attachment flag is set, the info will be a comment in message's attachment*/}}
		{{- if $CCInfo_Attachment}}
			{{/*Generate the $leadingComment*/}}
			{{- $leadingComment:= printf "{{/*\n\tDescription:\n\n\tUsage:\n"}}

			{{- range reFindAllSubmatches `parseArgs\s+\d+\s+"(.+)"` $params.code}}
				{{- $leadingComment = printf "%s\t\t\"%s\"\n" $leadingComment (index . 1)}}
			{{- end}}

			{{- $leadingComment = printf "%s\n\tRecomended trigger: \"%s\"\n\tTrigger type: %s\n\n\tCredits:\n*/}}" $leadingComment $params.trigger $params.triggerType}}

			{{- $attachment = printf "%s\n\n%s" $leadingComment $attachment}}
		{{- end}}

		{{- sendMessage nil (complexMessage
			"content" $content
			"file" $attachment
		)}}
	{{- end}}

	{{- sleep 1}}
{{else}}
	{{/*If there are 0 args, send full CC list*/}}
	{{$answerLines:= split (exec "cc") "\n"}}

	{{/*Save the first line, and the rest of them, in different variables*/}}
	{{$newMessage:= index $answerLines 0}}
	{{$answerLines:= slice $answerLines 1 (sub (len $answerLines) 1) | cslice.AppendSlice}}

	{{/*For each CC, if It's blacklisted, strikethrough whole line*/}}
	{{range $index, $content:= $answerLines}}
		{{- $CCID:= index (reFindAllSubmatches `^\x60#([0-9 ]{3})` $content) 0 1 | toInt}}

		{{- if in $blacklisted_CCIDs $CCID}}
			{{- if $hideBlacklistedCCs}}
				{{- $answerLines.Set $index ""}}
			{{- else}}
				{{- $answerLines.Set $index (printf "~~%s~~" $content)}}
			{{- end}}
		{{- end}}
	{{end}}

	{{/*A DIY "joinStr `\n` $answerLines"*/}}
	{{range $answerLines}}
		{{- $newMessage = printf "%s\n%s" $newMessage .}}
	{{end}}

	{{template "sendLongMessage" (sdict "channelID" nil "text" $newMessage "separator" "\n")}}
{{end}}

{{/*If $limitTo5CCs flag is not set, and there are still arguments left, execute CC again to process them*/}}
{{if and (not $limitTo5CCs) (gt $numArgs 5)}}
	{{scheduleUniqueCC .CCID nil 1 "cc2file - remaining args" (slice $args 5 $numArgs)}}
{{end}}
```