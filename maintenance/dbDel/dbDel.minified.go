{{$a:=parseArgs 2 "" (carg "int" "userID") (carg "int" "id") (carg "string" "type")}}{{$b:=false}}{{if $a.IsSet 2}}{{if in (cslice "-i" "-id") ($a.Get 2)}}{{$b =true}}{{end}}{{end}}{{if $b}}{{dbDelByID ($a.Get 0) ($a.Get 1)}}{{else}}{{dbDel ($a.Get 0) ($a.Get 1)}}{{end}}
Successfully deleted!
