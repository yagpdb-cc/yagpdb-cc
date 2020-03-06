{{/*
  This command allows you to parse string to time, in a human friendly way.
  Recommended usage: As a part of a Larger Command. Can also be used standalone with -
    Trigger: Command trigger with trigger `time`

  Usage: 
      String to be converted is fed to -> $timeString
      Converted time is available in variable -> $timeConverted

      Supported Syntax:   
      Date: Format 1:  dd/mm/yyyy or dd.mm.yyyy or dd-mm-yyyy or dd,mm,yyyy
            Format 2:  String format with year mentioned with 4 digits and both short and long month names supported. Date components (i.e day , month , year) need not be present together. eg: 12 Feb 11:50 am , 2020 is supported.
            Format 3:  Today and tomorrow is supported.

      TimeZone: By default timezone is UTC. If user has timezone set using "setz" command, timezone adjustment is also possible. UTC time is parsed if explicitly specified UTC in this case.

	  Time: Time is mentioned as hh:mm:ss or hh:mm or hh. May or may not be followed by AM or PM.

  Credits: Developed by Satty#9361
*/}}

{{/* CONFIGURATION VALUES START */}}
{{/*String to be converted is fed to $timeString variable*/}}
{{ $timeString := .StrippedMsg }}
{{/* can be any string variable / string data but should contain only the time in the formats mentioned */}}
{{/* CONFIGURATION VALUES END */}}

{{/* Variable Declarations */}}
{{ $dTime := sdict "Day" currentTime.Day "Month" (toInt (printf "%d" currentTime.Month)) "Year" currentTime.Year  "Hour" currentTime.Hour "Min" currentTime.Minute "Sec" currentTime.Second }}
{{ $time := sdict "Day" $dTime.Day "Month" $dTime.Month "Year" $dTime.Year "Hour" 0 "Min" 0 "Sec" 0  }}
{{ $dateSet := false }} {{ $timeSet := false }}
{{ $timeConverted := 0 }}
{{ $months := sdict 
	"jan" 1
	"feb" 2
	"mar" 3
	"apr" 4
	"may" 5
	"jun" 6
	"jul" 7
	"aug" 8
	"sep" 9
	"oct" 10
	"nov" 11
	"dec" 12
 }}

{{/* Actual Code */}}
{{ $timeString = lower $timeString }}
{{/* Fetching Dates */}}
{{/* Fetching dates written in format dd.mm.yyyy or dd/mm/yyyy or dd-mm-yyyy or dd,mm,yyyy */}} 
{{ with reFindAllSubmatches `((\s|^)((\d{1,2})(\-|\.|\/|\,)(\d{1,2})(\-|\.|\/|\,)(\d{1,4}))(\s|$))` $timeString }}
      {{ $time.Set "Day" (toInt (index . 0 4)) }}
      {{ $time.Set "Month" (toInt (index . 0 6)) }}
      {{ $time.Set "Year" (toInt (index . 0 8)) }}
      {{ $dateSet = true }}
{{ else }}

{{/* Fetching dates written as a string with both long or short month names supported. Date , Month and Year need not be present together but year must be written in full form(with 4 digits) eg: 20 sept 1am ,2019 is supported */}}
     {{ with (reFindAllSubmatches `(?:[^a-z]|^)(jan((uary)?)|feb((ruary)?)|mar((ch)?)|apr((il)?)|may|jun(e?)|jul(y?)|aug((ust)?)|sep((t(ember)?)?)|oct((ober)?)|nov((ember)?)|dec((ember)?))(?:[^a-z]|$)` $timeString) }}
     {{ $time.Set "Month" ($months.Get (slice (index . 0 1) 0 3)) }}
     {{ $temp:= reReplace `(([^:]|^)((\d+)((:(\d+)){1,2}))((\s?(am|pm))?))|(((\d+))(\s?(am|pm)))` $timeString "" }}
     {{ with (reFindAllSubmatches `(?:\D|^)(\d{1,2})(?:\D|$)` $temp) }}
     	{{ $time.Set "Day" (toInt (index . 0 1)) }}
     {{ end }}
     {{ with (reFindAllSubmatches `(?:\D|^)(\d{4})(?:\D|$)` $temp) }}
     	{{ $time.Set "Year" (toInt (index . 0 1)) }}
     {{ end }}
     {{ $dateSet = true }}
     {{ end }}
{{ end }}

{{/* Fetching dates specified as today or tomorrow and assigning default values to invalid dates */}}
{{ if $dateSet }}
{{ if not $time.Day }}{{ $time.Set "Day" $dTime.Day }}{{ end }}
{{ if not $time.Month }}{{ $time.Set "Month" $dTime.Month }}{{ end }}
{{ if not $time.Year }}{{ $time.Set "Year" $dTime.Year }}{{ end }}
{{ else }}
	{{ with reFind `(today)|(tomorrow)` $timeString }}
		{{ if eq . "tomorrow" }}
			{{ $time.Set "Day" (add $dTime.Day 1) }}
		{{ end }}
	{{ end }}
{{ end }}

{{/* Fetching time specified as hh:mm or hh:mm:ss or hh. Can be followed by am/pm as well. */}}
{{ with reFind `(([^:]|^)((\d+)((:(\d+)){1,2}))((\s?(am|pm))?))|(((\d+))(\s?(am|pm)))` $timeString }}
	{{ with reFindAllSubmatches `(\d+)` . }}
		{{ $time.Set "Hour" (toInt (index . 0 0)) }}
		{{ if (gt (len .) 1) }}
			{{ $time.Set "Min" (toInt (index . 1 0) ) }}
		{{ end }}
		{{ if (gt (len .) 2) }}
			{{ $time.Set "Sec" (toInt (index . 2 0)) }}
		{{ end }}
	{{ end }}
	{{ with reFind `(am|pm)` . }}
		{{ if and (eq $time.Hour 12) (eq . "am") }}
			{{ $time.Set "Hour" 0 }}
		{{ else if and (eq . "pm" ) (lt $time.Hour 12) }}
			{{ $time.Set "Hour" (add $time.Hour 12) }}
		{{ end }}
	{{ end }}
	{{ $timeSet = true }}
{{ end }}

{{/* Setting time to current time when both explicit date and time setting was not done */}}
{{ if and (not $timeSet) (not $dateSet) }}
	{{ $time.Set "Hour" $dTime.Hour }}
	{{ $time.Set "Min" $dTime.Min }}
	{{ $time.Set "Sec" $dTime.Sec }}
{{ end }}

{{/* Conversion to time.Time datatype */}}
{{ $timeConverted = (newDate $time.Year $time.Month $time.Day $time.Hour $time.Min $time.Sec) }}

{{/*timezone adjustment - Remove if you only want UTC times*/}}
{{ if and (or $timeSet $dateSet) (not (reFind `([^a-z]|^)utc([^a-z]|$)` $timeString )) }}
	{{ $TimeHour := .TimeHour }}
	{{ with (reFind `(\-)?\d+(:\d+)?` (exec "setz -u") ) }}
		{{ $timeConverted = $timeConverted.Add (toDuration (mult -1.0 (toFloat (reReplace ":" . ".")) $TimeHour)) }}
	{{ end }}
{{ end }}