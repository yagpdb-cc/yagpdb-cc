---
sidebar_position: 14
title: Send
---

This is just like the simpleembed command. The difference being that is allows you to add fields to the embed.

**Trigger Type:** `Command`

**Trigger:** `embed`

**Example of usage:**  
`-embed -color 1752220 -title i am the title -description i am the description -channel 693662119765344257 -fields /name field name /value 1540 /inline true -fields /name field name 2 /value valueeee /inline true -fields /name vou ficar em baixo /value 4861 -image https://cdn.discordapp.com/attachments/682204005723799553/694677663717261402/PokecordSpawn.jpg -thumb https://cdn.discordapp.com/attachments/693662119765344257/698088081718247504/PokecordSpawn.jpg -author /name hello there /icon https://cdn.discordapp.com/attachments/693662119765344257/698087514484768818/PokecordSpawn.jpg -footer /text hello /icon https://cdn.discordapp.com/attachments/693662119765344257/698078976727318558/PokecordSpawn.jpg -timestamp`

Every flag (title, color, description, etc) should start with an `-`  
- Example: `-embed -color 1752220 -title i am the title -description i am the description`

Every field argument (value, name, inline) should start with an `/`  
- Example: `-embed -fields /name field name /value 1540 /inline true -fields /name field name 2 /value valueeee /inline true`

