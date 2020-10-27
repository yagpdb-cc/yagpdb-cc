{{$a:=`\x60(.*?)\x60|"(.*?)"|[^\s]+`}}{{$b:=cslice}}{{range reFindAllSubmatches $a .StrippedMsg}}{{$b =$b.Append (or (index . 2) (index . 1) (index . 0))}}{{end}}
**Args:**
{{joinStr "\n" $b.StringSlice}}
