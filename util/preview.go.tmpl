{{/*
	This command allows you to preview how colors look. Converts hex to dec, vice versa.
	Usage: `-preview <hex>` or `-preview <dec> -dec`.

	Recommended trigger: Regex trigger with trigger `\A(-|<@!?204255221017214977>\s*)(preview|color)(\s+|\z)`
*/}}

{{ $multipliers := cslice 1048576 65536 4096 256 16 1 }}
{{ $hex2dec := sdict "A" 10 "B" 11 "C" 12 "D" 13 "E" 14 "F" 15 }}
{{ $stripped := .StrippedMsg }}
{{ $force := or (reFind `-(d|dec)` $stripped) "" }}
{{ $regex := `(?:#?([a-fA-F\d]{1,6}))` }}
{{ if $force }}
	{{ $regex = `(\d+)` }}
{{ end }}
{{ with reFindAllSubmatches $regex $stripped }}
	{{ $hex := (printf "%06s" (index . 0 1)) | upper }}
	{{ $dec := 0 }}
	{{ with and $force (toInt (index . 0 1)) }}
		{{ $hex = (printf "%06x" .) | upper }}
		{{ $dec = . }}
	{{ end }}
	{{ if not $dec }}
		{{ range $k, $v := split $hex "" }}
			{{ $multiplier := index $multipliers $k }}
			{{ $num := or ($hex2dec.Get $v) $v}}
			{{ $dec = add $dec (mult $num $multiplier) }}
		{{ end }}
	{{ end }}
	{{ sendMessage nil (cembed
		"title" "❯ Color Preview"
		"color" $dec
		"description" (printf "❯ **Decimal:** %d\n❯ **Hex:** #%s" $dec $hex)
		"thumbnail" (sdict "url" (printf "https://dummyimage.com/400x400/%s/%s" $hex $hex))
	) }}
{{ else }}
	Correct usage is `-preview <hex>`.
{{ end }}