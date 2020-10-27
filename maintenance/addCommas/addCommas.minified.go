{{$d:=(parseArgs 1 "**Syntax:** `-addCommas <int>`" (carg "int" "number")).Get 0 | str}}{{$a:=toInt (mod (len $d) 3)}}{{$c:=""}}{{if ge (len $d) 3}}{{$c =slice $d $a}}{{end}}{{$b:=""}}{{if $a}}{{$b =slice $d 0 $a}}{{end}}{{range $k, $ := (split $c "")}}{{if not (mod $k 3)}}{{$b =joinStr "" $b (and $b ",") .}}{{else}}{{$b =joinStr "" $b .}}{{end}}{{end}}
❯ **Add commas**
Input: `{{$d}}`
Output: `{{$b}}`
