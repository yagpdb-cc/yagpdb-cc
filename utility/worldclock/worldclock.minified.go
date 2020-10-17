{{$b:=sdict
	"Vancouver" "America/Vancouver"
	"New York" "America/New_York"
	"London" "Europe/London"
	"Moscow" "Europe/Moscow"
	"Tokyo" "Asia/Tokyo"}}{{$d:=.TimeHour}}{{$c:=sdict
	"title" "🕰️ World Clock"
	"fields" cslice
	"color" 0x0070BB
	"footer" (sdict "text" "Your time")
	"timestamp" currentTime}}{{range $name, $ := $b}}{{$e:=currentTime.In (newDate 0 0 0 0 0 0 .).Location}}{{$a:=printf "%s, %s"
	$e.Weekday.String
	($e.Format "3:04:05 PM")}}{{$c.fields.Append (sdict
	"name" $name
	"value" $a
	) | $c.Set "fields"}}{{end}}{{sendMessage nil (cembed $c)}}