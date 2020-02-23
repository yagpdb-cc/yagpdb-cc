{{/* This command will set a slowmode for a specific User
 Trigger Type: Regex -- Trigger: .*   */}}
 
{{/* change the number below to the amount of seconds that the slowmode should be */}}
{{ $time := 10 }} 
{{ if eq (toInt (dbGet 2 "slowmode").Value) 0 }}
{{ dbSetExpire 2 "slowmode" 1 $time }}
{{ else }}
{{ if eq (toInt (dbGet 2 "slowmode").Value) 1 }} 
{{ deleteTrigger 0 }}
{{ end }}
{{ end }}
