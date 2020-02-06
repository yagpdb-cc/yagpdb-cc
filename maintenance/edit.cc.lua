{{- /*
	This command is a tool for editing messages sent by YAGPDB.
	Usage: `-edit [channel] <msg> <new-content>`.

	Recommended trigger: Command trigger with trigger `edit`.
*/ -}}

{{ $helpMsg := cembed
	"title" "`-edit [channel] <msg> <new-content>`"
	"color" 14232643
	"description" "Please provide a valid message (which was sent by YAGPDB).\n\nIf the message is an embed, you can use the syntax from the `-se` command to edit it: `-edit [channel] <msg> -title \"Hello world\" -desc \"Foobar\"`."
}}

{{ $available := cslice "title" "desc" "color" "url" "thumbnail" "image" "author" "authoricon" "footer" "footericon" }}
{{ $multipliers := cslice 1048576 65536 4096 256 16 1 }}
{{ $hex2dec := sdict "A" 10 "B" 11 "C" 12 "D" 13 "E" 14 "F" 15 }}
{{ $yag := 204255221017214977 }}
{{ $embed := sdict "author" (sdict "icon_url" "" "name" "") "footer" (sdict "text" "" "icon_url" "") }}
{{ $skip := false }}

{{ $channel := .Channel }}
{{ $args := cslice }}
{{ $id := "" }}

{{ if .CmdArgs }}
	{{ $channelID := "" }}
	{{ with reFindAllSubmatches `<#(\d+)>` (index .CmdArgs 0) }} {{ $channelID = index . 0 1 }} {{ end }}
	{{ $temp := getChannel (or $channelID (index .CmdArgs 0)) }}
	{{ if and $temp (ge (len .CmdArgs) 3) }}
		{{ $channel = $temp }}
		{{ $id = index .CmdArgs 1 }}
		{{ $args = slice .CmdArgs 2 }}
	{{ else if (ge (len .CmdArgs) 2) }}
		{{ $id = index .CmdArgs 0 }}
		{{ $args = slice .CmdArgs 1 }}
	{{ end }}
{{ end }}

{{ $id = toInt64 $id }}
{{ $msg := getMessage $channel.ID $id }}
{{ $userID := 0 }}
{{ with $msg }} {{ $userID = .Author.ID }} {{ end }}
{{ if and (eq $userID $yag) (len $args) }}
	{{ if (len $msg.Embeds) }}
		{{ range $k, $ := $args }}
			{{ if $skip }}
				{{ $skip = false }}
			{{ else }}
				{{ $flag := and (eq (slice . 0 1) "-") (slice . 1) }}
				{{ $next := "" }}
				{{ if gt (len $args) (add $k 1) }}
					{{ $next = index $args (add $k 1) }}
				{{ end }}
				{{ if and (in $available $flag) $next }}
					{{ if in (cslice "thumbnail" "image") $flag }} {{ $embed.Set $flag (sdict "url" $next) }}
					{{ else if in (cslice "authoricon" "footericon") $flag }} {{ ($embed.Get (reReplace "icon" $flag "")).Set "icon_url" $next }}
					{{ else if eq $flag "desc" }} {{ $embed.Set "description" $next }}
					{{ else if eq $flag "color" }}
						{{ $regex := `(?:#?([a-fA-F\d]{1,6}))` }}
						{{ with reFindAllSubmatches $regex $next }}
							{{ $hex := (printf "%06s" (index . 0 1)) | upper }}
							{{ $dec := 0 }}
							{{ range $flag, $v := split $hex "" }}
								{{ $multiplier := index $multipliers $flag }}
								{{ $num := or ($hex2dec.Get $v) $v}}
								{{ $dec = add $dec (mult $num $multiplier) }}
							{{ end }}
							{{ $embed.Set "color" $dec }}
						{{ end }}
					{{ else if eq $flag "url" }} {{ $embed.Set "url" $next }}
					{{ else if eq $flag "title" }} {{ $embed.Set "title" $next}}
					{{ else if eq $flag "author" }} {{ $embed.author.Set "name" $next }}
					{{ else if eq $flag "footer" }} {{ $embed.footer.Set "text" $next }} {{ end }}
					{{ $skip = true }}
				{{ end }}
			{{ end }}
		{{ end }}
		{{ editMessage $channel.ID $id (cembed $embed) }}
		Successfully edited message!
	{{ else if $msg.Content }}
		{{ editMessage $channel.ID $id (joinStr " " $args) }}
		Successfully edited message!
	{{ else }}
		{{ sendMessage nil $helpMsg }}
	{{ end }}
{{ else }}
	{{ sendMessage nil $helpMsg }}
{{ end }}