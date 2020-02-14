{{/*
	Extremely simple and consise counting system. 

	Recommended trigger: Regex trigger with `.*` trigger limited to your counting channel.
*/}}

{{ deleteResponse 2 }}
{{ $input := toInt .Message.Content }}
{{ $current := dbIncr 0 "counting" 1 | toInt }}
{{ $lastCounter := "" }}
{{ with dbGet 0 "lastCounter" }} {{ $lastCounter = str .Value }} {{ end }}
{{ if or (not (reFind `^\d+$` .Message.Content )) (ne $current $input) }}
	{{ block "reset" $current }} {{ dbSet 0 "counting" (sub . 1) }} {{ end }}
	{{ deleteTrigger 1 }}
	{{ .User.Mention }}, that was the wrong number!
{{ else if eq (str .User.ID) $lastCounter }}
	{{ template "reset" $current }}
	{{ deleteTrigger 1 }}
	{{ .User.Mention }}, you cannot count twice in a row!
{{ else }}
	{{ dbSet 0 "lastCounter" (str .User.ID) }}
{{ end }}