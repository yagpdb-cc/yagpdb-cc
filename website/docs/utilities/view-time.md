---
sidebar_position: 16
title: View Time
---

This command gets the time of your city, the weather of your city, and shows it in an embed with a different image / color depending on time.

**Trigger Type:** `Command`

**Trigger:** `time`

**Usage:**  
`-time`

```go
{{/*
	This command gets the time of your city, the weather of your city, and shows it in an embed with a different image / color depending on time.
	Usage: `-time`.

	Recommended trigger: Command trigger with trigger `time`
*/}}

{{/* CONFIGURATION VALUES START */}}
{{ $assets := sdict
	"morning" (sdict
		"image" "https://www.bnrconvention.com/wp-content/uploads/2017/04/coffee-icon-1.png"
		"color" 9498256
	)
	"afternoon" (sdict
		"image" "https://www.bnrconvention.com/wp-content/uploads/2017/04/coffee-icon-1.png"
		"color" 16747520
	)
	"evening" (sdict
		"image" "https://cdn4.iconfinder.com/data/icons/outdoors-3/460/night-512.png"
		"color" 8087790
	)
	"night" (sdict
		"image" "https://cdn4.iconfinder.com/data/icons/outdoors-3/460/night-512.png"
		"color" 1062054
	)
}} {{/* Only modify the individual sdicts, you should only be changing the image (url) or color (dec) */}}
{{ $timezone := "America/Vancouver" }} {{/* Avaliable from http://kevalbhatt.github.io/timezone-picker/ (same as setz) */}}
{{ $name := "Joe" }} {{/* Your name */}}
{{ $location := "Vancouver" }} {{/* City name */}}
{{/* CONFIGURATION VALUES END */}}

{{ $marker := "night" }}
{{ $output := exec "weather" $location }}
{{ $output = reReplace `\x60+` $output "" }}
{{ $res := split $output "\n" }}
{{ $weather := slice (index $res 3) 15 }}
{{ $temp := reReplace `\.\.` (reReplace ` \(.+$` (slice (index $res 4) 15) "") " - " }}

{{ $now := currentTime.In (newDate 0 0 0 0 0 0 $timezone).Location }}
{{ $hr := $now.Hour }}
{{ if and (ge $hr 5) (lt $hr 12) }} {{ $marker = "morning" }}
{{ else if and (ge $hr 12) (lt $hr 17) }} {{ $marker = "afternoon" }}
{{ else if and (ge $hr 17) (lt $hr 21) }} {{ $marker = "evening" }}
{{ end }}

{{ $asset := $assets.Get $marker }}
{{ $time := $now.Format "3:04:05 PM" }}
{{ $date := $now.Format "Monday, January 2, 2006" }}
{{ $embed := cembed
	"title" (printf "Good %s, %s" $marker $name)
	"color" $asset.color
	"thumbnail" (sdict "url" $asset.image)
	"description" (printf "❯ **Time:** %s\n❯ **Date:** %s\n❯ **Weather:** %s (%s)" $time $date $weather $temp)
}}
{{ sendMessage nil $embed }}
```
