{{/*
	This command allows you to enlarge emojis - version 2. Usage: `-bigemoji <emoji>`.

	Recommended trigger: Regex trigger with trigger `^-(big-?emo(te|ji))`
*/}}

{{if .CmdArgs}}
{{$embed := sdict}}{{$emoji := index .CmdArgs 0}}
 
	{{if reFind `\p{So}|.\x{20e3}` $emoji}}
		{{$emoji_U := ""}}{{$url := "https://raw.githubusercontent.com/iamcal/emoji-data/master/img-google-136/"}}
		{{- range toRune $emoji}}
			{{- $emoji_U = joinStr "-" $emoji_U (printf "%04x" .)}}
		{{- end -}}
		{{$url = joinStr "" $url $emoji_U ".png"}}
		{{ $embed.Set "image"  (sdict "url" $url) }}
	{{else}}
		{{ with reFindAllSubmatches `<(a)?:[\w|~]+:(\d+)>` $emoji }}
			{{ $animated := index . 0 1 }}
			{{ $id := index . 0 2 }}
			{{ $ext := ".png" }}
			{{ if $animated }} {{ $ext = ".gif" }} {{ end }}
			{{ $embed.Set "image"  (sdict "url" (printf "https://cdn.discordapp.com/emojis/%s%s" $id $ext)) }}
		{{end}}
	{{end}}
 	
	{{$ID := 0}}
	{{if $embed}}
		{{$embed.Set "color" 0x39ff14}}
		{{$embed.Set "author" (sdict "name" .User.Username "icon_url" (.User.AvatarURL "256"))}}
		{{$ID = sendMessageRetID nil (cembed $embed)}}
	{{end}}
  
	{{sleep 1}} {{/* This just puts a standard output when no matching image is found. You can also use deleteMessage here */}}
	{{with (getMessage nil $ID)}}
		{{if not (index .Embeds 0).Image.Width}}
			{{$embed.Set "description" $emoji}}{{$embed.Del "image"}}
			{{editMessage nil $ID (cembed $embed)}}
		{{end}}
	{{end}}
  
{{end}}
{{deleteTrigger 0}}