```go
{{/*
	This is just like the simpleembed command. The difference being that is allows you to add fields to the embed.
	Suggested trigger type: Command
	Suggested trigger: `embed`

	Example of usage: -embed -color 1752220 -title i am the title -description i am the description -channel 693662119765344257 -fields /name field name /value 1540 /inline true -fields /name field name 2 /value valueeee /inline true -fields /name vou ficar em baixo /value 4861 -image https://cdn.discordapp.com/attachments/682204005723799553/694677663717261402/PokecordSpawn.jpg -thumb https://cdn.discordapp.com/attachments/693662119765344257/698088081718247504/PokecordSpawn.jpg -author /name hello there /icon https://cdn.discordapp.com/attachments/693662119765344257/698087514484768818/PokecordSpawn.jpg -footer /text hello /icon https://cdn.discordapp.com/attachments/693662119765344257/698078976727318558/PokecordSpawn.jpg -timestamp

	Every flag (title, color, description, etc) should start with an -
		Example: -embed -color 1752220 -title i am the title -description i am the description
	Every field argument (value, name, inline) should start with an /
		Example: -embed -fields /name field name /value 1540 /inline true -fields /name field name 2 /value valueeee /inline true
*/}}

{{/* ACTUAL CODE DONT TOUCH */}}
{{$capture := false}} {{$field := sdict}} {{$name := false}} {{$value := false}} {{$boolean := false}} {{$hasField := false}} {{$nameV := ""}} {{$valueV := ""}} {{$booleanV := false}} {{$color := false}} {{$colorV := 123456}} {{$fields := cslice}} {{$isEmbed := false}} {{$description := false}} {{$descriptionV := ""}} {{$channel := false}} {{$channelV := .Channel.ID}} {{$title := false}} {{$titleV := ""}} {{$image := false}} {{$imageV := sdict}} {{$thumbnail := false}} {{$thumbnailV := sdict}} {{$author := false}} {{$authorV := sdict}} {{$authorName := false}} {{$authorNameV := ""}} {{$authorIcon := false}} {{$footer := false}} {{$footerV := sdict}} {{$footerText := false}} {{$footerIcon := false}} {{$footerTextV := ""}} {{$timeStamp := false}} {{$embed := sdict}}
{{$flags := cslice "-channel" "-fields" "-color" "-description" "-title" "-image" "-thumb" "-author" "-footer" "-timestamp"}}
{{- range $k, $v := .CmdArgs -}}
	{{- if eq . "-fields"}} {{$capture = true}} {{else if in $flags .}} {{$capture = false}} {{end -}}
	{{- if $capture -}}
		{{- $hasField = true -}}
		{{- if eq . "/name"}} {{$name = true}} {{$value = false}} {{$boolean = false -}}
		{{- else if eq . "/value"}} {{$name = false}} {{$value = true}} {{$boolean = false -}}
		{{- else if eq . "/inline"}} {{$name = false}} {{$value = false}} {{$boolean = true -}}
		{{- end -}}
		{{- if and ($name) (not (eq . "/name"))}} {{$nameV = joinStr " " $nameV .}} {{$field.Set "name" $nameV -}}
		{{- else if and ($value) (not (eq . "/value")) }} {{$valueV = joinStr " " $valueV .}} {{$field.Set "value" $valueV -}}
		{{- else if $boolean}} {{if eq . "true"}} {{$booleanV = true}} {{end}} {{$field.Set "inline" $booleanV -}}
		{{- else}} {{$field.Set "inline" $booleanV -}}
		{{- end -}}
	{{- end -}}
	{{- if and (ne $valueV "") (or (and ($hasField) (not $capture)) (and ($hasField) (eq $k (sub (len $.CmdArgs) 1))) (and (eq . "-fields") ($field.Get "name")))}} {{$hasField = false}} {{$isEmbed = true}} {{$fields = $fields.Append $field}} {{$field = sdict}} {{$nameV = ""}} {{$valueV = ""}} {{$booleanV = false}} {{end -}}
	{{- if eq . "-color"}} {{$color = true}} {{else if in $flags .}} {{$color = false}} {{end -}}
	{{- if and ($color) (not (eq . "-color"))}} {{with toInt .}} {{$isEmbed = true}} {{$colorV = .}} {{end}} {{end -}}
	{{- if eq . "-description"}} {{$description = true}} {{else if in $flags .}} {{$description = false}} {{end -}}
	{{- if and ($description) (not (eq . "-description"))}} {{$isEmbed = true}} {{$descriptionV = joinStr " " $descriptionV .}} {{end -}}
	{{- if eq . "-channel"}} {{$channel = true}} {{else if in $flags .}} {{$channel = false}} {{end -}}
	{{- if and ($channel) (not (eq . "-channel"))}} {{$checkChannel := reReplace `<|>|#` . ""}} {{with getChannel $checkChannel}} {{$channelV = .ID}} {{end}} {{end -}}
	{{- if eq . "-title"}} {{$title = true}} {{else if in $flags .}} {{$title = false}} {{end -}}
	{{- if and ($title) (not (eq . "-title"))}} {{$isEmbed = true}} {{$titleV = joinStr " " $titleV .}} {{end -}}
	{{- if eq . "-image"}} {{$image = true}} {{else if in $flags .}} {{$image = false}} {{end -}}
	{{- if and ($image) (not (eq . "-image"))}} {{if reFind `https?:\/\/\w+` .}} {{$isEmbed = true}} {{$imageV.Set "url" .}} {{end}} {{end -}}
	{{- if eq . "-thumb"}} {{$thumbnail = true}} {{else if in $flags .}} {{$thumbnail = false}} {{end -}}
	{{- if and ($thumbnail) (not (eq . "-thumb"))}} {{if reFind `https?:\/\/\w+` .}} {{$isEmbed = true}} {{$thumbnailV.Set "url" .}} {{end}} {{end -}}
	{{- if eq . "-author"}} {{$author = true}} {{else if in $flags .}} {{$author = false}} {{end -}}
	{{- if $author}}
		{{- if eq . "/name"}} {{$authorName = true}} {{$authorIcon = false -}}
		{{- else if eq . "/icon"}} {{$authorName = false}} {{$authorIcon = true -}}
		{{- end -}}
		{{- if and ($authorName) (not (eq . "/name"))}} {{$authorNameV = joinStr " " $authorNameV .}} {{$isEmbed = true}} {{$authorV.Set "name" $authorNameV -}}
		{{- else if and ($authorIcon) (not (eq . "/icon"))}} {{if reFind `https?:\/\/\w+` .}} {{$isEmbed = true}} {{$authorV.Set "icon_url" .}} {{end -}}
		{{- end -}}
	{{- end -}}
	{{- if eq . "-footer"}} {{$footer = true}} {{else if in $flags .}} {{$footer = false}} {{end -}}
	{{- if $footer}}
		{{- if eq . "/text"}} {{$footerText = true}} {{$footerIcon = false -}}
		{{- else if eq . "/icon"}} {{$footerText = false}} {{$footerIcon = true -}}
		{{- end -}}
		{{- if and ($footerText) (not (eq . "/text"))}} {{$footerTextV = joinStr " " $footerTextV .}} {{$isEmbed = true}} {{$footerV.Set "text" $footerTextV -}}
		{{- else if and ($footerIcon) (not (eq . "/icon"))}} {{if reFind `https?:\/\/\w+` .}} {{$isEmbed = true}} {{$footerV.Set "icon_url" .}} {{end -}}
		{{- end -}}
	{{- end -}}
	{{- if eq . "-timestamp"}} {{$timeStamp = currentTime}} {{$isEmbed = true}} {{end -}}
{{- end -}}

{{if $isEmbed}}
{{$embed.Set "fields" $fields}} {{$embed.Set "color" $colorV}} {{$embed.Set "description" $descriptionV}} {{$embed.Set "title" $titleV}} {{$embed.Set "image" $imageV}} {{$embed.Set "thumbnail" $thumbnailV}} {{$embed.Set "author" $authorV}} {{$embed.Set "footer" $footerV}} {{with $timeStamp}} {{$embed.Set "timestamp" .}} {{end}}
{{sendMessage $channelV (cembed $embed)}}
{{end}}
```