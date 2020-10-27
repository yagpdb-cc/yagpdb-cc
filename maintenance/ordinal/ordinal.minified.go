{{$b:="th"}}{{$c:=(parseArgs 1 "**Syntax:** -ordinal <number>" (carg "int" "number")).Get 0}}{{$a:=toInt (mod $c 100)}}{{$d:=toInt (mod $c 10)}}{{if not (and (ge $a 10) (le $a 19))}}{{if eq $d 1}}{{$b ="st"}}{{else if eq $d 2}}{{$b ="nd"}}{{else if eq $d 3}}{{$b ="rd"}}{{end}}{{end}}
❯ **Ordinal**
`{{$c}}{{$b}}`
