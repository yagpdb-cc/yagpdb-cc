{{$b:=parseArgs 1 "" (carg "string" "pattern") (carg "int" "max" 1 100) (carg "int" "skip")}}{{$d:=10}}{{$c:=0}}{{if $b.IsSet 1}}{{$d =$b.Get 1}}{{end}}{{if $b.IsSet 2}}{{$d =$b.Get 2}}{{end}}{{$a:=$b.Get 0}}{{range dbTopEntries $a $d $c}}
`{{.Key}}` (ID {{.UserID}}) - ID **{{.ID}}**
{{else}}
No entries found.
{{end}}
